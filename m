Received: from eggs.gnu.org ([2001:4830:134:3::10]:41339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNf-0005AW-0m
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNa-0005nA-GU
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNa-0005iV-4b
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00CC2C0B2033
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C39272010D99
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:14 +0200
Message-Id: <20181008173125.19678-21-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 20/31] vl: Clean up error reporting in
 machine_set_property()
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
is suspicious.  machine_set_property() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/vl.c b/vl.c
index ecb70f87d8..3adc9dbe4f 100644
--- a/vl.c
+++ b/vl.c
@@ -2676,7 +2676,7 @@ static int machine_set_property(void *opaque,
     g_free(qom_name);
 
     if (local_err) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         return -1;
     }
 
@@ -4201,11 +4201,8 @@ int main(int argc, char **argv, char **envp)
     }
 
     machine_opts = qemu_get_machine_opts();
-    if (qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
-                         NULL)) {
-        object_unref(OBJECT(current_machine));
-        exit(1);
-    }
+    qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
+                     &error_fatal);
 
     configure_accelerator(current_machine);
 
-- 
2.17.1
