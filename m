Received: from eggs.gnu.org ([2001:4830:134:3::10]:46781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcaNI-0006jm-4l
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcaNE-0007kr-Gw
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:50:28 -0400
Date: Tue, 1 Aug 2017 19:49:33 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170801164933.c54ocjzr26sxaizy@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muickcuy6dlrie5f"
Content-Disposition: inline
In-Reply-To: <20170801154703.GD22017@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--muickcuy6dlrie5f
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 04:47:03PM +0100, Stefan Hajnoczi wrote:
>On Mon, Jul 31, 2017 at 12:54:40PM +0300, Manos Pitsidianakis wrote:
>> ThrottleGroup is converted to an object. This will allow the future
>> throttle block filter drive easy creation and configuration of throttle
>> groups in QMP and cli.
>>
>> A new QAPI struct, ThrottleLimits, is introduced to provide a shared
>> struct for all throttle configuration needs in QMP.
>>
>> ThrottleGroups can be created via CLI as
>>     -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
>> where x-* are individual limit properties. Since we can't add non-scalar
>> properties in -object this interface must be used instead. However,
>> setting these properties must be disabled after initialization because
>> certain combinations of limits are forbidden and thus configuration
>> changes should be done in one transaction. The individual properties
>> will go away when support for non-scalar values in CLI is implemented
>> and thus are marked as experimental.
>>
>> ThrottleGroup also has a `limits` property that uses the ThrottleLimits
>> struct.  It can be used to create ThrottleGroups or set the
>> configuration in existing groups as follows:
>>
>> { "execute": "object-add",
>>   "arguments": {
>>     "qom-type": "throttle-group",
>>     "id": "foo",
>>     "props" : {
>>       "limits": {
>>           "iops-total": 100
>>       }
>>     }
>>   }
>> }
>> { "execute" : "qom-set",
>>     "arguments" : {
>>         "path" : "foo",
>>         "property" : "limits",
>>         "value" : {
>>             "iops-total" : 99
>>         }
>>     }
>> }
>>
>> This also means a group's configuration can be fetched with qom-get.
>>
>> ThrottleGroups can be anonymous which means they can't get accessed by
>> other users ie they will always be units instead of group (Because they
>> have one ThrottleGroupMember).
>
>blockdev.c automatically assigns -drive id=3D to the group name if
>throttling.group=3D wasn't given.  So who will use anonymous single-drive
>mode?

Manual filter nodes. It's possible to not pass a group name value and=20
the resulting group will be anonymous. Are you suggesting to move this=20
change to the throttle filter patch?

>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>> Notes:
>>     Note: I tested Markus Armbruster's patch in <87wp7fghi9.fsf@dusky.po=
nd.sub.org>
>>     on master and I can use this syntax successfuly:
>>     -object '{ "qom-type" : "throttle-group", "id" : "foo", "props" : { =
"limits" \
>>     : { "iops-total" : 1000 } } }'
>>     If this gets merged using -object will be a little more verbose but =
at least we
>>     won't have seperate properties, which is a good thing, so the x-* sh=
ould be
>>     dropped.
>>
>>  block/throttle-groups.c         | 402 +++++++++++++++++++++++++++++++++=
+++----
>>  include/block/throttle-groups.h |   3 +
>>  include/qemu/throttle-options.h |  59 ++++--
>>  include/qemu/throttle.h         |   3 +
>>  qapi/block-core.json            |  48 +++++
>>  tests/test-throttle.c           |   1 +
>>  util/throttle.c                 | 151 +++++++++++++++
>>  7 files changed, 617 insertions(+), 50 deletions(-)
>>
>> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
>> index f711a3dc62..b9c5036e44 100644
>> --- a/block/throttle-groups.c
>> +++ b/block/throttle-groups.c
>> @@ -25,9 +25,17 @@
>>  #include "qemu/osdep.h"
>>  #include "sysemu/block-backend.h"
>>  #include "block/throttle-groups.h"
>> +#include "qemu/throttle-options.h"
>>  #include "qemu/queue.h"
>>  #include "qemu/thread.h"
>>  #include "sysemu/qtest.h"
>> +#include "qapi/error.h"
>> +#include "qapi-visit.h"
>> +#include "qom/object.h"
>> +#include "qom/object_interfaces.h"
>> +
>> +static void throttle_group_obj_init(Object *obj);
>> +static void throttle_group_obj_complete(UserCreatable *obj, Error **err=
p);
>>
>>  /* The ThrottleGroup structure (with its ThrottleState) is shared
>>   * among different ThrottleGroupMembers and it's independent from
>> @@ -54,6 +62,10 @@
>>   * that ThrottleGroupMember has throttled requests in the queue.
>>   */
>>  typedef struct ThrottleGroup {
>> +    Object parent_obj;
>> +
>> +    /* refuse individual property change if initialization is complete =
*/
>> +    bool is_initialized;
>>      char *name; /* This is constant during the lifetime of the group */
>>
>>      QemuMutex lock; /* This lock protects the following four fields */
>> @@ -63,8 +75,7 @@ typedef struct ThrottleGroup {
>>      bool any_timer_armed[2];
>>      QEMUClockType clock_type;
>>
>> -    /* These two are protected by the global throttle_groups_lock */
>> -    unsigned refcount;
>> +    /* This is protected by the global throttle_groups_lock */
>>      QTAILQ_ENTRY(ThrottleGroup) list;
>>  } ThrottleGroup;
>>
>> @@ -77,7 +88,8 @@ static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =3D
>>   * If no ThrottleGroup is found with the given name a new one is
>>   * created.
>>   *
>> - * @name: the name of the ThrottleGroup
>> + * @name: the name of the ThrottleGroup, NULL means a new anonymous gro=
up will
>> + *        be created.
>>   * @ret:  the ThrottleState member of the ThrottleGroup
>>   */
>>  ThrottleState *throttle_group_incref(const char *name)
>> @@ -87,32 +99,30 @@ ThrottleState *throttle_group_incref(const char *nam=
e)
>>
>>      qemu_mutex_lock(&throttle_groups_lock);
>>
>> -    /* Look for an existing group with that name */
>> -    QTAILQ_FOREACH(iter, &throttle_groups, list) {
>> -        if (!strcmp(name, iter->name)) {
>> -            tg =3D iter;
>> -            break;
>> +    if (name) {
>> +        /* Look for an existing group with that name */
>> +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
>> +            if (!g_strcmp0(name, iter->name)) {
>> +                tg =3D iter;
>> +                break;
>> +            }
>>          }
>>      }
>>
>>      /* Create a new one if not found */
>>      if (!tg) {
>> -        tg =3D g_new0(ThrottleGroup, 1);
>> +        /* new ThrottleGroup obj will have a refcnt =3D 1 */
>> +        tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
>>          tg->name =3D g_strdup(name);
>> -        tg->clock_type =3D QEMU_CLOCK_REALTIME;
>> -
>> -        if (qtest_enabled()) {
>> -            /* For testing block IO throttling only */
>> -            tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
>> -        }
>> -        qemu_mutex_init(&tg->lock);
>> -        throttle_init(&tg->ts);
>> -        QLIST_INIT(&tg->head);
>> -
>> -        QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
>> +        throttle_group_obj_complete((UserCreatable *)tg, &error_abort);
>>      }
>>
>> -    tg->refcount++;
>> +    qemu_mutex_lock(&tg->lock);
>> +    if (!QLIST_EMPTY(&tg->head)) {
>> +        /* only ref if the group is not empty */
>> +        object_ref(OBJECT(tg));
>> +    }
>> +    qemu_mutex_unlock(&tg->lock);
>
>How do the refcounts work in various cases (legacy -drive
>throttling.group and -object throttle-group with 0, 1, or multiple
>drives)?
>
>It's not obvious to me that this code works in all cases.

Object is created with object_new(): ref count is 1
Each time we call throttle_group_incref() to add a new member to the=20
group, we increase the ref count by 1. We skip the first time we do that=20
because there's already a reference. When all members are removed,=20
object is deleted.

>>
>>      qemu_mutex_unlock(&throttle_groups_lock);
>>
>> @@ -129,15 +139,7 @@ ThrottleState *throttle_group_incref(const char *na=
me)
>>  void throttle_group_unref(ThrottleState *ts)
>>  {
>>      ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
>> -
>> -    qemu_mutex_lock(&throttle_groups_lock);
>> -    if (--tg->refcount =3D=3D 0) {
>> -        QTAILQ_REMOVE(&throttle_groups, tg, list);
>> -        qemu_mutex_destroy(&tg->lock);
>> -        g_free(tg->name);
>> -        g_free(tg);
>> -    }
>> -    qemu_mutex_unlock(&throttle_groups_lock);
>> +    object_unref(OBJECT(tg));
>>  }
>>
>>  /* Get the name from a ThrottleGroupMember's group. The name (and the p=
ointer)
>> @@ -572,9 +574,347 @@ void throttle_group_detach_aio_context(ThrottleGro=
upMember *tgm)
>>      throttle_timers_detach_aio_context(tt);
>>  }
>>
>> +#undef THROTTLE_OPT_PREFIX
>> +#define THROTTLE_OPT_PREFIX "x-"
>> +#define DOUBLE 0
>> +#define UINT64 1
>> +#define UNSIGNED 2
>> +
>> +typedef struct {
>> +    const char *name;
>> +    BucketType type;
>> +    int data_type;
>> +    const ptrdiff_t offset; /* offset in LeakyBucket struct. */
>> +} ThrottleParamInfo;
>> +
>> +static ThrottleParamInfo properties[] =3D {
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,
>> +    THROTTLE_OPS_TOTAL, DOUBLE, offsetof(LeakyBucket, avg),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX,
>> +    THROTTLE_OPS_TOTAL, DOUBLE, offsetof(LeakyBucket, max),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
>> +    THROTTLE_OPS_TOTAL, UNSIGNED, offsetof(LeakyBucket, burst_length),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,
>> +    THROTTLE_OPS_READ, DOUBLE, offsetof(LeakyBucket, avg),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX,
>> +    THROTTLE_OPS_READ, DOUBLE, offsetof(LeakyBucket, max),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGTH,
>> +    THROTTLE_OPS_READ, UNSIGNED, offsetof(LeakyBucket, burst_length),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,
>> +    THROTTLE_OPS_WRITE, DOUBLE, offsetof(LeakyBucket, avg),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX,
>> +    THROTTLE_OPS_WRITE, DOUBLE, offsetof(LeakyBucket, max),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
>> +    THROTTLE_OPS_WRITE, UNSIGNED, offsetof(LeakyBucket, burst_length),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,
>> +    THROTTLE_BPS_TOTAL, DOUBLE, offsetof(LeakyBucket, avg),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX,
>> +    THROTTLE_BPS_TOTAL, DOUBLE, offsetof(LeakyBucket, max),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
>> +    THROTTLE_BPS_TOTAL, UNSIGNED, offsetof(LeakyBucket, burst_length),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,
>> +    THROTTLE_BPS_READ, DOUBLE, offsetof(LeakyBucket, avg),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX,
>> +    THROTTLE_BPS_READ, DOUBLE, offsetof(LeakyBucket, max),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH,
>> +    THROTTLE_BPS_READ, UNSIGNED, offsetof(LeakyBucket, burst_length),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,
>> +    THROTTLE_BPS_WRITE, DOUBLE, offsetof(LeakyBucket, avg),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX,
>> +    THROTTLE_BPS_WRITE, DOUBLE, offsetof(LeakyBucket, max),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGTH,
>> +    THROTTLE_BPS_WRITE, UNSIGNED, offsetof(LeakyBucket, burst_length),
>> +},
>> +{
>> +    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,
>> +    0, UINT64, offsetof(ThrottleConfig, op_size),
>> +}
>> +};
>> +
>> +static void throttle_group_obj_init(Object *obj)
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +
>> +    tg->clock_type =3D QEMU_CLOCK_REALTIME;
>> +    if (qtest_enabled()) {
>> +        /* For testing block IO throttling only */
>> +        tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
>> +    }
>> +    tg->is_initialized =3D false;
>> +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
>
>Is the lock taken when the object-add QMP command or -object
>command-line argument are used?
>
>In any case, please do not assume that throttle_groups_lock is held for
>Object->init().  It should be possible to create new instances at any
>time.

