Received: from eggs.gnu.org ([2001:4830:134:3::10]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcI-0008HH-Ms
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcH-0005HU-6Q
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:34 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Feb 2017 14:28:17 +0000
Message-Id: <1486996099-15820-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] cpu: Clarify TODO comment in
 cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>

The TODO comment in cpu_generic_new() suggests that we want to
move to having all callers do the parse_features work by hand.
In fact the intention is that we would prefer to have this
happen automatically via machine core work or similar common
code changes. In the meantime boards should use the
cpu_generic_new() wrapper rather than calling parse_features
themselves, because this means we only need to change one
place in future if we change how parse_features gets called.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Change based on email conversation with Eduardo...hopefully
I have understood the intention here correctly.
---
 qom/cpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index a783aec..eacce5e 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -80,8 +80,14 @@ CPUState *cpu_generic_new(const char *typename, const char *cpu_model)
 
     cc = CPU_CLASS(oc);
     featurestr = strtok(NULL, ",");
-    /* TODO: all callers of cpu_generic_init() need to be converted to
-     * call parse_features() only once, before calling cpu_generic_init().
+    /* TODO: we should really arrange to have parse_features() called
+     * only once, since it needs only to be called once per CPU class
+     * rather than once per instance of that class. Perhaps this would
+     * be done by changes to how machine core code works or by doing
+     * something in main(). In the meantime, board code should prefer
+     * to use this function rather than calling parse_features()
+     * manually, so that refactoring how we handle this is easier in
+     * future.
      */
     cc->parse_features(object_class_get_name(oc), featurestr, &err);
     g_free(str);
-- 
2.7.4
