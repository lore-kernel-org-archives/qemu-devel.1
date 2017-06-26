Received: from eggs.gnu.org ([2001:4830:134:3::10]:48986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPVNZ-0003Qd-OQ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPVNW-00023Z-NX
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:52:41 -0400
Date: Mon, 26 Jun 2017 15:52:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626145234.GE29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-5-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 4/8] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2017 at 03:46:56PM +0300, Manos Pitsidianakis wrote:
> +static bool throttle_group_exists(const char *name)
> +{
> +    ThrottleGroup *iter;
> +    bool ret = false;
> +
> +    qemu_mutex_lock(&throttle_groups_lock);

Not sure if this lock or the throttle_groups list are necessary.

Have you seen iothread.c:qmp_query_iothreads()?  All objects are put
into a container (the parent object), so you can just iterate over its
children.  There's no need for a separate list because QOM already has
all the objects.

> +typedef struct ThrottleGroupClass {
> +    /* private */
> +    ObjectClass parent_class;
> +    /* public */
> +} ThrottleGroupClass;

This is unused?

> +
> +
> +#define DOUBLE 0
> +#define UINT64 1
> +#define UNSIGNED 2
> +
> +typedef struct {
> +    BucketType type;
> +    int size; /* field size */

sizeof(double) == sizeof(uint64_t) == 8.

This is a datatype field, not a size.

> +static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
> +{
> +    char *name = NULL;
> +    Error *local_error = NULL;
> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
> +
> +    name = object_get_canonical_path_component(OBJECT(obj));
> +    if (throttle_group_exists(name)) {
> +        error_setg(&local_error, "A throttle group with this name already \
> +                                  exists.");
> +        goto ret;
> +    }

QOM should enforce unique id=<ID>.  I don't think this is necessary.

> +
> +    qemu_mutex_lock(&throttle_groups_lock);
> +    tg->name = name;
> +    qemu_mutex_init(&tg->lock);
> +    QLIST_INIT(&tg->head);
> +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> +    tg->refcount++;
> +    qemu_mutex_unlock(&throttle_groups_lock);
> +
> +ret:
> +    error_propagate(errp, local_error);
> +    return;
> +
> +}
> +
> +static void throttle_group_set(Object *obj, Visitor *v, const char * name,
> +        void *opaque, Error **errp)
> +
> +{
> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
> +    ThrottleConfig cfg = tg->ts.cfg;
> +    Error *local_err = NULL;
> +    ThrottleParamInfo *info = opaque;
> +    int64_t value;

What happens if this property is set while QEMU is already running?

> +
> +    visit_type_int64(v, name, &value, &local_err);
> +
> +    if (local_err) {
> +        goto out;
> +    }
> +    if (value < 0) {
> +        error_setg(&local_err, "%s value must be in range [0, %"PRId64"]",
> +                "iops-total", INT64_MAX); /* change option string */

iops-total? :)

> +        goto out;
> +    }

This doesn't validate inputs properly for non int64_t types.

I'm also worried that the command-line bps=,iops=,... options do not
have unsigned or double types.  Input ranges and validation should match
the QEMU command-line (I know this is a bit of a pain with QOM since the
property types are different from QEMU option types).

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUR+xAAoJEJykq7OBq3PItzEH/2bQJJSYHDW4RxX86q7slpiF
cC730FEGXyEQP2uiWtGpf1c3XekOfxPM/KZONJo4Jbutt1rYL9dPTGS5VfpE0M/0
XZD0WKCz/3NWXAd6iwWPOv+O6nZqDTk99WXvs0ITY02V9ItJ8W0mf7Gg4TTGqYRM
wfKEKFw1FXhAmjPLUgBACyqJ5/DVA1FGPiLKB0rsRPZ2ue4RrvLlCKzW94ozCPDe
R3hBMruWTFfwmatc2SQe+UTN1FvnDOW7Pg0v9X1kIRb1cD1CDS2C7fJw5ftkrKYj
yY9+t4FkORVgMAMwem87bkD5HhDh/yzT+amjg31SrhR5BQBrc2YCXQKrkF8YDGE=
=JNzx
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
