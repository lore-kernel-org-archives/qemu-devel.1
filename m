Received: from eggs.gnu.org ([2001:4830:134:3::10]:60907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001Ax-Dq
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3p-0005in-P3
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3o-0005fC-Hd
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id g33-v6so6430171wrd.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:43 +0200
Message-Id: <1534870966-9287-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/74] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

When running qtests with -nodefaults, we are not interested in
these 'XYZ has no peer' messages.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1534419358-10932-3-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
