Received: from eggs.gnu.org ([2001:4830:134:3::10]:56566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbIa5-0002qq-SL
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbIa3-0005Py-Qj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:06:05 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-15-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f20385ca-81d1-df52-31e5-283c0c2fac0a@redhat.com>
Date: Wed, 8 Feb 2017 04:05:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-15-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BHpmBsheOB5cQBD24Spu776RXBgVMx9A2"
Subject: Re: [Qemu-devel] [PATCH v12 14/16] file-posix: Implement image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BHpmBsheOB5cQBD24Spu776RXBgVMx9A2
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <f20385ca-81d1-df52-31e5-283c0c2fac0a@redhat.com>
Subject: Re: [PATCH v12 14/16] file-posix: Implement image locking
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-15-famz@redhat.com>
In-Reply-To: <20170123123056.30383-15-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> This implements open flag sensible image locking for local file
> and host device protocol.
>=20
> virtlockd in libvirt locks the first byte, so we start looking at the
> file bytes from 1.
>=20
> Quoting what was proposed by Kevin Wolf <kwolf@redhat.com>, there are
> four locking modes by combining two bits (BDRV_O_RDWR and
> BDRV_O_SHARE_RW), and implemented by taking two locks.
>=20
> The complication is in the transactional reopen.  To make the reopen
> logic managable, and allow better reuse, the code is internally
> organized with a table from old mode to the new one.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 681 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 678 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 28b47d9..a8c76d6 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -131,8 +131,45 @@ do { \
> =20
>  #define MAX_BLOCKSIZE	4096
> =20
> +/* Posix file locking bytes. Libvirt takes byte 0, we start from byte =
0x10,
> + * leaving a few more bytes for its future use. */
> +#define RAW_LOCK_BYTE_MIN             0x10
> +#define RAW_LOCK_BYTE_NO_OTHER_WRITER 0x10
> +#define RAW_LOCK_BYTE_WRITE           0x11
> +#ifdef F_OFD_SETLK
> +#define RAW_LOCK_SUPPORTED 1
> +#else
> +#define RAW_LOCK_SUPPORTED 0
> +#endif
> +
> +/*
> + ** reader that can tolerate writers: Don't do anything
> + *
> + ** reader that can't tolerate writers: Take shared lock on byte 1. Te=
st
> + *  byte 2 is unlocked.

Byte 0x10 and 0x11 now -- or you call them byte 0 and byte 1. Or "the
first byte" and "the second byte".

Also, it should probably be "Test whether byte 2 is unlocked" or "Affirm
that byte 2 is unlocked" (this is what my sense of the English language
is telling me, may be wrong).

> + *
> + ** shared writer: Take shared lock on byte 2. Test byte 1 is unlocked=
=2E
> + *
> + ** exclusive writer: Take exclusive locks on both bytes.
> + */
> +
> +typedef enum {
> +    /* Read only and accept other writers. */
> +    RAW_L_READ_SHARE_RW,
> +    /* Read only and try to forbid other writers. */
> +    RAW_L_READ,
> +    /* Read write and accept other writers. */
> +    RAW_L_WRITE_SHARE_RW,
> +    /* Read write and try to forbid other writers. */

While fully comprehensible and I didn't nag about this in the last
revision, it isn't real English so let me complain now: May be better as
"Read+write", "Read & write" or "Read/write".

("Read and write" is kind of bad because of the immediate "and" afterward=
s.)

> +    RAW_L_WRITE,
> +} BDRVRawLockMode;
> +
>  typedef struct BDRVRawState {
>      int fd;
> +    /* A dup of @fd to make manipulating lock easier, especially durin=
g reopen,
> +     * where this will accept BDRVRawReopenState.lock_fd. */
> +    int lock_fd;
> +    bool disable_lock;
>      int type;
>      int open_flags;
>      size_t buf_align;

[...]

> @@ -393,10 +487,88 @@ static QemuOptsList raw_runtime_opts =3D {

[...]

> +static int raw_apply_image_lock(BlockDriverState *bs, int bdrv_flags,
> +                                Error **errp)
> +{
> +    int ret;
> +    BDRVRawState *s =3D bs->opaque;
> +    BDRVRawLockMode lock_mode;
> +
> +    if (!raw_lock_enabled(bs)) {
> +        return 0;
> +    }
> +    assert(s->cur_lock_mode =3D=3D RAW_L_READ_SHARE_RW);
> +    lock_mode =3D raw_get_lock_mode(bdrv_flags);
> +    ret =3D raw_open_lockfd(bs->exact_filename, s->open_flags, &lock_m=
ode,
> +                          errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +    s->lock_fd =3D ret;
> +    if (lock_mode =3D=3D RAW_L_READ_SHARE_RW) {
> +        return 0;
> +    }

Not really sure why this needs to be special-cased. It doesn't hurt, but
it doesn't really improve anything either, does it?

> +    ret =3D raw_lock_fd(s->lock_fd, lock_mode, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +    s->cur_lock_mode =3D lock_mode;
> +    return 0;
> +}
> +
>  static int raw_open_common(BlockDriverState *bs, QDict *options,
>                             int bdrv_flags, int open_flags, Error **err=
p)
>  {

[...]

> @@ -538,6 +720,465 @@ static int raw_open(BlockDriverState *bs, QDict *=
options, int flags,
>      return raw_open_common(bs, options, flags, 0, errp);
>  }
> =20
> +typedef enum {
> +    RAW_LT_PREPARE,
> +    RAW_LT_COMMIT,
> +    RAW_LT_ABORT
> +} RawLockTransOp;
> +
> +typedef int (*RawReopenFunc)(RawLockTransOp op,
> +                             int old_lock_fd, int new_lock_fd,
> +                             BDRVRawLockMode old_lock,
> +                             BDRVRawLockMode new_lock,
> +                             Error **errp);
> +
> +static int raw_lt_nop(RawLockTransOp op,
> +                      int old_lock_fd, int new_lock_fd,
> +                      BDRVRawLockMode old_lock,
> +                      BDRVRawLockMode new_lock,
> +                      Error **errp)
> +{
> +    assert(old_lock =3D=3D new_lock || new_lock =3D=3D RAW_L_READ_SHAR=
E_RW);
> +    return 0;
> +}
> +
> +static int raw_lt_from_unlock(RawLockTransOp op,
> +                              int old_lock_fd, int new_lock_fd,
> +                              BDRVRawLockMode old_lock,
> +                              BDRVRawLockMode new_lock,
> +                              Error **errp)
> +{
> +    assert(old_lock !=3D new_lock);
> +    assert(old_lock =3D=3D RAW_L_READ_SHARE_RW);
> +    switch (op) {
> +    case RAW_LT_PREPARE:
> +        return raw_lock_fd(new_lock_fd, new_lock, errp);
> +    case RAW_LT_COMMIT:
> +        break;

Ah, that's what the break was meant for.

(It was one line above in v10.)

> +    case RAW_LT_ABORT:
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +static int raw_lt_read_to_write_share(RawLockTransOp op,
> +                                      int old_lock_fd, int new_lock_fd=
,
> +                                      BDRVRawLockMode old_lock,
> +                                      BDRVRawLockMode new_lock,
> +                                      Error **errp)
> +{
> +    int ret =3D 0;
> +
> +    assert(old_lock =3D=3D RAW_L_READ);
> +    assert(new_lock =3D=3D RAW_L_WRITE_SHARE_RW);
> +
> +    /*
> +     *        lock byte "no other writer"      lock byte "write"
> +     * old                S                           0
> +     * new                0                           S
> +     *
> +     * (0 =3D unlocked; S =3D shared; X =3D exclusive.)
> +     */

Thanks, these comments are nice.

> +    switch (op) {
> +    case RAW_LT_PREPARE:
> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, true=
);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to lock new fd (write=
 byte)");
> +            break;
> +        }
> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITE=
R, 1, false);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to lock new fd (share=
 byte)");
> +            break;
> +        }
> +        ret =3D qemu_unlock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRI=
TER, 1);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to unlock old fd (sha=
re byte)");
> +            break;
> +        }
> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITE=
R, 1, true);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to upgrade new fd (sh=
are byte)");
> +            break;
> +        }
> +        ret =3D qemu_unlock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRI=
TER, 1);
> +        if (ret) {
> +            /* This is very unlikely, but catch it anyway. */
> +            error_setg_errno(errp, -ret, "Failed to unlock new fd (sha=
re byte)");

Let's say we fail here, however unlikely it is...

> +            break;
> +        }
> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, fals=
e);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to downgrade new fd (=
write byte)");
> +            break;
> +        }
> +        break;
> +    case RAW_LT_COMMIT:
> +        break;
> +    case RAW_LT_ABORT:
> +        ret =3D qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITE=
R, 1, false);
> +        if (ret) {
> +            error_report("Failed to restore lock on old fd (share byte=
)");
> +        }

