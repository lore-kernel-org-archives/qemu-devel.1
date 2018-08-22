Received: from eggs.gnu.org ([2001:4830:134:3::10]:59004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fsRRh-0001iS-KY
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fsRRe-0004ZR-TG
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:37:05 -0400
Date: Wed, 22 Aug 2018 10:12:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180822001242.GA15045@umbus.fritz.box>
References: <1534850868-30172-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1534850868-30172-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: Remove deprecated ppcemb target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, libvir-list@redhat.com, qemu-ppc@nongnu.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 01:27:48PM +0200, Thomas Huth wrote:
> There is no known available OS for ppc around anymore that uses page
> sizes below 4k, so it does not make much sense that we keep wasting
> our time on building and testing the ppcemb-softmmu target. It has
> been deprecated since two releases, and nobody complained, so let's
> remove this now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  configure                          | 13 +++----------
>  cpus.c                             |  1 -
>  default-configs/ppcemb-softmmu.mak | 23 -----------------------
>  hw/ppc/ppc405_boards.c             | 14 --------------
>  hw/ppc/ppc440_bamboo.c             |  7 -------
>  hw/ppc/sam460ex.c                  |  7 -------
>  hw/ppc/virtex_ml507.c              |  7 -------
>  include/exec/poison.h              |  1 -
>  qapi/common.json                   |  2 +-
>  qemu-deprecated.texi               |  6 ------
>  target/ppc/cpu-qom.h               |  2 --
>  target/ppc/cpu.h                   | 16 ----------------
>  target/ppc/kvm.c                   |  4 +---
>  target/ppc/mmu_helper.c            |  6 +++---
>  target/ppc/translate_init.inc.c    | 35 +-------------------------------=
---
>  tests/machine-none-test.c          |  1 -
>  16 files changed, 9 insertions(+), 136 deletions(-)
>  delete mode 100644 default-configs/ppcemb-softmmu.mak
>=20
> diff --git a/configure b/configure
> index e7bddc0..0fc55eb 100755
> --- a/configure
> +++ b/configure
> @@ -195,8 +195,7 @@ supported_kvm_target() {
>          i386:i386 | i386:x86_64 | i386:x32 | \
>          x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
>          mips:mips | mipsel:mips | \
> -        ppc:ppc | ppcemb:ppc | ppc64:ppc | \
> -        ppc:ppc64 | ppcemb:ppc64 | ppc64:ppc64 | \
> +        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | \
>          s390x:s390x)
>              return 0
>          ;;
> @@ -6935,7 +6934,7 @@ if test "$linux" =3D "yes" ; then
>    i386|x86_64|x32)
>      linux_arch=3Dx86
>      ;;
> -  ppcemb|ppc|ppc64)
> +  ppc|ppc64)
>      linux_arch=3Dpowerpc
>      ;;
>    s390x)
> @@ -6965,7 +6964,7 @@ target_name=3D$(echo $target | cut -d '-' -f 1)
>  target_bigendian=3D"no"
> =20
>  case "$target_name" in
> -  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|o=
r1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtens=
aeb)
> +  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|o=
r1k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
>    target_bigendian=3Dyes
>    ;;
>  esac
> @@ -7093,12 +7092,6 @@ case "$target_name" in
>      gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml"
>      target_compiler=3D$cross_cc_powerpc
>    ;;
> -  ppcemb)
> -    TARGET_BASE_ARCH=3Dppc
> -    TARGET_ABI_DIR=3Dppc
> -    gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml"
> -    target_compiler=3D$cross_cc_ppcemb
> -  ;;
>    ppc64)
>      TARGET_BASE_ARCH=3Dppc
>      TARGET_ABI_DIR=3Dppc
> diff --git a/cpus.c b/cpus.c
> index b5844b7..80ca683 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2203,7 +2203,6 @@ static CpuInfoArch sysemu_target_to_cpuinfo_arch(Sy=
sEmuTarget target)
>          return CPU_INFO_ARCH_X86;
> =20
>      case SYS_EMU_TARGET_PPC:
> -    case SYS_EMU_TARGET_PPCEMB:
>      case SYS_EMU_TARGET_PPC64:
>          return CPU_INFO_ARCH_PPC;
> =20
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
> deleted file mode 100644
> index ac44f15..0000000
> --- a/default-configs/ppcemb-softmmu.mak
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -# Default configuration for ppcemb-softmmu
> -
> -include pci.mak
> -include sound.mak
> -include usb.mak
> -CONFIG_PPC4XX=3Dy
> -CONFIG_M48T59=3Dy
> -CONFIG_SERIAL=3Dy
> -CONFIG_SERIAL_ISA=3Dy
> -CONFIG_I8257=3Dy
> -CONFIG_OPENPIC=3Dy
> -CONFIG_PFLASH_CFI01=3Dy
> -CONFIG_PFLASH_CFI02=3Dy
> -CONFIG_PTIMER=3Dy
> -CONFIG_I8259=3Dy
> -CONFIG_XILINX=3Dy
> -CONFIG_XILINX_ETHLITE=3Dy
> -CONFIG_USB_EHCI_SYSBUS=3Dy
> -CONFIG_SM501=3Dy
> -CONFIG_DDC=3Dy
> -CONFIG_IDE_SII3112=3Dy
> -CONFIG_I2C=3Dy
> -CONFIG_BITBANG_I2C=3Dy
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 7011107..3a54d52 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -202,13 +202,6 @@ static void ref405ep_init(MachineState *machine)
>      DriveInfo *dinfo;
>      MemoryRegion *sysmem =3D get_system_memory();
> =20
> -#ifdef TARGET_PPCEMB
> -    if (!qtest_enabled()) {
> -        warn_report("qemu-system-ppcemb is deprecated, "
> -                    "please use qemu-system-ppc instead.");
> -    }
> -#endif
> -
>      /* XXX: fix this */
>      memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405e=
p.ram",
>                                           0x08000000);
> @@ -503,13 +496,6 @@ static void taihu_405ep_init(MachineState *machine)
>      int fl_idx, fl_sectors;
>      DriveInfo *dinfo;
> =20
> -#ifdef TARGET_PPCEMB
> -    if (!qtest_enabled()) {
> -        warn_report("qemu-system-ppcemb is deprecated, "
> -                    "please use qemu-system-ppc instead.");
> -    }
> -#endif
> -
>      /* RAM is soldered to the board so the size cannot be changed */
>      ram_size =3D 0x08000000;
>      memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 3d4c43b..f5720f9 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -195,13 +195,6 @@ static void bamboo_init(MachineState *machine)
>          exit(1);
>      }
> =20
> -#ifdef TARGET_PPCEMB
> -    if (!qtest_enabled()) {
> -        warn_report("qemu-system-ppcemb is deprecated, "
> -                    "please use qemu-system-ppc instead.");
> -    }
> -#endif
> -
>      qemu_register_reset(main_cpu_reset, cpu);
>      ppc_booke_timers_init(cpu, 400000000, 0);
>      ppc_dcr_init(env, NULL, NULL);
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 9c77183..250fb86 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -419,13 +419,6 @@ static void sam460ex_init(MachineState *machine)
>          exit(1);
>      }
> =20
> -#ifdef TARGET_PPCEMB
> -    if (!qtest_enabled()) {
> -        warn_report("qemu-system-ppcemb is deprecated, "
> -                    "please use qemu-system-ppc instead.");
> -    }
> -#endif
> -
>      qemu_register_reset(main_cpu_reset, cpu);
>      boot_info =3D g_malloc0(sizeof(*boot_info));
>      env->load_info =3D boot_info;
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 7891464..ee9b4b4 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -211,13 +211,6 @@ static void virtex_init(MachineState *machine)
>      int kernel_size;
>      int i;
> =20
> -#ifdef TARGET_PPCEMB
> -    if (!qtest_enabled()) {
> -        warn_report("qemu-system-ppcemb is deprecated, "
> -                    "please use qemu-system-ppc instead.");
> -    }
> -#endif
> -
>      /* init CPUs */
>      cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 40000000=
0);
>      env =3D &cpu->env;
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 41cd2eb..97d3b56 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -24,7 +24,6 @@
>  #pragma GCC poison TARGET_NIOS2
>  #pragma GCC poison TARGET_OPENRISC
>  #pragma GCC poison TARGET_PPC
> -#pragma GCC poison TARGET_PPCEMB
>  #pragma GCC poison TARGET_PPC64
>  #pragma GCC poison TARGET_ABI32
>  #pragma GCC poison TARGET_S390X
> diff --git a/qapi/common.json b/qapi/common.json
> index c367adc..50ac121 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -146,6 +146,6 @@
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 67b7211..8cd2a3d 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -182,12 +182,6 @@ replaced by the ``target'' output member.
>  The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
>  or ``ivshmem-doorbell`` device types.
> =20
> -@subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12=
=2E0)
> -
> -qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc6=
4)
> -should be used instead. That means that embedded 4xx PowerPC CPUs will n=
ot
> -support page sizes < 4096 any longer.
> -
>  @section System emulator machines
> =20
>  @subsection pc-0.10 and pc-0.11 (since 3.0)
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 433a71e..4ea6769 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -24,8 +24,6 @@
> =20
>  #ifdef TARGET_PPC64
>  #define TYPE_POWERPC_CPU "powerpc64-cpu"
> -#elif defined(TARGET_PPCEMB)
> -#define TYPE_POWERPC_CPU "embedded-powerpc-cpu"
>  #else
>  #define TYPE_POWERPC_CPU "powerpc-cpu"
>  #endif
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4edcf62..758227d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -52,23 +52,7 @@
>  #else /* defined (TARGET_PPC64) */
>  /* PowerPC 32 definitions */
>  #define TARGET_LONG_BITS 32
> -
> -#if defined(TARGET_PPCEMB)
> -/* Specific definitions for PowerPC embedded */
> -/* BookE have 36 bits physical address space */
> -#if defined(CONFIG_USER_ONLY)
> -/* It looks like a lot of Linux programs assume page size
> - * is 4kB long. This is evil, but we have to deal with it...
> - */
> -#define TARGET_PAGE_BITS 12
> -#else /* defined(CONFIG_USER_ONLY) */
> -/* Pages can be 1 kB small */
> -#define TARGET_PAGE_BITS 10
> -#endif /* defined(CONFIG_USER_ONLY) */
> -#else /* defined(TARGET_PPCEMB) */
> -/* "standard" PowerPC 32 definitions */
>  #define TARGET_PAGE_BITS 12
> -#endif /* defined(TARGET_PPCEMB) */
> =20
>  #define TARGET_PHYS_ADDR_SPACE_BITS 36
>  #define TARGET_VIRT_ADDR_SPACE_BITS 32
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9211ee2..ef63842 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1315,9 +1315,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, =
int level)
>      return 0;
>  }
> =20
> -#if defined(TARGET_PPCEMB)
> -#define PPC_INPUT_INT PPC40x_INPUT_INT
> -#elif defined(TARGET_PPC64)
> +#if defined(TARGET_PPC64)
>  #define PPC_INPUT_INT PPC970_INPUT_INT
>  #else
>  #define PPC_INPUT_INT PPC6xx_INPUT_INT
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index e6739e6..a1d848f 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -2363,12 +2363,12 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target=
_ulong entry,
>      tlb->size =3D booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT)
>                                         & PPC4XX_TLBHI_SIZE_MASK);
>      /* We cannot handle TLB size < TARGET_PAGE_SIZE.
> -     * If this ever occurs, one should use the ppcemb target instead
> -     * of the ppc or ppc64 one
> +     * If this ever occurs, we should implement TARGET_PAGE_BITS_VARY
>       */
>      if ((val & PPC4XX_TLBHI_V) && tlb->size < TARGET_PAGE_SIZE) {
>          cpu_abort(cs, "TLB size " TARGET_FMT_lu " < %u "
> -                  "are not supported (%d)\n",
> +                  "are not supported (%d)\n"
> +                  "Please implement TARGET_PAGE_BITS_VARY\n",
>                    tlb->size, TARGET_PAGE_SIZE, (int)((val >> 7) & 0x7));
>      }
>      tlb->EPN =3D val & ~(tlb->size - 1);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 7813b1b..c16d986 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9630,17 +9630,6 @@ static int ppc_fixup_cpu(PowerPCCPU *cpu)
>      return 0;
>  }
> =20
> -static inline bool ppc_cpu_is_valid(PowerPCCPUClass *pcc)
> -{
> -#ifdef TARGET_PPCEMB
> -    return pcc->mmu_model =3D=3D POWERPC_MMU_BOOKE ||
> -           pcc->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
> -           pcc->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx_Z;
> -#else
> -    return true;
> -#endif
> -}
> -
>  static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs =3D CPU(dev);
> @@ -9664,8 +9653,6 @@ static void ppc_cpu_realize(DeviceState *dev, Error=
 **errp)
