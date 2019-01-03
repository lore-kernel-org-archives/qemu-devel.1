Received: from eggs.gnu.org ([208.118.235.92]:42965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gf6hk-0004Eb-6V
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gf6hh-00056G-3A
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gf6hg-00055N-UT
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so29950414oth.7
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 09:22:44 -0800 (PST)
MIME-Version: 1.0
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 3 Jan 2019 18:22:31 +0100
Message-ID: <CAGxU2F53zsuVRBbvGTOU81zObL+4tTg_FgE0i04G2eOWckc29Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/4] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, maran.wilson@oracle.com
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>

Hi Liam, Hi Maran,
I'm writing the optionrom to do PVH boot also with SeaBIOS.
It is almost complete and I'm testing it, but I have some issue with
QEMU -initrd parameter.
(It works correctly without -initrd and using a kernel with all needed
modules compiled statically)

Linux boots correctly, but it is not able to find the ramdisk. (I have
the same behavior with qboot)
Looking at Linux, QEMU, and qboot patches, I understood that the first
module pointed by 'modlist_paddr' in the 'hvm_start_info' should be
used to pass the ramdisk address and size to the kernel, but I didn't
understand who load it in RAM. (I guess QEMU directly or the firmware
by fw_cfg interface)

Can you give me some suggestions?

Thanks,
Stefano

On Fri, Dec 21, 2018 at 9:07 PM Liam Merwick <liam.merwick@oracle.com> wrot=
e:
>
> For certain applications it is desirable to rapidly boot a KVM virtual
> machine. In cases where legacy hardware and software support within the
> guest is not needed, QEMU should be able to boot directly into the
> uncompressed Linux kernel binary with minimal firmware involvement.
>
> There already exists an ABI to allow this for Xen PVH guests and the ABI
> is supported by Linux and FreeBSD:
>
>    https://xenbits.xen.org/docs/unstable/misc/pvh.html
>
> Details on the Linux changes (v9 staged for 4.21): https://lkml.org/lkml/=
2018/12/14/1330
> qboot pull request: https://github.com/bonzini/qboot/pull/17
>
> This patch series provides QEMU support to read the ELF header of an
> uncompressed kernel binary and get the 32-bit PVH kernel entry point
> from an ELF Note.  In load_linux() a call is made to load_elfboot()
> so see if the header matches that of an uncompressed kernel binary (ELF)
> and if so, loads the binary and determines the kernel entry address
> from an ELF Note in the binary.  Then qboot does futher initialisation
> of the guest (e820, etc.) and jumps to the kernel entry address and
> boots the guest.
>
> changes v1 -> v2
> - Based on feedback from Stefan Hajnoczi
> - The reading of the PVH entry point is now done in a single pass during
>   elf_load() which results in Patch2 in v1 being split into Patches 1&2 i=
n v2
>   and considerably reworked.
> - Patch1 adds a new optional function pointer to parse the ELF note type
>   (the type is passed in via the existing translate_opaque arg - the
>   function already had 11 args so I didn't want to add more than one new =
arg).
> - Patch2 adds a function to elf_ops.h to find an ELF note
>   matching a specific type
> - Patch3 just has a line added to the commit message to state that the Xe=
n
>   repo is the canonical location
> - Patch4 (that does the PVH boot) is mainly equivalent to Patch3 in v1
>   just minor load_elfboot() changes and the addition of a
>   read_pvh_start_addr() helper function for load_elf()
>
>
> Us=D1=96ng the method/scripts documented by the NEMU team at
>
>    https://github.com/intel/nemu/wiki/Measuring-Boot-Latency
>    https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00200.html
>
> below are some timings measured (vmlinux and bzImage from the same build)
> Time to get to kernel start is almost halved (95=E1=B9=81s -> 48ms)
>
> QEMU + qboot + vmlinux (PVH + 4.20-rc4)
>  qemu_init_end: 41.550521
>  fw_start: 41.667139 (+0.116618)
>  fw_do_boot: 47.448495 (+5.781356)
>  linux_startup_64: 47.720785 (+0.27229)
>  linux_start_kernel: 48.399541 (+0.678756)
>  linux_start_user: 296.952056 (+248.552515)
>
> QEMU + qboot + bzImage:
>  qemu_init_end: 29.209276
>  fw_start: 29.317342 (+0.108066)
>  linux_start_boot: 36.679362 (+7.36202)
>  linux_startup_64: 94.531349 (+57.851987)
>  linux_start_kernel: 94.900913 (+0.369564)
>  linux_start_user: 401.060971 (+306.160058)
>
> QEMU + bzImage:
>  qemu_init_end: 30.424430
>  linux_startup_64: 893.770334 (+863.345904)
>  linux_start_kernel: 894.17049 (+0.400156)
>  linux_start_user: 1208.679768 (+314.509278)
>
>
> Liam Merwick (4):
>   elf: Add optional function ptr to load_elf() to parse ELF notes
>   elf-ops.h: Add get_elf_note_type()
>   pvh: Add x86/HVM direct boot ABI header file
>   pvh: Boot uncompressed kernel using direct boot ABI
>
>  hw/alpha/dp264.c               |   4 +-
>  hw/arm/armv7m.c                |   3 +-
>  hw/arm/boot.c                  |   2 +-
>  hw/core/generic-loader.c       |   2 +-
>  hw/core/loader.c               |  24 ++++---
>  hw/cris/boot.c                 |   3 +-
>  hw/hppa/machine.c              |   6 +-
>  hw/i386/multiboot.c            |   2 +-
>  hw/i386/pc.c                   | 131 +++++++++++++++++++++++++++++++++++=
-
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
>  include/hw/elf_ops.h           |  72 ++++++++++++++++++++
>  include/hw/loader.h            |   9 ++-
>  include/hw/xen/start_info.h    | 146 +++++++++++++++++++++++++++++++++++=
++++++
>  44 files changed, 469 insertions(+), 71 deletions(-)
>  create mode 100644 include/hw/xen/start_info.h
>
> --
> 1.8.3.1
>

--
Stefano Garzarella
Red Hat