=2E..will this not fail then?

(exclusive lock is still present on new_lock_fd.)

> +        break;
> +    }
> +    return ret;

By the way, couldn't this function use the same logic as
raw_lt_write_share_to_read()? (i.e. lock old_lock_fd's
RAW_LOCK_BYTE_NO_OTHER_WRITER exclusively and then lock new_lock_fd's
RAW_LOCK_BYTE_WRITE in shared mode)

> +}

[...]

> +static int raw_lt_write_share_to_read(RawLockTransOp op,
> +                                      int old_lock_fd, int new_lock_fd=
,
> +                                      BDRVRawLockMode old_lock,
> +                                      BDRVRawLockMode new_lock,
> +                                      Error **errp)
> +{
> +    int ret =3D 0;
> +
> +    assert(old_lock =3D=3D RAW_L_WRITE_SHARE_RW);
> +    assert(new_lock =3D=3D RAW_L_READ);
> +    /*
> +     *        lock byte "no other writer"      lock byte "write"
> +     * old                0                           S
> +     * new                S                           0
> +     *
> +     * (0 =3D unlocked; S =3D shared; X =3D exclusive.)
> +     */
> +    switch (op) {
> +    case RAW_LT_PREPARE:
> +        /* Make sure there are no other writers. */
> +        ret =3D qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, true=
);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to lock old fd (write=
 byte)");
> +            break;
> +        }
> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITE=
R, 1, false);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to lock new fd (share=
 byte)");
