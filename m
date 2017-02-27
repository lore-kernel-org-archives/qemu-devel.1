Received: from eggs.gnu.org ([2001:4830:134:3::10]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciUid-0007wI-FS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciUia-0000RV-Be
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:28:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciUia-0000R9-3F
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:28:36 -0500
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814892313.28146.906456388544163572.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <851bab51-f448-e21a-32df-c2b2e3b8dd8d@redhat.com>
Date: Mon, 27 Feb 2017 17:28:33 -0600
MIME-Version: 1.0
In-Reply-To: <148814892313.28146.906456388544163572.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pCqpM6GPPK6AhCuAwmGVXKwfgi3vSC5Rw"
Subject: Re: [Qemu-devel] [PATCH v2 04/28] 9pfs: introduce openat_nofollow()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pCqpM6GPPK6AhCuAwmGVXKwfgi3vSC5Rw
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <851bab51-f448-e21a-32df-c2b2e3b8dd8d@redhat.com>
Subject: Re: [PATCH v2 04/28] 9pfs: introduce openat_nofollow() helper
References: <148814889214.28146.16915712763478774662.stgit@bahia>
 <148814892313.28146.906456388544163572.stgit@bahia>
In-Reply-To: <148814892313.28146.906456388544163572.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 04:42 PM, Greg Kurz wrote:
> When using the passthrough security mode, symbolic links created by the=

> guest are actual symbolic links on the host file system.
>=20

>=20
> diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> new file mode 100644
> index 000000000000..62fd7a76212a
> --- /dev/null

> +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mod=
e)
> +{
> +    int fd;
> +
> +    fd =3D dup(dirfd);
> +    if (fd =3D=3D -1) {
> +        return -1;
> +    }
> +

Do you want to assert that the caller's path does not start with '/'?
This function ignores dirfd in that case, which may not be what you want.=


> +    while (*path) {
> +        const char *c;
> +        int next_fd;
> +        char *head;
> +
> +        head =3D g_strdup(path);
> +        c =3D strchr(path, '/');

So if the caller passes path=3D"a//b", then the first iteration sets
head=3D"a", but the second iteration sets head=3D"".


> +        if (c) {
> +            head[c - path] =3D 0;
> +            next_fd =3D openat_dir(fd, head);

The second iteration will then fail (openat_dir on "" should fail with
ENOENT, right?).  Oops.

> +        } else {
> +            next_fd =3D openat_file(fd, head, flags, mode);
> +        }
> +        g_free(head);
> +        if (next_fd =3D=3D -1) {
> +            close_preserve_errno(fd);
> +            return -1;
> +        }
> +        close(fd);
> +        fd =3D next_fd;
> +
> +        if (!c) {
> +            break;
> +        }
> +        path =3D c + 1;

I think the fix is that you should skip past all consecutive '/' here,
rather than assuming there is just one.  Or can you assert that all
callers are well-behaved, and that *path is not '/' at this point?

> +    }

> +static inline int openat_file(int dirfd, const char *name, int flags,
> +                              mode_t mode)
> +{
> +    int fd, serrno;
> +
> +    fd =3D openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBL=
OCK,
> +                mode);
> +    if (fd =3D=3D -1) {
> +        return -1;
> +    }
> +
> +    serrno =3D errno;
> +    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
> +    assert(!fcntl(fd, F_SETFL, flags));

Ouch - side effect inside an assertion.  We don't support use of NDEBUG,
but this is poor practice.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pCqpM6GPPK6AhCuAwmGVXKwfgi3vSC5Rw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtLYhAAoJEKeha0olJ0NqSMgH/1F0Y7KIEIHAv/3sjtTkNi5S
8M6wv1Ww8pcJa/pld17Om3bFW403ZZ4hda42D78qABBDfJbebcE/mzf1G43yKtNF
M1SgA23UNdPsWMt4gGpiiZNJmP6dKaBpk59oQmAGfClxAjQ4FJEVb5Iy75tLa6p0
ngJDRcn7wjOgW2voENi//8rW66M+o3JmNKdGJXZBsVHbN/tV8tk7rSfRfbA786ps
xi/NA6PyQHH8URynZ9mdXvuOMzwvkv8Am2h8WWt7b4sTs/89C7r089TfMf6O4ooh
y5hMculgBjh3JqxhFdRzBMscLQGmf5vXW0bFfLsOHGQb7Qd0XLi2SIbOrknKH2Y=
=gh0x
-----END PGP SIGNATURE-----

--pCqpM6GPPK6AhCuAwmGVXKwfgi3vSC5Rw--
