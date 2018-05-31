Received: from eggs.gnu.org ([2001:4830:134:3::10]:59363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBQ-0006Ha-IS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBP-0003yz-LE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57506 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBP-0003xS-Fs
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F3837D83A
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:15 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B597539D63
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:15:56 +0200
Message-Id: <20180531171606.21604-5-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/53] scripts/update-linux-headers: Handle
 __aligned_u64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

We'll currently replace any 'u64' with a 'uint64_t' including when
it's embedded in an '__aligned_u64', creating a '__aligned_uint64_t'
which doesn't exist. We need to instead expand out the kernel's
definition of __aligned_u64:
   #define __aligned_u64 __u64 __attribute__((aligned(8)))
before we convert the __u64 to uint64_t.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180525132755.21839-3-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 947dec2852..1fe54f8ab1 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -51,7 +51,8 @@ cp_portable() {
     fi
 
     header=$(basename "$f");
-    sed -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
+    sed -e 's/__aligned_u64/__u64 __attribute__((aligned(8)))/g' \
+        -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/u\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/__s\([0-9][0-9]*\)/int\1_t/g' \
         -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
-- 
2.17.0
