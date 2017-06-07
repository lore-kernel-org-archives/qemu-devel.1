Received: from eggs.gnu.org ([2001:4830:134:3::10]:37001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcff-0001Wi-Vb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcfa-00065t-4Q
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:14:55 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIcfZ-00064z-UQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:14:50 -0400
Received: by mail-wm0-x242.google.com with SMTP id x3so3055076wme.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:14:49 -0700 (PDT)
Date: Wed, 7 Jun 2017 16:14:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170607151445.GE21990@stefanha-x1.localdomain>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-3-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <20170606072229.9302-3-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] nvdimm: warn if the backend is not
 a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2017 at 03:22:27PM +0800, Haozhong Zhang wrote:
> diff --git a/util/osdep.c b/util/osdep.c
> index a2863c8e53..02881f96bc 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -471,3 +471,64 @@ writev(int fd, const struct iovec *iov, int iov_cnt)
>      return readv_writev(fd, iov, iov_cnt, true);
>  }
>  #endif
> +
> +#ifdef __linux__
> +static ssize_t qemu_dev_dax_sysfs_read(int fd, const char *entry,
> +                                       char *buf, size_t len)
> +{
> +    ssize_t read_bytes;
> +    struct stat st;
> +    unsigned int major, minor;
> +    char *path, *pos;
> +    int sysfs_fd;
> +
> +    if (fstat(fd, &st)) {
> +        return 0;
> +    }
> +
> +    major = major(st.st_rdev);
> +    minor = minor(st.st_rdev);
> +    path = g_strdup_printf("/sys/dev/char/%u:%u/%s", major, minor, entry);
> +
> +    sysfs_fd = open(path, O_RDONLY);
> +    g_free(path);
> +    if (sysfs_fd == -1) {
> +        return 0;
> +    }
> +
> +    read_bytes = read(sysfs_fd, buf, len - 1);
> +    close(sysfs_fd);
> +    if (read_bytes > 0) {
> +        buf[read_bytes] = '\0';
> +        pos = g_strstr_len(buf, read_bytes, "\n");
> +        if (pos) {
> +            *pos = '\0';
> +        }

Should read_bytes be adjusted since we made the string shorter?

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOBhlAAoJEJykq7OBq3PIX7EH/35ihQZrEYWMkuHVVTOVxIVM
dj8fBP4nhOBIMoj0n5tCG8jrrpCDF/yYdBksOr4rBKfbQDudv5uRYJUuxaJjw8JZ
UcRVnFR4VBxIBihTCGL3nIityBVxlrE71ioDShWauS+z51dEZ5SrONBGAOOtqWBY
HKmn5fIP6qvz51VXPS48NmiLJszfQIIl/Ki4N9oBdzzUdeboSQYgGxEEgi3aqK62
wr7ivKgU6TTVJGQabj/iicNXXY41dsQ8i1dvD46QWlxuKCxFTAC9XJAX9/fgXxg6
NS6VXoWRXOILY81z+HmaGETgNZtBSvqE1ZxOFzlbn4KiZ+3rK7fAFXTyFdnLyH4=
=T3eN
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
