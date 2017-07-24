Received: from eggs.gnu.org ([2001:4830:134:3::10]:53761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZf2d-0005vv-37
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZf2Z-0006cU-LW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:13:03 -0400
Date: Mon, 24 Jul 2017 16:12:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724151247.GJ2784@stefanha-x1.localdomain>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-5-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SBT+cnFS/G3NVgv4"
Content-Disposition: inline
In-Reply-To: <20170714094521.4909-5-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 4/7] block: convert ThrottleGroup to object
 with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--SBT+cnFS/G3NVgv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 12:45:18PM +0300, Manos Pitsidianakis wrote:
> ThrottleGroup is converted to an object. This will allow the future
> throttle block filter drive easy creation and configuration of throttle
> groups in QMP and cli.
>=20
> A new QAPI struct, ThrottleLimits, is introduced to provide a shared
> struct for all throttle configuration needs in QMP.
>=20
> ThrottleGroups can be created via CLI as
>     -object throttling-group,id=3Dfoo,x-iops-total=3D100,x-..

Please make the QOM name and struct name consistent.  Either
ThrottleGroup/throttle-group or ThrottlingGroup/throttling-group but not
ThrottleGroup/throttling-group.

> where x-* are individual limit properties. Since we can't add non-scalar
> properties in -object this interface must be used instead. However,
> setting these properties must be disabled after initialization because
> certain combinations of limits are forbidden and thus configuration
> changes should be done in one transaction. The individual properties
> will go away when support for non-scalar values in CLI is implemented
> and thus are marked as experimental.
>=20
> ThrottleGroup also has a `limits` property that uses the ThrottleLimits
> struct.  It can be used to create ThrottleGroups or set the
> configuration in existing groups as follows:
>=20
> { "execute": "object-add",
>   "arguments": {
>     "qom-type": "throttling-group",
>     "id": "foo",
>     "props" : {
>       "limits": {
>           "iops-total": 100
>       }
>     }
>   }
> }
> { "execute" : "qom-set",
>     "arguments" : {
>         "path" : "foo",
>         "property" : "limits",
>         "value" : {
>             "iops-total" : 99
>         }
>     }
> }
>=20
> This also means a group's configuration can be fetched with qom-get.
>=20
> ThrottleGroups can be anonymous which means they can't get accessed by
> other users ie they will always be units instead of group (Because they
> have one ThrottleGroupMember).
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>=20
> Notes:
>     Note: I tested Markus Armbruster's patch in <87wp7fghi9.fsf@dusky.pon=
d.sub.org>
>     on master and I can use this syntax successfuly:
>     -object '{ "qom-type" : "throttling-group", "id" : "foo", "props" : {=
 "limits" \
