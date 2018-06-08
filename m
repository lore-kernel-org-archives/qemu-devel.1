Received: from eggs.gnu.org ([2001:4830:134:3::10]:48217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fRNfu-0008Tv-SZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fRNft-0007Ku-U5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:54 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:44872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fRNft-0007KZ-Pl
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:53 -0400
Received: by mail-qk0-x22c.google.com with SMTP id 185-v6so9507924qkk.11
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 13:07:53 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Fri,  8 Jun 2018 17:07:37 -0300
Message-Id: <20180608200740.24915-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/3] scsi-block: VPD Block Limits emulation
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
Cc: pbonzini@redhat.com, famz@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

When using SCSI passthrough and running in Linux, QEMU edits the
reply of the SCSI Inquiry VPD Block Limits message with the value
of the /sys/bus/<dev>/queue/max_sectors_kb parameter the device
has in the host. Doing so allows the Linux guest to proper setup
the device.

But the Block Limits message is optional, and its absence can cause
the device to be unusable by the guest. An example can be seen
at https://bugzilla.redhat.com/show_bug.cgi?id=1566195.

This series implements an approach to solve it. First patch has more
details on the problem and why the existing workarounds are not enough,
including the first step towards the solution. Patch 2 wraps it up
and solves it. Patch 3 is a sort of 'cleanup' patch to isolate the
logic, avoiding tampering with the communication of SCSI hardware
that does implement the Block Limits message.


Daniel Henrique Barboza (3):
  scsi-block: emulate missing Block Limits response
  scsi-block: add VPD Block Limits in INQUIRY Supported Pages reply
  scsi-block: adding flag at realize to enable Block Limits emulation

 hw/scsi/scsi-disk.c    |  51 +++++++++++++++-
 hw/scsi/scsi-generic.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++---
 include/hw/scsi/scsi.h |   4 ++
 3 files changed, 201 insertions(+), 11 deletions(-)

-- 
2.14.3
