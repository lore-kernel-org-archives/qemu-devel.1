Received: from eggs.gnu.org ([2001:4830:134:3::10]:55513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXf-0000dz-N8
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXd-0006Xb-L9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:19 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXd-0006XR-Gq
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:17 -0400
Received: by mail-qk0-x242.google.com with SMTP id a77so6862277qkb.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:53:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:53:00 -0300
Message-Id: <20170831035306.29170-2-f4bug@amsat.org>
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to use
 the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/serial.h |  1 +
 hw/char/serial.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index c4daf11a14..96bccb39e1 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -93,6 +93,7 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end);
+Chardev *serial_chr_nonnull(Chardev *chr);
 
 /* serial-isa.c */
 #define TYPE_ISA_SERIAL "isa-serial"
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9aec6c60d8..7a100db107 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1025,6 +1025,19 @@ static const MemoryRegionOps serial_mm_ops[3] = {
     },
 };
 
+Chardev *serial_chr_nonnull(Chardev *chr)
+{
+    static int serial_id;
+    char *label;
+
+    label = g_strdup_printf("discarding-serial%d", serial_id++);
+    chr = qemu_chr_new(label, "null");
+    assert(chr);
+    g_free(label);
+
+    return chr;
+}
+
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
-- 
2.14.1
