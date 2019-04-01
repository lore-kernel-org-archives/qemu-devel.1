Received: from eggs.gnu.org ([209.51.188.92]:41839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45e-0002Oo-H3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45d-00045v-A5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45c-0003zc-TO
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1pQA061939
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:21 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s3r4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:21 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:20 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:11 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-98-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 97/97] usb-mtp: use O_NOFOLLOW and O_CLOEXEC.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <ppandit@redhat.com>, Bandan Das <bsd@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Open files and directories with O_NOFOLLOW to avoid symlinks attacks.
While being at it also add O_CLOEXEC.

usb-mtp only handles regular files and directories and ignores
everything else, so users should not see a difference.

Because qemu ignores symlinks, carrying out a successful symlink attack
requires swapping an existing file or directory below rootdir for a
symlink and winning the race against the inotify notification to qemu.

Fixes: CVE-2018-16872
Cc: Prasad J Pandit <ppandit@redhat.com>
Cc: Bandan Das <bsd@redhat.com>
Reported-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael Hanselmann <public@hansmi.ch>
Message-id: 20181213122511.13853-1-kraxel@redhat.com
(cherry picked from commit bab9df35ce73d1c8e19a37e2737717ea1c984dc1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/dev-mtp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 899c8a36ab..f4223fb9de 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -649,13 +649,18 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
 {
     struct dirent *entry;
     DIR *dir;
+    int fd;
 
     if (o->have_children) {
         return;
     }
     o->have_children = true;
 
-    dir = opendir(o->path);
+    fd = open(o->path, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW);
+    if (fd < 0) {
+        return;
+    }
+    dir = fdopendir(fd);
     if (!dir) {
         return;
     }
@@ -1003,7 +1008,7 @@ static MTPData *usb_mtp_get_object(MTPState *s, MTPControl *c,
 
     trace_usb_mtp_op_get_object(s->dev.addr, o->handle, o->path);
 
-    d->fd = open(o->path, O_RDONLY);
+    d->fd = open(o->path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
     if (d->fd == -1) {
         usb_mtp_data_free(d);
         return NULL;
@@ -1027,7 +1032,7 @@ static MTPData *usb_mtp_get_partial_object(MTPState *s, MTPControl *c,
                                         c->argv[1], c->argv[2]);
 
     d = usb_mtp_data_alloc(c);
-    d->fd = open(o->path, O_RDONLY);
+    d->fd = open(o->path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
     if (d->fd == -1) {
         usb_mtp_data_free(d);
         return NULL;
@@ -1608,7 +1613,7 @@ static void usb_mtp_write_data(MTPState *s)
                                  0, 0, 0, 0);
             goto done;
         }
-        d->fd = open(path, O_CREAT | O_WRONLY, mask);
+        d->fd = open(path, O_CREAT | O_WRONLY | O_CLOEXEC | O_NOFOLLOW, mask);
         if (d->fd == -1) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
-- 
2.17.1