Hm, isn't the global lock held in both cases? And in the third case=20
where we create the object from throttle_group_incref() we hold the=20
throttle_groups_lock.


>> +    qemu_mutex_init(&tg->lock);
>> +    throttle_init(&tg->ts);
>> +    QLIST_INIT(&tg->head);
>> +}
>> +
>> +static void throttle_group_obj_complete(UserCreatable *obj, Error **err=
p)
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj), *iter;
>> +    ThrottleConfig *cfg =3D &tg->ts.cfg;
>> +
>> +    /* set group name to object id if it exists */
>> +    if (!tg->name && tg->parent_obj.parent) {
>> +        tg->name =3D object_get_canonical_path_component(OBJECT(obj));
>> +    }
>> +
>> +    if (tg->name) {
>> +        /* error if name is duplicate */
>> +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
>
>Same locking issue: is throttle_groups_lock held here in all cases?  I
>think it's not held in the object-add QMP and -object throttle-group
>cases.
>
>> +            if (!g_strcmp0(tg->name, iter->name) && tg !=3D iter) {
>> +                error_setg(errp, "A group with this name already exists=
");
>> +                return;
>> +            }
>> +        }
>> +    }
>> +
>> +    /* unfix buckets to check validity */
>> +    throttle_get_config(&tg->ts, cfg);
>> +    if (!throttle_is_valid(cfg, errp)) {
>> +        return;
>> +    }
>> +    /* fix buckets again */
>> +    throttle_config(&tg->ts, tg->clock_type, cfg);
>> +
>> +    tg->is_initialized =3D true;
>> +}
>> +
>> +static void throttle_group_obj_finalize(Object *obj)
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    qemu_mutex_lock(&throttle_groups_lock);
>> +    QTAILQ_REMOVE(&throttle_groups, tg, list);
>> +    qemu_mutex_unlock(&throttle_groups_lock);
>> +    qemu_mutex_destroy(&tg->lock);
>> +    g_free(tg->name);
>> +}
>> +
>> +static void throttle_group_set(Object *obj, Visitor *v, const char * na=
me,
>> +        void *opaque, Error **errp)
>> +
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +    ThrottleParamInfo *info =3D opaque;
>> +    ThrottleLimits *arg =3D NULL;
>> +    Error *local_err =3D NULL;
>> +    int64_t value;
>> +
>> +    /* If we have finished initialization, don't accept individual prop=
erty
>> +     * changes through QOM. Throttle configuration limits must be set i=
n one
>> +     * transaction, as certain combinations are invalid.
>> +     */
>> +    if (tg->is_initialized) {
>> +        error_setg(&local_err, "Property cannot be set after initializa=
tion");
>> +        goto fail;
>> +    }
>> +
>> +    visit_type_int64(v, name, &value, &local_err);
>> +    if (local_err) {
>> +        goto fail;
>> +    }
>> +    if (value < 0) {
>> +        error_setg(&local_err, "Property values cannot be negative");
>> +        goto fail;
>> +    }
>> +
>> +    cfg =3D tg->ts.cfg;
>> +    switch (info->data_type) {
>> +    case UINT64:
>> +        {
>> +            uint64_t *field =3D (void *)&cfg.buckets[info->type] + info=
->offset;
>> +            *field =3D value;
>> +        }
>> +        break;
>> +    case DOUBLE:
>> +        {
>> +            double *field =3D (void *)&cfg.buckets[info->type] + info->=
offset;
>> +            *field =3D value;
>> +        }
>> +        break;
>> +    case UNSIGNED:
>> +        {
>> +            if (value > UINT_MAX) {
>> +                error_setg(&local_err, "%s value must be in the"
>> +                                       "range [0, %u]", info->name, UIN=
T_MAX);
>> +                goto fail;
>> +            }
>> +            unsigned *field =3D (void *)&cfg.buckets[info->type] + info=
->offset;
>> +            *field =3D value;
>> +        }
>> +    }
>> +
>> +    tg->ts.cfg =3D cfg;
>> +    goto ret;
>> +
>> +fail:
>> +    error_propagate(errp, local_err);
>> +ret:
>> +    g_free(arg);
>> +    return;
>
>arg is unused, please drop it.

Oops!
>
>> +
>> +}
>> +
>> +static void throttle_group_get(Object *obj, Visitor *v, const char *nam=
e,
>> +        void *opaque, Error **errp)
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +    ThrottleParamInfo *info =3D opaque;
>> +    int64_t value;
>> +
>> +    cfg =3D tg->ts.cfg;
>> +    switch (info->data_type) {
>> +    case UINT64:
>> +        {
>> +            uint64_t *field =3D (void *)&cfg.buckets[info->type] + info=
->offset;
>> +            value =3D *field;
>> +        }
>> +        break;
>> +    case DOUBLE:
>> +        {
>> +            double *field =3D (void *)&cfg.buckets[info->type] + info->=
offset;
>> +            value =3D *field;
>> +        }
>> +        break;
>> +    case UNSIGNED:
>> +        {
>> +            unsigned *field =3D (void *)&cfg.buckets[info->type] + info=
->offset;
>> +            value =3D *field;
>> +        }
>> +    }
>> +
>> +    visit_type_int64(v, name, &value, errp);
>> +}
>> +
>> +static void throttle_group_set_limits(Object *obj, Visitor *v,
>> +                                      const char *name, void *opaque,
>> +                                      Error **errp)
>> +
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +    ThrottleLimits *arg =3D NULL;
>> +    Error *local_err =3D NULL;
>> +
>> +    arg =3D g_new0(ThrottleLimits, 1);
>
>Why does ThrottleLimits need to be allocated on the heap?

