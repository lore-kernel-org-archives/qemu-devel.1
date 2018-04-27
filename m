Received: from eggs.gnu.org ([2001:4830:134:3::10]:60098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzav-0002Yo-UV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzas-0002Tj-RE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:23:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:09 +1000
Message-Id: <20180427092126.24812-33-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 32/49] target/ppc: Simplify cpu valid check in
 ppc_cpu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The #if isn't necessary, because there's a suitable one inside
ppc_cpu_is_valid().  We've already filtered for suitable cpu models in the
functions that search and register them.  So by the time we get to realize
having an invalid one indicates a code error, not a user error, so an
assert() is more appropriate than error_setg().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate_init.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56b80a204a..2ae718242a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9749,14 +9749,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
         }
     }
 
-#if defined(TARGET_PPCEMB)
-    if (!ppc_cpu_is_valid(pcc)) {
-        error_setg(errp, "CPU does not possess a BookE or 4xx MMU. "
-                   "Please use qemu-system-ppc or qemu-system-ppc64 instead "
-                   "or choose another CPU model.");
-        goto unrealize;
-    }
-#endif
+    assert(ppc_cpu_is_valid(pcc));
 
     create_ppc_opcodes(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.14.3
