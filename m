Received: from eggs.gnu.org ([209.51.188.92]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu9Aq-00019x-VF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu9Ap-0008Uk-CW
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:03:00 -0500
Date: Thu, 14 Feb 2019 15:59:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214045926.GB1884@umbus.fritz.box>
References: <20190117025115.81178-1-aik@ozlabs.ru>
	<fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
	<b82674e7-cc41-6bba-2f9e-9882bfd7afbd@ozlabs.ru>
	<20190207081830.4dcbb822@x1.home>
	<295fa9ca-29c1-33e6-5168-8991bc0ef7b1@ozlabs.ru>
	<20190207202620.23e9c063@x1.home>
	<20190208052849.GB6434@umbus.fritz.box>
	<45e89e77-02ad-aebf-ab2f-e5e7f7e12ecb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5C/VXimrgG1HEvSQ"
Content-Disposition: inline
In-Reply-To: <45e89e77-02ad-aebf-ab2f-e5e7f7e12ecb@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr_pci,
 vfio: NVIDIA V100 + P9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>


--5C/VXimrgG1HEvSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 02:49:49PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 08/02/2019 16:28, David Gibson wrote:
> > On Thu, Feb 07, 2019 at 08:26:20PM -0700, Alex Williamson wrote:
> >> On Fri, 8 Feb 2019 13:29:37 +1100
> >> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>
> >>> On 08/02/2019 02:18, Alex Williamson wrote:
> >>>> On Thu, 7 Feb 2019 15:43:18 +1100
> >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>  =20
> >>>>> On 07/02/2019 04:22, Daniel Henrique Barboza wrote: =20
> >>>>>> Based on this series, I've sent a Libvirt patch to allow a QEMU pr=
ocess
> >>>>>> to inherit IPC_LOCK when using VFIO passthrough with the Tesla V100
> >>>>>> GPU:
> >>>>>>
> >>>>>> https://www.redhat.com/archives/libvir-list/2019-February/msg00219=
=2Ehtml
> >>>>>>
> >>>>>>
> >>>>>> In that thread, Alex raised concerns about allowing QEMU to freely=
 lock
> >>>>>> all the memory it wants. Is this an issue to be considered in the =
review
> >>>>>> of this series here?
> >>>>>>
> >>>>>> Reading the patches, specially patch 3/3, it seems to me that QEMU=
 is
> >>>>>> going to lock the KVM memory to populate the NUMA node with memory
> >>>>>> of the GPU itself, so at first there is no risk of not taking over=
 the
> >>>>>> host RAM.
> >>>>>> Am I missing something?   =20
> >>>>>
> >>>>>
> >>>>> The GPU memory belongs to the device and not visible to the host as
> >>>>> memory blocks and not covered by page structs, for the host it is m=
ore
> >>>>> like MMIO which is passed through to the guest without that locked
> >>>>> accounting, I'd expect libvirt to keep working as usual except that:
> >>>>>
> >>>>> when libvirt calculates the amount of memory needed for TCE tables
> >>>>> (which is guestRAM/64k*8), now it needs to use the end of the last =
GPU
> >>>>> RAM window as a guest RAM size. For example, in QEMU HMP "info mtre=
e -f":
> >>>>>
> >>>>> FlatView #2
> >>>>>  AS "memory", root: system
> >>>>>  AS "cpu-memory-0", root: system
> >>>>>  Root memory region: system
> >>>>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>>>>   0000010000000000-0000011fffffffff (prio 0, ram): nvlink2-mr
> >>>>>
> >>>>> So previously the DMA window would cover 0x7fffffff+1, now it has to
> >>>>> cover 0x11fffffffff+1. =20
> >>>>
> >>>> This looks like a chicken and egg problem, you're saying libvirt nee=
ds
> >>>> to query mtree to understand the extent of the GPU layout, but we ne=
ed
> >>>> to specify the locked memory limits in order for QEMU to start?  Is
> >>>> libvirt supposed to start the VM with unlimited locked memory and fix
> >>>> it at some indeterminate point in the future?  Run a dummy VM with
> >>>> unlimited locked memory in order to determine the limits for the real
> >>>> VM?  Neither of these sound practical.  Thanks, =20
> >>>
> >>>
> >>> QEMU maps GPU RAM at known locations (which only depends on the vPHB's
> >>> index or can be set explicitely) and libvirt knows how many GPUs are
> >>> passed so it is quite easy to calculate the required amount of memory.
> >>>
> >>> Here is the window start calculation:
> >>> https://github.com/aik/qemu/commit/7073cad3ae7708d657e01672bcf5309280=
8b54fb#diff-662409c2a5a150fe231d07ea8384b920R3812
> >>>
> >>> We do not exactly know the GPU RAM window size until QEMU reads it fr=
om
> >>> VFIO/nvlink2 but we know that all existing hardware has a window of
> >>> 128GB (the adapters I have access to only have 16/32GB on board).
> >>
> >> So you're asking that libvirt add 128GB per GPU with magic nvlink
> >> properties, which may be 8x what's actually necessary and libvirt
> >> determines which GPUs to apply this to how?  Does libvirt need to sort
> >> through device tree properties for this?  Thanks,
> >=20
> > Hm.  If the GPU memory is really separate from main RAM, which it
> > sounds like, I don't think it makes sense to account it against the
> > same locked memory limit as regular RAM.
>=20
> This is accounting for TCE table to cover GPU RAM, not for GPU RAM itself.

Ah, ok, that makes sense then

> So I am asking libvirt to add 128GB/64k*8=3D16MB to the locked_vm. It
> already does so for the guest RAM.

That seems reasonable.  IIRC we already have some slop in the amount
of locked vm that libvirt allocates; not sure if it'll be enough as
is.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5C/VXimrgG1HEvSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxk9asACgkQbDjKyiDZ
s5LFzw/41jP75NOaTjZ/RL0vQ4BqtiYAfrK0rcxU+wl8pnnGgvqWWh2reQ+QOU/S
RbopzKn6UgRiiX9LoS7rGQjPSGoD7Y5kjm9OnKeyLMhukVFq8T+UWgfu8yB5qyiy
ZzTuShHB1USEn4ILfe7o+fqC+b5kazlK5wqRiHgZqavKtV+H++utZZqMOXYM88QH
4BzhZO2uDUeeHHQovDXLbnfqGGLZm3vg5f2e5XsOIKELm8jAcy7y3WnQulvYQDy3
KfKy52dCtP76JNZmd9wu3SauPZ2uB2c1lIJLKWbpCNnxSfIPLAvz2vm3e8sUckwQ
MBJaND85CU2jxxf3wY2I8EF8ED5DpIHGLlz9qhQpYEmurR2bT+ndIwYVA3EGe2F1
w3xoGDxT9erzogMamPKiTHU9s1BXu/JtDxH9PF/aZs4hXNH5v2IYURa5cksmDU8P
t5o5XgM4CX8uesAICeXWIYOx5DaLgCvbGFRAY5WUsyLuTNKNm4VP0DKfpaCsLBdY
+YtsEhMSqvUYPialusQPW9MahxUUcQdpMIeDDmeTvl03MK5CkmoCjefdt1vdDuf2
QJNV2O7QS1Lbq8EowUbqOkWUkU9i38ohFZkXHssH+LHbbuYwiyKa8PugAAjldier
iyVNLosfS9U+BQaA4h7s0rDPiRNsCYauaL1glSJ4auN0X8aG4g==
=OM6+
-----END PGP SIGNATURE-----

--5C/VXimrgG1HEvSQ--
