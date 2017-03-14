Received: from eggs.gnu.org ([2001:4830:134:3::10]:36838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9n-0003cj-NS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9m-0006lV-Pv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:43 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9m-0006kn-Jp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:42 -0400
Received: by mail-wm0-x241.google.com with SMTP id n11so610589wma.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:20 +0100
Message-Id: <1489508300-48184-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/18] nbd/client: fix drop_sync [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Comparison symbol is misused. It may lead to memory corruption.
Introduced in commit 7d3123e.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
[eblake: add CVE details, update conditional]
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170307151627.27212-1-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index 5c9dee3..3dc2564 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size)
     char small[1024];
     char *buffer;
 
-    buffer = sizeof(small) < size ? small : g_malloc(MIN(65536, size));
+    buffer = sizeof(small) >= size ? small : g_malloc(MIN(65536, size));
     while (size > 0) {
         ssize_t count = read_sync(ioc, buffer, MIN(65536, size));
 
-- 
1.8.3.1