> +            break;
> +        }
> +        break;
> +    case RAW_LT_COMMIT:
> +        break;
> +    case RAW_LT_ABORT:
> +        break;

Shouldn't the abort path downgrade the exclusive lock on old_lock_fd to
a shared lock?

> +    }
> +    return ret;
> +}

[...]

> +static int raw_lt_write_to_read(RawLockTransOp op,
> +                                int old_lock_fd, int new_lock_fd,
> +                                BDRVRawLockMode old_lock,
> +                                BDRVRawLockMode new_lock,
> +                                Error **errp)
> +{
> +    int ret =3D 0;
> +
> +    assert(old_lock =3D=3D RAW_L_WRITE);
> +    assert(new_lock =3D=3D RAW_L_READ);
> +    /*
> +     *        lock byte "no other writer"      lock byte "write"
> +     * old                X                           X
> +     * new                S                           0
> +     *
> +     * (0 =3D unlocked; S =3D shared; X =3D exclusive.)
> +     */
> +    switch (op) {
> +    case RAW_LT_PREPARE:
> +        ret =3D qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITE=
R, 1, false);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to downgrade old fd (=
share byte)");
> +            break;
> +        }
> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITE=
R, 1, false);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to lock new fd (share=
 byte)");
> +            break;
> +        }
> +        break;
> +    case RAW_LT_COMMIT:
> +        break;
> +    case RAW_LT_ABORT:
> +        ret =3D qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITE=
R, 1, true);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to restore old fd (sh=
are byte)");
> +        }

I think you should release the lock on new_lock_fd first.

