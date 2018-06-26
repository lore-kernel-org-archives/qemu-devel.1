Received: from eggs.gnu.org ([2001:4830:134:3::10]:34309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq57-0008Ng-BG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq55-0005e2-G6
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:37 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fXq55-0005dj-8Y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:35 -0400
Received: by mail-wm0-x242.google.com with SMTP id p11-v6so2326108wmc.4
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:40:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Jun 2018 17:40:25 +0200
Message-Id: <20180626154028.11133-3-pbonzini@redhat.com>
In-Reply-To: <20180626154028.11133-1-pbonzini@redhat.com>
References: <20180626154028.11133-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] pr-helper: fix assertion failure on failed
 multipath PERSISTENT RESERVE IN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

The response size is expected to be zero if the SCSI status is not
"GOOD", but nothing was resetting it.

This can be reproduced simply by "sg_persist -s /dev/sdb" where /dev/sdb
in the guest is a scsi-block device corresponding to a multipath device
on the host.

Before:

  PR in (Read full status): Aborted command

and on the host:

  prh_write_response: Assertion `resp->sz == 0' failed.

After:

  PR in (Read full status): bad field in cdb or parameter list
  (perhaps unsupported service action)

Reported-by: Jiri Belka <jbelka@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 4057cf355c..0218d65bbf 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -558,7 +558,11 @@ static int do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
 #ifdef CONFIG_MPATH
     if (is_mpath(fd)) {
         /* multipath_pr_in fills the whole input buffer.  */
-        return multipath_pr_in(fd, cdb, sense, data, *resp_sz);
+        int r = multipath_pr_in(fd, cdb, sense, data, *resp_sz);
+        if (r != GOOD) {
+            *resp_sz = 0;
+        }
+        return r;
     }
 #endif
 
-- 
2.17.1
