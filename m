Received: from eggs.gnu.org ([2001:4830:134:3::10]:46342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj2iV-00086v-4h
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj2iR-0005Is-VJ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:23:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 27 Jul 2018 10:23:11 -0300
Message-Id: <20180727132311.2777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: Remove duplicate 'host' entry in
 '-cpu ?' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Since 86f0a186d6f the TYPE_ARM_HOST_CPU is only compiled when CONFIG_KVM
is enabled.

Remove the now redundant special-case introduced in a96c0514ab7, to avoid:

  $ qemu-system-aarch64 -machine virt -cpu \? | fgrep host
  host
  host (only available in KVM mode)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22d812240a..66afb08ee0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5591,12 +5591,6 @@ void arm_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     (*cpu_fprintf)(f, "Available CPUs:\n");
     g_slist_foreach(list, arm_cpu_list_entry, &s);
     g_slist_free(list);
-#ifdef CONFIG_KVM
-    /* The 'host' CPU type is dynamically registered only if KVM is
-     * enabled, so we have to special-case it here:
-     */
-    (*cpu_fprintf)(f, "  host (only available in KVM mode)\n");
-#endif
 }
 
 static void arm_cpu_add_definition(gpointer data, gpointer user_data)
-- 
2.18.0
