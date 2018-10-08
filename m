Received: from eggs.gnu.org ([2001:4830:134:3::10]:41251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNd-0005AG-4K
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNY-0005kk-HR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNY-0005in-4d
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6910C7C11
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 856B910021B2
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:17 +0200
Message-Id: <20181008173125.19678-24-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 23/31] vl: Clean up error reporting in
 device_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Calling error_report() in a function that takes an Error ** argument
is suspicious.  device_init_func() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/vl.c b/vl.c
index a3a39ec06b..86eee4c798 100644
--- a/vl.c
+++ b/vl.c
@@ -2222,12 +2222,10 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
 
 static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    Error *err = NULL;
     DeviceState *dev;
 
-    dev = qdev_device_add(opts, &err);
+    dev = qdev_device_add(opts, errp);
     if (!dev) {
-        error_report_err(err);
         return -1;
     }
     object_unref(OBJECT(dev));
@@ -4444,10 +4442,8 @@ int main(int argc, char **argv, char **envp)
 
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
-    if (qemu_opts_foreach(qemu_find_opts("device"),
-                          device_init_func, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("device"),
+                      device_init_func, NULL, &error_fatal);
 
     cpu_synchronize_all_post_init();
 
-- 
2.17.1
