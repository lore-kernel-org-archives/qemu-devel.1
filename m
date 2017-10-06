Received: from eggs.gnu.org ([2001:4830:134:3::10]:42092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQR-0000OT-SW
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQQ-0006Km-Vx
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:38 -0300
Message-Id: <20171006235023.11952-44-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 43/88] hw/core: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added changes in hw/core/qdev.c]
---
 hw/core/irq.c    | 2 +-
 hw/core/ptimer.c | 2 +-
 hw/core/qdev.c   | 2 +-
 hw/core/reset.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index b98d1d69f5..d9b13b1762 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -115,7 +115,7 @@ static void qemu_splitirq(void *opaque, int line, int level)
 
 qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2)
 {
-    qemu_irq *s = g_malloc0(2 * sizeof(qemu_irq));
+    qemu_irq *s = g_new0(qemu_irq, 2);
     s[0] = irq1;
     s[1] = irq2;
     return qemu_allocate_irq(qemu_splitirq, s, 0);
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7221c68a98..ef4a6646ed 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -349,7 +349,7 @@ ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy_mask)
 {
     ptimer_state *s;
 
-    s = (ptimer_state *)g_malloc0(sizeof(ptimer_state));
+    s = g_new0(ptimer_state, 1);
     s->bh = bh;
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ptimer_tick, s);
     s->policy_mask = policy_mask;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 606ab53c42..7b92af1013 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -378,7 +378,7 @@ static NamedGPIOList *qdev_get_named_gpio_list(DeviceState *dev,
         }
     }
 
-    ngl = g_malloc0(sizeof(*ngl));
+    ngl = g_new0(NamedGPIOList, 1);
     ngl->name = g_strdup(name);
     QLIST_INSERT_HEAD(&dev->gpios, ngl, node);
     return ngl;
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 84c8869371..01d86c3a95 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -40,7 +40,7 @@ static QTAILQ_HEAD(reset_handlers, QEMUResetEntry) reset_handlers =
 
 void qemu_register_reset(QEMUResetHandler *func, void *opaque)
 {
-    QEMUResetEntry *re = g_malloc0(sizeof(QEMUResetEntry));
+    QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
 
     re->func = func;
     re->opaque = opaque;
-- 
2.14.2
