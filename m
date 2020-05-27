Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A171C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED251207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yb0OBybW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED251207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpC0-0002C8-2F
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6e-0002cL-NP
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:00:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6b-0004Gc-6e
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590559196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6YgtXDpCWCf9KnSRhU+LICwWG5pFJTKsR57WPE8YO4=;
 b=Yb0OBybWCBSsK2Ta7LtTuLAlMgZqXjfwcP3UNeVcrGQ81fjQy7sXpL+hDj9eIpkbjZweec
 mwBRnIiRwljom/M00iSM/XiuzFFOVMUTsB5ZaumNwuq9RhwiMf0lCZlFNMZJdWOw7D4d0c
 7gXFvEOXtn1CZ6/T/vOkME7epy6PEKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-eEH0X-D4OE60pRaysMOMXQ-1; Wed, 27 May 2020 01:59:51 -0400
X-MC-Unique: eEH0X-D4OE60pRaysMOMXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 710038014D4;
 Wed, 27 May 2020 05:59:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C56279C5C;
 Wed, 27 May 2020 05:59:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4B9E11386A3; Wed, 27 May 2020 07:59:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] xen: Fix and improve handling of device_add usb-host
 errors
Date: Wed, 27 May 2020 07:59:37 +0200
Message-Id: <20200527055945.6774-3-armbru@redhat.com>
In-Reply-To: <20200527055945.6774-1-armbru@redhat.com>
References: <20200527055945.6774-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

usbback_portid_add() leaks the error when qdev_device_add() fails.
Fix that.  While there, use the error to improve the error message.

The qemu_opts_from_qdict() similarly leaks on failure.  But any
failure there is a programming error.  Pass &error_abort.

Fixes: 816ac92ef769f9ffc534e49a1bb6177bddce7aa2
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200505101908.6207-3-armbru@redhat.com>
Acked-by: Paul Durrant <paul@xen.org>
---
 hw/usb/xen-usb.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 961190d0f7..4d266d7bb4 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -30,6 +30,7 @@
 #include "hw/usb.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "monitor/qdev.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 
@@ -755,13 +756,16 @@ static void usbback_portid_add(struct usbback_info *usbif, unsigned port,
     qdict_put_int(qdict, "port", port);
     qdict_put_int(qdict, "hostbus", atoi(busid));
     qdict_put_str(qdict, "hostport", portname);
-    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
-    if (local_err) {
-        goto err;
-    }
+    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
+                                &error_abort);
     usbif->ports[port - 1].dev = USB_DEVICE(qdev_device_add(opts, &local_err));
     if (!usbif->ports[port - 1].dev) {
-        goto err;
+        qobject_unref(qdict);
+        xen_pv_printf(&usbif->xendev, 0,
+                      "device %s could not be opened: %s\n",
+                      busid, error_get_pretty(local_err));
+        error_free(local_err);
+        return;
     }
     qobject_unref(qdict);
     speed = usbif->ports[port - 1].dev->speed;
@@ -793,11 +797,6 @@ static void usbback_portid_add(struct usbback_info *usbif, unsigned port,
     usbback_hotplug_enq(usbif, port);
 
     TR_BUS(&usbif->xendev, "port %d attached\n", port);
-    return;
-
-err:
-    qobject_unref(qdict);
-    xen_pv_printf(&usbif->xendev, 0, "device %s could not be opened\n", busid);
 }
 
 static void usbback_process_port(struct usbback_info *usbif, unsigned port)
-- 
2.21.3


