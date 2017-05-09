Received: from eggs.gnu.org ([2001:4830:134:3::10]:48866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8CA1-0001fu-FF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8C9y-0003rV-Rn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:55:09 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:46636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d8C9y-0003qn-Kf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:55:06 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B3E6FEE6DF
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 22:55:04 +0200 (CEST)
Date: Tue, 9 May 2017 22:54:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170509225455.694ef4dc@bahia>
In-Reply-To: <1494356693-13190-3-git-send-email-sstabellini@kernel.org>
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
	<1494356693-13190-3-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/CG2M8v.3ocpQ5K13yucqeqP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen: call qemu_set_cloexec instead
 of fcntl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xen.org, anthony.perard@citrix.com, aneesh.kumar@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>

--Sig_/CG2M8v.3ocpQ5K13yucqeqP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  9 May 2017 12:04:53 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Use the common utility function, which contains checks on return values,

... and first calls F_GETFD as recommended by POSIX.1-2001.

http://pubs.opengroup.org/onlinepubs/009695399/functions/fcntl.html

"The arg values to F_GETFD, F_SETFD, F_GETFL, and F_SETFL all represent
flag values to allow for future growth. Applications using these functions
should do a read-modify-write operation on them, rather than assuming that
only the values defined by this volume of IEEE Std 1003.1-2001 are valid.
It is a common error to forget this, particularly in the case of F_SETFD."

> instead of manually calling fcntl.
>=20
> CID: 1374831
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: anthony.perard@citrix.com
> CC: groug@kaod.org
> CC: aneesh.kumar@linux.vnet.ibm.com
> CC: Eric Blake <eblake@redhat.com>
> ---
>  hw/9pfs/xen-9p-backend.c | 2 +-
>  hw/xen/xen_backend.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index a1fdede..5df97c9 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -380,7 +380,7 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
>          if (xen_9pdev->rings[i].evtchndev =3D=3D NULL) {
>              goto out;
>          }
> -        fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev), F_SETFD,
> FD_CLOEXEC);
> +        qemu_set_cloexec(xenevtchn_fd(xen_9pdev->rings[i].evtchndev));
>          xen_9pdev->rings[i].local_port =3D xenevtchn_bind_interdomain
>                                              (xen_9pdev->rings[i].evtchnd=
ev,
>                                               xendev->dom,
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index c85f163..2cac47d 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -147,7 +147,7 @@ static struct XenDevice *xen_be_get_xendev(const char
> *type, int dom, int dev, qdev_unplug(DEVICE(xendev), NULL);
>          return NULL;
>      }
> -    fcntl(xenevtchn_fd(xendev->evtchndev), F_SETFD, FD_CLOEXEC);
> +    qemu_set_cloexec(xenevtchn_fd(xendev->evtchndev));
> =20
>      if (ops->flags & DEVOPS_FLAG_NEED_GNTDEV) {
>          xendev->gnttabdev =3D xengnttab_open(NULL, 0);


--Sig_/CG2M8v.3ocpQ5K13yucqeqP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEUEARECAAYFAlkSLJ8ACgkQAvw66wEB28J8WgCXURaOc6wJ4hlGlHs46d5Ncws5
eQCdHVuraoF5oNNQle6SHaRKx+kM+QY=
=f+fa
-----END PGP SIGNATURE-----

--Sig_/CG2M8v.3ocpQ5K13yucqeqP--
