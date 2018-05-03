Received: from eggs.gnu.org ([2001:4830:134:3::10]:47952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRd-0000Zy-KK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRa-0000OW-H9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:45 -0400
Date: Thu, 3 May 2018 10:25:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180503092528.GC5301@stefanha-x1.localdomain>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20180418030424.28980-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/7] file-posix: Implement
 bdrv_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 11:04:21AM +0800, Fam Zheng wrote:
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 3794c0007a..45ad543481 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -100,6 +100,7 @@
>  #ifdef CONFIG_XFS
>  #include <xfs/xfs.h>
>  #endif
> +#include <sys/syscall.h>

Is sys/syscall.h available on all systems?  I wasn't able to find it in
the POSIX specs.

> =20
>  //#define DEBUG_BLOCK
> =20
> @@ -185,6 +186,8 @@ typedef struct RawPosixAIOData {
>  #define aio_ioctl_cmd   aio_nbytes /* for QEMU_AIO_IOCTL */
>      off_t aio_offset;
>      int aio_type;
> +    int fd2;
> +    off_t offset2;

Is there a reason for abandoning the aio_* field naming convention?

>  } RawPosixAIOData;
> =20
>  #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
> @@ -1421,6 +1424,48 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixA=
IOData *aiocb)
>      return -ENOTSUP;
>  }
> =20
> +#ifdef __NR_copy_file_range
> +#define HAS_COPY_FILE_RANGE
> +#endif
> +
> +#ifdef HAS_COPY_FILE_RANGE
> +static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> +                             off_t *out_off, size_t len, unsigned int fl=
ags)
> +{
> +    return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
> +                   out_off, len, flags);
> +}
> +#endif

Further #ifdefs can be avoided by providing an implementation here:

#else
static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
                             off_t *out_off, size_t len, unsigned int flags)
{
    errno =3D ENOSYS;
    return -1;
}
#endif /* !HAS_COPY_FILE_RANGE */

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6tWHAAoJEJykq7OBq3PItH0H/2talLPR+CqKQJBEMdeOq+E6
zlhlTwEz/sDzA/oq8UCQXYt/ewJA/DAYSdUoJqDeWAB6+lF1ivyev4FRhzALMXXv
UDj4kwBZ0pcC/U71pY7LmARnIrfRtJf/ZeKpdWiesEZw3WUuw2NgVHDXuxqtbUgP
YlMne+HOrvBt/Y7bnBSJBIhIA11S+2vnRjZcsynb1zWPS2jGR2SSwGL4OW0YzsLq
Eh0BI2g77Bic25YBwLzmGXnW5klovVaby3Eu89tQC1XAqf3YzGxjyK4vF6rAT9BL
xIIllDs5CcXndWOpRD5oJjoyA+Ez+pFTQe7fT9E2x9nuzpQsoq9PUD4v6ISR7AU=
=julC
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
