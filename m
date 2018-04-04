Received: from eggs.gnu.org ([2001:4830:134:3::10]:33551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3iKr-0002Hy-E4
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3iKl-0001XT-T0
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:20:21 -0400
Date: Wed, 4 Apr 2018 14:20:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404132012.GQ4467@stefanha-x1.localdomain>
References: <20180329110914.20888-1-famz@redhat.com>
	<20180329110914.20888-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eBTWNsZZiigckDWV"
Content-Disposition: inline
In-Reply-To: <20180329110914.20888-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 4/8] file-posix: Implement
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com


--eBTWNsZZiigckDWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2018 at 07:09:10PM +0800, Fam Zheng wrote:
> +static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
> +{
> +#ifndef HAS_COPY_FILE_RANGE
> +    return -ENOTSUP;
> +#else
> +    uint64_t bytes = aiocb->aio_nbytes;
> +    off_t in_off = aiocb->aio_offset;
> +    off_t out_off = aiocb->offset2;
> +
> +    while (bytes) {
> +        ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
> +                                      aiocb->fd2, &out_off,
> +                                      bytes, 0);
> +        if (ret < 0) {
> +            return -errno;
> +        }

EINTR should retry.

--eBTWNsZZiigckDWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxNEMAAoJEJykq7OBq3PIvOsH+wU4dfuIKQPKyGiPxTotx3bz
UbQ7d+yTwMjPCvyJj9UpAePcTYTo043G2itQjXxbui7+rJ1smkW696T+4/ZnljeG
Z9E4h1Z42BNGO/45hEp79pVlvXmlqYFSY+DlzxyzSauJwW6J2lNof5WOZtGu0N/h
vLcmes6WAwNf7KMEX8FDlnZiu/h1rhpTF+uehT1O9Co7S0fqdSnC2aECiL9Kxj7L
SICeoyN44q9zsEenTfXRGJWO4jbC4WHgsrs2jB5lAOg0RZi+XtBLgfL76K2D+4QZ
YzM8QywPpO+/1O4uj2Mqk2ywe9Dfb3meBk31HpcAzlT2G2+u9E+X3Wq8Au6PFbQ=
=i/uf
-----END PGP SIGNATURE-----

--eBTWNsZZiigckDWV--
