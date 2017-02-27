Received: from eggs.gnu.org ([2001:4830:134:3::10]:54629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciUrh-0007aZ-VR
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciUre-000316-RL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:38:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciUre-00030p-JG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:37:58 -0500
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
	<1488236421-30983-8-git-send-email-groug@kaod.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bbb5051-c3ad-bdbc-fb20-38f16de840da@redhat.com>
Date: Mon, 27 Feb 2017 17:37:56 -0600
MIME-Version: 1.0
In-Reply-To: <1488236421-30983-8-git-send-email-groug@kaod.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Ud6LDnL9XPBvmm5U9f6bNFBmIWbbvoeX"
Subject: Re: [Qemu-devel] [PULL 07/31] 9pfs: introduce
 relative_openat_nofollow() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Ud6LDnL9XPBvmm5U9f6bNFBmIWbbvoeX
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Message-ID: <0bbb5051-c3ad-bdbc-fb20-38f16de840da@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/31] 9pfs: introduce
 relative_openat_nofollow() helper
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
 <1488236421-30983-8-git-send-email-groug@kaod.org>
In-Reply-To: <1488236421-30983-8-git-send-email-groug@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 04:59 PM, Greg Kurz wrote:
> When using the passthrough security mode, symbolic links created by the=

> guest are actual symbolic links on the host file system.
>=20

Hmm, I just barely started reviewing the series, and see a pull request.
At this point, anything I point out can probably be done as followup
patches rather than forcing a respin of the pull (and soft freeze is
appropriate for that).

> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> (renamed openat_nofollow() to relative_openat_nofollow(),
>  assert path is relative, Greg Kurz)
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

> +int relative_openat_nofollow(int dirfd, const char *path, int flags,
> +                             mode_t mode)
> +{
> +    int fd;
> +
> +    assert(path[0] !=3D '/');

If you move this assert...

> +
> +    fd =3D dup(dirfd);
> +    if (fd =3D=3D -1) {
> +        return -1;
> +    }
> +
> +    while (*path) {
> +        const char *c;
> +        int next_fd;
> +        char *head;

=2E..here, you can make sure there are no 'a//b' issues to worry about.

> +
> +        head =3D g_strdup(path);
> +        c =3D strchr(path, '/');
> +        if (c) {
> +            head[c - path] =3D 0;
> +            next_fd =3D openat_dir(fd, head);
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

or else add an assert here.


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

Ewww. Side effect inside an assert().  :(

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7Ud6LDnL9XPBvmm5U9f6bNFBmIWbbvoeX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtLhUAAoJEKeha0olJ0NqZu0H/jJXIe0FVauzrjKfJhtXWr7W
ofDqJWMVhI8u9+/pgvl0tWTawWcVur9Ei3zPkJ/q6ntaVCEaLd2RRtarEy1ceNIj
u+roxFE+MOn2vDjJL0e4DZZflZLyC31JHORI8Wx6eeIA5OAttogEM6gJNSGJLVt+
ZsVTPw/uu294n31lNgHsl5GaF7JVOo9N00pgwNTbZEzfERhy/62UYDbAmGFQdE5P
Piq/SEpskAvA3pzPBnuXTU/eWwLIjNPahFuJRk1OA9ntKGqlSoIyLLnoSRlNh5WR
WWlQFsWlJJDsI9ZqdyC2Hc1l7+fEugKmKMaiiFMiv2FA0zOwcABQxZOl+YCoRl4=
=/cn5
-----END PGP SIGNATURE-----

--7Ud6LDnL9XPBvmm5U9f6bNFBmIWbbvoeX--
