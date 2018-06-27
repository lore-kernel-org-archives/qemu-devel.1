Received: from eggs.gnu.org ([2001:4830:134:3::10]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fYEBT-0007pG-Cx
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fYEBS-0005zV-Ds
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:24:47 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fYEBS-0005yJ-94
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 13:24:46 -0400
Received: by mail-qt0-x242.google.com with SMTP id a18-v6so2344964qtj.4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:24:45 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 27 Jun 2018 14:24:29 -0300
Message-Id: <20180627172432.11120-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/3] VPD Block Limits emulation
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

v2:
- series overhauled - first 2 patches are cleanups (split in 2
for easier review), patch 3 contains the whole logic
- previous version link:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02289.html


When using SCSI passthrough and running in Linux, QEMU edits the
reply of the SCSI Inquiry VPD Block Limits message with the value
of the /sys/bus/<dev>/queue/max_sectors_kb parameter the device
has in the host. Doing so allows the Linux guest to proper setup
the device.

But the Block Limits message is optional, and its absence can cause
the device to be unusable by the guest. An example can be seen
at https://bugzilla.redhat.com/show_bug.cgi?id=1566195.

This series implements an approach to solve it. 


Daniel Henrique Barboza (3):
  hw/scsi: cleanups before VPD BL emulation
  hw/scsi: centralize SG_IO calls into single function
  hw/scsi: add VPD Block Limits emulation

 hw/scsi/scsi-disk.c    | 427 +++++++++++++++++++++--------------------
 hw/scsi/scsi-generic.c | 246 ++++++++++++++++++------
 include/hw/scsi/scsi.h |   6 +-
 3 files changed, 401 insertions(+), 278 deletions(-)

-- 
2.17.1