>          }
>      }
> =20
> -    assert(ppc_cpu_is_valid(pcc));
> -
>      create_ppc_opcodes(cpu, &local_err);
>      if (local_err !=3D NULL) {
>          error_propagate(errp, local_err);
> @@ -9916,10 +9903,6 @@ static gint ppc_cpu_compare_class_pvr(gconstpointe=
r a, gconstpointer b)
>          return -1;
>      }
> =20
> -    if (!ppc_cpu_is_valid(pcc)) {
> -        return -1;
> -    }
> -
>      return pcc->pvr =3D=3D pvr ? 0 : -1;
>  }
> =20
> @@ -9950,10 +9933,6 @@ static gint ppc_cpu_compare_class_pvr_mask(gconstp=
ointer a, gconstpointer b)
>          return -1;
>      }
> =20
> -    if (!ppc_cpu_is_valid(pcc)) {
> -        return -1;
> -    }
> -
>      if (pcc->pvr_match(pcc, pvr)) {
>          return 0;
>      }
> @@ -10019,11 +9998,7 @@ static ObjectClass *ppc_cpu_class_by_name(const c=
har *name)
>      g_free(typename);
>      g_free(cpu_model);
> =20
> -    if (oc && ppc_cpu_is_valid(POWERPC_CPU_CLASS(oc))) {
> -        return oc;
> -    }
> -
> -    return NULL;
> +    return oc;
>  }
> =20
>  static void ppc_cpu_parse_featurestr(const char *type, char *features,
> @@ -10129,9 +10104,6 @@ static void ppc_cpu_list_entry(gpointer data, gpo=
inter user_data)
>      char *name;
>      int i;
> =20
> -    if (!ppc_cpu_is_valid(pcc)) {
> -        return;
> -    }
>      if (unlikely(strcmp(typename, TYPE_HOST_POWERPC_CPU) =3D=3D 0)) {
>          return;
>      }
> @@ -10189,11 +10161,6 @@ static void ppc_cpu_defs_entry(gpointer data, gp=
ointer user_data)
>      const char *typename;
>      CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> -
> -    if (!ppc_cpu_is_valid(pcc)) {
> -        return;
> -    }
> =20
>      typename =3D object_class_get_name(oc);
>      info =3D g_malloc0(sizeof(*info));
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 7e72466..2b3b750 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -44,7 +44,6 @@ static struct arch2cpu cpus_map[] =3D {
>      { "or1k", "or1200" },
>      { "ppc", "604" },
>      { "ppc64", "power8e_v2.1" },
> -    { "ppcemb", "440epb" },
>      { "s390x", "qemu" },
>      { "sh4", "sh7750r" },
>      { "sh4eb", "sh7751r" },

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlt8qngACgkQbDjKyiDZ
s5JeKA//fNDuAhalxjQXhRebUlpQ77MyqFwxEx7O845ly3CNT8Ozjdg25H+B8vhY
sYLqtnxHhV+krdKD5R/uR0YHRzj7RMhb2NDzQUQBcsAP9HKWLa+DsnyQ17Z8PBgz
T45hjsjuf/uXTfIWal1MwwVByAJ/Q4K9H8p/7l7stg69vpJSSlS+EC/DyGvn2q3H
J6Wzzo/0cemAYPhr4XAuhVX8fRx1Dh8JOMGhMNi73DUgzwd1hZ+3humkVzwwQvK7
BT+jbShsv9iBjyuu1Ah5593Hg7OWI2viZXR8dK8A3z8CTXm/GQt2LgTGux2G652z
JOiGEGhS8Mn9kcMjwlQNNZ2fr225eaHHc3F24QFjUBNc/aRznMtLWFVkdD2WT22w
T6yP5V18gXREMYCnmh3EdVXxHe5RjpsAIg8wjYB6ZV2mgxlYy4ySZKPIhc0vqwvA
BTXKr6dXEh9imp8Pz7LeO6Ez5wfiX3JIlf4nfQRDIMd2dEOs7hMqGfw4/lOY9hTi
GNdBPowDGO5pBEnd0cz1LMof/qunqizyUVKYp5i7Jcp9yVM4DSmRxs89t2cDesHh
7cgN5DPmP0qpNReXVPUNRQXNPlPRGIfMvNqj/0FsiagFnDcw08fSeqCkjKuFLFX2
bLzeIQ3pH6zQNFBFoi86HcrzxAJ/3hM2sfahG3Qj3NgqAqOvCrU=
=Xtjc
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
