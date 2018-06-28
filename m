Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAr-0007UD-E6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAq-0000ou-Ed
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:49 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAq-0000oF-7u
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:48 -0400
Received: by mail-wm0-x242.google.com with SMTP id n17-v6so9764067wmh.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:48 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	127-v6sm6211110wmd.18.2018.06.28.13.05.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 13:05:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:44 +0200
Message-Id: <1530216310-52873-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/60] pr-manager-helper: avoid SIGSEGV when
 writing to the socket fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When writing to the qemu-pr-helper socket failed, the persistent
reservation manager was correctly disconnecting the socket, but it
did not clear pr_mgr->ioc.  So the rest of the code did not know
that the socket had been disconnected, accessed pr_mgr->ioc and
happily caused a crash.

To reproduce, it is enough to stop qemu-pr-helper between QEMU
startup and executing e.g. sg_persist -k /dev/sdb.

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/pr-manager-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 82ff6b6..0c0fe38 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -71,6 +71,7 @@ static int pr_manager_helper_write(PRManagerHelper *pr_mgr,
         if (n_written <= 0) {
             assert(n_written != QIO_CHANNEL_ERR_BLOCK);
             object_unref(OBJECT(pr_mgr->ioc));
+            pr_mgr->ioc = NULL;
             return n_written < 0 ? -EINVAL : 0;
         }
 
-- 
1.8.3.1
