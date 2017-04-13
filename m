Received: from eggs.gnu.org ([2001:4830:134:3::10]:37578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylRT-0003M3-Qo
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylRT-0002Km-2l
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:34:11 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 22:33:59 +0200
Message-Id: <20170413203401.3213-2-mreitz@redhat.com>
In-Reply-To: <20170413203401.3213-1-mreitz@redhat.com>
References: <20170413203401.3213-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/3] qemu-img/convert: Always set ret
 < 0 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

Otherwise the qemu-img process will exit with EXIT_SUCCESS instead of
EXIT_FAILURE.

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 37c2894678..f2809e1ab4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2069,6 +2069,7 @@ static int img_convert(int argc, char **argv)
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
             if (!opts) {
+                ret = -1;
                 goto fail_getopt;
             }
             break;
@@ -2081,6 +2082,7 @@ static int img_convert(int argc, char **argv)
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
                           NULL, NULL)) {
+        ret = -1;
         goto fail_getopt;
     }
 
-- 
2.12.2
