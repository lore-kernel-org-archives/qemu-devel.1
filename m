Received: from eggs.gnu.org ([2001:4830:134:3::10]:37695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cY20e-0005E2-P0
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cY20b-0003pS-Fq
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:48:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40563
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cY20b-0003ol-B2
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:47:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0U2iGHH097611
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:56 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 289pf0snu2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:56 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 30 Jan 2017 00:47:54 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id ED9F5352005F
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:18 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0U2lp085136636
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 00:47:51 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0U2lpGO001272
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 00:47:51 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 00:47:37 -0200
In-Reply-To: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1485744457-10324-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 2/2] risu_ppc64: Compare FPSCR flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

When running FP operations, FPSCR flag must be compared to make sure
that any exception will behave consistently.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risu_reginfo_ppc64le.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
index 4dc509c..ee0e55e 100644
--- a/risu_reginfo_ppc64le.c
+++ b/risu_reginfo_ppc64le.c
@@ -21,6 +21,7 @@
 
 #define XER 37
 #define CCR 38
+#define FPREG 32
 
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
@@ -82,6 +83,10 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
         }
     }
 
+    if (m->fpregs[FPREG] != a->fpregs[FPREG]) {
+        return 0;
+    }
+
     for (i = 0; i < 32; i++) {
         if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
                 m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
-- 
2.7.4