It is passed to visit_type_ThrottleLimits which needs a double pointer. =20
The alternative would be:

    ThrottleLimits arg =3D { 0 }, *p =3D &arg;
    visit_type_ThrottleLimits(v, name, &p, &local_err);

Which didn't seem very pretty at the time. Is it a problem?

>
>> +    visit_type_ThrottleLimits(v, name, &arg, &local_err);
>> +    if (local_err) {
>> +        goto fail;
>> +    }
>> +    qemu_mutex_lock(&tg->lock);
>> +    throttle_get_config(&tg->ts, &cfg);
>> +    throttle_limits_to_config(arg, &cfg, &local_err);
>> +    if (local_err) {
>> +        qemu_mutex_unlock(&tg->lock);
>> +        goto fail;
>> +    }
>> +    throttle_config(&tg->ts, tg->clock_type, &cfg);
>> +    qemu_mutex_unlock(&tg->lock);
>> +
>> +    goto ret;
>
>error_propagate() is a nop if local_err is NULL so this goto is
>unnecessary.
>
>> +
>> +fail:
>> +    error_propagate(errp, local_err);
>> +ret:
>> +    g_free(arg);
>> +    return;
>> +}
>> +
>> +static void throttle_group_get_limits(Object *obj, Visitor *v,
>> +                                      const char *name, void *opaque,
>> +                                      Error **errp)
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg;
>> +    ThrottleLimits *arg =3D NULL;
>> +
>> +    arg =3D g_new0(ThrottleLimits, 1);
>> +    qemu_mutex_lock(&tg->lock);
>> +    throttle_get_config(&tg->ts, &cfg);
>> +    qemu_mutex_unlock(&tg->lock);
>> +    throttle_config_to_throttle_limits(&cfg, arg);
>> +    visit_type_ThrottleLimits(v, name, &arg, errp);
>> +    g_free(arg);
>> +}
>> +
>> +static void throttle_group_obj_class_init(ObjectClass *klass, void *cla=
ss_data)
>> +{
>> +    size_t i =3D 0;
>> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(klass);
>> +
>> +    ucc->complete =3D throttle_group_obj_complete;
>> +    /* individual properties */
>> +    for (i =3D 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i=
++) {
>> +        object_class_property_add(klass,
>> +                properties[i].name,
>> +                "int",
>> +                throttle_group_get,
>> +                throttle_group_set,
>> +                NULL, &properties[i],
>> +                &error_abort);
>> +    }
>> +
>> +    /* ThrottleLimits */
>> +    object_class_property_add(klass,
>> +                              "limits", "ThrottleLimits",
>> +                              throttle_group_get_limits,
>> +                              throttle_group_set_limits,
>> +                              NULL, NULL,
>> +                              &error_abort);
>> +}
>> +
>> +static const TypeInfo throttle_group_info =3D {
>> +   .name =3D TYPE_THROTTLE_GROUP,
>> +   .parent =3D TYPE_OBJECT,
>> +   .class_init =3D throttle_group_obj_class_init,
>> +   .instance_size =3D sizeof(ThrottleGroup),
>> +   .instance_init =3D throttle_group_obj_init,
>> +   .instance_finalize =3D throttle_group_obj_finalize,
>> +   .interfaces =3D (InterfaceInfo[]) {
>> +       { TYPE_USER_CREATABLE },
>> +       { }
>> +   },
>> +};
>> +
>>  static void throttle_groups_init(void)
>>  {
>>      qemu_mutex_init(&throttle_groups_lock);
>> +    type_register_static(&throttle_group_info);
>>  }
>>
>> -block_init(throttle_groups_init);
>> +type_init(throttle_groups_init);
>> diff --git a/include/block/throttle-groups.h b/include/block/throttle-gr=
oups.h
>> index a0f27cac63..82f030523f 100644
>> --- a/include/block/throttle-groups.h
>> +++ b/include/block/throttle-groups.h
>> @@ -53,6 +53,9 @@ typedef struct ThrottleGroupMember {
>>
>>  } ThrottleGroupMember;
>>
>> +#define TYPE_THROTTLE_GROUP "throttle-group"
>> +#define THROTTLE_GROUP(obj) OBJECT_CHECK(ThrottleGroup, (obj), TYPE_THR=
OTTLE_GROUP)
>> +
>>  const char *throttle_group_get_name(ThrottleGroupMember *tgm);
>>
>>  ThrottleState *throttle_group_incref(const char *name);
>> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opt=
ions.h
>> index 3133d1ca40..182b7896e1 100644
>> --- a/include/qemu/throttle-options.h
>> +++ b/include/qemu/throttle-options.h
>> @@ -10,81 +10,102 @@
>>  #ifndef THROTTLE_OPTIONS_H
>>  #define THROTTLE_OPTIONS_H
>>
>> +#define QEMU_OPT_IOPS_TOTAL "iops-total"
>> +#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
>> +#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
>> +#define QEMU_OPT_IOPS_READ "iops-read"
>> +#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
>> +#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
>> +#define QEMU_OPT_IOPS_WRITE "iops-write"
>> +#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
>> +#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
>> +#define QEMU_OPT_BPS_TOTAL "bps-total"
>> +#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
>> +#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
>> +#define QEMU_OPT_BPS_READ "bps-read"
>> +#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
>> +#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
>> +#define QEMU_OPT_BPS_WRITE "bps-write"
>> +#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
>> +#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
>> +#define QEMU_OPT_IOPS_SIZE "iops-size"
>> +
>> +#define THROTTLE_OPT_PREFIX "throttling."
>>  #define THROTTLE_OPTS \
>>            { \
>> -            .name =3D "throttling.iops-total",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "limit total I/O operations per second",\
>>          },{ \
>> -            .name =3D "throttling.iops-read",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "limit read operations per second",\
>>          },{ \
>> -            .name =3D "throttling.iops-write",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "limit write operations per second",\
>>          },{ \
>> -            .name =3D "throttling.bps-total",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "limit total bytes per second",\
>>          },{ \
>> -            .name =3D "throttling.bps-read",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "limit read bytes per second",\
>>          },{ \
>> -            .name =3D "throttling.bps-write",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "limit write bytes per second",\
>>          },{ \
>> -            .name =3D "throttling.iops-total-max",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "I/O operations burst",\
>>          },{ \
>> -            .name =3D "throttling.iops-read-max",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "I/O operations read burst",\
>>          },{ \
>> -            .name =3D "throttling.iops-write-max",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "I/O operations write burst",\
>>          },{ \
>> -            .name =3D "throttling.bps-total-max",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "total bytes burst",\
>>          },{ \
>> -            .name =3D "throttling.bps-read-max",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "total bytes read burst",\
>>          },{ \
>> -            .name =3D "throttling.bps-write-max",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "total bytes write burst",\
>>          },{ \
>> -            .name =3D "throttling.iops-total-max-length",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENGT=
H,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "length of the iops-total-max burst period, in se=
conds",\
>>          },{ \
>> -            .name =3D "throttling.iops-read-max-length",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGTH=
,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "length of the iops-read-max burst period, in sec=
onds",\
>>          },{ \
>> -            .name =3D "throttling.iops-write-max-length",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENGT=
H,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "length of the iops-write-max burst period, in se=
conds",\
>>          },{ \
>> -            .name =3D "throttling.bps-total-max-length",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGTH=
,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "length of the bps-total-max burst period, in sec=
onds",\
>>          },{ \
>> -            .name =3D "throttling.bps-read-max-length",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "length of the bps-read-max burst period, in seco=
nds",\
>>          },{ \
>> -            .name =3D "throttling.bps-write-max-length",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGTH=
,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "length of the bps-write-max burst period, in sec=
onds",\
>>          },{ \
>> -            .name =3D "throttling.iops-size",\
>> +            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,\
>>              .type =3D QEMU_OPT_NUMBER,\
>>              .help =3D "when limiting by iops max size of an I/O in byte=
s",\
>>          }
>> diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
>> index d056008c18..17e750b12d 100644
>> --- a/include/qemu/throttle.h
>> +++ b/include/qemu/throttle.h
>> @@ -152,5 +152,8 @@ bool throttle_schedule_timer(ThrottleState *ts,
>>                               bool is_write);
>>
>>  void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
>> +void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
>> +                               Error **errp);
>> +void throttle_config_to_throttle_limits(ThrottleConfig *cfg, ThrottleLi=
mits *var);
>>
>>  #endif
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 833c602150..0bdc69aa5f 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1905,6 +1905,54 @@
>>              '*iops_size': 'int', '*group': 'str' } }
>>
>>  ##
>> +# @ThrottleLimits:
>> +#
>> +# Limit parameters for throttling.
>> +# Since some limit combinations are illegal, limits should always be se=
t in one
>> +# transaction. All fields are optional. When setting limits, if a field=
 is
