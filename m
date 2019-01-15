Received: from eggs.gnu.org ([209.51.188.92]:33367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjXpz-0001Qv-Vc
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjXpx-0008Vx-H5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:09:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjXpr-0008K0-JM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:09:33 -0500
References: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6bc8a913-c7e8-4a31-a951-f5d8b292f723@redhat.com>
Date: Wed, 16 Jan 2019 00:09:03 +0100
MIME-Version: 1.0
In-Reply-To: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, stefanha@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com

On 15/01/19 13:18, Liam Merwick wrote:
> For certain applications it is desirable to rapidly boot a KVM virtual
> machine. In cases where legacy hardware and software support within the
> guest is not needed, QEMU should be able to boot directly into the
> uncompressed Linux kernel binary with minimal firmware involvement.
>=20
> There already exists an ABI to allow this for Xen PVH guests and the AB=
I
> is supported by Linux and FreeBSD:
>=20
>    https://xenbits.xen.org/docs/unstable/misc/pvh.html
>=20
> Details on the Linux changes (in 4.21): https://lkml.org/lkml/2018/12/1=
4/1330
> qboot pull request integrated: https://github.com/bonzini/qboot/pull/17=
=20
>=20
> This patch series provides QEMU support to read the ELF header of an
> uncompressed kernel binary and get the 32-bit PVH kernel entry point
> from an ELF Note.  In load_linux() a call is made to load_elfboot()
> so see if the header matches that of an uncompressed kernel binary (ELF=
)
> and if so, loads the binary and determines the kernel entry address
> from an ELF Note in the binary.  Then qboot does futher initialisation
> of the guest (e820, etc.) and jumps to the kernel entry address and
> boots the guest.

Queued, thanks!

Paolo

> changes v1 -> v2
> - Based on feedback from Stefan Hajnoczi
> - The reading of the PVH entry point is now done in a single pass durin=
g
>   elf_load() which results in Patch2 in v1 being split into Patches 1&2=
 in v2
>   and considerably reworked.
> - Patch1 adds a new optional function pointer to parse the ELF note typ=
e
>   (the type is passed in via the existing translate_opaque arg - the
>   function already had 11 args so I didn't want to add more than one ne=
w arg).
> - Patch2 adds a function to elf_ops.h to find an ELF note
>   matching a specific type=20
> - Patch3 just has a line added to the commit message to state that the =
Xen
>   repo is the canonical location
> - Patch4 (that does the PVH boot) is mainly equivalent to Patch3 in v1
>   just minor load_elfboot() changes and the addition of a
>   read_pvh_start_addr() helper function for load_elf()
>=20
> changes v2 -> v3
> - Based on feedback from Stefan Hajnoczi
> - Fix formatting issues where a few tabs snuck in v2
> - Moved code to use ELF Note in load_elf() from Patch1 to Patch2
> - In load_elf() set data to NULL after g_free() [now in Patch2 followin=
g move]
> - Added Patch5 containing changes by Stefano Garzarella to support -ini=
trd
>=20
> Us=D1=96ng the method/scripts documented by the NEMU team at
>=20
>    https://github.com/intel/nemu/wiki/Measuring-Boot-Latency
>    https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00200.html
>=20
> below are some timings measured (vmlinux and bzImage from the same buil=
d)
> Time to get to kernel start is almost halved (95=E1=B9=81s -> 48ms)
>=20
> QEMU + qboot + vmlinux (PVH + 4.20-rc4)
>  qemu_init_end: 41.550521
>  fw_start: 41.667139 (+0.116618)
>  fw_do_boot: 47.448495 (+5.781356)
>  linux_startup_64: 47.720785 (+0.27229)
>  linux_start_kernel: 48.399541 (+0.678756)
>  linux_start_user: 296.952056 (+248.552515)
>=20
> QEMU + qboot + bzImage:
>  qemu_init_end: 29.209276
>  fw_start: 29.317342 (+0.108066)
>  linux_start_boot: 36.679362 (+7.36202)
>  linux_startup_64: 94.531349 (+57.851987)
>  linux_start_kernel: 94.900913 (+0.369564)
>  linux_start_user: 401.060971 (+306.160058)
>=20
> QEMU + bzImage:
>  qemu_init_end: 30.424430
>  linux_startup_64: 893.770334 (+863.345904)
>  linux_start_kernel: 894.17049 (+0.400156)
>  linux_start_user: 1208.679768 (+314.509278)
>=20
>=20
> Liam Merwick (4):
>   elf: Add optional function ptr to load_elf() to parse ELF notes
>   elf-ops.h: Add get_elf_note_type()
>   pvh: Add x86/HVM direct boot ABI header file
>   pvh: Boot uncompressed kernel using direct boot ABI
>=20
>  hw/alpha/dp264.c               |   4 +-
>  hw/arm/armv7m.c                |   3 +-
>  hw/arm/boot.c                  |   2 +-
>  hw/core/generic-loader.c       |   2 +-
>  hw/core/loader.c               |  24 ++++---
>  hw/cris/boot.c                 |   3 +-
>  hw/hppa/machine.c              |   6 +-
>  hw/i386/multiboot.c            |   2 +-
>  hw/i386/pc.c                   | 135 +++++++++++++++++++++++++++++++++=
++++
>  hw/lm32/lm32_boards.c          |   6 +-
>  hw/lm32/milkymist.c            |   3 +-
>  hw/m68k/an5206.c               |   2 +-
>  hw/m68k/mcf5208.c              |   2 +-
>  hw/microblaze/boot.c           |   7 +-
>  hw/mips/mips_fulong2e.c        |   5 +-
>  hw/mips/mips_malta.c           |   5 +-
>  hw/mips/mips_mipssim.c         |   5 +-
>  hw/mips/mips_r4k.c             |   5 +-
>  hw/moxie/moxiesim.c            |   2 +-
>  hw/nios2/boot.c                |   7 +-
>  hw/openrisc/openrisc_sim.c     |   2 +-
>  hw/pci-host/prep.c             |   2 +-
>  hw/ppc/e500.c                  |   3 +-
>  hw/ppc/mac_newworld.c          |   5 +-
>  hw/ppc/mac_oldworld.c          |   5 +-
>  hw/ppc/ppc440_bamboo.c         |   2 +-
>  hw/ppc/sam460ex.c              |   3 +-
>  hw/ppc/spapr.c                 |   7 +-
>  hw/ppc/virtex_ml507.c          |   2 +-
>  hw/riscv/sifive_e.c            |   2 +-
>  hw/riscv/sifive_u.c            |   2 +-
>  hw/riscv/spike.c               |   2 +-
>  hw/riscv/virt.c                |   2 +-
>  hw/s390x/ipl.c                 |   9 ++-
>  hw/sparc/leon3.c               |   3 +-
>  hw/sparc/sun4m.c               |   6 +-
>  hw/sparc64/sun4u.c             |   4 +-
>  hw/tricore/tricore_testboard.c |   2 +-
>  hw/xtensa/sim.c                |  12 ++--
>  hw/xtensa/xtfpga.c             |   2 +-
>  include/elf.h                  |  10 +++
>  include/hw/elf_ops.h           |  77 ++++++++++++++++++++++
>  include/hw/loader.h            |   9 ++-
>  include/hw/xen/start_info.h    | 146 +++++++++++++++++++++++++++++++++=
++++++++
>  44 files changed, 479 insertions(+), 70 deletions(-)
>  create mode 100644 include/hw/xen/start_info.h
>=20
