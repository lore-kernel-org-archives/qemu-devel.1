Received: from eggs.gnu.org ([2001:4830:134:3::10]:57993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGoK-0000X8-Fp
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGoH-0002JP-8A
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:07:44 -0500
Received: from smtp.citrix.com ([66.165.176.89]:11756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGoH-0002HP-0z
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:07:41 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23202.30969.590920.764930@mariner.uk.xensource.com>
Date: Fri, 9 Mar 2018 12:07:21 +0000
In-Reply-To: <23202.28943.344150.512881@mariner.uk.xensource.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520530757-4477-4-git-send-email-ian.jackson@eu.citrix.com>
	<20180308200345.GD3417@localhost.localdomain>
	<23202.28943.344150.512881@mariner.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S.
	Tsirkin" <mst@redhat.com>

Ian Jackson writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> Eduardo Habkost writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> > I don't think we should have accelerator-specific code in main(),
> > if we already have accelerator classes that can abstract that
> > out.  I suggest adding a AccelClass;:setup_post() method that can
> > be called here.
> 
> I think I can do that.

How about this ?

>From 61f11221afaa29e10021599420238e03836ba413 Mon Sep 17 00:00:00 2001
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 9 Mar 2018 12:02:50 +0000
Subject: [PATCH v6.2 12/11] AccelClass: Introduce accel_setup_post

This is called just before os_setup_post.  Currently none of the
accelerators provide this hook, but the Xen one is going to provide
one in a moment.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
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
index e6e8e1e..3fd6401 100644
--- a/vl.c
+++ b/vl.c
@@ -4719,6 +4719,7 @@ int main(int argc, char **argv, char **envp)
         vm_start();
     }
 
+    accel_setup_post(current_machine);
     xen_setup_post();
     os_setup_post();
 
-- 
2.1.4