>     : { "iops-total" : 1000 } } }'
>     If this gets merged using -object will be a little more verbose but a=
t least we
>     won't have seperate properties, which is a good thing, so the x-* sho=
uld be
>     dropped.
>=20
>  block/throttle-groups.c         | 507 ++++++++++++++++++++++++++++++++++=
+++---
>  include/block/throttle-groups.h |   3 +
>  include/qemu/throttle-options.h |  59 +++--
>  include/qemu/throttle.h         |   3 +
>  qapi/block-core.json            |  45 ++++
>  tests/test-throttle.c           |   1 +
>  util/throttle.c                 | 121 ++++++++++
>  7 files changed, 689 insertions(+), 50 deletions(-)
>=20
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index f711a3dc62..4d1f82ec06 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -25,9 +25,17 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/block-backend.h"
>  #include "block/throttle-groups.h"
> +#include "qemu/throttle-options.h"
>  #include "qemu/queue.h"
>  #include "qemu/thread.h"
>  #include "sysemu/qtest.h"
> +#include "qapi/error.h"
> +#include "qapi-visit.h"
> +#include "qom/object.h"
> +#include "qom/object_interfaces.h"
> +
> +static void throttle_group_obj_init(Object *obj);
> +static void throttle_group_obj_complete(UserCreatable *obj, Error **errp=
);
> =20
>  /* The ThrottleGroup structure (with its ThrottleState) is shared
>   * among different ThrottleGroupMembers and it's independent from
> @@ -54,6 +62,10 @@
>   * that ThrottleGroupMember has throttled requests in the queue.
>   */
>  typedef struct ThrottleGroup {
> +    Object parent_obj;
> +
> +    /* refuse individual property change if initialization is complete */
> +    bool is_initialized;
>      char *name; /* This is constant during the lifetime of the group */
> =20
>      QemuMutex lock; /* This lock protects the following four fields */
> @@ -63,8 +75,7 @@ typedef struct ThrottleGroup {
>      bool any_timer_armed[2];
>      QEMUClockType clock_type;
> =20
> -    /* These two are protected by the global throttle_groups_lock */
> -    unsigned refcount;
> +    /* This is protected by the global throttle_groups_lock */
>      QTAILQ_ENTRY(ThrottleGroup) list;
>  } ThrottleGroup;
> =20
> @@ -77,7 +88,8 @@ static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =3D
>   * If no ThrottleGroup is found with the given name a new one is
>   * created.
>   *
> - * @name: the name of the ThrottleGroup
> + * @name: the name of the ThrottleGroup, NULL means a new anonymous grou=
p will
> + *        be created.
>   * @ret:  the ThrottleState member of the ThrottleGroup
>   */
>  ThrottleState *throttle_group_incref(const char *name)
> @@ -87,32 +99,30 @@ ThrottleState *throttle_group_incref(const char *name)
> =20
>      qemu_mutex_lock(&throttle_groups_lock);
> =20
> -    /* Look for an existing group with that name */
> -    QTAILQ_FOREACH(iter, &throttle_groups, list) {
> -        if (!strcmp(name, iter->name)) {
> -            tg =3D iter;
> -            break;
> +    if (name) {
> +        /* Look for an existing group with that name */
> +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
> +            if (!g_strcmp0(name, iter->name)) {
> +                tg =3D iter;
> +                break;
> +            }
>          }
>      }
> =20
>      /* Create a new one if not found */
>      if (!tg) {
> -        tg =3D g_new0(ThrottleGroup, 1);
> +        /* new ThrottleGroup obj will have a refcnt =3D 1 */
> +        tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
>          tg->name =3D g_strdup(name);
> -        tg->clock_type =3D QEMU_CLOCK_REALTIME;
> -
> -        if (qtest_enabled()) {
> -            /* For testing block IO throttling only */
> -            tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
> -        }
> -        qemu_mutex_init(&tg->lock);
> -        throttle_init(&tg->ts);
> -        QLIST_INIT(&tg->head);
> -
> -        QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> +        throttle_group_obj_complete((UserCreatable *)tg, &error_abort);
>      }
> =20
> -    tg->refcount++;
> +    qemu_mutex_lock(&tg->lock);
> +    if (!QLIST_EMPTY(&tg->head)) {
> +        /* only ref if the group is not empty */
> +        object_ref(OBJECT(tg));
> +    }
> +    qemu_mutex_unlock(&tg->lock);
> =20
>      qemu_mutex_unlock(&throttle_groups_lock);
> =20
> @@ -129,15 +139,7 @@ ThrottleState *throttle_group_incref(const char *nam=
e)
>  void throttle_group_unref(ThrottleState *ts)
>  {
>      ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
> -
> -    qemu_mutex_lock(&throttle_groups_lock);
> -    if (--tg->refcount =3D=3D 0) {
> -        QTAILQ_REMOVE(&throttle_groups, tg, list);
> -        qemu_mutex_destroy(&tg->lock);
> -        g_free(tg->name);
> -        g_free(tg);
> -    }
> -    qemu_mutex_unlock(&throttle_groups_lock);
> +    object_unref(OBJECT(tg));
>  }
> =20
>  /* Get the name from a ThrottleGroupMember's group. The name (and the po=
inter)
> @@ -572,9 +574,452 @@ void throttle_group_detach_aio_context(ThrottleGrou=
pMember *tgm)
>      throttle_timers_detach_aio_context(tt);
>  }
> =20
> +#define DOUBLE 0
> +#define UINT64 1
> +#define UNSIGNED 2
> +
> +typedef struct {
> +    BucketType type;
> +    int data_type;
> +    ptrdiff_t offset; /* offset in LeakyBucket struct. */
> +} ThrottleParamInfo;
> +
> +static ThrottleParamInfo throttle_iops_total_info =3D {

These can be made const.  This offers a tiny security benefit because
=2Eoffset will be read-only and therefore cannot be used to overwrite
arbitrary memory.  Exploits often gain control of execution by first
overwriting a function pointer or pointer field that they can influence.

Also, how about defining an array and looping over it to avoid
repetition?

  for (i =3D 0; i < ARRAY_SIZE(params); i++) {
      object_class_property_add(klass,
                                params[i].name,
                                "int",
                                throttle_group_get,
                                throttle_group_set,
                                NULL, &params[i],
                                &error_abort);
  }

> +    THROTTLE_OPS_TOTAL, DOUBLE, offsetof(LeakyBucket, avg),
> +};
> +
> +static ThrottleParamInfo throttle_iops_total_max_info =3D {
> +    THROTTLE_OPS_TOTAL, DOUBLE, offsetof(LeakyBucket, max),
> +};
> +
> +static ThrottleParamInfo throttle_iops_total_max_length_info =3D {
> +    THROTTLE_OPS_TOTAL, UNSIGNED, offsetof(LeakyBucket, burst_length),
> +};
> +
> +static ThrottleParamInfo throttle_iops_read_info =3D {
> +    THROTTLE_OPS_READ, DOUBLE, offsetof(LeakyBucket, avg),
> +};
> +
> +static ThrottleParamInfo throttle_iops_read_max_info =3D {
> +    THROTTLE_OPS_READ, DOUBLE, offsetof(LeakyBucket, max),
> +};
> +
> +static ThrottleParamInfo throttle_iops_read_max_length_info =3D {
> +    THROTTLE_OPS_READ, UNSIGNED, offsetof(LeakyBucket, burst_length),
> +};
> +
> +static ThrottleParamInfo throttle_iops_write_info =3D {
> +    THROTTLE_OPS_WRITE, DOUBLE, offsetof(LeakyBucket, avg),
> +};
> +
> +static ThrottleParamInfo throttle_iops_write_max_info =3D {
> +    THROTTLE_OPS_WRITE, DOUBLE, offsetof(LeakyBucket, max),
> +};
> +
> +static ThrottleParamInfo throttle_iops_write_max_length_info =3D {
> +    THROTTLE_OPS_WRITE, UNSIGNED, offsetof(LeakyBucket, burst_length),
> +};
> +
> +static ThrottleParamInfo throttle_bps_total_info =3D {
> +    THROTTLE_BPS_TOTAL, DOUBLE, offsetof(LeakyBucket, avg),
> +};
> +
> +static ThrottleParamInfo throttle_bps_total_max_info =3D {
> +    THROTTLE_BPS_TOTAL, DOUBLE, offsetof(LeakyBucket, max),
> +};
> +
> +static ThrottleParamInfo throttle_bps_total_max_length_info =3D {
> +    THROTTLE_BPS_TOTAL, UNSIGNED, offsetof(LeakyBucket, burst_length),
> +};
> +
> +static ThrottleParamInfo throttle_bps_read_info =3D {
> +    THROTTLE_BPS_READ, DOUBLE, offsetof(LeakyBucket, avg),
> +};
> +
> +static ThrottleParamInfo throttle_bps_read_max_info =3D {
> +    THROTTLE_BPS_READ, DOUBLE, offsetof(LeakyBucket, max),
> +};
> +
> +static ThrottleParamInfo throttle_bps_read_max_length_info =3D {
> +    THROTTLE_BPS_READ, UNSIGNED, offsetof(LeakyBucket, burst_length),
> +};
> +
> +static ThrottleParamInfo throttle_bps_write_info =3D {
> +    THROTTLE_BPS_WRITE, DOUBLE, offsetof(LeakyBucket, avg),
> +};
> +
> +static ThrottleParamInfo throttle_bps_write_max_info =3D {
> +    THROTTLE_BPS_WRITE, DOUBLE, offsetof(LeakyBucket, max),
> +};
> +
> +static ThrottleParamInfo throttle_bps_write_max_length_info =3D {
> +    THROTTLE_BPS_WRITE, UNSIGNED, offsetof(LeakyBucket, burst_length),
> +};
> +
> +static ThrottleParamInfo throttle_iops_size_info =3D {
> +    0, UINT64, offsetof(ThrottleConfig, op_size),
> +};
> +
> +static void throttle_group_obj_init(Object *obj)
> +{
> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> +
> +    tg->clock_type =3D QEMU_CLOCK_REALTIME;
> +    if (qtest_enabled()) {
> +        /* For testing block IO throttling only */
> +        tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
> +    }
> +    tg->is_initialized =3D false;
> +    qemu_mutex_init(&tg->lock);
> +    throttle_init(&tg->ts);
> +    QLIST_INIT(&tg->head);
> +}
> +
> +static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
> +{
> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj), *iter;
> +    ThrottleConfig *cfg =3D &tg->ts.cfg;
> +
> +    /* set group name to object id if it exists */
> +    if (!tg->name && tg->parent_obj.parent) {
> +        tg->name =3D object_get_canonical_path_component(OBJECT(obj));
> +    }
> +
> +    if (tg->name) {
> +        /* error if name is duplicate */
> +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
> +            if (!g_strcmp0(tg->name, iter->name)) {
> +                error_setg(errp, "A group with this name already exists"=
);
> +                goto fail;
> +            }
> +        }
> +    }
> +
> +    /* unfix buckets to check validity */
> +    throttle_get_config(&tg->ts, cfg);
> +    if (!throttle_is_valid(cfg, errp)) {
> +        goto fail;
> +    }
> +    /* fix buckets again */
> +    throttle_config(&tg->ts, tg->clock_type, cfg);
> +
> +    tg->is_initialized =3D true;
> +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> +    return;
> +fail:
> +    qemu_mutex_destroy(&tg->lock);
> +    g_free(tg->name);

