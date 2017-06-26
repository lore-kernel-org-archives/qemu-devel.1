Received: from eggs.gnu.org ([2001:4830:134:3::10]:59805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPVsq-0002NI-UN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPVsp-0000QO-RN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:25:00 -0400
Date: Mon, 26 Jun 2017 18:24:09 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170626152409.banswonpr6aj4h55@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
	<20170626145234.GE29664@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gyftvtfcv5trqsum"
Content-Disposition: inline
In-Reply-To: <20170626145234.GE29664@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--gyftvtfcv5trqsum
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 03:52:34PM +0100, Stefan Hajnoczi wrote:
>Have you seen iothread.c:qmp_query_iothreads()?  All objects are put
>into a container (the parent object), so you can just iterate over its
>children.  There's no need for a separate list because QOM already has
>all the objects.

Thanks, QOM was difficult to figure out in general.

>> +
>> +
>> +#define DOUBLE 0
>> +#define UINT64 1
>> +#define UNSIGNED 2
>> +
>> +typedef struct {
>> +    BucketType type;
>> +    int size; /* field size */
>
>sizeof(double) =3D=3D sizeof(uint64_t) =3D=3D 8.
>
>This is a datatype field, not a size.
>
>> +static void throttle_group_obj_complete(UserCreatable *obj, Error **err=
p)
>> +{
>> +    char *name =3D NULL;
>> +    Error *local_error =3D NULL;
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +
>> +    name =3D object_get_canonical_path_component(OBJECT(obj));
>> +    if (throttle_group_exists(name)) {
>> +        error_setg(&local_error, "A throttle group with this name alrea=
dy \
>> +                                  exists.");
>> +        goto ret;
>> +    }
>
>QOM should enforce unique id=3D<ID>.  I don't think this is necessary.
>
>> +
>> +    qemu_mutex_lock(&throttle_groups_lock);
>> +    tg->name =3D name;
>> +    qemu_mutex_init(&tg->lock);
>> +    QLIST_INIT(&tg->head);
>> +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
>> +    tg->refcount++;
>> +    qemu_mutex_unlock(&throttle_groups_lock);
>> +
>> +ret:
>> +    error_propagate(errp, local_error);
>> +    return;
>> +
>> +}
>> +
>> +static void throttle_group_set(Object *obj, Visitor *v, const char * na=
me,
>> +        void *opaque, Error **errp)
>> +
>> +{
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +    ThrottleConfig cfg =3D tg->ts.cfg;
>> +    Error *local_err =3D NULL;
>> +    ThrottleParamInfo *info =3D opaque;
>> +    int64_t value;
>
>What happens if this property is set while QEMU is already running?

I assume you mean setting a property while a group has active members=20
and requests? My best answer would be "don't do that". I couldn't figure=20
a way to do this cleanly. Individual limit changes may render a=20
ThrottleConfig invalid, so it should not be allowed. ThrottleGroups and=20
throttle nodes should be destroyed and recreated to change limits with=20
this version, but in the next it will be done through=20
block_set_io_throttle() which is the existing way to change limits and=20
check for validity. This was discussed in the proposal about the new=20
syntax we had on the list.

As we also talked about on IRC, clock_type should be a ThrottleGroup=20
field in order to set a group's configuration without passing a=20
ThrottleGroupMember, so changing this will make group configuring=20
possible on QMP.
>
>> +
>> +    visit_type_int64(v, name, &value, &local_err);
>> +
>> +    if (local_err) {
>> +        goto out;
>> +    }
>> +    if (value < 0) {
>> +        error_setg(&local_err, "%s value must be in range [0, %"PRId64"=
]",
>> +                "iops-total", INT64_MAX); /* change option string */
>
>iops-total? :)

I even left a comment to remind myself to change this... pah.

>
>> +        goto out;
>> +    }
>
>This doesn't validate inputs properly for non int64_t types.
>
>I'm also worried that the command-line bps=3D,iops=3D,... options do not
>have unsigned or double types.  Input ranges and validation should match
>the QEMU command-line (I know this is a bit of a pain with QOM since the
>property types are different from QEMU option types).

I don't know what should be done about this, to be honest, except for=20
manually checking the limits for each datatype in the QOM setters.

--gyftvtfcv5trqsum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllRJxkACgkQc2J8L2kN
9xBciRAAnMqiW3colzZzfJqzwtEJQKrmkDdSJO3Hg1qD0ik2JXNfowfcIbGrhS1x
7IMUw9Osy4G0lCE0lmB6bSmn+GUVezSv2xx77ETjP+pOHcvdRYCJxbzCB0sjPhA4
j8YgQ4QRTFWIBXV+gzArVDAObA5UBJNQcO2dWKMzAZ++K/JOQKR1IESRZ0eBN+h4
TQJU8pPpMEV9RL/Slj1GiOvH/GFP2XSmx14IBW77dTZhbj3o8xBRekucU2XRtDIV
1+oBJ/YG2N2uLcw94jnO17UOOAFt+hDwk79w3suQ5G2PcOyrVQhRihYjUb9mWcm3
Q4nmNLFCcMlO6I96zPRA4Y3ushLiupslbyYcLpEAwonE9BrjnOsQ9MBPuOa74L82
C3l8Yt/Pzyc+7xJwz4Rb1jA/HhrL3qUT/LYsbD0e5Ljt/hCqpTco6+bTzzXLtShX
k//Vs7mmW8zKpO9juj2n1hcipoKIfI3mQ3tVIFQGNBBfLbY34B6FWXJi9PhjfoHF
8kJZ3dMVH4ucbS8Tx8OHA1aLcVSxsXkk1IBYw/WwXhQROP0cle0/LBW0EarpfRZm
OF1aZl24HnxVo6ISbX9PE9YHe61+81wiS5F+d8mNbru19UjSV9QrukZbxckeWcu9
Nctm4VFkAWjMBgZNyjYnyTbJgMCrC7xAywLj2D4Nfdwq3v9KzRU=
=XRA5
-----END PGP SIGNATURE-----

--gyftvtfcv5trqsum--
