Received: from eggs.gnu.org ([2001:4830:134:3::10]:51540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSs-0007DY-FV
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSq-0002lA-0J
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:06 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSp-0002l0-SC
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:03 -0500
Received: by mail-qt0-x243.google.com with SMTP id w10so12061767qtb.10
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:45 -0300
Message-Id: <20180108024558.17983-17-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 16/29] Revert "irq: introduce
 qemu_irq_proxy()"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

This function isn't used anymore.

This reverts commit 22ec3283efba9ba0792790da786d6776d83f2a92.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I think circular IRQ dependencies should be avoided with today's QOM devices.

 include/hw/irq.h |  5 -----
 hw/core/irq.c    | 14 --------------
 2 files changed, 19 deletions(-)

diff --git a/include/hw/irq.h b/include/hw/irq.h
index 4c4c2eaf9a..ee823177e6 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -53,11 +53,6 @@ qemu_irq qemu_irq_invert(qemu_irq irq);
 /* Returns a new IRQ which feeds into both the passed IRQs */
 qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
 
-/* Returns a new IRQ set which connects 1:1 to another IRQ set, which
- * may be set later.
- */
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
-
 /* For internal use in qtest.  Similar to qemu_irq_split, but operating
    on an existing vector of qemu_irq.  */
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
diff --git a/hw/core/irq.c b/hw/core/irq.c
index b98d1d69f5..c8e96f122a 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -121,20 +121,6 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2)
     return qemu_allocate_irq(qemu_splitirq, s, 0);
 }
 
-static void proxy_irq_handler(void *opaque, int n, int level)
-{
-    qemu_irq **target = opaque;
-
-    if (*target) {
-        qemu_set_irq((*target)[n], level);
-    }
-}
-
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n)
-{
-    return qemu_allocate_irqs(proxy_irq_handler, target, n);
-}
-
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
 {
     int i;
-- 
2.15.1
