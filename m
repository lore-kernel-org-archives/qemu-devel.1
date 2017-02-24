Received: from eggs.gnu.org ([2001:4830:134:3::10]:36454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrR-00084e-AY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrQ-0002KG-34
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:53 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJrP-0002K1-TC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:52 -0500
Received: by mail-wr0-x242.google.com with SMTP id 89so3129484wrr.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:29 +0100
Message-Id: <1487958030-51417-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/17] qapi: flatten GuestPanicInformation union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eric Blake <eblake@redhat.com>
Message-Id: <1487614915-18710-3-git-send-email-den@openvz.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi-schema.json  | 12 ++++++++++++
 target/i386/cpu.c | 15 ++++++---------
 vl.c              | 12 ++++++------
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index e9a6364..b142e15 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5872,6 +5872,16 @@
   'data': [ 'pause', 'poweroff' ] }
 
 ##
+# @GuestPanicInformationType:
+#
+# An enumeration of the guest panic information types
+#
+# Since: 2.9
+##
+{ 'enum': 'GuestPanicInformationType',
+  'data': [ 'hyper-v'] }
+
+##
 # @GuestPanicInformation:
 #
 # Information about a guest panic
@@ -5879,6 +5889,8 @@
 # Since: 2.9
 ##
 {'union': 'GuestPanicInformation',
+ 'base': {'type': 'GuestPanicInformationType'},
+ 'discriminator': 'type',
  'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
 
 ##
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd7add2..63be816 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3502,19 +3502,16 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
     GuestPanicInformation *panic_info = NULL;
 
     if (env->features[FEAT_HYPERV_EDX] & HV_X64_GUEST_CRASH_MSR_AVAILABLE) {
-        GuestPanicInformationHyperV *panic_info_hv =
-            g_malloc0(sizeof(GuestPanicInformationHyperV));
         panic_info = g_malloc0(sizeof(GuestPanicInformation));
 
-        panic_info->type = GUEST_PANIC_INFORMATION_KIND_HYPER_V;
-        panic_info->u.hyper_v.data = panic_info_hv;
+        panic_info->type = GUEST_PANIC_INFORMATION_TYPE_HYPER_V;
 
         assert(HV_X64_MSR_CRASH_PARAMS >= 5);
-        panic_info_hv->arg1 = env->msr_hv_crash_params[0];
-        panic_info_hv->arg2 = env->msr_hv_crash_params[1];
-        panic_info_hv->arg3 = env->msr_hv_crash_params[2];
-        panic_info_hv->arg4 = env->msr_hv_crash_params[3];
-        panic_info_hv->arg5 = env->msr_hv_crash_params[4];
+        panic_info->u.hyper_v.arg1 = env->msr_hv_crash_params[0];
+        panic_info->u.hyper_v.arg2 = env->msr_hv_crash_params[1];
+        panic_info->u.hyper_v.arg3 = env->msr_hv_crash_params[2];
+        panic_info->u.hyper_v.arg4 = env->msr_hv_crash_params[3];
+        panic_info->u.hyper_v.arg5 = env->msr_hv_crash_params[4];
     }
 
     return panic_info;
diff --git a/vl.c b/vl.c
index b5d0a19..e307ae0 100644
--- a/vl.c
+++ b/vl.c
@@ -1697,14 +1697,14 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     }
 
     if (info) {
-        if (info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
+        if (info->type == GUEST_PANIC_INFORMATION_TYPE_HYPER_V) {
             qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
                           " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
-                          info->u.hyper_v.data->arg1,
-                          info->u.hyper_v.data->arg2,
-                          info->u.hyper_v.data->arg3,
-                          info->u.hyper_v.data->arg4,
-                          info->u.hyper_v.data->arg5);
+                          info->u.hyper_v.arg1,
+                          info->u.hyper_v.arg2,
+                          info->u.hyper_v.arg3,
+                          info->u.hyper_v.arg4,
+                          info->u.hyper_v.arg5);
         }
         qapi_free_GuestPanicInformation(info);
     }
-- 
1.8.3.1
