Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6ZrE-0001C3-Rf
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6Zr6-00078e-8k
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:48:59 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d6Zr6-00078P-1g
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:48:56 -0400
Received: by mail-wm0-x242.google.com with SMTP id u65so237280wmu.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 02:48:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 11:48:50 +0200
Message-Id: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] ppc: xics: fix compilation with CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, dgibson@redhat.com

The PowerPCCPU typedef is included twice if a file includes
both hw/ppc/xics.h and target/ppc/cpu-qom.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	There are other failures but I don't have time to debug them today:

	In file included from /tmp/qemu-test/src/include/hw/ppc/pnv.h:26,
	                 from /tmp/qemu-test/src/hw/ppc/pnv.c:31:
	/tmp/qemu-test/src/include/hw/ppc/pnv_psi.h:50: error: redefinition of typedef ‘PnvPsi’
	/tmp/qemu-test/src/include/hw/ppc/pnv_lpc.h:26: note: previous declaration of ‘PnvPsi’ was here
	In file included from /tmp/qemu-test/src/include/hw/ppc/pnv.h:27,
	                 from /tmp/qemu-test/src/hw/ppc/pnv.c:31:
	/tmp/qemu-test/src/include/hw/ppc/pnv_occ.h:25: error: redefinition of typedef ‘PnvPsi’
	/tmp/qemu-test/src/include/hw/ppc/pnv_psi.h:50: note: previous declaration of ‘PnvPsi’ was here
	In file included from /tmp/qemu-test/src/hw/ppc/pnv.c:39:
	/tmp/qemu-test/src/include/hw/ipmi/ipmi.h:188: error: redefinition of typedef ‘IPMIBmc’
	/tmp/qemu-test/src/include/hw/ppc/pnv.h:121: note: previous declaration of ‘IPMIBmc’ was here
	make[1]: *** [hw/ppc/pnv.o] Error 1

	Please start including Docker-based tests in your pre-pull-request tests.

 include/hw/ppc/xics.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index c215dc7..ce1942b 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -29,6 +29,7 @@
 #define XICS_H
 
 #include "hw/qdev.h"
+#include "target/ppc/cpu-qom.h"
 
 #define XICS_IPI        0x2
 #define XICS_BUID       0x1
@@ -46,7 +47,6 @@ typedef struct ICSStateClass ICSStateClass;
 typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
 typedef struct XICSFabric XICSFabric;
-typedef struct PowerPCCPU PowerPCCPU;
 
 #define TYPE_ICP "icp"
 #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
-- 
1.8.3.1
