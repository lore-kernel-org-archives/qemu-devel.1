Received: from eggs.gnu.org ([2001:4830:134:3::10]:41705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duHtO-00080J-Aq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duHtN-0007Bi-Dv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duHtN-0007B4-7u
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:45 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:44:40 +0200
Message-Id: <20170919124440.30017-3-pbonzini@redhat.com>
In-Reply-To: <20170919124440.30017-1-pbonzini@redhat.com>
References: <20170919124440.30017-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/50] update-linux-headers: prepare for
 hyperv.h removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

All definitions related to Hyper-V emulation are now taken from the QEMU
own header, so the one imported from the kernel is no longer needed.

Unfortunately it's included by kvm_para.h.

So, until this is fixed in the kernel, teach the header harvesting
script to substitute kernel's hyperv.h with a dummy.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20170713201522.13765-3-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.13.5
