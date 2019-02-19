Received: from eggs.gnu.org ([209.51.188.92]:52698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gw6fo-0007gr-6a
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gw6fn-0001bV-Cj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:47:04 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Tue, 19 Feb 2019 14:46:43 +0000
Message-ID: <20190219144621.450-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] target/arm: Stop unintentional sign extension
 in pmu_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aaron Lindsay OS <aaron@os.amperecomputing.com>

This was introduced by
    commit bf8d09694ccc07487cd73d7562081fdaec3370c8
    target/arm: Don't clear supported PMU events when initializing PMCEID1
and identified by Coverity (CID 1398645).

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a018eb23fe..5a29bc9799 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1167,7 +1167,7 @@ void pmu_init(ARMCPU *cpu)
=20
         if (cnt->supported(&cpu->env)) {
             supported_event_map[cnt->number] =3D i;
-            uint64_t event_mask =3D 1 << (cnt->number & 0x1f);
+            uint64_t event_mask =3D 1ULL << (cnt->number & 0x1f);
             if (cnt->number & 0x20) {
                 cpu->pmceid1 |=3D event_mask;
             } else {
--=20
2.20.1
