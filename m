Received: from eggs.gnu.org ([209.51.188.92]:39202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkX2e-0005w8-RU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkX2a-0000pE-DJ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:30:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gkX2Y-0000m0-66
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:30:42 -0500
Date: Fri, 18 Jan 2019 11:30:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190118112947-mutt-send-email-mst@kernel.org>
References: <20190118112410.3010-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/43] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On Fri, Jan 18, 2019 at 07:23:27PM +0800, Yang Zhong wrote:
> This Kconfig implementation is rebased from Paolo's branch
> https://github.com/bonzini/qemu/commits/kconfig
>=20
> I rebased most of patches except non-x86 ARCHs dependency definitions
> this time.
> https://github.com/yangzhon/qemu/commits/topic/upstream/Kconfig
>=20
> The current RFC patches only support
> (*) x86_64 platform build
>     Once design is fixed, we can do other archs.
>=20
> (*) defconfig
>     "randconfig" build has some issues, which are mostly related
>     with CONFIG* in Kconfig.host abd configure. In randconfig mode,
>     some CONFIG* has different setting value in config-host.mak and
>     %/config-device.mak, which make QEMU build failure.
>=20
> (*) Kconfig in hw/ directory
>=20
> The current configure and build command are same with previous
> commands and if we want to disable or enable some features, like
> "tcg", we still need add "--enable/--disable-tcg" in configure
> command line. If we want to disable one emulation device, we can
> disable this in related Kconfig file in hw/ directory.
>=20
> The current build command:
> (*) ./configure --target-list=3Dx86_64-softmmu
> (*) make -j8
>=20
> Since the Kconfig language replace traditional CONFIG_* in
> default-config/%-softmmu.mak, the %-softmmu.mak file only
> define embeded boards or machines, like 440fx and Q35 in x86_64
> platform. The Kconfig has already defined dependency topology
> between different Kconfig files, but there are still some issues
>=20
> (*) Kconfig for configure(config-host.mak)
>     Some CONFIG* in configure  need some logic to generate, those
>     are hard to input this CONFIG* in Kconfig.host or Kconfig* file.
>=20
> (*) Kconfig for %config-target.mak
>     The CONFIG* in %/config-target.mak file, this is still related
>     with configure.
>=20
> (*) randconfig support issue.
>=20
> Before this RFC patches, we have talked Kconfig in another thread
> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html
>=20
> Please give your comments on this RFC thread, many thanks!

I wonder whether we can support menuconfig as well?
Right now entries have no description for menuconfig -
can that be added?

