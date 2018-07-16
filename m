Received: from eggs.gnu.org ([2001:4830:134:3::10]:43428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ff36W-0001Cd-RB
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ff36U-00025W-EW
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ff36U-00025G-7H
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:50 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Jul 2018 14:59:43 +0200
Message-Id: <20180716125948.11666-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 0/5] Add support for TPM Physical Presence
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

v8: ACPI code improvements
- replace various aml_int() with variables
- make op/op_flags common variables
- replace the switch field indexing hack by a dynamic operation region

v7:
- relace RAM with RAM device ptr
- a few ACPI code & comments improvements
- add back proof-of-concept ACPI memory clear interface, handled in
  qemu (pass again WHLK TCG tests)

Marc-Andr=C3=A9 Lureau (2):
  tpm: add a "ppi" boolean property
  PoC: tpm: add ACPI memory clear interface

Stefan Berger (3):
  tpm: implement virtual memory device for TPM PPI
  acpi: add fw_cfg file for TPM and PPI virtual memory device
  acpi: build TPM Physical Presence interface

 hw/tpm/tpm_ppi.h      |  26 +++
 include/hw/acpi/tpm.h |  17 ++
 include/hw/compat.h   |  10 +
 hw/i386/acpi-build.c  | 456 +++++++++++++++++++++++++++++++++++++++++-
 hw/tpm/tpm_crb.c      |  11 +
 hw/tpm/tpm_ppi.c      |  56 ++++++
 hw/tpm/tpm_tis.c      |  11 +
 docs/specs/tpm.txt    | 101 ++++++++++
 hw/tpm/Makefile.objs  |   1 +
 hw/tpm/trace-events   |   3 +
 10 files changed, 690 insertions(+), 2 deletions(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

--=20
2.18.0.129.ge3331758f1
