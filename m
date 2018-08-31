Received: from eggs.gnu.org ([2001:4830:134:3::10]:56218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvn9w-000703-1N
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvn9q-0002w6-TZ
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:24:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvn9q-0002vq-Mv
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:24:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Aug 2018 19:24:18 +0200
Message-Id: <20180831172424.12029-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 0/6] Add support for TPM Physical Presence
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

v10:
- fix 3.1 pc machines patch
- describe PPI memory size in doc
- change "Memory overwrite variable" location to offset 0x15a

Marc-Andr=C3=A9 Lureau (3):
  hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
  tpm: add a "ppi" boolean property
  tpm: add ACPI memory clear interface

Stefan Berger (3):
  tpm: allocate/map buffer for TPM Physical Presence interface
  acpi: expose TPM/PPI configuration parameters to firmware via fw_cfg
  acpi: build TPM Physical Presence interface

 hw/tpm/tpm_ppi.h      |  28 +++
 include/hw/acpi/tpm.h |  17 ++
 include/hw/compat.h   |  11 +-
 include/hw/i386/pc.h  |   5 +-
 hw/i386/acpi-build.c  | 456 +++++++++++++++++++++++++++++++++++++++++-
 hw/i386/pc_piix.c     |  15 +-
 hw/i386/pc_q35.c      |  13 +-
 hw/tpm/tpm_crb.c      |  12 ++
 hw/tpm/tpm_ppi.c      |  54 +++++
 hw/tpm/tpm_tis.c      |  12 ++
 docs/specs/tpm.txt    | 105 ++++++++++
 hw/tpm/Makefile.objs  |   1 +
 hw/tpm/trace-events   |   3 +
 13 files changed, 723 insertions(+), 9 deletions(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.19.0.rc1
