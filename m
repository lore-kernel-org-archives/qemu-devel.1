Received: from eggs.gnu.org ([2001:4830:134:3::10]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drJUz-0006xi-Qd
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drJUw-00019x-O4
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:51:17 -0400
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:52287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drJUw-00017v-HU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:51:14 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 59F84930E9
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 09:51:10 +0200 (CEST)
Date: Mon, 11 Sep 2017 09:50:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911095059.101e0cfc@bahia.lan>
In-Reply-To: <1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/dvLeBt9=am+I5T=gEssXqqO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, lvivier@redhat.com

--Sig_/dvLeBt9=am+I5T=gEssXqqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 10 Sep 2017 15:37:33 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> Commit a90db15 "target-ppc: Convert ppc cpu savevm to VMStateDescription"
> appears to drop the internal CPU IRQ state from the migration stream. Whi=
lst
> testing migration on g3beige/mac99 machines, test images would randomly f=
ail to
> resume unless a key was pressed on the VGA console.
>=20
> Further investigation suggests that internal CPU IRQ state isn't being
> preserved and so interrupts asserted at the time of migration are lost. A=
dding
> the pending_interrupts and irq_input_state fields back into the migration
> stream appears to fix the problem here during local tests.
>=20
> As part of this commit we bump the vmstate_ppc version from 5 to 6 to han=
dle
> the additional fields.
>=20

And so this unconditionally breaks backward migration... what about adding
a subsection for this ?

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/machine.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index e59049f..8fec1a4 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -647,7 +647,7 @@ static const VMStateDescription vmstate_compat =3D {
> =20
>  const VMStateDescription vmstate_ppc_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 5,
> +    .version_id =3D 6,
>      .minimum_version_id =3D 5,
>      .minimum_version_id_old =3D 4,
>      .load_state_old =3D cpu_load_old,
> @@ -678,6 +678,10 @@ const VMStateDescription vmstate_ppc_cpu =3D {
>          VMSTATE_UINTTL(env.hflags_nmsr, PowerPCCPU),
>          /* FIXME: access_type? */
> =20
> +        /* Interrupt state */
> +        VMSTATE_UINT32_V(env.pending_interrupts, PowerPCCPU, 6),
> +        VMSTATE_UINT32_V(env.irq_input_state, PowerPCCPU, 6),
> +
>          /* Sanity checking */
>          VMSTATE_UINTTL_TEST(mig_msr_mask, PowerPCCPU, cpu_pre_2_8_migrat=
ion),
>          VMSTATE_UINT64_TEST(mig_insns_flags, PowerPCCPU, cpu_pre_2_8_mig=
ration),


--Sig_/dvLeBt9=am+I5T=gEssXqqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbZAYwAKCRAC/DrrAQHb
wmSHAJ9ChdFCX54ywSV1mpvoKYfpIPJYpACcDtsUuwo/lZBAm/vtm6eaTB5zgTM=
=DbhS
-----END PGP SIGNATURE-----

--Sig_/dvLeBt9=am+I5T=gEssXqqO--
