Received: from eggs.gnu.org ([2001:4830:134:3::10]:42767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8BlM-0000zv-UR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8BlI-0002st-R9
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:29:40 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:43151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d8BlI-0002sU-Ks
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:29:36 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 33E35EE69D
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 22:29:34 +0200 (CEST)
Date: Tue, 9 May 2017 22:29:26 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170509222926.293ab520@bahia>
In-Reply-To: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/naxKA=FAPtwU3bzvGFshwoq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen/9pfs: fix two resource leaks on
 error paths, discovered by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xen.org, anthony.perard@citrix.com, aneesh.kumar@linux.vnet.ibm.com

--Sig_/naxKA=FAPtwU3bzvGFshwoq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  9 May 2017 12:04:51 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> CID: 1374836
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: anthony.perard@citrix.com
> CC: groug@kaod.org
> CC: aneesh.kumar@linux.vnet.ibm.com
> ---
>  hw/9pfs/xen-9p-backend.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 9c7f41a..a1fdede 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -332,12 +332,14 @@ static int xen_9pfs_connect(struct XenDevice *xende=
v)
>          str =3D g_strdup_printf("ring-ref%u", i);
>          if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
>                                   &xen_9pdev->rings[i].ref) =3D=3D -1) {
> +            g_free(str);
>              goto out;
>          }
>          g_free(str);

I would rather do something like:

    int ret;

    [...]

        str =3D g_strdup_printf("ring-ref%u", i);
        ret =3D xenstore_read_fe_int(&xen_9pdev->xendev, str,
                                   &xen_9pdev->rings[i].ref);
        g_free(str);
        if (ret =3D=3D  -1) {
            goto out;
        }

but this is a matter of taste and you own this code so:

Reviewed-by: Greg Kurz <groug@kaod.org>

>          str =3D g_strdup_printf("event-channel-%u", i);
>          if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
>                                   &xen_9pdev->rings[i].evtchn) =3D=3D -1)=
 {
> +            g_free(str);
>              goto out;
>          }
>          g_free(str);


--Sig_/naxKA=FAPtwU3bzvGFshwoq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkSJqYACgkQAvw66wEB28LRXACeJH2/eljzwM9UXX7+erH4je6A
dbcAn1bqcSd7vMJwxsGc7xz92mDZFt07
=6UzK
-----END PGP SIGNATURE-----

--Sig_/naxKA=FAPtwU3bzvGFshwoq--
