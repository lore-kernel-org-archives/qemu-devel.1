Received: from eggs.gnu.org ([209.51.188.92]:52101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXo-0008S2-UQ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXn-0007Qv-1h
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:04 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXl-0007HA-4E
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:02 -0500
Received: by mail-wm1-x32e.google.com with SMTP id a62so10640227wmh.4
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:57:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:21 +0000
Message-Id: <20190221185739.25362-4-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/21] target/arm: Stop unintentional sign
 extension in pmu_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay OS <aaron@os.amperecomputing.com>

This was introduced by
    commit bf8d09694ccc07487cd73d7562081fdaec3370c8
    target/arm: Don't clear supported PMU events when initializing PMCEID1
and identified by Coverity (CID 1398645).

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190219144621.450-1-aaron@os.amperecomputing.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe054897c78..c2630fa1ea4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1167,7 +1167,7 @@ void pmu_init(ARMCPU *cpu)
 
         if (cnt->supported(&cpu->env)) {
             supported_event_map[cnt->number] = i;
-            uint64_t event_mask = 1 << (cnt->number & 0x1f);
+            uint64_t event_mask = 1ULL << (cnt->number & 0x1f);
             if (cnt->number & 0x20) {
                 cpu->pmceid1 |= event_mask;
             } else {
-- 
2.20.1
