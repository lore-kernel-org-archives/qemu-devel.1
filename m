Received: from eggs.gnu.org ([2001:4830:134:3::10]:47788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCyJ-0004II-4p
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCyD-0003jG-H1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCyC-0003Z9-Gj
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:27:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 02:26:42 +0400
Message-Id: <20181212222648.595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 0/6] Add support for TPM Physical Presence
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, f4bug@amsat.org, Stefan Berger <stefanb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

 hw/tpm/tpm_ppi.h      |  47 +++++
 include/hw/acpi/tpm.h |  23 +++
 include/hw/compat.h   |  11 +-
 hw/acpi/tpm.c         | 447 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |  29 ++-
 hw/tpm/tpm_crb.c      |  11 ++
 hw/tpm/tpm_ppi.c      |  53 +++++
 hw/tpm/tpm_tis.c      |  11 ++
 docs/specs/tpm.txt    | 104 ++++++++++
 hw/acpi/Makefile.objs |   1 +
 hw/tpm/Makefile.objs  |   1 +
 hw/tpm/trace-events   |   3 +
 12 files changed, 738 insertions(+), 3 deletions(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/acpi/tpm.c
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.20.0
