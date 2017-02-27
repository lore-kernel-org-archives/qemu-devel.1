Received: from eggs.gnu.org ([2001:4830:134:3::10]:36165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgw-0004p8-AS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgu-0000gE-3x
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgt-0000fr-SS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:12 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:50 +0100
Message-Id: <20170227124551.8673-17-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 16/17] qapi: flatten GuestPanicInformation union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>

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
index 150ee98..ad341b2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5906,6 +5906,16 @@
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
@@ -5913,6 +5923,8 @@
 # Since: 2.9
 ##
 {'union': 'GuestPanicInformation',
+ 'base': {'type': 'GuestPanicInformationType'},
+ 'discriminator': 'type',
  'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
 
 ##
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6f157d..8c3e882 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3501,19 +3501,16 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
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
index e10a27b..7f57ded 100644
--- a/vl.c
+++ b/vl.c
@@ -1717,14 +1717,14 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
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
2.9.3
