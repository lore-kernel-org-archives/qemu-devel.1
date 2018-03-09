Received: from eggs.gnu.org ([2001:4830:134:3::10]:58197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGpM-00016N-Po
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGpJ-0002dK-IJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:08:48 -0500
Received: from smtp.citrix.com ([66.165.176.89]:34152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGpJ-0002cz-A6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:08:45 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23202.31050.607695.817387@mariner.uk.xensource.com>
Date: Fri, 9 Mar 2018 12:08:42 +0000
In-Reply-To: <23202.30969.590920.764930@mariner.uk.xensource.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520530757-4477-4-git-send-email-ian.jackson@eu.citrix.com>
	<20180308200345.GD3417@localhost.localdomain>
	<23202.28943.344150.512881@mariner.uk.xensource.com>
	<23202.30969.590920.764930@mariner.uk.xensource.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

Ian Jackson writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> How about this ?

And here's the corresponding change to the Xen-specific patch.

>From d6140681a877c4d468c4fcf5cac075cdffbea22c Mon Sep 17 00:00:00 2001
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 9 Mar 2018 12:04:25 +0000
Subject: [PATCH v6.2 13/11] squash! xen: defer call to xen_restrict until just before
 os_setup_post

v7: Use new AccelClass setup_post hook, rather than ad-hoc call
    in vl.c.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 hw/xen/xen-common.c     | 3 ++-
 include/sysemu/sysemu.h | 2 --
 stubs/xen-hvm.c         | 4 ----
 vl.c                    | 1 -
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 8ede246..6ec14c7 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -122,7 +122,7 @@ static void xen_change_state_handler(void *opaque, int running,
     }
 }
 
-void xen_setup_post(void)
+static void xen_setup_post(MachineState *ms, AccelState *accel)
 {
     int rc;
 
@@ -183,6 +183,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "Xen";
     ac->init_machine = xen_init;
+    ac->setup_post = xen_setup_post;
     ac->allowed = &xen_allowed;
     ac->global_props = xen_compat_props;
 }
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 6b785a4..d24ad09 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -92,8 +92,6 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 void qemu_announce_self(void);
 
-void xen_setup_post(void);
-
 extern int autostart;
 
 typedef enum {
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 48ca8da..7787ea2 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -62,7 +62,3 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
 }
-
-void xen_setup_post(void)
-{
-}
diff --git a/vl.c b/vl.c
index 3fd6401..f52a9f4 100644
--- a/vl.c
+++ b/vl.c
@@ -4720,7 +4720,6 @@ int main(int argc, char **argv, char **envp)
     }
 
     accel_setup_post(current_machine);
-    xen_setup_post();
     os_setup_post();
 
     main_loop();
-- 
2.1.4
