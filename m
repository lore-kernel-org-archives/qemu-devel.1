Received: from eggs.gnu.org ([2001:4830:134:3::10]:40546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fIYqs-0007XY-19
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fIYqn-0000H3-Iq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:14:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fIYqn-0000GJ-CB
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:14:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 15 May 2018 14:14:29 +0200
Message-Id: <20180515121433.6112-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] Add support for TPM Physical Presence
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

Git branches:
https://github.com/elmarco/qemu tpm-ppi
https://github.com/elmarco/edk2 tpm-ppi

Marc-Andr=C3=A9 Lureau (1):
  tpm: add a fake ACPI memory clear interface

Stefan Berger (3):
  tpm: implement virtual memory device for TPM PPI
  acpi: add fw_cfg file for TPM and PPI virtual memory device
  acpi: build TPM Physical Presence interface

 hw/tpm/tpm_ppi.h      |  26 ++++
 include/hw/acpi/tpm.h |  30 ++++
 hw/i386/acpi-build.c  | 318 ++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_crb.c      |   5 +
 hw/tpm/tpm_ppi.c      |  56 ++++++++
 hw/tpm/tpm_tis.c      |   5 +
 docs/specs/tpm.txt    |  20 +++
 hw/tpm/Makefile.objs  |   2 +-
 hw/tpm/trace-events   |   4 +
 9 files changed, 465 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.17.0.253.g3dd125b46d
