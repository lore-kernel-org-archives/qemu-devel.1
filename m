Received: from eggs.gnu.org ([2001:4830:134:3::10]:44252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fXn0f-00034h-K9
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fXn0c-0008HA-Gh
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:23:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fXn0c-0008Gh-BV
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:23:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 26 Jun 2018 14:23:39 +0200
Message-Id: <20180626122343.13473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/4] Add support for TPM Physical Presence
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

 hw/tpm/tpm_ppi.h      |  27 +++
 include/hw/acpi/tpm.h |  17 ++
 include/hw/compat.h   |  10 +
 hw/i386/acpi-build.c  | 440 ++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_crb.c      |  10 +
 hw/tpm/tpm_ppi.c      |  57 ++++++
 hw/tpm/tpm_tis.c      |  10 +
 docs/specs/tpm.txt    |  99 ++++++++++
 hw/tpm/Makefile.objs  |   2 +-
 hw/tpm/trace-events   |   4 +
 10 files changed, 675 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.18.0.rc1
