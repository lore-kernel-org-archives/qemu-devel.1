Received: from eggs.gnu.org ([2001:4830:134:3::10]:35363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciKfM-0003ms-SJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciKfJ-0008Sq-OY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:44:36 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciKfJ-0008Sk-Iq
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:44:33 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so13264910wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 04:44:33 -0800 (PST)
Date: Mon, 27 Feb 2017 12:44:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227124430.GG28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814892313.28146.906456388544163572.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline
In-Reply-To: <148814892313.28146.906456388544163572.stgit@bahia>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 26, 2017 at 11:42:03PM +0100, Greg Kurz wrote:
> +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mode)
> +{
> +    int fd;
> +
> +    fd = dup(dirfd);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +
> +    while (*path) {
> +        const char *c;
> +        int next_fd;
> +        char *head;
> +
> +        head = g_strdup(path);
> +        c = strchr(path, '/');
> +        if (c) {
> +            head[c - path] = 0;
> +            next_fd = openat_dir(fd, head);
> +        } else {
> +            next_fd = openat_file(fd, head, flags, mode);
> +        }
> +        g_free(head);
> +        if (next_fd == -1) {
> +            close_preserve_errno(fd);
> +            return -1;
> +        }
> +        close(fd);
> +        fd = next_fd;
> +
> +        if (!c) {
> +            break;
> +        }
> +        path = c + 1;
> +    }
> +
> +    return fd;
> +}

If I understand the Linux openat(2) implementation correctly this
function fails with ENOENT if:

1. An absolute path is given
2. A path contains consecutive slashes ("a///b")

Both of these behaviors are problematic.  If the function doesn't
support absolute paths it should be called relative_openat_nofollow()
and have an error if path[0] == '/'.

I believe guests can pass in paths with consecutive slashes, so the
function must cope with them.

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtB8uAAoJEJykq7OBq3PI+BEIAMOxUKcusSnOqOyxeESOML5v
l4cOCZfOCyaSRXy1qCWwHrQbLaiwQBVmRC/Z4glwUpz3HY4gvxCV3SzSOukmkxMH
8se3gjKyLA+5JXEHrsYv4TwhcaemjQbrEyiobXOsHcgAEF/tJoY+etRHoFW3xZqd
DCX8SxpTP+IK7LLNDe39d/wLlLX7blSK8wwAsehkvQBPwkAvQEMxyASJmh/pma3R
+5cW/qU3yuRhJCGnv5JCO34hPvH1nzXr7hat3xP7lSVgXeFQnkX01tClOxzNwKi0
kI5M73EQr+JgB3WhiZGAsdXMLOvBuSJvPERWmuKSpqx74e1YhBz+r96M1BbOQ5U=
=+aE/
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
