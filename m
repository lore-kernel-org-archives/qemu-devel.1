Received: from eggs.gnu.org ([2001:4830:134:3::10]:53888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu01-0004X0-VB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUtzy-0005vY-Mu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:41 -0400
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com
	([104.47.32.47]:14122
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dUtzy-0005sN-Az
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:38 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Jul 2017 05:07:12 -0700
Message-ID: <cover.1499774331.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8]  Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

QEMU currently has a standard method to report errors with
error_repot(). This ensure a sane and standard format when printing
errors. This series is attempting to extend this functionality for
warnings and information as well.

This patch renames error_print_loc() function to be more clear, but I
didn't bother renaming the others. It seems silly to change
error_printf() to error_warning_printf() and printf is already taken so
I just left it as is.
v3:
 - Regenerate the replacement patch
v1:
 - Convert all of the existing warning messages in QEMU
 - Add a error_report*_err() functions as well
RFCv3:
 - Use more detailed enum and function names
 - Add wrapper functions for the info and warning reporting
RFCv2:
 - Use enums for ERROR, WARN and INFO with a generic report() function
   instead of adding new functions



Alistair Francis (8):
  util/qemu-error: Rename error_print_loc() to be more generic
  error: Functions to report warnings and informational messages
  Convert error_report() to warn_report()
  hw/i386: Improve some of the warning messages
  char-socket: Report TCP socket waiting as information
  error: Implement the warn and free Error functions
  Convert error_report*_err() to warn_report*_err()
  error: Add a 'error: ' prefix to error_report()

 block/backup.c                 |  10 ++--
 block/gluster.c                |   4 +-
 block/iscsi.c                  |   6 +--
 block/nfs.c                    |  12 ++---
 block/rbd.c                    |   6 +--
 block/ssh.c                    |   4 +-
 blockdev.c                     |   2 +-
 chardev/char-socket.c          |   4 +-
 cpus.c                         |   2 +-
 hw/9pfs/9p.c                   |   2 +-
 hw/arm/highbank.c              |   6 +--
 hw/arm/imx25_pdk.c             |   6 +--
 hw/arm/kzm.c                   |   6 +--
 hw/core/machine.c              |  10 ++--
 hw/core/qdev-properties.c      |  10 ++--
 hw/i386/acpi-build.c           |  11 +++--
 hw/i386/kvm/pci-assign.c       |   6 +--
 hw/i386/pc.c                   |  16 +++---
 hw/i386/pc_piix.c              |   8 +--
 hw/i386/pc_q35.c               |   6 +--
 hw/misc/aspeed_sdmc.c          |   8 +--
 hw/nvram/fw_cfg.c              |   2 +-
 hw/pci-host/piix.c             |   2 +-
 hw/ppc/pnv.c                   |   6 +--
 hw/ppc/spapr.c                 |   4 +-
 hw/ppc/spapr_iommu.c           |   2 +-
 hw/scsi/scsi-bus.c             |   6 +--
 hw/usb/dev-smartcard-reader.c  |   4 +-
 hw/usb/redirect.c              |   2 +-
 include/qapi/error.h           |  11 +++++
 include/qemu/error-report.h    |   7 +++
 net/tap-linux.c                |   2 +-
 scripts/checkpatch.pl          |   7 ++-
 target/i386/cpu.c              |   8 +--
 target/i386/kvm.c              |   4 +-
 target/s390x/cpu_models.c      |   2 +-
 target/s390x/kvm.c             |   2 +-
 tests/test-qdev-global-props.c |   6 +--
 trace/control.c                |   4 +-
 util/error.c                   |  20 ++++++++
 util/qemu-error.c              | 107 +++++++++++++++++++++++++++++++++++++=
+---
 vl.c                           |  20 ++++----
 42 files changed, 254 insertions(+), 119 deletions(-)

--=20
2.11.0
