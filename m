Received: from eggs.gnu.org ([2001:4830:134:3::10]:41487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8PkX-0003G2-Po
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8PkT-0000Ih-La
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g8PkP-0008L1-Lt
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:25 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  5 Oct 2018 15:01:48 +0200
Message-Id: <1538744508-17108-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1538744508-17108-1-git-send-email-thuth@redhat.com>
References: <1538744508-17108-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] hw/core/generic-loader: Compile only
 once, not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>

The generic-loader is currently compiled target specific due to one
single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We have already a
function called target_words_bigendian() for this instead, so we can
put the generic-loader into common-obj to save some compilation time.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/Makefile.objs    | 2 +-
 hw/core/generic-loader.c | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index eb88ca9..b736ce2 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -20,6 +20,6 @@ common-obj-$(CONFIG_SOFTMMU) += register.o
 common-obj-$(CONFIG_SOFTMMU) += or-irq.o
 common-obj-$(CONFIG_SOFTMMU) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
+common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 
-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 obj-$(CONFIG_SOFTMMU) += null-machine.o
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index be29ae1..fbae05f 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -130,11 +130,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         s->cpu = first_cpu;
     }
 
-#ifdef TARGET_WORDS_BIGENDIAN
-    big_endian = 1;
-#else
-    big_endian = 0;
-#endif
+    big_endian = target_words_bigendian();
 
     if (s->file) {
         AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
-- 
1.8.3.1
