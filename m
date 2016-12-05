Received: from eggs.gnu.org ([2001:4830:134:3::10]:35044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE2uJ-0002fz-7G
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE2uI-0002Lm-7n
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:42:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  5 Dec 2016 17:42:35 -0600
Message-Id: <20161205234235.5728-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] doc: Propose NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nbd-general@lists.sourceforge.net
Cc: qemu-devel@nongnu.org, xieyingtai@huawei.com, subo7@huawei.com, eric.fangyi@huawei.com, pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@gmail.com

While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
team discovered that it is useful if a server can advertise
whether an export is in a known-all-zeroes state at the time
the client connects.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 doc/proto.md | 5 +++++
 1 file changed, 5 insertions(+)

This replaces the following qemu patch attempt:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00357.html
which tried to add NBD_CMD_HAS_ZERO_INIT with poor semantics. The
semantics in this proposal should be much better.

Patch is to the merge of the master branch and the
extension-write-zeroes branch.  By the way, qemu 2.8 is due
to be released "real soon now", and implements NBD_CMD_WRITE_ZEROES,
so maybe it is time to consider promoting the extension-write-zeroes
branch into master.

diff --git a/doc/proto.md b/doc/proto.md
index afe71fc..7e4ec7f 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -697,6 +697,11 @@ The field has the following format:
   the export.
 - bit 9, `NBD_FLAG_SEND_BLOCK_STATUS`: defined by the experimental
   `BLOCK_STATUS` [extension](https://github.com/NetworkBlockDevice/nbd/blob/extension-blockstatus/doc/proto.md).
+- bit 10, `NBD_FLAG_INIT_ZEROES`: Indicates that the server guarantees
+  that at the time transmission phase begins, all offsets within the
+  export read as zero bytes.  Clients MAY use this information to
+  avoid writing to sections of the export that should still read as
+  zero after the client is done writing.

 Clients SHOULD ignore unknown flags.

-- 
2.9.3
