Received: from eggs.gnu.org ([2001:4830:134:3::10]:49373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabP-0000uA-Lx
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabN-0005Lj-T6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpabN-0005Lb-Nu
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 14 Aug 2018 16:46:57 +0200
Message-Id: <1534258018-22859-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1534258018-22859-1-git-send-email-thuth@redhat.com>
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

When running qtests with -nodefaults, we are not interested in
these 'XYZ has no peer' messages.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 vl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 16b913f..7055df3 100644
--- a/vl.c
+++ b/vl.c
@@ -4559,11 +4559,10 @@ int main(int argc, char **argv, char **envp)
      * (2) CONFIG_SLIRP not set, in which case the implicit "-net nic"
      * sets up a nic that isn't connected to anything.
      */
-    if (!default_net) {
+    if (!default_net && (!qtest_enabled() || has_defaults)) {
         net_check_clients();
     }
 
-
     if (boot_once) {
         qemu_boot_set(boot_once, &error_fatal);
         qemu_register_reset(restore_boot_order, g_strdup(boot_order));
-- 
1.8.3.1
