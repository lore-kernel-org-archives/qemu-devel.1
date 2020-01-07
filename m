Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE743C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767E9206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV918qiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767E9206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokaD-0008LC-Dw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iokLW-0007OU-SF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iokLV-0000nz-Cg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:36:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iokLV-0000nk-8b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578386172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H74u4ccpOmFW8WpFlSyJmH42d9MpNKG/rlTz5n+yfOY=;
 b=FV918qiBx0zzSfAbWkU494mxcjOAFLbUUP185PJ/aWTEq/LQatjJSTMso/VftCog1z79Xw
 R0v8TOxNx+MOnBU7xGH+UFFEqjq7QtdMgNgzMHQ34yWizpIxAZVInqmu4smiMku3M5WeOh
 qkiCsqU5AmflzdvRgcd2cuRvZg1KZH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-AEzLKSoDPJCJ_TIPbRSNPA-1; Tue, 07 Jan 2020 03:36:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20DF9801E6C
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 08:36:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9BA60BEC;
 Tue,  7 Jan 2020 08:36:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E0AE11AAA; Tue,  7 Jan 2020 09:36:06 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] xhci: recheck slot status
Date: Tue,  7 Jan 2020 09:36:06 +0100
Message-Id: <20200107083606.12393-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AEzLKSoDPJCJ_TIPbRSNPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out slot status check into a helper function.  Add an additional
check after completing transfers.  This is needed in case a guest
queues multiple transfers in a row and a device unplug happens while
qemu processes them.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1786413
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 80988bb305a1..c198a2d150c9 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1861,6 +1861,13 @@ static void xhci_kick_ep(XHCIState *xhci, unsigned i=
nt slotid,
     xhci_kick_epctx(epctx, streamid);
 }
=20
+static bool xhci_slot_ok(XHCIState *xhci, int slotid)
+{
+    return (xhci->slots[slotid - 1].uport &&
+            xhci->slots[slotid - 1].uport->dev &&
+            xhci->slots[slotid - 1].uport->dev->attached);
+}
+
 static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
 {
     XHCIState *xhci =3D epctx->xhci;
@@ -1878,9 +1885,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, uns=
igned int streamid)
=20
     /* If the device has been detached, but the guest has not noticed this
        yet the 2 above checks will succeed, but we must NOT continue */
-    if (!xhci->slots[epctx->slotid - 1].uport ||
-        !xhci->slots[epctx->slotid - 1].uport->dev ||
-        !xhci->slots[epctx->slotid - 1].uport->dev->attached) {
+    if (!xhci_slot_ok(xhci, epctx->slotid)) {
         return;
     }
=20
@@ -1987,6 +1992,10 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, un=
signed int streamid)
         } else {
             xhci_fire_transfer(xhci, xfer, epctx);
         }
+        if (!xhci_slot_ok(xhci, epctx->slotid)) {
+            /* surprise removal -> stop processing */
+            break;
+        }
         if (xfer->complete) {
             /* update ring dequeue ptr */
             xhci_set_ep_state(xhci, epctx, stctx, epctx->state);
--=20
2.18.1


