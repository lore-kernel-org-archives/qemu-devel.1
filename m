Received: from eggs.gnu.org ([2001:4830:134:3::10]:56483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAZAy-00071v-Hn
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAZAu-0008Fu-Kn
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:53:56 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:52366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAZAu-0008EB-Dt
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:53:52 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5B8451FD09
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 11:53:50 +0200 (CEST)
Date: Tue, 16 May 2017 11:53:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170516115342.5530d62d@bahia>
In-Reply-To: <149484840466.20089.893964776019028654.stgit@bahia.lan>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qH6X2XVpPHFzwLykbD878+i";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 6/6] spapr: fix migration of ICP
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>

--Sig_/qH6X2XVpPHFzwLykbD878+i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 13:40:04 +0200
Greg Kurz <groug@kaod.org> wrote:

> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> is an improvement since we no longer allocate ICP objects that will
> never be used. But it has the side-effect of breaking migration of
> older machine types from older QEMU versions.
>=20
> This patch introduces a compat flag in the sPAPR machine class so
> that all pseries machine up to 2.9 go on with the previous behavior
> of pre-allocating ICP objects.
>=20
> While here, we also ensure that object_property_add_child() errors cause
> QEMU to abort for newer machines.
>=20

Looking at the code again...

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c          |   36 ++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c |   28 ++++++++++++++++++++--------
>  include/hw/ppc/spapr.h  |    2 ++
>  3 files changed, 58 insertions(+), 8 deletions(-)
[...]
> @@ -142,12 +145,19 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      Object *obj;
> =20
> -    obj =3D object_new(spapr->icp_type);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);

... I now realize that we're lacking

       object_unref(obj);

and the ref count of the ICP object can never go down to zero...

I'll fix that in a preparatory patch for v2.

> -    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> -    if (local_err) {
> -        goto error;
> +    if (spapr->legacy_icps) {
> +        int index =3D cpu->parent_obj.cpu_index;
> +
> +        obj =3D OBJECT(&spapr->legacy_icps[index]);
> +    } else {
> +        obj =3D object_new(spapr->icp_type);
> +        object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> +        object_property_add_const_link(obj, "xics", OBJECT(spapr),
> +                                       &error_abort);
> +        object_property_set_bool(obj, true, "realized", &local_err);
> +        if (local_err) {
> +            goto error;
> +        }
>      }
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
> @@ -164,7 +174,9 @@ static void spapr_cpu_core_realize_child(Object *chil=
d, Error **errp)
>      return;
> =20
>  error:
> -    object_unparent(obj);
> +    if (!spapr->legacy_icps) {
> +        object_unparent(obj);
> +    }
>      error_propagate(errp, local_err);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f888c39d..72cd5af2679b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -53,6 +53,7 @@ struct sPAPRMachineClass {
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by defau=
lt */
> +    bool must_pre_allocate_icps; /* only for pseries-2.9 and older */
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
>                            hwaddr *mmio32, hwaddr *mmio64,
> @@ -109,6 +110,7 @@ struct sPAPRMachineState {
>      MemoryHotplugState hotplug_memory;
> =20
>      const char *icp_type;
> +    ICPState *legacy_icps;
>  };
> =20
>  #define H_SUCCESS         0
>=20
>=20


--Sig_/qH6X2XVpPHFzwLykbD878+i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkazCYACgkQAvw66wEB28IcmgCfRjDfvee5JTKdmD7+1UmpzL8m
QHwAn1mn9Ee2tNKhQMBFoVM0eYzEfNZN
=wgrw
-----END PGP SIGNATURE-----

--Sig_/qH6X2XVpPHFzwLykbD878+i--
