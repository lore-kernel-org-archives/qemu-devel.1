Received: from eggs.gnu.org ([2001:4830:134:3::10]:41985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZC-0007rw-4W
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ8-0005qO-2z
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:10 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZ7-0005pb-TD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:06 -0500
Received: by mail-wr0-x241.google.com with SMTP id g38so1843348wrd.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:05 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:03 +0100
Message-Id: <1515756676-3860-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/52] irq: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzhecheng <linzhecheng@huawei.com>

From: linzhecheng <linzhecheng@huawei.com>

entry is moved from list but is not freed.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

Message-Id: <20171225024704.19540-1-linzhecheng@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 825aea5..4912f4d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3470,6 +3470,7 @@ int kvm_arch_release_virq_post(int virq)
         if (entry->virq == virq) {
             trace_kvm_x86_remove_msi_route(virq);
             QLIST_REMOVE(entry, list);
+            g_free(entry);
             break;
         }
     }
-- 
1.8.3.1
