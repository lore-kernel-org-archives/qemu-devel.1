Received: from eggs.gnu.org ([2001:4830:134:3::10]:54434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHV5B-0000Ro-R5
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHV57-00041z-Sy
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:28:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eHV57-00041d-Ja
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:28:49 -0500
Date: Wed, 22 Nov 2017 14:28:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122142843.257ef9e2.cohuck@redhat.com>
In-Reply-To: <d0e6d96e-f35a-17fb-2714-3fbbb95c38a3@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171121114243.7ac15767.cohuck@redhat.com>
	<cd7b7f6e-dbb3-3d9a-bd3d-a5fb7d7b9d2b@linux.vnet.ibm.com>
	<d0e6d96e-f35a-17fb-2714-3fbbb95c38a3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/pci: rework PCI STORE BLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com

On Wed, 22 Nov 2017 13:15:21 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/11/22 =E4=B8=8A=E5=8D=882:07, Pierre Morel =E5=86=99=E9=81=
=93:
> > On 21/11/2017 11:42, Cornelia Huck wrote: =20
> >> On Thu, 16 Nov 2017 18:51:52 +0100
> >> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> >> =20
> >>> Enhance the fault detection.
> >>>
> >>> Fixup the precedence to check the destination path existance
> >>> before checking for the source accessibility.
> >>>
> >>> Add the maxstbl entry to both the Query PCI Function Group
> >>> response and the PCIBusDevice structure.
> >>>
> >>> Initialize the maxstbl to 128 per default until we get
> >>> the actual data from the hardware.
> >>>
> >>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >>> ---
> >>> =C2=A0 hw/s390x/s390-pci-bus.h=C2=A0 |=C2=A0 1 +
> >>> =C2=A0 hw/s390x/s390-pci-inst.c | 62=20
> >>> +++++++++++++++++++++++++++++-------------------
> >>> =C2=A0 hw/s390x/s390-pci-inst.h |=C2=A0 2 +-
> >>> =C2=A0 3 files changed, 40 insertions(+), 25 deletions(-) =20
> >> =20
> >>> @@ -700,8 +685,33 @@ int pcistb_service_call(S390CPU *cpu, uint8_t=20
> >>> r1, uint8_t r3, uint64_t gaddr,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (pcias > 5) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DPRINTF("pcistb invalid s=
pace\n");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setcc(cpu, ZPCI_PCI_LS_ER=
R);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_set_status_code(env,=
 r1, ZPCI_PCI_ST_INVAL_AS);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 /* Verify the address, offset and length */
> >>> +=C2=A0=C2=A0=C2=A0 /* offset must be a multiple of 8 */
> >>> +=C2=A0=C2=A0=C2=A0 if (offset % 8) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto addressing_error;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0 /* Length must be greater than 8, a multiple of 8=
, not greater=20
> >>> maxstbl */ =20
> >>
> >> "not greater than maxstlb" =20
> >
> > Better I know but greater that 80 characters, this is why I preferred=20
> > broken English.
> > What do I do ? break the line or English ? =20
> less than?

It's less or equal, no?

In any case, I prefer a multi-line comment over awkward language.

> > =20
> >> =20
> >>> +=C2=A0=C2=A0=C2=A0 if ((len <=3D 8) || (len % 8) || (len > pbdev->ma=
xstbl)) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto addressing_error;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0 /* Do not cross a 4K-byte boundary */
> >>> +=C2=A0=C2=A0=C2=A0 if (((offset & 0xfff) + len) > 0x1000) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto addressing_error;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0 /* Guest address must be double word aligned */
> >>> +=C2=A0=C2=A0=C2=A0 if (gaddr & 0x07UL) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto addressing_error;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mr =3D pbdev->pdev->io_regions[pcias].=
memory;
> >>> -=C2=A0=C2=A0=C2=A0 if (!memory_region_access_valid(mr, env->regs[r3]=
, len, true)) {
> >>> +=C2=A0=C2=A0=C2=A0 if (!memory_region_access_valid(mr, offset, len, =
true)) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 program_interr=
upt(env, PGM_OPERAND, 6);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> >>
> >> Looks good.
> >> =20
> >
> > =20
>=20
