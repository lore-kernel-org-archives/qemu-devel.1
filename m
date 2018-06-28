Received: from eggs.gnu.org ([2001:4830:134:3::10]:33107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYahE-0007Ne-Cf
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYahA-0003j3-Dm
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:27:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYahA-0003h7-8t
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:27:00 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 28 Jun 2018 19:26:53 +0200
Message-Id: <20180628172657.11646-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/4] Add support for TPM Physical Presence
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

v6: (see changeset in patches)
 - replace mmio region with ram
 - ASL code improvements
 - endianess fix on 8bit fw-cfg fields

v5:
 - more code documentation (Marc-Andr=C3=A9)
 - use some explicit named variables to ease reading (Marc-Andr=C3=A9)
 - use fixed size fields/memory regions, remove PPI struct (Marc-Andr=C3=A9=
)
 - only add PPI ACPI methods if PPI is enabled (Marc-Andr=C3=A9)
 - document the qemu/firmware ACPI memory region (Stefan)
 - remove the dummy ACPI memory clear interface patch

v4:
 - add a "ppi" property, default to true, unless machine <=3D 2.12
 - pass PPI address to tpm_ppi_init_io()
 - renamed tpm_ppi struct name

Marc-Andr=C3=A9 Lureau (1):
  tpm: add a "ppi" boolean property

Stefan Berger (3):
  tpm: implement virtual memory device for TPM PPI
  acpi: add fw_cfg file for TPM and PPI virtual memory device
  acpi: build TPM Physical Presence interface

 hw/tpm/tpm_ppi.h      |  25 +++
 include/hw/acpi/tpm.h |  17 ++
 include/hw/compat.h   |  10 +
 hw/i386/acpi-build.c  | 420 +++++++++++++++++++++++++++++++++++++++++-
 hw/tpm/tpm_crb.c      |  11 ++
 hw/tpm/tpm_ppi.c      |  33 ++++
 hw/tpm/tpm_tis.c      |  11 ++
 docs/specs/tpm.txt    |  99 ++++++++++
 hw/tpm/Makefile.objs  |   2 +-
 hw/tpm/trace-events   |   4 +
 10 files changed, 629 insertions(+), 3 deletions(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.18.0.rc1
