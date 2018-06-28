Received: from eggs.gnu.org ([2001:4830:134:3::10]:38216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAq-0007T4-Gs
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAp-0000oJ-LU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:48 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAp-0000nF-DI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:47 -0400
Received: by mail-wr0-x236.google.com with SMTP id k7-v6so3190053wrq.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:47 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	127-v6sm6211110wmd.18.2018.06.28.13.05.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 13:05:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:43 +0200
Message-Id: <1530216310-52873-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/60] pr-helper: fix assertion failure on
 failed multipath PERSISTENT RESERVE IN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scsi/qemu-pr-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 4057cf3..0218d65 100644
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
1.8.3.1
