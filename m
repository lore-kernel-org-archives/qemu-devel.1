Received: from eggs.gnu.org ([2001:4830:134:3::10]:44944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k8-0003yI-Sb
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k8-0003e9-03
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2k7-0003dz-Ry
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:31 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:20 +0100
Message-Id: <20180621164727.36626-3-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] hmp-commands: use long for begin and length
 in dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, sjitindarsingh@gmail.com, walling@linux.ibm.com
Cc: armbru@redhat.com

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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
Message-Id: <20180620003202.10546-1-sjitindarsingh@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 0de7c4c29e..754620e411 100644
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
2.17.1
