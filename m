Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EA6C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0426E2081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SREKbRHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0426E2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzTY-0007wg-3D
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iqzQp-0004Xv-Nb
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iqzQo-0006ZO-Ic
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iqzQo-0006Yz-FE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyXkf738RR6ynOggZs46AJASE8KQmvr7U42M+84b7kk=;
 b=SREKbRHrhLKh8tI09wur8Pm4tFOSgCs2ZILjj9XYuiejTP4UB74+2d1c43v4A60QZpA8aZ
 Q2T6tKAnOg4/TLrC/iElsfny0lzeGNJaI3iR/pxTysHKq8sRPgZKOoe3+PJAWTjmiynL13
 MtSjYI8QFIP2xvRB795APx+3Wxx8++c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-4S7x8E2vNAalfR8nU05yFw-1; Mon, 13 Jan 2020 08:06:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 810E78024F1;
 Mon, 13 Jan 2020 13:06:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D338E5C21B;
 Mon, 13 Jan 2020 13:06:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 662F531F73; Mon, 13 Jan 2020 14:06:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] xhci: recheck slot status
Date: Mon, 13 Jan 2020 14:06:46 +0100
Message-Id: <20200113130646.30099-6-kraxel@redhat.com>
In-Reply-To: <20200113130646.30099-1-kraxel@redhat.com>
References: <20200113130646.30099-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4S7x8E2vNAalfR8nU05yFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out slot status check into a helper function.  Add an additional
check after completing transfers.  This is needed in case a guest
queues multiple transfers in a row and a device unplug happens while
qemu processes them.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1786413
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200107083606.12393-1-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 0d3d96d05a00..fb05de4b0524 100644
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


