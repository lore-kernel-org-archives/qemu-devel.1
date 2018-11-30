Received: from eggs.gnu.org ([2001:4830:134:3::10]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSgil-00057n-4T
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSgih-0006mB-3O
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:12:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gSgig-0006ls-U3
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:12:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27ABE3002883
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:12:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 30 Nov 2018 12:12:22 +0100
Message-Id: <20181130111222.25386-3-kraxel@redhat.com>
In-Reply-To: <20181130111222.25386-1-kraxel@redhat.com>
References: <20181130111222.25386-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 2/2] usb-mtp: outlaw slashes in
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Slash is unix directory separator, so they are not allowed in filenames.
Note this also stops the classic escape via "../".

Fixes: CVE-2018-16867
Reported-by: Michael Hanselmann (hansmi.ch)
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index fbe1ace035..87eeac1084 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1718,6 +1718,12 @@ static void usb_mtp_write_metadata(MTPState *s)
 
     filename = utf16_to_str(dataset->length, dataset->filename);
 
+    if (strchr(filename, '/')) {
+        usb_mtp_queue_result(s, RES_INVALID_PARAMETER, d->trans,
+                             0, 0, 0, 0);
+        return;
+    }
+
     o = usb_mtp_object_lookup_name(p, filename, dataset->length);
     if (o != NULL) {
         next_handle = o->handle;
-- 
2.9.3
