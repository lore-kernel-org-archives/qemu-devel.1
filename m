Received: from eggs.gnu.org ([209.51.188.92]:34091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004DP-Ka
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e6-0006PE-Oz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-00069E-19
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id v16so14710340wrp.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.34
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:50 +0100
Message-Id: <20190429170030.11323-3-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/42] hw/ssi/xilinx_spips: Avoid variable
 length array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the stripe8() function we use a variable length array; however
we know that the maximum length required is MAX_NUM_BUSSES. Use
a fixed-length array and an assert instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20190328152635.2794-1-peter.maydell@linaro.org
---
 hw/ssi/xilinx_spips.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 16f88f74029..c615058cc1b 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -429,12 +429,14 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
 
 static inline void stripe8(uint8_t *x, int num, bool dir)
 {
-    uint8_t r[num];
-    memset(r, 0, sizeof(uint8_t) * num);
+    uint8_t r[MAX_NUM_BUSSES];
     int idx[2] = {0, 0};
     int bit[2] = {0, 7};
     int d = dir;
 
+    assert(num <= MAX_NUM_BUSSES);
+    memset(r, 0, sizeof(uint8_t) * num);
+
     for (idx[0] = 0; idx[0] < num; ++idx[0]) {
         for (bit[0] = 7; bit[0] >= 0; bit[0]--) {
             r[idx[!d]] |= x[idx[d]] & 1 << bit[d] ? 1 << bit[!d] : 0;
-- 
2.20.1