>> +# missing the current value is not changed.
>> +#
>> +# @iops-total:             limit total I/O operations per second
>> +# @iops-total-max:         I/O operations burst
>> +# @iops-total-max-length:  length of the iops-total-max burst period, i=
n seconds
>> +#                          It must only be set if @iops-total-max is se=
t as well.
>> +# @iops-read:              limit read operations per second
>> +# @iops-read-max:          I/O operations read burst
>> +# @iops-read-max-length:   length of the iops-read-max burst period, in=
 seconds
>> +#                          It must only be set if @iops-read-max is set=
 as well.
>> +# @iops-write:             limit write operations per second
>> +# @iops-write-max:         I/O operations write burst
>> +# @iops-write-max-length:  length of the iops-write-max burst period, i=
n seconds
>> +#                          It must only be set if @iops-write-max is se=
t as well.
>> +# @bps-total:              limit total bytes per second
>> +# @bps-total-max:          total bytes burst
>> +# @bps-total-max-length:   length of the bps-total-max burst period, in=
 seconds.
>> +#                          It must only be set if @bps-total-max is set=
 as well.
>> +# @bps-read:               limit read bytes per second
>> +# @bps-read-max:           total bytes read burst
>> +# @bps-read-max-length:    length of the bps-read-max burst period, in =
seconds
>> +#                          It must only be set if @bps-read-max is set =
as well.
>> +# @bps-write:              limit write bytes per second
>> +# @bps-write-max:          total bytes write burst
>> +# @bps-write-max-length:   length of the bps-write-max burst period, in=
 seconds
