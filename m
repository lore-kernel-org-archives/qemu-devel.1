Received: from eggs.gnu.org ([209.51.188.92]:56243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkz-0005ar-6u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkx-0005CD-J5
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:53 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkx-00058Z-8R
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:51 -0500
Received: by mail-pf1-x443.google.com with SMTP id c123so7221377pfb.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:07 +1100
Message-Id: <20190118213122.22865-34-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 34/49] linux-user: Split out stime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  3 +++
 linux-user/syscall-time.inc.c | 12 ++++++++++++
 linux-user/syscall.c          |  9 ---------
 linux-user/strace.list        |  3 ---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 0d8da0c6d6..6ca82af397 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -152,6 +152,9 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_stime
+SYSCALL_DEF(stime, ARG_PTR);
+#endif
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
diff --git a/linux-user/syscall-time.inc.c b/linux-user/syscall-time.inc.c
index 14fec88e47..d1fb72bde0 100644
--- a/linux-user/syscall-time.inc.c
+++ b/linux-user/syscall-time.inc.c
@@ -16,6 +16,18 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifdef TARGET_NR_stime
+SYSCALL_IMPL(stime)
+{
+    time_t host_time;
+
+    if (get_user_sal(host_time, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(stime(&host_time));
+}
+#endif
+
 #ifdef TARGET_NR_time
 SYSCALL_IMPL(time)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b35d84794f..c0ce4068b6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,15 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_stime /* not on alpha */
-    case TARGET_NR_stime:
-        {
-            time_t host_time;
-            if (get_user_sal(host_time, arg1))
-                return -TARGET_EFAULT;
-            return get_errno(stime(&host_time));
-        }
-#endif
 #ifdef TARGET_NR_alarm /* not on alpha */
     case TARGET_NR_alarm:
         return alarm(arg1);
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 0f32c456cd..a5f308c497 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1254,9 +1254,6 @@
 #ifdef TARGET_NR_statfs64
 { TARGET_NR_statfs64, "statfs64" , NULL, print_statfs64, NULL },
 #endif
-#ifdef TARGET_NR_stime
-{ TARGET_NR_stime, "stime" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_streams1
 { TARGET_NR_streams1, "streams1" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
