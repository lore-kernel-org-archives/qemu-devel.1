Received: from eggs.gnu.org ([2001:4830:134:3::10]:44505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEzAj-0001L1-VP
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEzAi-0006rm-U0
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:55:41 -0500
Date: Thu, 8 Dec 2016 13:55:27 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161208135527.GH26641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 08, 2016 at 02:23:05PM +0100, Kevin Wolf wrote:
> This adds blockdev-add support to the iscsi block driver.
> 
> Note that this is only compile tested at this point. Jeff is going to
> take over from here and bring the series to a mergable state.
> 
> Kevin Wolf (6):
>   iscsi: Split URL into individual options
>   iscsi: Handle -iscsi user/password in bdrv_parse_filename()
>   iscsi: Add initiator-name option
>   iscsi: Add header-digest option
>   iscsi: Add timeout option
>   iscsi: Add blockdev-add support
> 
>  block/iscsi.c        | 342 ++++++++++++++++++++++++++++++---------------------
>  qapi/block-core.json |  74 ++++++++++-
>  2 files changed, 272 insertions(+), 144 deletions(-)

This series works as well as my series does, once you apply this fix
for the crash bug I mention:

diff --git a/block/iscsi.c b/block/iscsi.c
index 6a11cdd..320e56a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1524,7 +1524,7 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
 {
     QemuOptsList *list;
     QemuOpts *opts;
-    const char *user, *initiator_name, *header_digest, *timeout;
+    const char *user, *initiator_name, *header_digest, *timeout, *password, *password_secret;
 
     list = qemu_find_opts("iscsi");
     if (!list) {
@@ -1542,10 +1542,14 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
     user = qemu_opt_get(opts, "user");
     if (user) {
         qdict_set_default_str(options, "user", user);
-        qdict_set_default_str(options, "password",
-                              qemu_opt_get(opts, "password"));
-        qdict_set_default_str(options, "password-secret",
-                              qemu_opt_get(opts, "password-secret"));
+    }
+    password = qemu_opt_get(opts, "password");
+    if (password) {
+        qdict_set_default_str(options, "password", password);
+    }
+    password_secret = qemu_opt_get(opts, "password-secret");
+    if (password_secret) {
+        qdict_set_default_str(options, "password-secret", password_secret);
     }
 
     initiator_name = qemu_opt_get(opts, "initiator-name");


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