If throttle_group_obj_finalize() can still be called there will be
double-frees.  UserCreatable->complete() is not part of the core Object
lifecycle so I think it could happen and it's safer to leave tg fields
allocated so that throttle_group_obj_finalize() frees them once and only
once.

> +}
> +
> +static void throttle_group_obj_finalize(Object *obj)
> +{
> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> +    qemu_mutex_lock(&throttle_groups_lock);
> +    QTAILQ_REMOVE(&throttle_groups, tg, list);
> +    qemu_mutex_unlock(&throttle_groups_lock);
> +    qemu_mutex_destroy(&tg->lock);
> +    g_free(tg->name);
> +}
> +
> +static void throttle_group_set(Object *obj, Visitor *v, const char * nam=
e,
> +        void *opaque, Error **errp)
> +
> +{
> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> +    ThrottleConfig cfg;
> +    ThrottleParamInfo *info =3D opaque;
> +    ThrottleLimits *arg =3D NULL;
> +    Error *local_err =3D NULL;
> +    int64_t value;
> +
> +    if (!info) {
> +        arg =3D g_new0(ThrottleLimits, 1);
> +        visit_type_ThrottleLimits(v, name, &arg, &local_err);
> +        if (local_err) {
> +            goto fail;
> +        }
> +        qemu_mutex_lock(&tg->lock);
> +        throttle_get_config(&tg->ts, &cfg);
> +        throttle_limits_to_config(arg, &cfg, &local_err);
> +        if (local_err) {
> +            qemu_mutex_unlock(&tg->lock);
> +            goto fail;
> +        }
> +        throttle_config(&tg->ts, tg->clock_type, &cfg);
> +        qemu_mutex_unlock(&tg->lock);
> +
> +        goto ret;
> +    }

There is no need to share a function between ThrottleLimits and
individual fields.  The code would be clearer with two separate setter
functions.  The individual fields removal patch will also be cleaner
because it just needs to delete lines of code instead of modifying
throttle_group_set().

> +
> +    /* If we have finished initialization, don't accept individual prope=
rty
> +     * changes through QOM. Throttle configuration limits must be set in=
 one
> +     * transaction, as certain combinations are invalid.
> +     */
> +    if (tg->is_initialized) {
> +        error_setg(&local_err, "Property cannot be set after initializat=
ion");
> +        goto fail;
> +    }
> +
> +    visit_type_int64(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto fail;
> +    }
> +    if (value < 0) {
> +        error_setg(&local_err, "Property value must be in range "
> +                               "[0, %"PRId64"]", INT64_MAX);

Please print the maximum value relevant to the actual field type instead
of INT64_MAX.

> +        goto fail;
> +    }
> +
> +    cfg =3D tg->ts.cfg;
> +    switch (info->data_type) {
> +    case UINT64:
> +        {
> +            uint64_t *field =3D (void *)&cfg.buckets[info->type] + info-=
>offset;
> +            *field =3D value;
> +        }
> +        break;
> +    case DOUBLE:
> +        {
> +            double *field =3D (void *)&cfg.buckets[info->type] + info->o=
ffset;
> +            *field =3D value;
> +        }
> +        break;
> +    case UNSIGNED:
> +        {
> +            unsigned *field =3D (void *)&cfg.buckets[info->type] + info-=
>offset;
> +            *field =3D value;
> +        }
> +    }
> +
> +    tg->ts.cfg =3D cfg;
> +    goto ret;
> +
> +fail:
> +    error_propagate(errp, local_err);
> +ret:
> +    g_free(arg);
> +    return;
> +
> +}
> +
> +static void throttle_group_get(Object *obj, Visitor *v, const char *name,
> +        void *opaque, Error **errp)
> +{
> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> +    ThrottleConfig cfg;
> +    ThrottleParamInfo *info =3D opaque;
> +    ThrottleLimits *arg =3D NULL;
> +    int64_t value;
> +
> +    if (!info) {
> +        arg =3D g_new0(ThrottleLimits, 1);
> +        qemu_mutex_lock(&tg->lock);
> +        throttle_get_config(&tg->ts, &cfg);
> +        qemu_mutex_unlock(&tg->lock);
> +        throttle_config_to_throttle_limits(&cfg, arg);
> +        visit_type_ThrottleLimits(v, name, &arg, errp);
> +        g_free(arg);
> +        return;
> +    }
> +
> +    cfg =3D tg->ts.cfg;
> +    switch (info->data_type) {
> +    case UINT64:
> +        {
> +            uint64_t *field =3D (void *)&cfg.buckets[info->type] + info-=
>offset;
> +            value =3D *field;
> +        }
> +        break;
> +    case DOUBLE:
> +        {
> +            double *field =3D (void *)&cfg.buckets[info->type] + info->o=
ffset;
> +            value =3D *field;
> +        }
> +        break;
> +    case UNSIGNED:
> +        {
> +            unsigned *field =3D (void *)&cfg.buckets[info->type] + info-=
>offset;
> +            value =3D *field;
> +        }
> +    }
> +
> +    visit_type_int64(v, name, &value, errp);
> +}
> +
> +#undef THROTTLE_OPT_PREFIX
> +#define THROTTLE_OPT_PREFIX "x-"
> +static void throttle_group_obj_class_init(ObjectClass *klass, void *clas=
s_data)
> +{
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(klass);
> +
> +    ucc->complete =3D throttle_group_obj_complete;
> +    /* iops limits */
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_total_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MA=
X,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_total_max_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX
> +                              QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_total_max_length_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_read_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_read_max_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX
> +                              QEMU_OPT_IOPS_READ_MAX_LENGTH,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_read_max_length_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_write_info, &error_ab=
ort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MA=
X,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_write_max_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX
> +                              QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_write_max_length_info,
> +                              &error_abort);
> +    /* bps limits */
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_total_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_total_max_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX
> +                              QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_total_max_length_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_read_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_read_max_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_=
LENGTH,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_read_max_length_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_write_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_write_max_info,
> +                              &error_abort);
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX
> +                              QEMU_OPT_BPS_WRITE_MAX_LENGTH,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_bps_write_max_length_info,
> +                              &error_abort);
> +    /* rest */
> +    object_class_property_add(klass,
> +                              THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,
> +                              "int",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, &throttle_iops_size_info,
> +                              &error_abort);
> +
> +    /* ThrottleLimits */
> +    object_class_property_add(klass,
> +                              "limits", "ThrottleLimits",
> +                              throttle_group_get,
> +                              throttle_group_set,
> +                              NULL, NULL,
> +                              &error_abort);
> +}
> +
> +static const TypeInfo throttle_group_info =3D {
> +   .name =3D TYPE_THROTTLE_GROUP,
> +   .parent =3D TYPE_OBJECT,
> +   .class_init =3D throttle_group_obj_class_init,
> +   .instance_size =3D sizeof(ThrottleGroup),
> +   .instance_init =3D throttle_group_obj_init,
> +   .instance_finalize =3D throttle_group_obj_finalize,
> +   .interfaces =3D (InterfaceInfo[]) {
> +       { TYPE_USER_CREATABLE },
> +       { }
> +   },
> +};
> +
>  static void throttle_groups_init(void)
>  {
>      qemu_mutex_init(&throttle_groups_lock);
> +    type_register_static(&throttle_group_info);
>  }
> =20
> -block_init(throttle_groups_init);
> +type_init(throttle_groups_init);
> diff --git a/include/block/throttle-groups.h b/include/block/throttle-gro=
ups.h
> index a0f27cac63..096d05ef92 100644
> --- a/include/block/throttle-groups.h
> +++ b/include/block/throttle-groups.h
> @@ -53,6 +53,9 @@ typedef struct ThrottleGroupMember {
> =20
>  } ThrottleGroupMember;
> =20
> +#define TYPE_THROTTLE_GROUP "throttling-group"
> +#define THROTTLE_GROUP(obj) OBJECT_CHECK(ThrottleGroup, (obj), TYPE_THRO=
TTLE_GROUP)
> +
>  const char *throttle_group_get_name(ThrottleGroupMember *tgm);
> =20
>  ThrottleState *throttle_group_incref(const char *name);
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opti=
ons.h
> index 3133d1ca40..182b7896e1 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -10,81 +10,102 @@
>  #ifndef THROTTLE_OPTIONS_H
>  #define THROTTLE_OPTIONS_H
> =20
> +#define QEMU_OPT_IOPS_TOTAL "iops-total"
> +#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
> +#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
> +#define QEMU_OPT_IOPS_READ "iops-read"
> +#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
> +#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
> +#define QEMU_OPT_IOPS_WRITE "iops-write"
> +#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
> +#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
> +#define QEMU_OPT_BPS_TOTAL "bps-total"
> +#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
> +#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
> +#define QEMU_OPT_BPS_READ "bps-read"
> +#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
> +#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
> +#define QEMU_OPT_BPS_WRITE "bps-write"
> +#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
> +#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
> +#define QEMU_OPT_IOPS_SIZE "iops-size"
> +
> +#define THROTTLE_OPT_PREFIX "throttling."
>  #define THROTTLE_OPTS \
>            { \
> -            .name =3D "throttling.iops-total",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "limit total I/O operations per second",\
>          },{ \
> -            .name =3D "throttling.iops-read",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "limit read operations per second",\
>          },{ \
> -            .name =3D "throttling.iops-write",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "limit write operations per second",\
>          },{ \
> -            .name =3D "throttling.bps-total",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "limit total bytes per second",\
>          },{ \
> -            .name =3D "throttling.bps-read",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "limit read bytes per second",\
>          },{ \
> -            .name =3D "throttling.bps-write",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "limit write bytes per second",\
>          },{ \
> -            .name =3D "throttling.iops-total-max",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "I/O operations burst",\
>          },{ \
> -            .name =3D "throttling.iops-read-max",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "I/O operations read burst",\
>          },{ \
> -            .name =3D "throttling.iops-write-max",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "I/O operations write burst",\
>          },{ \
> -            .name =3D "throttling.bps-total-max",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "total bytes burst",\
>          },{ \
> -            .name =3D "throttling.bps-read-max",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "total bytes read burst",\
>          },{ \
> -            .name =3D "throttling.bps-write-max",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "total bytes write burst",\
>          },{ \
> -            .name =3D "throttling.iops-total-max-length",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENGTH=
,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "length of the iops-total-max burst period, in sec=
onds",\
>          },{ \
> -            .name =3D "throttling.iops-read-max-length",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGTH,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "length of the iops-read-max burst period, in seco=
nds",\
>          },{ \
> -            .name =3D "throttling.iops-write-max-length",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENGTH=
,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "length of the iops-write-max burst period, in sec=
onds",\
>          },{ \
> -            .name =3D "throttling.bps-total-max-length",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGTH,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "length of the bps-total-max burst period, in seco=
nds",\
>          },{ \
> -            .name =3D "throttling.bps-read-max-length",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "length of the bps-read-max burst period, in secon=
ds",\
>          },{ \
> -            .name =3D "throttling.bps-write-max-length",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGTH,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "length of the bps-write-max burst period, in seco=
nds",\
>          },{ \
> -            .name =3D "throttling.iops-size",\
> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,\
>              .type =3D QEMU_OPT_NUMBER,\
>              .help =3D "when limiting by iops max size of an I/O in bytes=
",\
>          }
> diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
> index d056008c18..17e750b12d 100644
> --- a/include/qemu/throttle.h
> +++ b/include/qemu/throttle.h
> @@ -152,5 +152,8 @@ bool throttle_schedule_timer(ThrottleState *ts,
>                               bool is_write);
> =20
>  void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
> +void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
> +                               Error **errp);
> +void throttle_config_to_throttle_limits(ThrottleConfig *cfg, ThrottleLim=
its *var);
> =20
>  #endif
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c437aa50ef..1084158b6a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1896,6 +1896,51 @@
>              '*iops_size': 'int', '*group': 'str' } }
> =20
>  ##
> +# @ThrottleLimits:
> +#
> +# Limit parameters for throttling.

