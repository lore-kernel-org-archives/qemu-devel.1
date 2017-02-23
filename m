Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgthQ-0007F5-LT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgthN-0004U1-FR
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:44:48 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgthN-0004Tr-8P
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:44:45 -0500
Received: by mail-wm0-x229.google.com with SMTP id v77so29908794wmv.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 05:44:45 -0800 (PST)
Date: Thu, 23 Feb 2017 13:44:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223134441.GG30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760161575.31154.505252736798591155.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <148760161575.31154.505252736798591155.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce
 symlink-attack safe xattr helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2017 at 03:40:15PM +0100, Greg Kurz wrote:
> +static ssize_t do_xattrat_op(int op_type, int dirfd, const char *path,
> +                             const char *name, void *value, size_t size,
> +                             int flags)
> +{
> +    struct xattrat_data *data;
> +    pid_t pid;
> +    ssize_t ret = -1;
> +    int wstatus;
> +
> +    data = mmap(NULL, sizeof(*data) + size, PROT_READ | PROT_WRITE,
> +                MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +    if (data == MAP_FAILED) {
> +        return -1;
> +    }
> +    data->ret = -1;
> +
> +    pid = fork();
> +    if (pid < 0) {
> +        goto err_out;
> +    } else if (pid == 0) {
> +        if (fchdir(dirfd) == 0) {
> +            switch (op_type) {
> +            case XATTRAT_OP_GET:
> +                data->ret = lgetxattr(path, name, data->value, size);
> +                break;
> +            case XATTRAT_OP_LIST:
> +                data->ret = llistxattr(path, data->value, size);
> +                break;
> +            case XATTRAT_OP_SET:
> +                data->ret = lsetxattr(path, name, value, size, flags);
> +                break;
> +            case XATTRAT_OP_REMOVE:
> +                data->ret = lremovexattr(path, name);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +        }
> +        data->serrno = errno;
> +        _exit(0);
> +    }
> +    assert(waitpid(pid, &wstatus, 0) == pid && WIFEXITED(wstatus));
> +
> +    ret = data->ret;
> +    if (ret < 0) {
> +        errno = data->serrno;
> +        goto err_out;
> +    }
> +    if (value) {
> +        memcpy(value, data->value, data->ret);
> +    }
> +err_out:
> +    munmap_preserver_errno(data, sizeof(*data) + size);
> +    return ret;
> +}

Forking is ugly since QEMU is a multi-threaded program.  We brainstormed
alternatives on IRC like using /proc/self/fd/$fd to work around the
missing getxattrat() API.

Stefan

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrudJAAoJEJykq7OBq3PIO7wIAKvM0zbWRZSWh2puHHNrzk2X
a4NYB+Jn+UokFXDsdyufEaBJz9UHxabvWFm0nEBPuT0szB6azS0nqJcvkAsJXnGg
vofgof+lfrltusj87lJL5jM3aBtRbk+GHpgBt0xyIEV2xP3aPp3DZhPHQgyw17T8
M/bvEUw2pj8Ecl0qlqOJPaMLj9Meq7LRQecuxvimrKD6mptl5HontsK8tKk2uAe3
GmYPJ+J7pealIaIfOA1TQ+iWRnbDksWRNk6o1kYRxM9r8HR7IQHcBCr0PgUTdWLu
1sBWOSoB3NUE4W+pvnsKE8WO3JTR//0bRT5oWOhiioK6zdWwTaYHq9GdZ0OPIvg=
=wfPK
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
