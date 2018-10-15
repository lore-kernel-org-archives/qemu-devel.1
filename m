Received: from eggs.gnu.org ([2001:4830:134:3::10]:39791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RG-0004K3-Cb
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RD-0002EZ-Ix
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1RD-00028u-84
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE9EF3078ADD
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:53:01 +0200
Message-Id: <20181015115309.17089-28-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 27/35] vnc: Clean up error reporting in
 vnc_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  vnc_init_func() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/vnc.c | 9 +++++----
 vl.c     | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 98e3d3b1d8..fcd2744d52 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4082,13 +4082,14 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     assert(id);
     vnc_display_init(id, &local_err);
     if (local_err) {
-        error_report_err(local_err);
-        exit(1);
+        error_propagate(errp, local_err);
+        return -1;
     }
     vnc_display_open(id, &local_err);
     if (local_err != NULL) {
-        error_reportf_err(local_err, "Failed to start VNC server: ");
-        exit(1);
+        error_propagate_prepend(errp, local_err,
+                                "Failed to start VNC server: ");
+        return -1;
     }
     return 0;
 }
diff --git a/vl.c b/vl.c
index c053117028..8e0006d49c 100644
--- a/vl.c
+++ b/vl.c
@@ -4526,7 +4526,7 @@ int main(int argc, char **argv, char **envp)
     /* init remote displays */
 #ifdef CONFIG_VNC
     qemu_opts_foreach(qemu_find_opts("vnc"),
-                      vnc_init_func, NULL, NULL);
+                      vnc_init_func, NULL, &error_fatal);
 #endif
 
     if (using_spice) {
-- 
2.17.1
