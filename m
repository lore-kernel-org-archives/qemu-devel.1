Received: from eggs.gnu.org ([2001:4830:134:3::10]:38480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofr-0000Dp-Bc
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofq-0004Wn-DB
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:43 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofo-0004Tk-By
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id y139so5871080wmc.5
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.37
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:10 +0000
Message-Id: <20181214144214.1260-19-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/22] hw/arm/mps2-tz.c: Free mscname string in
 make_dma()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The clang leak sanitizer spots a (one-off, trivial) memory
leak in make_dma() due to a missing free.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181204132952.2601-3-peter.maydell@linaro.org
---
 hw/arm/mps2-tz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 6dd02ae47e8..82b1d020a58 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -322,6 +322,7 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
     sysbus_connect_irq(s, 2, qdev_get_gpio_in_named(iotkitdev,
                                                     "EXP_IRQ", 57 + i * 3));
 
+    g_free(mscname);
     return sysbus_mmio_get_region(s, 0);
 }
 
-- 
2.19.2