>> +#                          It must only be set if @bps-write-max is set=
 as well.
>> +# @iops-size:              when limiting by iops max size of an I/O in =
bytes
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'struct': 'ThrottleLimits',
>> +  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
>> +            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
>> +            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
>> +            '*iops-write' : 'int', '*iops-write-max' : 'int',
>> +            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
>> +            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
>> +            '*bps-read' : 'int', '*bps-read-max' : 'int',
>> +            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
>> +            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
>> +            '*iops-size' : 'int' } }
>> +
>> +##
>>  # @block-stream:
>>  #
>>  # Copy data from a backing file into a block device.
>> diff --git a/tests/test-throttle.c b/tests/test-throttle.c
>> index 57cf5ba711..0ea9093eee 100644
>> --- a/tests/test-throttle.c
>> +++ b/tests/test-throttle.c
>> @@ -662,6 +662,7 @@ int main(int argc, char **argv)
>>      qemu_init_main_loop(&error_fatal);
>>      ctx =3D qemu_get_aio_context();
>>      bdrv_init();
>> +    module_call_init(MODULE_INIT_QOM);
>>
>>      do {} while (g_main_context_iteration(NULL, false));
>>
>> diff --git a/util/throttle.c b/util/throttle.c
>> index b2a52b8b34..99fd73157b 100644
>> --- a/util/throttle.c
>> +++ b/util/throttle.c
>> @@ -502,3 +502,154 @@ void throttle_account(ThrottleState *ts, bool is_w=
rite, uint64_t size)
>>      }
>>  }
>>
>> +/* return a ThrottleConfig based on the options in a ThrottleLimits
>> + *
>> + * @arg:    the ThrottleLimits object to read from
>> + * @cfg:    the ThrottleConfig to edit
>> + * @errp:   error object
>> + */
>> +void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
>> +                               Error **errp)
>> +{
>> +    if (arg->has_bps_total) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps_total;
>> +    }
>> +    if (arg->has_bps_read) {
>> +        cfg->buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_read;
>> +    }
>> +    if (arg->has_bps_write) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_write;
>> +    }
>> +
>> +    if (arg->has_iops_total) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops_total;
>> +    }
>> +    if (arg->has_iops_read) {
>> +        cfg->buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_read;
>> +    }
>> +    if (arg->has_iops_write) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_write;
>> +    }
>> +
>> +    if (arg->has_bps_total_max) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_total_max;
>> +    }
>> +    if (arg->has_bps_read_max) {
>> +        cfg->buckets[THROTTLE_BPS_READ].max =3D arg->bps_read_max;
>> +    }
>> +    if (arg->has_bps_write_max) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_write_max;
>> +    }
>> +    if (arg->has_iops_total_max) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_total_max;
>> +    }
>> +    if (arg->has_iops_read_max) {
>> +        cfg->buckets[THROTTLE_OPS_READ].max =3D arg->iops_read_max;
>> +    }
>> +    if (arg->has_iops_write_max) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_write_max;
>> +    }
>> +
>> +    if (arg->has_bps_total_max_length) {
>> +        if (arg->bps_total_max_length > UINT_MAX) {
>> +            error_setg(errp, "bps-total-max-length value must be in"
>> +                    " the range [0, %u]", UINT_MAX);
>> +            return;
>> +        }
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_tota=
l_max_length;
>> +    }
>> +    if (arg->has_bps_read_max_length) {
>> +        if (arg->bps_read_max_length > UINT_MAX) {
>> +            error_setg(errp, "bps-read-max-length value must be in"
>> +                    " the range [0, %u]", UINT_MAX);
>> +            return;
>> +        }
>> +        cfg->buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_read_=
max_length;
>> +    }
>> +    if (arg->has_bps_write_max_length) {
>> +        if (arg->bps_write_max_length > UINT_MAX) {
>> +            error_setg(errp, "bps-write-max-length value must be in"
>> +                    " the range [0, %u]", UINT_MAX);
>> +            return;
>> +        }
>> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_writ=
e_max_length;
>> +    }
>> +    if (arg->has_iops_total_max_length) {
>> +        if (arg->iops_total_max_length > UINT_MAX) {
>> +            error_setg(errp, "iops-total-max-length value must be in"
>> +                    " the range [0, %u]", UINT_MAX);
>> +            return;
>> +        }
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_tot=
al_max_length;
>> +    }
>> +    if (arg->has_iops_read_max_length) {
>> +        if (arg->iops_read_max_length > UINT_MAX) {
>> +            error_setg(errp, "iops-read-max-length value must be in"
>> +                    " the range [0, %u]", UINT_MAX);
>> +            return;
>> +        }
>> +        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_read=
_max_length;
>> +    }
>> +    if (arg->has_iops_write_max_length) {
>> +        if (arg->iops_write_max_length > UINT_MAX) {
>> +            error_setg(errp, "iops-write-max-length value must be in"
>> +                    " the range [0, %u]", UINT_MAX);
>> +            return;
>> +        }
>> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wri=
te_max_length;
>> +    }
>> +
>> +    if (arg->has_iops_size) {
>> +        cfg->op_size =3D arg->iops_size;
>> +    }
>> +
>> +    throttle_is_valid(cfg, errp);
>> +}
>> +
>> +/* write the options of a ThrottleConfig to a ThrottleLimits
>> + *
>> + * @cfg:    the ThrottleConfig to read from
>> + * @var:    the ThrottleLimits to write to
>> + */
>> +void throttle_config_to_throttle_limits(ThrottleConfig *cfg, ThrottleLi=
mits *var)
>> +{
>> +    var->bps_total               =3D cfg->buckets[THROTTLE_BPS_TOTAL].a=
vg;
>> +    var->bps_read                =3D cfg->buckets[THROTTLE_BPS_READ].av=
g;
>> +    var->bps_write               =3D cfg->buckets[THROTTLE_BPS_WRITE].a=
vg;
>> +    var->iops_total              =3D cfg->buckets[THROTTLE_OPS_TOTAL].a=
vg;
>> +    var->iops_read               =3D cfg->buckets[THROTTLE_OPS_READ].av=
g;
>> +    var->iops_write              =3D cfg->buckets[THROTTLE_OPS_WRITE].a=
vg;
>> +    var->bps_total_max           =3D cfg->buckets[THROTTLE_BPS_TOTAL].m=
ax;
>> +    var->bps_read_max            =3D cfg->buckets[THROTTLE_BPS_READ].ma=
x;
>> +    var->bps_write_max           =3D cfg->buckets[THROTTLE_BPS_WRITE].m=
ax;
>> +    var->iops_total_max          =3D cfg->buckets[THROTTLE_OPS_TOTAL].m=
ax;
>> +    var->iops_read_max           =3D cfg->buckets[THROTTLE_OPS_READ].ma=
x;
>> +    var->iops_write_max          =3D cfg->buckets[THROTTLE_OPS_WRITE].m=
ax;
>> +    var->bps_total_max_length    =3D cfg->buckets[THROTTLE_BPS_TOTAL].b=
urst_length;
>> +    var->bps_read_max_length     =3D cfg->buckets[THROTTLE_BPS_READ].bu=
rst_length;
>> +    var->bps_write_max_length    =3D cfg->buckets[THROTTLE_BPS_WRITE].b=
urst_length;
>> +    var->iops_total_max_length   =3D cfg->buckets[THROTTLE_OPS_TOTAL].b=
urst_length;
>> +    var->iops_read_max_length    =3D cfg->buckets[THROTTLE_OPS_READ].bu=
rst_length;
>> +    var->iops_write_max_length   =3D cfg->buckets[THROTTLE_OPS_WRITE].b=
urst_length;
>> +    var->iops_size               =3D cfg->op_size;
>> +
>> +    var->has_bps_total =3D true;
>> +    var->has_bps_read =3D true;
>> +    var->has_bps_write =3D true;
>> +    var->has_iops_total =3D true;
>> +    var->has_iops_read =3D true;
>> +    var->has_iops_write =3D true;
>> +    var->has_bps_total_max =3D true;
>> +    var->has_bps_read_max =3D true;
>> +    var->has_bps_write_max =3D true;
>> +    var->has_iops_total_max =3D true;
>> +    var->has_iops_read_max =3D true;
>> +    var->has_iops_write_max =3D true;
>> +    var->has_bps_read_max_length =3D true;
>> +    var->has_bps_total_max_length =3D true;
>> +    var->has_bps_write_max_length =3D true;
>> +    var->has_iops_total_max_length =3D true;
>> +    var->has_iops_read_max_length =3D true;
>> +    var->has_iops_write_max_length =3D true;
>> +    var->has_iops_size =3D true;
>> +}
>> --
>> 2.11.0
>>



