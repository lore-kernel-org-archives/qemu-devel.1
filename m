Received: from eggs.gnu.org ([2001:4830:134:3::10]:53500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dVkWN-0000ji-Vx
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dVkWL-0000xV-Rj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:15:35 -0400
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com
	([104.47.1.97]:58779
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dVkWL-0000vd-JB
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:15:33 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 13 Jul 2017 23:15:22 +0300
Message-Id: <20170713201522.13765-3-rkagan@virtuozzo.com>
In-Reply-To: <20170713201522.13765-1-rkagan@virtuozzo.com>
References: <20170713201522.13765-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] update-linux-headers: prepare for hyperv.h
 removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Denis V . Lunev" <den@openvz.org>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, Igor Mammedov <imammedo@redhat.com>

All definitions related to Hyper-V emulation are now taken from the QEMU
own header, so the one imported from the kernel is no longer needed.

Unfortunately it's included by kvm_para.h.

So, until this is fixed in the kernel, teach the header harvesting
script to substitute kernel's hyperv.h with a dummy.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 scripts/update-linux-headers.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 2f906c4d16..ad80fe3fca 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -104,7 +104,9 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
     fi
     if [ $arch = x86 ]; then
-        cp_portable "$tmpdir/include/asm/hyperv.h" "$output/include/standard-headers/asm-x86/"
+        cat <<-EOF >"$output/include/standard-headers/asm-x86/hyperv.h"
+        /* this is a temporary placeholder until kvm_para.h stops including it */
+        EOF
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
-- 
2.13.0
