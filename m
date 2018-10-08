Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNf-0005Ab-6X
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNa-0005mq-2k
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005iT-Nt
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEF3731F404
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF435D77C
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:13 +0200
Message-Id: <20181008173125.19678-20-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 19/31] vl: Clean up error reporting in
 parse_add_fd()
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
is suspicious.  chardev_init_func() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index b8576f8f10..ecb70f87d8 100644
--- a/vl.c
+++ b/vl.c
@@ -2239,7 +2239,7 @@ static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 
     if (!qemu_chr_new_from_opts(opts, &local_err)) {
         if (local_err) {
-            error_report_err(local_err);
+            error_propagate(errp, local_err);
             return -1;
         }
         exit(0);
@@ -4185,10 +4185,8 @@ int main(int argc, char **argv, char **envp)
                       user_creatable_add_opts_foreach,
                       object_create_initial, &error_fatal);
 
-    if (qemu_opts_foreach(qemu_find_opts("chardev"),
-                          chardev_init_func, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("chardev"),
+                      chardev_init_func, NULL, &error_fatal);
 
 #ifdef CONFIG_VIRTFS
     if (qemu_opts_foreach(qemu_find_opts("fsdev"),
-- 
2.17.1