Please add a note that atomic updates are recommended.  Even though
fields are optional it's best to specify all fields one wishes to change
at once instead of performing multiple changes.

> +#
> +# @iops-total:             limit total I/O operations per second
> +# @iops-total-max:         I/O operations burst
> +# @iops-total-max-length:  length of the iops-total-max burst period, in=
 seconds
> +#                          It must only be set if @iops-total-max is set=
 as well.
> +# @iops-read:              limit read operations per second
> +# @iops-read-max:          I/O operations read burst
> +# @iops-read-max-length:   length of the iops-read-max burst period, in =
seconds
> +#                          It must only be set if @iops-read-max is set =
as well.
> +# @iops-write:             limit write operations per second
> +# @iops-write-max:         I/O operations write burst
> +# @iops-write-max-length:  length of the iops-write-max burst period, in=
 seconds
> +#                          It must only be set if @iops-write-max is set=
 as well.
> +# @bps-total:              limit total bytes per second
> +# @bps-total-max:          total bytes burst
> +# @bps-total-max-length:   length of the bps-total-max burst period, in =
seconds.
> +#                          It must only be set if @bps-total-max is set =
as well.
> +# @bps-read:               limit read bytes per second
> +# @bps-read-max:           total bytes read burst
> +# @bps-read-max-length:    length of the bps-read-max burst period, in s=
econds
> +#                          It must only be set if @bps-read-max is set a=
s well.
> +# @bps-write:              limit write bytes per second
> +# @bps-write-max:          total bytes write burst
> +# @bps-write-max-length:   length of the bps-write-max burst period, in =
seconds
> +#                          It must only be set if @bps-write-max is set =
as well.
> +# @iops-size:              when limiting by iops max size of an I/O in b=
ytes
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'ThrottleLimits',
> +  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
> +            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
> +            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
> +            '*iops-write' : 'int', '*iops-write-max' : 'int',
> +            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
> +            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
> +            '*bps-read' : 'int', '*bps-read-max' : 'int',
> +            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
> +            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
> +            '*iops-size' : 'int' } }
> +
> +##
>  # @block-stream:
>  #
>  # Copy data from a backing file into a block device.
> diff --git a/tests/test-throttle.c b/tests/test-throttle.c
> index 57cf5ba711..0ea9093eee 100644
> --- a/tests/test-throttle.c
> +++ b/tests/test-throttle.c
> @@ -662,6 +662,7 @@ int main(int argc, char **argv)
>      qemu_init_main_loop(&error_fatal);
>      ctx =3D qemu_get_aio_context();
>      bdrv_init();
> +    module_call_init(MODULE_INIT_QOM);
> =20
>      do {} while (g_main_context_iteration(NULL, false));
> =20
> diff --git a/util/throttle.c b/util/throttle.c
> index b2a52b8b34..3bb21a63e6 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -502,3 +502,124 @@ void throttle_account(ThrottleState *ts, bool is_wr=
ite, uint64_t size)
>      }
>  }
> =20
> +/* return a ThrottleConfig based on the options in a ThrottleLimits
> + *
> + * @arg:    the ThrottleLimits object to read from
> + * @cfg:    the ThrottleConfig to edit
> + * @errp:   error object
> + */
> +void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
> +                               Error **errp)
> +{
> +    if (arg->has_bps_total) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps_total;
> +    }
> +    if (arg->has_bps_read) {
> +        cfg->buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_read;
> +    }
> +    if (arg->has_bps_write) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_write;
> +    }
> +
> +    if (arg->has_iops_total) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops_total;
> +    }
> +    if (arg->has_iops_read) {
> +        cfg->buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_read;
> +    }
> +    if (arg->has_iops_write) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_write;
> +    }
> +
> +    if (arg->has_bps_total_max) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_total_max;
> +    }
> +    if (arg->has_bps_read_max) {
> +        cfg->buckets[THROTTLE_BPS_READ].max =3D arg->bps_read_max;
> +    }
> +    if (arg->has_bps_write_max) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_write_max;
> +    }
> +    if (arg->has_iops_total_max) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_total_max;
> +    }
> +    if (arg->has_iops_read_max) {
> +        cfg->buckets[THROTTLE_OPS_READ].max =3D arg->iops_read_max;
> +    }
> +    if (arg->has_iops_write_max) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_write_max;
> +    }
> +
> +    if (arg->has_bps_total_max_length) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_total=
_max_length;
> +    }
> +    if (arg->has_bps_read_max_length) {
> +        cfg->buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_read_m=
ax_length;
> +    }
> +    if (arg->has_bps_write_max_length) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_write=
_max_length;
> +    }
> +    if (arg->has_iops_total_max_length) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_tota=
l_max_length;
> +    }
> +    if (arg->has_iops_read_max_length) {
> +        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_read_=
max_length;
> +    }
> +    if (arg->has_iops_write_max_length) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_writ=
e_max_length;
> +    }
> +
> +    if (arg->has_iops_size) {
> +        cfg->op_size =3D arg->iops_size;
> +    }
> +
> +    throttle_is_valid(cfg, errp);
> +}
> +
> +/* write the options of a ThrottleConfig to a ThrottleLimits
> + *
> + * @cfg:    the ThrottleConfig to read from
> + * @var:    the ThrottleLimits to write to
> + */
> +void throttle_config_to_throttle_limits(ThrottleConfig *cfg, ThrottleLim=
its *var)
> +{
> +    var->bps_total               =3D cfg->buckets[THROTTLE_BPS_TOTAL].av=
g;
> +    var->bps_read                =3D cfg->buckets[THROTTLE_BPS_READ].avg;
> +    var->bps_write               =3D cfg->buckets[THROTTLE_BPS_WRITE].av=
g;
> +    var->iops_total              =3D cfg->buckets[THROTTLE_OPS_TOTAL].av=
g;
> +    var->iops_read               =3D cfg->buckets[THROTTLE_OPS_READ].avg;
> +    var->iops_write              =3D cfg->buckets[THROTTLE_OPS_WRITE].av=
g;
> +    var->bps_total_max           =3D cfg->buckets[THROTTLE_BPS_TOTAL].ma=
x;
> +    var->bps_read_max            =3D cfg->buckets[THROTTLE_BPS_READ].max;
> +    var->bps_write_max           =3D cfg->buckets[THROTTLE_BPS_WRITE].ma=
x;
> +    var->iops_total_max          =3D cfg->buckets[THROTTLE_OPS_TOTAL].ma=
x;
> +    var->iops_read_max           =3D cfg->buckets[THROTTLE_OPS_READ].max;
> +    var->iops_write_max          =3D cfg->buckets[THROTTLE_OPS_WRITE].ma=
x;
> +    var->bps_total_max_length    =3D cfg->buckets[THROTTLE_BPS_TOTAL].bu=
rst_length;
> +    var->bps_read_max_length     =3D cfg->buckets[THROTTLE_BPS_READ].bur=
st_length;
> +    var->bps_write_max_length    =3D cfg->buckets[THROTTLE_BPS_WRITE].bu=
rst_length;
> +    var->iops_total_max_length   =3D cfg->buckets[THROTTLE_OPS_TOTAL].bu=
rst_length;
> +    var->iops_read_max_length    =3D cfg->buckets[THROTTLE_OPS_READ].bur=
st_length;
> +    var->iops_write_max_length   =3D cfg->buckets[THROTTLE_OPS_WRITE].bu=
rst_length;
> +    var->iops_size               =3D cfg->op_size;
> +
> +    var->has_bps_total =3D true;
> +    var->has_bps_read =3D true;
> +    var->has_bps_write =3D true;
> +    var->has_iops_total =3D true;
> +    var->has_iops_read =3D true;
> +    var->has_iops_write =3D true;
> +    var->has_bps_total_max =3D true;
> +    var->has_bps_read_max =3D true;
> +    var->has_bps_write_max =3D true;
> +    var->has_iops_total_max =3D true;
> +    var->has_iops_read_max =3D true;
> +    var->has_iops_write_max =3D true;
> +    var->has_bps_read_max_length =3D true;
> +    var->has_bps_total_max_length =3D true;
> +    var->has_bps_write_max_length =3D true;
> +    var->has_iops_total_max_length =3D true;
> +    var->has_iops_read_max_length =3D true;
> +    var->has_iops_write_max_length =3D true;
> +    var->has_iops_size =3D true;
> +}
> --=20
> 2.11.0
>=20

--SBT+cnFS/G3NVgv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdg5vAAoJEJykq7OBq3PIl4cIAIdeIN4AMQ3l9PGeGx/HdB71
XBubK5/48mBJn5Cq2sJorb0wR45x5U4qbQKkD/Ejb2P0GrQKwGOYkVYfpho7oLyg
xqm3cbgMQl0dWa6FMcaKcd9OOHstdI6FDGiQLDyxayngfiRXd5BymQuNF0ln1Ekg
OYVzsSJTAvSyNvylZEIlUMwN8g/TetO1YCrUQ2YjghofUo8NU0qAx6ldTm/a5fwG
mPu7mGHlKPDg8S3vN6+nTspYupbEqat8TBSfWAAbNocF3GJTS6Sy4AZVRvfZIVAY
qsIQdZrgUkKtLwiTZDNTipH3pgUbNbXpeq8ozHDSjvyLz+lvqhwjwo7prbj8lXI=
=Z5Vg
-----END PGP SIGNATURE-----

--SBT+cnFS/G3NVgv4--
