Received: from eggs.gnu.org ([2001:4830:134:3::10]:54740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnnhO-00030u-Fx
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnnhN-0007M9-PT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:45:18 -0400
From: Andreas Grapentin <andreas@grapentin.org>
Date: Tue, 14 Mar 2017 15:44:53 +0100
Message-Id: <20170314144453.5027-2-andreas@grapentin.org>
In-Reply-To: <20170314144453.5027-1-andreas@grapentin.org>
References: <20170314144453.5027-1-andreas@grapentin.org>
Subject: [Qemu-devel] [PATCH 1/1] added configure check for _Static_assert
 and updated QEMU_BUILD_BUG_ON(...) accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Andreas Grapentin <andreas@grapentin.org>

---
 configure               | 18 ++++++++++++++++++
 include/qemu/compiler.h |  4 +++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 75c7c3526c..e9b33d9cf8 100755
--- a/configure
+++ b/configure
@@ -4725,6 +4725,20 @@ if compile_prog "" "" ; then
 fi
 
 ##########################################
+# check for _Static_assert()
+
+have_static_assert=no
+cat > $TMPC << EOF
+_Static_assert(1, "success.");
+int main(void) {
+    return 0;
+}
+EOF
+if compile_prog "" "" ; then
+    have_static_assert=yes
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
@@ -5694,6 +5708,10 @@ if test "$have_sysmacros" = "yes" ; then
   echo "CONFIG_SYSMACROS=y" >> $config_host_mak
 fi
 
+if test "$have_static_assert" = "yes" ; then
+  echo "CONFIG_STATIC_ASSERT=y" >> $config_host_mak
+fi
+
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
 #                                     a thread we have a handle to
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index e0ce9ffb28..37a65d4bb7 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -90,7 +90,9 @@
         int:(x) ? -1 : 1; \
     }
 
-#ifdef __COUNTER__
+#if defined(CONFIG_STATIC_ASSERT)
+#define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), #x)
+#elif defined(__COUNTER__)
 #define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
     glue(qemu_build_bug_on__, __COUNTER__) __attribute__((unused))
 #else
-- 
2.12.0
