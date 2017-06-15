Received: from eggs.gnu.org ([2001:4830:134:3::10]:53245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dLPGr-0007oS-Sd
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dLPGn-0004rn-Sk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:32:49 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:45675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dLPGn-0004rU-MM
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:32:45 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6292F10689E
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 09:32:44 +0200 (CEST)
Date: Thu, 15 Jun 2017 09:32:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170615093238.65532c77@bahia.ttt.fr.ibm.com>
In-Reply-To: <1497495164-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1497495164-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/V17y8+d4ZH15iNgPvJGPQoR";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [FIX PATCH] spapr: prevent QEMU crash when CPU
 realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

--Sig_/V17y8+d4ZH15iNgPvJGPQoR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jun 2017 08:22:44 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> ICPState objects were being allocated before CPU thread realization.
> However commit 9ed656631d73 (xics: setup cpu at realize time) reversed it
> by allocating ICPState objects after CPU thread is realized. But it
> didn't take care to fix the error path because of which we observe
> a SIGSEGV when CPU thread realization fails during cold/hotplug.
>=20
> Fix this by ensuring that we do object_unparent() of ICPState object
> only in case when is was created earlier.
>=20

Oops, my bad... my initial intent was to conditionally call object_unparent=
()
and I simply forgot to put the "if (obj) { }". But your patch is valid as w=
ell
of course. Maybe you can drop the initialization of obj to NULL on the way,
since it really doesn't make sense anymore.

Thanks!

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> NOTE: There is another SIGSEGV failure that I am investigating which happ=
ens
> when CPU realization fails. It appears that that the CPU object isn't get=
ting
> fully cleaned up.
>=20



>  hw/ppc/spapr_cpu_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index d6719d5..0d0e959 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -198,13 +198,14 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
>      object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abor=
t);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> -        goto error;
> +        goto free_icp;
>      }
> =20
>      return;
> =20
> -error:
> +free_icp:
>      object_unparent(obj);
> +error:
>      error_propagate(errp, local_err);
>  }
> =20


--Sig_/V17y8+d4ZH15iNgPvJGPQoR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllCOBcACgkQAvw66wEB28KG2wCdFpn6WZBEjzsxZXKOmzQGwoKw
XcUAn1wPEWvpdiV3qean6vMMyP0YhfHD
=JMsJ
-----END PGP SIGNATURE-----

--Sig_/V17y8+d4ZH15iNgPvJGPQoR--
