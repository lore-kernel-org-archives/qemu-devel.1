Received: from eggs.gnu.org ([2001:4830:134:3::10]:36479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DD-00079o-Cs
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DC-0006w5-Fh
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:43 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:9743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DC-0006on-56
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:42 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Tue, 24 Apr 2018 18:58:15 +0100
Message-ID: <1524592709-6553-3-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 02/16] AccelClass: Introduce accel_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This is called just before os_setup_post.  Currently none of the
accelerators provide this hook, but the Xen one is going to provide
one in a moment.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
v7: New patch in this version of the series
---
 accel/accel.c          | 9 +++++++++
 include/sysemu/accel.h | 3 +++
 vl.c                   | 1 +
 3 files changed, 13 insertions(+)

diff --git a/accel/accel.c b/accel/accel.c
index 93e2434..9cfab11 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -126,6 +126,15 @@ void accel_register_compat_props(AccelState *accel)
     register_compat_props_array(class->global_props);
 }
 
+void accel_setup_post(MachineState *ms)
+{
+    AccelState *accel = ms->accelerator;
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->setup_post) {
+        acc->setup_post(ms, accel);
+    }
+}
+
 static void register_accel_types(void)
 {
     type_register_static(&accel_type);
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 5a632ce..637358f 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -40,6 +40,7 @@ typedef struct AccelClass {
     const char *name;
     int (*available)(void);
     int (*init_machine)(MachineState *ms);
+    void (*setup_post)(MachineState *ms, AccelState *accel);
     bool *allowed;
     /*
      * Array of global properties that would be applied when specific
@@ -68,5 +69,7 @@ extern unsigned long tcg_tb_size;
 void configure_accelerator(MachineState *ms);
 /* Register accelerator specific global properties */
 void accel_register_compat_props(AccelState *accel);
+/* Called just before os_setup_post (ie just before drop OS privs) */
+void accel_setup_post(MachineState *ms);
 
 #endif
diff --git a/vl.c b/vl.c
index fce1fd1..36c5bd4 100644
--- a/vl.c
+++ b/vl.c
@@ -4729,6 +4729,7 @@ int main(int argc, char **argv, char **envp)
         vm_start();
     }
 
+    accel_setup_post(current_machine);
     os_setup_post();
 
     main_loop();
-- 
2.1.4
