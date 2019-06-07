Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010FFC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FC5208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FC5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJdT-0004Is-Kv
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hZIAo-00046m-Sj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hZIAn-00029r-Jw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:57:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hZIAl-0001r8-LI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74F243091D63
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 16:56:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B393BAA1;
 Fri,  7 Jun 2019 16:56:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 240F817532; Fri,  7 Jun 2019 18:56:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 18:56:50 +0200
Message-Id: <20190607165650.8801-2-kraxel@redhat.com>
In-Reply-To: <20190607165650.8801-1-kraxel@redhat.com>
References: <20190607165650.8801-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 07 Jun 2019 16:56:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/1] usb-mtp: refactor the flow of
 usb_mtp_write_data
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bandan Das <bsd@redhat.com>

There's no functional change but the flow is (hopefully)
more consistent for both file and folder object types.

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-Id: <20190401211712.19012-4-bsd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 57 +++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index d90b336d53f4..f31fc76c01ca 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1599,7 +1599,7 @@ static int usb_mtp_update_object(MTPObject *parent, char *name)
     return ret;
 }
 
-static int usb_mtp_write_data(MTPState *s)
+static void usb_mtp_write_data(MTPState *s, uint32_t handle)
 {
     MTPData *d = s->data_out;
     MTPObject *parent =
@@ -1616,26 +1616,33 @@ static int usb_mtp_write_data(MTPState *s)
         if (!parent || !s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                 0, 0, 0, 0);
-        return 1;
+            return;
         }
 
         if (s->dataset.filename) {
             path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
             if (s->dataset.format == FMT_ASSOCIATION) {
                 ret = mkdir(path, mask);
-                goto free;
+                if (!ret) {
+                    usb_mtp_queue_result(s, RES_OK, d->trans, 3,
+                                         QEMU_STORAGE_ID,
+                                         s->dataset.parent_handle,
+                                         handle);
+                    goto close;
+                }
+                goto done;
             }
+
             d->fd = open(path, O_CREAT | O_WRONLY |
                          O_CLOEXEC | O_NOFOLLOW, mask);
             if (d->fd == -1) {
-                usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                     0, 0, 0, 0);
+                ret = 1;
                 goto done;
             }
 
             /* Return success if initiator sent 0 sized data */
             if (!s->dataset.size) {
-                goto success;
+                goto done;
             }
             if (d->length != MTP_WRITE_BUF_SZ && !d->pending) {
                 d->write_status = WRITE_END;
@@ -1647,13 +1654,12 @@ static int usb_mtp_write_data(MTPState *s)
         rc = write_retry(d->fd, d->data, d->data_offset,
                          d->offset - d->data_offset);
         if (rc != d->data_offset) {
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
+            ret = 1;
             goto done;
         }
         if (d->write_status != WRITE_END) {
             g_free(path);
-            return ret;
+            return;
         } else {
             /*
              * Return an incomplete transfer if file size doesn't match
@@ -1665,16 +1671,20 @@ static int usb_mtp_write_data(MTPState *s)
                 usb_mtp_update_object(parent, s->dataset.filename)) {
                 usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
                                      0, 0, 0, 0);
-                goto done;
+                goto close;
             }
         }
     }
 
-success:
-    usb_mtp_queue_result(s, RES_OK, d->trans,
-                         0, 0, 0, 0);
-
 done:
+    if (ret) {
+        usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                             0, 0, 0, 0);
+    } else {
+        usb_mtp_queue_result(s, RES_OK, d->trans,
+                             0, 0, 0, 0);
+    }
+close:
     /*
      * The write dataset is kept around and freed only
      * on success or if another write request comes in
@@ -1683,12 +1693,10 @@ done:
         close(d->fd);
         d->fd = -1;
     }
-free:
     g_free(s->dataset.filename);
     s->dataset.size = 0;
     g_free(path);
     s->write_pending = false;
-    return ret;
 }
 
 static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
@@ -1732,16 +1740,11 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
     s->write_pending = true;
 
     if (s->dataset.format == FMT_ASSOCIATION) {
-        if (usb_mtp_write_data(s)) {
-            /* next_handle will be allocated to the newly created dir */
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
-            return;
-        }
+        usb_mtp_write_data(s, next_handle);
+    } else {
+        usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
+                             s->dataset.parent_handle, next_handle);
     }
-
-    usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
-                         s->dataset.parent_handle, next_handle);
 }
 
 static void usb_mtp_get_data(MTPState *s, mtp_container *container,
@@ -1821,14 +1824,14 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
             } else {
                 d->write_status = WRITE_START;
             }
-            usb_mtp_write_data(s);
+            usb_mtp_write_data(s, 0);
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
             return;
         }
         if (d->data_offset == d->length) {
             d->pending = true;
-            usb_mtp_write_data(s);
+            usb_mtp_write_data(s, 0);
         }
         break;
     default:
-- 
2.18.1


