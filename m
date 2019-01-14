Received: from eggs.gnu.org ([209.51.188.92]:58983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gjAov-00024R-ND
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gjAou-0006E0-Sl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:35:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gjAou-0006Dr-NO
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:35:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 02:27:48 +0400
Message-Id: <20190114222754.21701-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v17 0/6] Add support for TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, f4bug@amsat.org, Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi,

The following patches implement the TPM Physical Presence Interface
that allows a user to set a command via ACPI (sysfs entry in Linux)
that, upon the next reboot, the firmware looks for and acts upon by
sending sequences of commands to the TPM.

A dedicated memory region is added to the TPM CRB & TIS devices, at
address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
holds the location for that PPI region and some version details, to
allow for future flexibility.

With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" test
now runs successfully.

It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
Implement Physical Presence interface for TPM 1.2 and 2")

The edk2 support is merged upstream.

v17:
- rebased, minor conflicts
- modify commit message in "acpi: add ACPI memory clear interface" to
  add a link to the specification.
- add some r-b

v16:
- minor comments and stylistic changes
- add r-b & t-b tags

v15:
- fix crash on reset when PPI is disabled

v14:
- rebased, fixing conflicts after compat-props refactoring
- fix build regression from v13 with --disable-tpm

v13:
- removed needless error handling in tpm_ppi_init()
- splitted "add ACPI memory clear interface"
- moved acpi build function in dedicated hw/acpi/tpm.c
- added some function documentation in headers
- various code cleanups suggested by Philippe
- rebased

Marc-Andr=C3=A9 Lureau (3):
  tpm: add a "ppi" boolean property
  acpi: add ACPI memory clear interface
  tpm: clear RAM when "memory overwrite" requested

Stefan Berger (3):
  tpm: allocate/map buffer for TPM Physical Presence interface
  acpi: expose TPM/PPI configuration parameters to firmware via fw_cfg
  acpi: build TPM Physical Presence interface

 hw/tpm/tpm_ppi.h      |  46 +++++
 include/hw/acpi/tpm.h |  21 ++
 hw/acpi/tpm.c         | 459 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/machine.c     |   2 +
 hw/i386/acpi-build.c  |  29 ++-
 hw/tpm/tpm_crb.c      |  13 ++
 hw/tpm/tpm_ppi.c      |  53 +++++
 hw/tpm/tpm_tis.c      |  13 ++
 stubs/tpm.c           |   5 +
 docs/specs/tpm.txt    | 104 ++++++++++
 hw/acpi/Makefile.objs |   1 +
 hw/tpm/Makefile.objs  |   1 +
 hw/tpm/trace-events   |   3 +
 13 files changed, 748 insertions(+), 2 deletions(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/acpi/tpm.c
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.20.1.98.gecbdaf0899