> Changes in v3:
> patch 3:    resume CONFIG_ACPI=3Dy for ARM (Thomas Huth)
> patch 4:    CONFIG_AN5206 for an5206.o and mcf5206.o (Thomas Huth)
> patch 6:    CONFIG_VT82C686 is only in mips64el-softmmu.mak (Thomas Hut=
h)
> patch 7:    sort the new config switches into "# For Macs" and
>             "# For embedded PPC" section (Thomas Huth)
> patch 8:    sh7750.o and sh7750_regnames.o are "common" code, no need t=
o
>             define new CONFIG.(Thomas Huth)
> patch 12:   CONFIG_NIOS2_10M50 replace CONFIG_NIOS2_10M50_BOARD(Thomas =
Huth)
> patch 13:   added new CONFIGs for sifive_e.o and sifive_u.o(Thomas Huth=
)
>             CONFIG_RISCV_VIRT for virt.o
> patch 15~20:added for other non-x86 platforms(alpha/Kconfig, cris/Kconf=
ig
>             hppa/Kconfig,unicore32/Kconfig,tricore/Kconfig,moxie/Kconfi=
g
>             openrisc/Kconfig)(Thomas Huth)
> patch 25:   sort the sources/*/Kconfig entries alphabetically(Thomas Hu=
th)
>             added the new configs for arm/nios2/ppc/sh4/sparc
> patch 29:   E1000E_PCI with PCIE dependency(Thomas Huth)
> patch 30:   CONFIG_ISA_BUS replace CONFIG_ISA(Thomas Huth)
> patch 32:   changed the commit message (Paolo)(Thomas Huth)
> patch 41:   "I440FX && Q35" was changedto "I440FX || Q35"(Thomas Huth)
>             "default y" for IPMI_LOCAL and IPMI_EXTERN
>=20
> Changes in v2:
> patch 1:    added "CONFIG_PAM=3Dy" in default-configs/i386-softmmu.mak
>             (Thomas Huth)
> patch 3~14: added support for other ARCHs configurable(Paolo)
> patch 15:   changed the annotate (Paolo)
> patch 16:   changed the python code (Paolo)
> patch 19:   added other ARCHs Kconfig files(Paolo)
> patch 21:   added "select IDE_PCI" for CMD646, PIIX, VIA and SII3112(Th=
omas Huth)
> patch 22:   added new patch for PCIE configurable.
> patch 23:   moved "select IDE_PCI" from  CMD646, PIIX, VIA to 21 patch(=
Thomas Huth)
>             added "select CAN_BUS" for net/Kconfig (Thomas Huth)
>             added "depends on PCI" for CAN_SJA1000 (Paolo)
>             removed CONFIG_PCIE=3Dy and add dependency for pcie(Paolo)
> patch 26:   added "depends on PSERIES" for "config SPAPR_VSCSI" (Thomas=
 Huth)
>             USB_STORAGE_BOT and USB_STORAGE_UAS must also "select SCSI"=
(Paolo)
> patch 28:   added "select SERIAL" into "config SERIAL_PCI" (Thomas Huth=
)
>             removed "depend on ISA_BUS" from "config VGA_CIRRUS"(Thomas=
 Huth)
> patch 30:   "config XLNX_ZYNQMP_ARM" is defined in hw/arm/Kconfig(Thoma=
s Huth)
>             CONFIG_AUX should select I2C(Paolo)
> patch 33:   depends on HYPERV for HYPERV_TESTDEV(Thomas Huth)
>             removed "select HYPERV" and "select HYPERV_TESTDEV" with
>             "default y if PC" in "config HYPERV" and "config HYPERV_TES=
TDEV"(Paolo)
> patch 34:   deleted default-configs/virtio.mak(Thomas Huth)
>             removed "y" in "config VIRTIO_MMIO"(Thomas Huth)
> patch 35:   removed remaining CONFIG_* and removed "select xxxx" from h=
w/i386/Kconfig
>             to other Kconfigs(Paolo)
>=20
> Paolo Bonzini (18):
>   build: actually use CONFIG_PAM
>   hw/i386/Makefile.objs: Build pc_piix* and pc_q35 boards
>   minikconfig: add parser skeleton
>   minikconfig: add AST
>   minikconfig: add semantic analysis
>   kconfig: introduce kconfig files
>   build: switch to Kconfig
>   ide: express dependencies with Kconfig
>   build: convert pci.mak to Kconfig
>   build: convert sound.mak to Kconfig
>   build: convert usb.mak to Kconfig
>   scsi: express dependencies with Kconfig
>   bluetooth: express dependencies with Kconfig
>   isa: express dependencies with kconfig
>   i386: express dependencies with Kconfig
>   i2c: express dependencies with Kconfig
>   ptimer: express dependencies with Kconfig
>   minikconf: implement allyesconfig, allnoconfig, randconfig, defconfig
>=20
> Yang Zhong (17):
>   hw/arm/Makefile.objs: CONFIG_VIRT created for virt board
>   hw/nios2/Makefile.objs: Conditionally build nios2
>   hw/riscv/Makefile.objs: Create CONFIG_* for riscv boards
>   hw/sparc64/Makefile.objs: Create CONFIG_* for sparc64
>   hw/alpha/Makefile.objs: Create CONFIG_* for alpha
>   hw/cris/Makefile.objs: Create CONFIG_* for cris
>   hw/hppa/Makefile.objs: Create CONFIG_* for hppa
>   hw/moxie/Makefile.objs: Conditionally build moxie
>   hw/openrisc/Makefile.objs: Create CONFIG_* for openrisc
>   hw/tricore/Makefile.objs: Create CONFIG_* for tricore
>   hw/display: make edid configurable
>   hw/pci/Makefile.objs: make pcie configurable
>   edid: express dependencies with kconfig
>   hyperv: express dependencies with kconfig
>   virtio: make virtio dependencies with Kconfig
>   i386-softmmu.mak: remove all CONFIG_* except boards definitions
>   Makefile: only support defconfig
>=20
> =C1kos Kov=E1cs (8):
>   hw/m68k/Makefile.objs: Conditionally build boards
>   hw/microblaze/Makefile.objs: Create configs for petalogix and xilinx
>     boards
>   hw/mips/Makefile.objs: Create CONFIG_* for r4k, malta,mipssim boards
>   hw/ppc/Makefile.objs: Build all boards conditinally with CONFIG_*
>   hw/sh4/Makefile.objs: New CONFIG_* varibales created for sh4 boards
>     and device
>   hw/sparc/Makefile.objs: CONFIG_* for sun4m and leon3 created
>   hw/lm32/Makefile.objs: Conditionally build lm32 and milkmyst
>   hw/xtensa/Makefile.objs: Build xtensa_sim and xtensa_fpga
>     conditionally
>=20
>  Kconfig.host                            |  24 +
>  Makefile                                |  19 +-
>  Makefile.target                         |   7 +-
>  default-configs/alpha-softmmu.mak       |   7 +-
>  default-configs/arm-softmmu.mak         |   5 +-
>  default-configs/cris-softmmu.mak        |   1 +
>  default-configs/hppa-softmmu.mak        |   5 +-
>  default-configs/hyperv.mak              |   2 -
>  default-configs/i386-softmmu.mak        |  72 +--
>  default-configs/m68k-softmmu.mak        |   2 +
>  default-configs/microblaze-softmmu.mak  |   3 +
>  default-configs/mips-softmmu-common.mak |   8 +-
>  default-configs/moxie-softmmu.mak       |   1 +
>  default-configs/nios2-softmmu.mak       |   1 +
>  default-configs/or1k-softmmu.mak        |   1 +
>  default-configs/pci.mak                 |  49 --
>  default-configs/ppc-softmmu.mak         |  12 +-
>  default-configs/riscv32-softmmu.mak     |  11 +-
>  default-configs/riscv64-softmmu.mak     |  11 +-
>  default-configs/s390x-softmmu.mak       |   1 -
>  default-configs/sh4-softmmu.mak         |   5 +-
>  default-configs/sh4eb-softmmu.mak       |   5 +-
>  default-configs/sound.mak               |   4 -
>  default-configs/sparc-softmmu.mak       |   2 +
>  default-configs/sparc64-softmmu.mak     |   5 +-
>  default-configs/tricore-softmmu.mak     |   1 +
>  default-configs/usb.mak                 |  11 -
>  default-configs/virtio.mak              |  14 -
>  default-configs/xtensa-softmmu.mak      |   3 +
>  default-configs/xtensaeb-softmmu.mak    |   3 +
>  hw/9pfs/Kconfig                         |   4 +
>  hw/Kconfig                              |  69 +++
>  hw/Makefile.objs                        |   4 +-
>  hw/acpi/Kconfig                         |  30 ++
>  hw/adc/Kconfig                          |   2 +
>  hw/alpha/Kconfig                        |   5 +
>  hw/alpha/Makefile.objs                  |   4 +-
>  hw/arm/Kconfig                          | 113 ++++
>  hw/arm/Makefile.objs                    |   3 +-
>  hw/audio/Kconfig                        |  52 ++
>  hw/block/Kconfig                        |  37 ++
>  hw/bt/Kconfig                           |   2 +
>  hw/char/Kconfig                         |  42 ++
>  hw/core/Kconfig                         |  11 +
>  hw/cpu/Kconfig                          |   8 +
>  hw/cris/Kconfig                         |   2 +
>  hw/cris/Makefile.objs                   |   2 +-
>  hw/display/Kconfig                      | 106 ++++
>  hw/display/Makefile.objs                |   4 +-
>  hw/dma/Kconfig                          |  20 +
>  hw/gpio/Kconfig                         |   9 +
>  hw/hppa/Kconfig                         |   5 +
>  hw/hppa/Makefile.objs                   |   4 +-
>  hw/hyperv/Kconfig                       |   9 +
>  hw/i2c/Kconfig                          |  27 +
>  hw/i2c/Makefile.objs                    |   7 +-
>  hw/i386/Kconfig                         |  87 +++
>  hw/i386/Makefile.objs                   |   4 +-
>  hw/ide/Kconfig                          |  54 ++
>  hw/input/Kconfig                        |  28 +
>  hw/intc/Kconfig                         |  55 ++
>  hw/ipack/Kconfig                        |   4 +
>  hw/ipmi/Kconfig                         |  22 +
>  hw/isa/Kconfig                          |  30 ++
>  hw/lm32/Kconfig                         |   5 +
>  hw/lm32/Makefile.objs                   |   4 +-
>  hw/m68k/Kconfig                         |   8 +
>  hw/m68k/Makefile.objs                   |   4 +-
>  hw/mem/Kconfig                          |  10 +
>  hw/microblaze/Kconfig                   |   8 +
>  hw/microblaze/Makefile.objs             |   6 +-
>  hw/mips/Kconfig                         |  20 +
>  hw/mips/Makefile.objs                   |   6 +-
>  hw/misc/Kconfig                         | 110 ++++
>  hw/misc/macio/Kconfig                   |  11 +
>  hw/moxie/Kconfig                        |   2 +
>  hw/moxie/Makefile.objs                  |   2 +-
>  hw/net/Kconfig                          | 122 +++++
>  hw/nios2/Kconfig                        |   5 +
>  hw/nios2/Makefile.objs                  |   3 +-
>  hw/nvram/Kconfig                        |   8 +
>  hw/openrisc/Kconfig                     |   2 +
>  hw/openrisc/Makefile.objs               |   2 +-
>  hw/pci-bridge/Kconfig                   |  25 +
>  hw/pci-host/Kconfig                     |  46 ++
>  hw/pci-host/Makefile.objs               |   2 +-
>  hw/pci/Kconfig                          |   5 +
>  hw/pci/Makefile.objs                    |   5 +-
>  hw/pcmcia/Kconfig                       |   2 +
>  hw/ppc/Kconfig                          |  56 ++
>  hw/ppc/Makefile.objs                    |  12 +-
>  hw/riscv/Kconfig                        |  14 +
>  hw/riscv/Makefile.objs                  |  22 +-
>  hw/scsi/Kconfig                         |  52 ++
>  hw/scsi/Makefile.objs                   |   2 +-
>  hw/sd/Kconfig                           |  14 +
>  hw/sh4/Kconfig                          |  11 +
>  hw/sh4/Makefile.objs                    |   4 +-
>  hw/smbios/Kconfig                       |   2 +
>  hw/sparc/Kconfig                        |  11 +
>  hw/sparc/Makefile.objs                  |   4 +-
>  hw/sparc64/Kconfig                      |   5 +
>  hw/sparc64/Makefile.objs                |   6 +-
>  hw/ssi/Kconfig                          |  14 +
>  hw/timer/Kconfig                        |  63 +++
>  hw/tpm/Kconfig                          |  20 +
>  hw/tricore/Kconfig                      |   2 +
>  hw/tricore/Makefile.objs                |   2 +-
>  hw/unicore32/Kconfig                    |   2 +
>  hw/usb/Kconfig                          |  92 ++++
>  hw/vfio/Kconfig                         |  11 +
>  hw/virtio/Kconfig                       |  27 +
>  hw/watchdog/Kconfig                     |  15 +
>  hw/xtensa/Kconfig                       |   5 +
>  hw/xtensa/Makefile.objs                 |   4 +-
>  rules.mak                               |   2 +-
>  scripts/make_device_config.sh           |  30 --
>  scripts/minikconf.py                    | 680 ++++++++++++++++++++++++
>  118 files changed, 2502 insertions(+), 265 deletions(-)
>  create mode 100644 Kconfig.host
>  delete mode 100644 default-configs/hyperv.mak
>  delete mode 100644 default-configs/pci.mak
>  delete mode 100644 default-configs/sound.mak
>  delete mode 100644 default-configs/usb.mak
>  delete mode 100644 default-configs/virtio.mak
>  create mode 100644 hw/9pfs/Kconfig
>  create mode 100644 hw/Kconfig
>  create mode 100644 hw/acpi/Kconfig
>  create mode 100644 hw/adc/Kconfig
>  create mode 100644 hw/alpha/Kconfig
>  create mode 100644 hw/arm/Kconfig
>  create mode 100644 hw/audio/Kconfig
>  create mode 100644 hw/block/Kconfig
>  create mode 100644 hw/bt/Kconfig
>  create mode 100644 hw/char/Kconfig
>  create mode 100644 hw/core/Kconfig
>  create mode 100644 hw/cpu/Kconfig
>  create mode 100644 hw/cris/Kconfig
>  create mode 100644 hw/display/Kconfig
>  create mode 100644 hw/dma/Kconfig
>  create mode 100644 hw/gpio/Kconfig
>  create mode 100644 hw/hppa/Kconfig
>  create mode 100644 hw/hyperv/Kconfig
>  create mode 100644 hw/i2c/Kconfig
>  create mode 100644 hw/i386/Kconfig
>  create mode 100644 hw/ide/Kconfig
>  create mode 100644 hw/input/Kconfig
>  create mode 100644 hw/intc/Kconfig
>  create mode 100644 hw/ipack/Kconfig
>  create mode 100644 hw/ipmi/Kconfig
>  create mode 100644 hw/isa/Kconfig
>  create mode 100644 hw/lm32/Kconfig
>  create mode 100644 hw/m68k/Kconfig
>  create mode 100644 hw/mem/Kconfig
>  create mode 100644 hw/microblaze/Kconfig
>  create mode 100644 hw/mips/Kconfig
>  create mode 100644 hw/misc/Kconfig
>  create mode 100644 hw/misc/macio/Kconfig
>  create mode 100644 hw/moxie/Kconfig
>  create mode 100644 hw/net/Kconfig
>  create mode 100644 hw/nios2/Kconfig
>  create mode 100644 hw/nvram/Kconfig
>  create mode 100644 hw/openrisc/Kconfig
>  create mode 100644 hw/pci-bridge/Kconfig
>  create mode 100644 hw/pci-host/Kconfig
>  create mode 100644 hw/pci/Kconfig
>  create mode 100644 hw/pcmcia/Kconfig
>  create mode 100644 hw/ppc/Kconfig
>  create mode 100644 hw/riscv/Kconfig
>  create mode 100644 hw/scsi/Kconfig
>  create mode 100644 hw/sd/Kconfig
>  create mode 100644 hw/sh4/Kconfig
>  create mode 100644 hw/smbios/Kconfig
>  create mode 100644 hw/sparc/Kconfig
>  create mode 100644 hw/sparc64/Kconfig
>  create mode 100644 hw/ssi/Kconfig
>  create mode 100644 hw/timer/Kconfig
>  create mode 100644 hw/tpm/Kconfig
>  create mode 100644 hw/tricore/Kconfig
>  create mode 100644 hw/unicore32/Kconfig
>  create mode 100644 hw/usb/Kconfig
>  create mode 100644 hw/vfio/Kconfig
>  create mode 100644 hw/virtio/Kconfig
>  create mode 100644 hw/watchdog/Kconfig
>  create mode 100644 hw/xtensa/Kconfig
>  delete mode 100644 scripts/make_device_config.sh
>  create mode 100644 scripts/minikconf.py
>=20
> --=20
> 2.17.1
>=20