--muickcuy6dlrie5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmAsR0ACgkQc2J8L2kN
9xCteg//TSWZbtQqo1Xb1M7v+6m3saXzCLxXbQjASrYIyhtp4LvYNkmaZ/vgUsA7
kKfVddgUf/Z3vJO+N5DMLW1eHhzxzLn03EOVggunGYCepA5ZfJsIKhgeH+G8Z5wy
YeXu9dIfcAHouJa7DBdX7CA/mrEEGe9MoLpGqWJ0eFMjdp+2U+lVIy1ArgtS9tWn
GagmPQdL5zEVYqKaRRcDW+h7TtiAhTN1e/bd5o+F3b+8/OVYA6p6ZrAPE3f8/xBu
DQVP3/1Unm1sToynDpcIUhxg2giFaPbEFM2lo+TGSyBYqIlwY3RZs1e2UFHf7sXJ
5t5nKmXgPvQXLh7geHEsoVKPNdfo4DHISWSVCC3TDKOA8kty03A9qjdwGTC7AWQJ
1afMlCoenzVS/51bXt+ET+4LEYMUxEXUZRNvGqrBgwkUmPQR9ikiJE8mmtDaskTP
ohTY9p7obfmjCtAkpRHSYD3vGmGKQIBJzkc4gSIWu+iEDgbJI+wtkAcLsVjUdXk0
+EBKzEIESU2oaSM9Hj0qzGPhNMZWHWMrBrhhBsp71LGRmmD9gweDiq6m2A1o2nqo
K+ovi73/0Fafc+PZNwcJhppPaiGMHtxgkQK4qxn2ejLCtKQUl5LeTs8YbPhwskGH
fUHpYdnetusTCpxZipDobRP8tgDUEWegAkeqO/TA7zX7f+W4WLk=
=t9Sk
-----END PGP SIGNATURE-----

--muickcuy6dlrie5f--
