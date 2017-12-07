Received: from eggs.gnu.org ([2001:4830:134:3::10]:44948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kV-0005aE-GX
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kU-0001zA-Ag
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:31 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3kU-0001yK-3O
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:30 -0500
Received: by mail-pg0-x241.google.com with SMTP id k15so5361440pgr.7
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:30:30 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:30:11 -0600
Message-Id: <1512682213-4354-7-git-send-email-minyard@acm.org>
In-Reply-To: <1512682213-4354-1-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 6/8] vl.c: disallow command line fw cfg without
 opt/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

Allowing arbitary file names on command line is setting us up for
failure: future guests will look for a specific QEMU-specified name and
will get confused finding a user file there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[Change "warning" to "error" in the error report.]
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 1ad1c04..fae9300 100644
--- a/vl.c
+++ b/vl.c
@@ -2400,8 +2400,9 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         return -1;
     }
     if (strncmp(name, "opt/", 4) != 0) {
-        warn_report("externally provided fw_cfg item names "
-                    "should be prefixed with \"opt/\"");
+        error_report("error: externally provided fw_cfg item names "
+                     "should be prefixed with \"opt/\"");
+        return -1;
     }
     if (nonempty_str(str)) {
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
-- 
2.7.4
