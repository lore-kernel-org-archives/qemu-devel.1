Received: from eggs.gnu.org ([2001:4830:134:3::10]:48092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZObr-0001Km-5m
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZObm-0005ZV-TB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:17:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZObm-0005Ym-Hs
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:17:02 -0500
Date: Tue, 18 Dec 2018 18:17:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218181640-mutt-send-email-mst@kernel.org>
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
	<20181217203706-mutt-send-email-mst@kernel.org>
	<CAJ+F1CK-Ko1H+VCAs_Epf+0vy2r=J7FjpHBXA7e=Ycrwm6xFJQ@mail.gmail.com>
	<20181218091942-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKmgJnoubPuQvL9v5CgUzMyvhpoL1x9f6ck8_G4E=C==w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKmgJnoubPuQvL9v5CgUzMyvhpoL1x9f6ck8_G4E=C==w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 0/6] Add support for TPM Physical
 Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

On Tue, Dec 18, 2018 at 09:56:35PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Dec 18, 2018 at 6:20 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >
> > On Tue, Dec 18, 2018 at 01:28:53PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Hi Michael,
> > >
> > > On Tue, Dec 18, 2018 at 5:42 AM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > >
> > > > On Thu, Dec 13, 2018 at 02:26:42AM +0400, Marc-Andr=E9 Lureau wro=
te:
> > > > > Hi,
> > > > >
> > > > > The following patches implement the TPM Physical Presence Inter=
face
> > > > > that allows a user to set a command via ACPI (sysfs entry in Li=
nux)
> > > > > that, upon the next reboot, the firmware looks for and acts upo=
n by
> > > > > sending sequences of commands to the TPM.
> > > > >
> > > > > A dedicated memory region is added to the TPM CRB & TIS devices=
, at
> > > > > address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg en=
try
> > > > > holds the location for that PPI region and some version details=
, to
> > > > > allow for future flexibility.
> > > > >
> > > > > With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.=
3" test
> > > > > now runs successfully.
> > > > >
> > > > > It is based on previous work from Stefan Berger ("[PATCH v2 0/4=
]
> > > > > Implement Physical Presence interface for TPM 1.2 and 2")
> > > > >
> > > > > The edk2 support is merged upstream.
> > > >
> > > >
> > > > Breaks build with tpm disabled:
> > > >
> > > > /usr/bin/ld: hw/i386/acpi-build.o: in function `build_dsdt':
> > > > /scm/qemu/hw/i386/acpi-build.c:2158: undefined reference to `tpm_=
build_ppi_acpi'
> > > > /usr/bin/ld: /scm/qemu/hw/i386/acpi-build.c:2179: undefined refer=
ence to `tpm_build_ppi_acpi'
> > > > collect2: error: ld returned 1 exit status
> > >
> > > Thanks for noticing, this is probably a regression from v13, since =
the
> > > tpm_build_ppi_acpi was moved to a separate unit that is not always
> > > built.
> > >
> > > There is a lot of TPM code that we always build in acpi-build. Eith=
er
> > > the code should have #ifdef TPM, or we use stubs.
> > >
> > > Fwiw, the preliminary #ifdef patch would look like that, is that
> > > desirable, or should we just add some stub:
> >
> > Seems way too messy. I'd prefer stubs.
>=20
> Beside the missing stub, and an indentation fix, could someone review
> the last 2 patches?

I think they are fine was going to merge.

> >
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 236a20eaa8..e6ca350067 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -41,14 +41,16 @@
> > >  #include "hw/isa/isa.h"
> > >  #include "hw/block/fdc.h"
> > >  #include "hw/acpi/memory_hotplug.h"
> > > +#ifdef CONFIG_TPM
> > >  #include "sysemu/tpm.h"
> > >  #include "hw/acpi/tpm.h"
> > > -#include "hw/acpi/vmgenid.h"
> > >  #include "sysemu/tpm_backend.h"
> > > +#endif
> > > +#include "hw/acpi/vmgenid.h"
> > >  #include "hw/timer/mc146818rtc_regs.h"
> > >  #include "hw/mem/memory-device.h"
> > >  #include "sysemu/numa.h"
> > > -
> > > +#include "qemu/units.h"
> > >  /* Supported chipsets: */
> > >  #include "hw/acpi/piix4.h"
> > >  #include "hw/acpi/pcihp.h"
> > > @@ -105,7 +107,9 @@ typedef struct AcpiPmInfo {
> > >  typedef struct AcpiMiscInfo {
> > >      bool is_piix4;
> > >      bool has_hpet;
> > > +#ifdef CONFIG_TPM
> > >      TPMVersion tpm_version;
> > > +#endif
> > >      const unsigned char *dsdt_code;
> > >      unsigned dsdt_size;
> > >      uint16_t pvpanic_port;
> > > @@ -234,7 +238,9 @@ static void acpi_get_misc_info(AcpiMiscInfo *in=
fo)
> > >      }
> > >
> > >      info->has_hpet =3D hpet_find();
> > > +#ifdef CONFIG_TPM
> > >      info->tpm_version =3D tpm_get_version(tpm_find());
> > > +#endif
> > >      info->pvpanic_port =3D pvpanic_port();
> > >      info->applesmc_io_base =3D applesmc_port();
> > >  }
> > > @@ -1962,10 +1968,12 @@ build_dsdt(GArray *table_data, BIOSLinker *=
linker,
> > >          }
> > >      }
> > >
> > > +#ifdef CONFIG_TPM
> > >      if (TPM_IS_TIS(tpm_find())) {
> > >          aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> > >                     TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> > >      }
> > > +#endif
> > >      aml_append(scope, aml_name_decl("_CRS", crs));
> > >
> > >      /* reserve GPE0 block resources */
> > > @@ -2133,6 +2141,7 @@ build_dsdt(GArray *table_data, BIOSLinker *li=
nker,
> > >              /* Scan all PCI buses. Generate tables to support hotp=
lug. */
> > >              build_append_pci_bus_devices(scope, bus, pm->pcihp_bri=
dge_en);
> > >
> > > +#ifdef CONFIG_TPM
> > >              if (TPM_IS_TIS(tpm_find())) {
> > >                  dev =3D aml_device("ISA.TPM");
> > >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("=
PNP0C31")));
> > > @@ -2149,11 +2158,12 @@ build_dsdt(GArray *table_data, BIOSLinker *=
linker,
> > >                  aml_append(dev, aml_name_decl("_CRS", crs));
> > >                  aml_append(scope, dev);
> > >              }
> > > -
> > > +#endif
> > >              aml_append(sb_scope, scope);
> > >          }
> > >      }
> > >
> > > +#ifdef CONFIG_TPM
> > >      if (TPM_IS_CRB(tpm_find())) {
> > >          dev =3D aml_device("TPM");
> > >          aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101=
")));
> > > @@ -2168,7 +2178,7 @@ build_dsdt(GArray *table_data, BIOSLinker *li=
nker,
> > >
> > >          aml_append(sb_scope, dev);
> > >      }
> > > -
> > > +#endif
> > >      aml_append(dsdt, sb_scope);
> > >
> > >      /* copy AML table into ACPI tables blob and patch header there=
 */
> > > @@ -2194,6 +2204,7 @@ build_hpet(GArray *table_data, BIOSLinker *li=
nker)
> > >                   (void *)hpet, "HPET", sizeof(*hpet), 1, NULL, NUL=
L);
> > >  }
> > >
> > > +#ifdef CONFIG_TPM
> > >  static void
> > >  build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcp=
alog)
> > >  {
> > > @@ -2247,6 +2258,7 @@ build_tpm2(GArray *table_data, BIOSLinker
> > > *linker, GArray *tcpalog)
> > >      build_header(linker, table_data,
> > >                   (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, N=
ULL, NULL);
> > >  }
> > > +#endif
> > >
> > >  #define HOLE_640K_START  (640 * KiB)
> > >  #define HOLE_640K_END   (1 * MiB)
> > > @@ -2679,6 +2691,7 @@ void acpi_build(AcpiBuildTables *tables,
> > > MachineState *machine)
> > >          acpi_add_table(table_offsets, tables_blob);
> > >          build_hpet(tables_blob, tables->linker);
> > >      }
> > > +#ifdef CONFIG_TPM
> > >      if (misc.tpm_version !=3D TPM_VERSION_UNSPEC) {
> > >          acpi_add_table(table_offsets, tables_blob);
> > >          build_tpm_tcpa(tables_blob, tables->linker, tables->tcpalo=
g);
> > > @@ -2688,6 +2701,7 @@ void acpi_build(AcpiBuildTables *tables,
> > > MachineState *machine)
> > >              build_tpm2(tables_blob, tables->linker, tables->tcpalo=
g);
> > >          }
> > >      }
> > > +#endif
> > >      if (pcms->numa_nodes) {
> > >          acpi_add_table(table_offsets, tables_blob);
> > >          build_srat(tables_blob, tables->linker, machine);
> > > @@ -2886,9 +2900,10 @@ void acpi_setup(void)
> > >          acpi_add_rom_blob(build_state, tables.linker->cmd_blob,
> > >                            "etc/table-loader", 0);
> > >
> > > +#ifdef CONFIG_TPM
> > >      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
> > >                      tables.tcpalog->data, acpi_data_len(tables.tcp=
alog));
> > > -
> > > +#endif
> > >      vmgenid_dev =3D find_vmgenid_dev();
> > >      if (vmgenid_dev) {
> > >          vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
> > >
> > >
> > > >
> > > > > v13:
> > > > > - removed needless error handling in tpm_ppi_init()
> > > > > - splitted "add ACPI memory clear interface"
> > > > > - moved acpi build function in dedicated hw/acpi/tpm.c
> > > > > - added some function documentation in headers
> > > > > - various code cleanups suggested by Philippe
> > > > > - rebased
> > > > >
> > > > > Marc-Andr=E9 Lureau (3):
> > > > >   tpm: add a "ppi" boolean property
> > > > >   acpi: add ACPI memory clear interface
> > > > >   tpm: clear RAM when "memory overwrite" requested
> > > > >
> > > > > Stefan Berger (3):
> > > > >   tpm: allocate/map buffer for TPM Physical Presence interface
> > > > >   acpi: expose TPM/PPI configuration parameters to firmware via=
 fw_cfg
> > > > >   acpi: build TPM Physical Presence interface
> > > > >
> > > > >  hw/tpm/tpm_ppi.h      |  47 +++++
> > > > >  include/hw/acpi/tpm.h |  23 +++
> > > > >  include/hw/compat.h   |  11 +-
> > > > >  hw/acpi/tpm.c         | 447 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > >  hw/i386/acpi-build.c  |  29 ++-
> > > > >  hw/tpm/tpm_crb.c      |  11 ++
> > > > >  hw/tpm/tpm_ppi.c      |  53 +++++
> > > > >  hw/tpm/tpm_tis.c      |  11 ++
> > > > >  docs/specs/tpm.txt    | 104 ++++++++++
> > > > >  hw/acpi/Makefile.objs |   1 +
> > > > >  hw/tpm/Makefile.objs  |   1 +
> > > > >  hw/tpm/trace-events   |   3 +
> > > > >  12 files changed, 738 insertions(+), 3 deletions(-)
> > > > >  create mode 100644 hw/tpm/tpm_ppi.h
> > > > >  create mode 100644 hw/acpi/tpm.c
> > > > >  create mode 100644 hw/tpm/tpm_ppi.c
> > > > >
> > > > > --
> > > > > 2.20.0
> > > >
> > >
> > >
> > > --
> > > Marc-Andr=E9 Lureau
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
