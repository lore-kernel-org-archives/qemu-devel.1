Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDVbW-0001FN-QU
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDVbT-0003C1-P2
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:46:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fDVbT-0003Bb-KD
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0003140267D8
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 13:45:52 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96032111DCFE
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 13:45:49 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  1 May 2018 15:44:57 +0200
Message-Id: <1525182297-205763-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525176522-200354-5-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-5-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/5] arm: boot: set boot_info starting from
 first_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Even though nothing is currently broken (since all boards
use first_cpu as boot cpu), make sure that boot_info is set
on all CPUs.
If some board would like support heterogenuos setup (i.e.
init boot_info on subset of CPUs) in future, it should add
a reasonable API to do it, instead of starting assigning
boot_info from some CPU and till the end of present CPUs
list.

Ref:
"Message-ID: <CAFEAcA_NMWuA8WSs3cNeY6xX1kerO_uAcN_3=fK02BEhHJW86g@mail.gmail.com>"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ad71dd4..144abbd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1139,7 +1139,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     }
     info->is_linux = is_linux;
 
-    for (cs = CPU(cpu); cs; cs = CPU_NEXT(cs)) {
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
         ARM_CPU(cs)->env.boot_info = info;
     }
 
-- 
2.7.4
