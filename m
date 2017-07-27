Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYly-00062M-8H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlx-0008Kj-26
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:23 -0300
Message-Id: <20170727024224.22900-19-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 19/20] spapr_vio: fix overflow of
 qdevs in spapr_dt_vdevice()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

sizeof(ptr) was used instead of sizeof(struct)...

also use g_malloc_n() which take care of possible type overflow.

hw/ppc/spapr_vio.c:641:22: warning: The code calls sizeof() on a pointer type. This can produce an unexpected result
    qdevs = g_malloc(sizeof(qdev) * num);
                     ^     ~~~~~~
hw/ppc/spapr_vio.c:648:23: warning: The code calls sizeof() on a pointer type. This can produce an unexpected result
    qsort(qdevs, num, sizeof(qdev), compare_reg);
                      ^     ~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/spapr_vio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index ea3bc8bd9e..9991b44c9f 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -638,14 +638,14 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
     }
 
     /* Copy out into an array of pointers */
-    qdevs = g_malloc(sizeof(qdev) * num);
+    qdevs = g_malloc_n(num, sizeof(*qdev));
     num = 0;
     QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
         qdevs[num++] = kid->child;
     }
 
     /* Sort the array */
-    qsort(qdevs, num, sizeof(qdev), compare_reg);
+    qsort(qdevs, num, sizeof(*qdev), compare_reg);
 
     /* Hack alert. Give the devices to libfdt in reverse order, we happen
      * to know that will mean they are in forward order in the tree. */
-- 
2.13.3
