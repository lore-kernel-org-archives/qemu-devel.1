Received: from eggs.gnu.org ([2001:4830:134:3::10]:59159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fo9P0-0008Be-TX
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fo9Ov-00076j-WB
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fo9Ov-000765-RS
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:32:29 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Aug 2018 17:32:17 +0200
Message-Id: <20180810153223.28409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 0/6] Add support for TPM Physical Presence
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

v9:
- add 3.1 pc machines patch
- call tpm_ppi_reset() from TIS/CRB device reset()
- mintor doc/commit improvements
- add acks/review-by

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
 include/hw/compat.h   |  14 +-
 include/hw/i386/pc.h  |   5 +-
 hw/i386/acpi-build.c  | 456 +++++++++++++++++++++++++++++++++++++++++-
 hw/i386/pc_piix.c     |  13 +-
 hw/i386/pc_q35.c      |  12 +-
 hw/tpm/tpm_crb.c      |  12 ++
 hw/tpm/tpm_ppi.c      |  54 +++++
 hw/tpm/tpm_tis.c      |  12 ++
 docs/specs/tpm.txt    | 101 ++++++++++
 hw/tpm/Makefile.objs  |   1 +
 hw/tpm/trace-events   |   3 +
 13 files changed, 722 insertions(+), 6 deletions(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.18.0.547.g1d89318c48
