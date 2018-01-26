Received: from eggs.gnu.org ([2001:4830:134:3::10]:38014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1ef879-0001R0-Qd
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1ef879-0003o5-50
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:48:35 -0500
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5A6B5091.8030601@hisilicon.com>
Date: Fri, 26 Jan 2018 16:00:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo before
 enabled the interruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Linuxarm <linuxarm@huawei.com>, Rob Herring <rob.herring@linaro.org>, Daode Huang <huangdaode@hisilicon.com>, "Chenxin (Charles)" <charles.chenxin@huawei.com>, Zhangyi ac <zhangyi.ac@huawei.com>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, tiantao6@huawei.com

If the user pressed some keys in the console during the guest booting,
the console will be hanged after entering the shell.
Because in the above case the pl011_can_receive will return 0 that
the pl011_receive will not be called. That means no interruption will
be injected in to the kernel and the pl011 state could not be driven
further.

This patch fixed that issue by checking the interruption is enabled or
not before putting into the fifo.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 hw/char/pl011.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 2aa277fc4f..6296de9527 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -229,6 +229,8 @@ static int pl011_can_receive(void *opaque)
     PL011State *s = (PL011State *)opaque;
     int r;

+    if (!s->int_enabled)
+	return 0;
     if (s->lcr & 0x10) {
         r = s->read_count < 16;
     } else {
-- 
2.11.0
