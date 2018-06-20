Received: from eggs.gnu.org ([2001:4830:134:3::10]:41677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fVR2y-0004f7-9Z
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fVR2v-0008Km-7i
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:32:28 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1fVR2v-0008Jf-0x
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:32:25 -0400
Received: by mail-pl0-x242.google.com with SMTP id 31-v6so738740plc.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 17:32:24 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 20 Jun 2018 10:32:02 +1000
Message-Id: <20180620003202.10546-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH] [RESEND] hmp-commands: use long for begin and
 length in dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The dump-guest-memory command is used to dump an area of guest memory
to a file, the piece of memory is specified by a begin address and
a length. These parameters are specified as ints and thus have a maximum
value of 4GB. This means you can't dump the guest memory past the first
4GB and instead get:
(qemu) dump-guest-memory tmp 0x100000000 0x100000000
'dump-guest-memory' has failed: integer is for 32-bit values
Try "help dump-guest-memory" for more information

This limitation is imposed in monitor_parse_arguments() since they are
both ints. hmp_dump_guest_memory() uses 64 bit quantities to store both
the begin and length values. Thus specify begin and length as long so
that the entire guest memory space can be dumped.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hmp-commands.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 0734fea931..3b5c1f65db 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1116,7 +1116,7 @@ ETEXI
 
     {
         .name       = "dump-guest-memory",
-        .args_type  = "paging:-p,detach:-d,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:i?,length:i?",
+        .args_type  = "paging:-p,detach:-d,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:l?,length:l?",
         .params     = "[-p] [-d] [-z|-l|-s] filename [begin length]",
         .help       = "dump guest memory into file 'filename'.\n\t\t\t"
                       "-p: do paging to get guest's memory mapping.\n\t\t\t"
-- 
2.13.6
