Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQu-0001tO-GC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQp-0005ER-Gl
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIDQp-0005EG-AP
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:17:55 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 14:17:40 +0200
Message-Id: <20170606121747.25356-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] megasas: fix TOCTOU and segmentation fault
 bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zyy4013@stu.ouc.edu.cn, ppandit@redhat.com, hare@suse.de

The first patch add a simple no-op qtest.  Patches 2-6 change the
device to only read from cmd->frame once, thus avoiding TOC-TOU
bugs and possible vulnerabilities.

The last patch fixes a NULL pointer dereference reported by PJP.
It has a dependency on patch 4, because megasas_abort_command now
needs an extra cmd->dcmd_opcode != -1 check (and cmd->dcmd_opcode is
added in patch 4).

Paolo

Paolo Bonzini (7):
  megasas: add qtest
  megasas: do not read sense length more than once from frame
  megasas: do not read iovec count more than once from frame
  megasas: do not read DCMD opcode more than once from frame
  megasas: do not read command more than once from frame
  megasas: do not read SCSI req parameters more than once from frame
  megasas: always store SCSIRequest* into MegasasCmd

 hw/scsi/megasas.c      | 175 ++++++++++++++++++++++---------------------------
 tests/Makefile.include |   3 +
 tests/megasas-test.c   |  86 ++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 96 deletions(-)
 create mode 100644 tests/megasas-test.c

-- 
2.13.0
