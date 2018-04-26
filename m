Received: from eggs.gnu.org ([2001:4830:134:3::10]:34617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGN-00010Z-Jc
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGM-0003gK-Bn
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:51 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:29395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGM-0003eE-1t
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:50 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 16:56:16 +0100
Message-ID: <1524758187-9351-6-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 05/16] xen: defer call to xen_restrict until
 just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

We need to restrict *all* the control fds that qemu opens.  Looking in
/proc/PID/fd shows there are many; their allocation seems scattered
throughout Xen support code in qemu.

We must postpone the restrict call until roughly the same time as qemu
changes its uid, chroots (if applicable), and so on.

There doesn't seem to be an appropriate hook already.  The RunState
change hook fires at different times depending on exactly what mode
qemu is operating in.

And it appears that no-one but the Xen code wants a hook at this phase
of execution.  So, introduce a bare call to a new function
xen_setup_post, just before os_setup_post.  Also provide the
appropriate stub for when Xen compilation is disabled.

We do the restriction before rather than after os_setup_post, because
xen_restrict may need to open /dev/null, and os_setup_post might have
called chroot.

Currently this does not work with migration, because when running as
the Xen device model qemu needs to signal to the toolstack that it is
ready.  It currently does this using xenstore, and for incoming
migration (but not for ordinary startup) that happens after
os_setup_post.

It is correct that this happens late: we want the incoming migration
stream to be processed by a restricted qemu.  The fix for this will be
to do the startup notification a different way, without using
xenstore.  (QMP is probably a reasonable choice.)

So for now this restriction feature cannot be used in conjunction with
migration.  (Note that this is not a regression in this patch, because
previously the -xen-restrict-domid call was, in fact, simply
ineffective!)  We will revisit this in the Xen 4.11 release cycle.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
CC: Richard Henderson <rth@twiddle.net> (maintainer:X86)
CC: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
CC: Michael S. Tsirkin <mst@redhat.com> (supporter:PC)
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/xen/xen-hvm.c |  8 --------
 hw/xen/xen-common.c   | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f24b7d4..9c3b6b3 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1254,14 +1254,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
 
-    if (xen_domid_restrict) {
-        rc = xen_restrict(xen_domid);
-        if (rc < 0) {
-            error_report("failed to restrict: error %d", errno);
-            goto err;
-        }
-    }
-
     xen_create_ioreq_server(xen_domid, &state->ioservid);
 
     state->exit.notify = xen_exit_notifier;
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 83099dd..454777c 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -117,6 +117,19 @@ static void xen_change_state_handler(void *opaque, int running,
     }
 }
 
+static void xen_setup_post(MachineState *ms, AccelState *accel)
+{
+    int rc;
+
+    if (xen_domid_restrict) {
+        rc = xen_restrict(xen_domid);
+        if (rc < 0) {
+            perror("xen: failed to restrict");
+            exit(1);
+        }
+    }
+}
+
 static int xen_init(MachineState *ms)
 {
     xen_xc = xc_interface_open(0, 0, 0);
@@ -165,6 +178,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "Xen";
     ac->init_machine = xen_init;
+    ac->setup_post = xen_setup_post;
     ac->allowed = &xen_allowed;
     ac->global_props = xen_compat_props;
 }
-- 
2.1.4