> +        break;
> +    }
> +    return ret;
> +}
> +
> +static int raw_lt_write_to_write_share(RawLockTransOp op,
> +                                       int old_lock_fd, int new_lock_f=
d,
> +                                       BDRVRawLockMode old_lock,
> +                                       BDRVRawLockMode new_lock,
> +                                       Error **errp)
> +{
> +    int ret =3D 0;
> +
> +    assert(old_lock =3D=3D RAW_L_WRITE);
> +    assert(new_lock =3D=3D RAW_L_WRITE_SHARE_RW);
> +    /*
> +     *        lock byte "no other writer"      lock byte "write"
> +     * old                X                           X
> +     * new                0                           S
> +     *
> +     * (0 =3D unlocked; S =3D shared; X =3D exclusive.)
> +     */
> +    switch (op) {
> +    case RAW_LT_PREPARE:
> +        break;
> +    case RAW_LT_COMMIT:
> +        ret =3D qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, fals=
e);
> +        if (ret) {
> +            error_report("Failed to downgrade old fd (share byte)");
> +            break;
> +        }
> +        ret =3D qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, fals=
e);
> +        if (ret) {
> +            error_report("Failed to unlock new fd (share byte)");
> +            break;
> +        }

The second one is not an "unlock", but a new shared lock. Which brings
me to the point that both of these commands can fail and thus should be
in the prepare path.

(This function should be a mirror of raw_lt_write_to_read, if I'm not
mistaken.)

> +        break;
> +    case RAW_LT_ABORT:
> +        break;
> +    }
> +    return ret;
> +}
> +
> +/**
> + * Transactionally moving between possible locking states is tricky an=
d must be
> + * done carefully. That is mostly because downgrading an exclusive loc=
k to
> + * shared or unlocked is not guaranteed to be revertible. As a result,=
 in such

Interesting. Wiktionary says "revertible" means "able to be reverted",
which sounds reasonable, albeit I'm not sure I have ever heard
"revertible" before.

However, my favorite online dictionary gave me a German word I have
never heard before.

Note that Wiktionary also has the word "revertable" with the same
definition. Of course, it also has "reversible". Now I understand there
is a difference between "to revert" and "to reverse", but maybe
"reversible" is still the better choice considering it has a unique
meaning and scores more than thousand times as many results on Google.

(For anyone wondering, the German word is "heimf=E4llig" and it means
"designated to go back to the original owner" (e.g. after death). It's
apparently related to "anheimfallen", which I do know, which means "to
become someone's property" or "to become a victim of something"
("something" being a process of some sorts, usually, such as a mishap).)

((Apparently "heimf=E4llig" is used in Austria and Swiss, mostly.))

Max

> + * cases we have to defer the downgrading to "commit", given that no r=
evert will
> + * happen after that point, and that downgrading a lock should never f=
ail.
> + *
> + * On the other hand, upgrading a lock (e.g. from unlocked or shared t=
o
> + * exclusive lock) must happen in "prepare" because it may fail.
> + *
> + * Manage the operation matrix with this state transition table to mak=
e
> + * fulfilling above conditions easier.
> + */

[...]



--BHpmBsheOB5cQBD24Spu776RXBgVMx9A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaixASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnfUH/1bP9JSjuZ6HQ9tAsAHUvuAM+5T28ex4
+goPJNi8OskiYQqUF/AlmgCidSLiqDBvsKp5xfDaA+ZPhclABDDcmN+iVbFaRBHE
to/UZWIzR4L4OCfNS+ysgEuGBuijgADEHBpCbMqGBPyVA3CsUtfclP0MIVKuya6B
usH/7ao9ARzl3MlwulpRBekIIvELfUBPMBjHhEj/y4vvtO0JdoP18sD+i8gmVt4y
bpPVUu1bLxorXN5UeCLfreU0YfrOBv1WDk9HWnoDkrbWNefB5jEFfrJ2XY2p0XxV
cxnzQVR/N/PeArpHKtTl/B48nG7sW7gjKcMgyEHhLNHbIHGxWCrHL+g=
=4tkx
-----END PGP SIGNATURE-----

--BHpmBsheOB5cQBD24Spu776RXBgVMx9A2--
