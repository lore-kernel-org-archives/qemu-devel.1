Received: from eggs.gnu.org ([2001:4830:134:3::10]:42294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dgTTe-0008E2-BY
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dgTTb-0001nc-4S
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:17:06 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:46668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dgTTa-0001ks-UU
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:17:03 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8FB1F8C5A2
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 12:16:59 +0200 (CEST)
Date: Sat, 12 Aug 2017 12:16:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170812121651.497c6e39@bahia.lan>
In-Reply-To: <1502527090-11473-1-git-send-email-thuth@redhat.com>
References: <1502527090-11473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/oqH4CO.ltADaW4aUJTX7uad";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc/spapr_cpu_core: Add a
 proper check for spapr machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

--Sig_/oqH4CO.ltADaW4aUJTX7uad
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Aug 2017 10:38:10 +0200
Thomas Huth <thuth@redhat.com> wrote:

> QEMU currently crashes when the user tries to add a spapr-cpu-core
> on a non-pseries machine:
>=20
> $ qemu-system-ppc64 -S -machine ppce500,accel=3Dtcg \
>                     -device POWER5+_v2.1-spapr-cpu-core
> hw/ppc/spapr_cpu_core.c:178:spapr_cpu_core_realize_child:
> Object 0x55cee1f55160 is not an instance of type spapr-machine
> Aborted (core dumped)
>=20
> So let's add a proper check for the correct machine time with
> a more friendly error message here.
>=20
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/ppc/spapr_cpu_core.c   | 9 ++++++++-
>  scripts/device-crash-test | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ea278ce..0f3d653 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -175,11 +175,18 @@ static void spapr_cpu_core_unrealizefn(DeviceState =
*dev, Error **errp)
>  static void spapr_cpu_core_realize_child(Object *child, Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    sPAPRMachineState *spapr;
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      Object *obj;
> =20
> +    spapr =3D (sPAPRMachineState *)object_dynamic_cast(qdev_get_machine(=
),
> +                                                     TYPE_SPAPR_MACHINE);
> +    if (!spapr) {
> +        error_setg(errp, "spapr-cpu-core needs a pseries machine");
> +        return;
> +    }
> +

This is the realize function for individual threads. Maybe this sanity check
should be performed earlier at the core level in spapr_cpu_core_realize() ?

Also, spapr_cpu_core_realize_child() seem to only have spapr to pass it down
to spapr_cpu_init()... ie, not even sure spapr_cpu_core_realize_child()
actually needs a spapr variable.

>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
>          goto error;
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index e77b693..8eb2d02 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -200,6 +200,7 @@ ERROR_WHITELIST =3D [
>      {'log':r"Multiple VT220 operator consoles are not supported"},
>      {'log':r"core 0 already populated"},
>      {'log':r"could not find stage1 bootloader"},
> +    {'log':r"spapr-cpu-core needs a pseries machine"},
> =20
>      # other exitcode=3D1 failures not listed above will just generate IN=
FO messages:
>      {'exitcode':1, 'loglevel':logging.INFO},


--Sig_/oqH4CO.ltADaW4aUJTX7uad
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmO1ZMACgkQAvw66wEB28KFPACdEi5aULrOh7pIoPjWnJ1VxVlD
xR8AoJ0Qa/s4OTS7T9uGxxghlDudusob
=yiiW
-----END PGP SIGNATURE-----

--Sig_/oqH4CO.ltADaW4aUJTX7uad--
