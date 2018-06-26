Received: from eggs.gnu.org ([2001:4830:134:3::10]:34314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq57-0008Nl-DU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq56-0005eV-Al
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:37 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fXq56-0005e6-32
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:36 -0400
Received: by mail-wr0-x241.google.com with SMTP id g18-v6so17734564wro.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:40:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Jun 2018 17:40:26 +0200
Message-Id: <20180626154028.11133-4-pbonzini@redhat.com>
In-Reply-To: <20180626154028.11133-1-pbonzini@redhat.com>
References: <20180626154028.11133-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] pr-manager-helper: avoid SIGSEGV when
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
Cc: mprivozn@redhat.com

When writing to the qemu-pr-helper socket failed, the persistent
reservation manager was correctly disconnecting the socket, but it
did not clear pr_mgr->ioc.  So the rest of the code did not know
that the socket had been disconnected, accessed pr_mgr->ioc and
happily caused a crash.

To reproduce, it is enough to stop qemu-pr-helper between QEMU
startup and executing e.g. sg_persist -k /dev/sdb.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/pr-manager-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 82ff6b6123..0c0fe389b7 100644
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
2.17.1
