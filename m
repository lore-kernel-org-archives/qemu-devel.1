Received: from eggs.gnu.org ([2001:4830:134:3::10]:60633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Ch0-0002Ht-Va
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgz-0006I4-Qe
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:55 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:53489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgz-0006EO-Cr
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:53 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 19 Apr 2018 17:45:12 +0100
Message-ID: <1524156319-11465-10-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 09/16] os-posix: cleanup: Replace fprintfs with
 error_report in change_process_uid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

I'm going to be editing this function and it makes sense to clean up
this style problem in advance.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
CC: Michael Tokarev <mjt@tls.msk.ru>
---
 os-posix.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index b9c2343..560db95 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -167,20 +167,20 @@ static void change_process_uid(void)
 {
     if (user_pwd) {
         if (setgid(user_pwd->pw_gid) < 0) {
-            fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);
+            error_report("Failed to setgid(%d)", user_pwd->pw_gid);
             exit(1);
         }
         if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
-            fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
-                    user_pwd->pw_name, user_pwd->pw_gid);
+            error_report("Failed to initgroups(\"%s\", %d)",
+                         user_pwd->pw_name, user_pwd->pw_gid);
             exit(1);
         }
         if (setuid(user_pwd->pw_uid) < 0) {
-            fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);
+            error_report("Failed to setuid(%d)", user_pwd->pw_uid);
             exit(1);
         }
         if (setuid(0) != -1) {
-            fprintf(stderr, "Dropping privileges failed\n");
+            error_report("Dropping privileges failed");
             exit(1);
         }
     }
-- 
2.1.4
