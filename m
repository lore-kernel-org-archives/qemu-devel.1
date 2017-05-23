Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dD43h-0003pM-G4
	for qemu-devel@nongnu.org; Tue, 23 May 2017 03:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dD43e-0008VZ-8b
	for qemu-devel@nongnu.org; Tue, 23 May 2017 03:16:45 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:52335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dD43e-0008Uj-1r
	for qemu-devel@nongnu.org; Tue, 23 May 2017 03:16:42 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7851F3DED9
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 09:16:40 +0200 (CEST)
Date: Tue, 23 May 2017 09:16:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170523091631.4f1ddf20@bahia.lan>
In-Reply-To: <20170523063645.1247-1-david@gibson.dropbear.id.au>
References: <20170523063645.1247-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/fJ9RZjwO0Y=H245XcQx7H/7";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] pseries: Restore support for total vcpus
 not a multiple of threads-per-core for old machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/fJ9RZjwO0Y=H245XcQx7H/7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017 16:36:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> As of pseries-2.7 and later, we require the total number of guest vcpus to
> be a multiple of the threads-per-core.  pseries-2.6 and earlier machine
> types, however, are supposed to allow this for the sake of migration from
> old qemu versions which allowed this.
>=20
> Unfortunately, 8149e29 "pseries: Enforce homogeneous threads-per-core"
> broke this by not considering the old machine type case.  This fixes it by
> only applying the check when the machine type supports hotpluggable cpus.
> By not-entirely-coincidence, that corresponds to the same time when we
> started enforcing total threads being a multiple of threads-per-core.
>=20
> Fixes: 8149e2992f7811355cc34721b79d69d1a3a667dd
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Tested-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c92d269..bcb0e18 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2863,7 +2863,13 @@ static void spapr_core_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> -    if (cc->nr_threads !=3D smp_threads) {
> +    /*
> +     * In general we should have homogeneous threads-per-core, but old
> +     * (pre hotplug support) machine types allow the last core to have
> +     * reduced threads as a compatibility hack for when we allowed
> +     * total vcpus not a multiple of threads-per-core.
> +     */
> +    if (mc->has_hotpluggable_cpus && (cc->nr_threads !=3D smp_threads)) {
>          error_setg(errp, "invalid nr-threads %d, must be %d",
>                     cc->nr_threads, smp_threads);
>          return;


--Sig_/fJ9RZjwO0Y=H245XcQx7H/7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkj4c8ACgkQAvw66wEB28KARwCgj/XOvdZsWwFVQss0wE53yHyW
VyMAn0ALrcpDC8e1RORR8xsL/rArx8Xg
=LwAl
-----END PGP SIGNATURE-----

--Sig_/fJ9RZjwO0Y=H245XcQx7H/7--
