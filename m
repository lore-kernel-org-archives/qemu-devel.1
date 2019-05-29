Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E935C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1633621019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1633621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVs6K-0001SC-2g
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:30:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVs4m-0000aH-8E
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVs4l-0004e1-2l
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVs4k-0004dQ-An
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B0D33082E25;
	Wed, 29 May 2019 06:28:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C60071972C;
	Wed, 29 May 2019 06:28:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 10B3B17472; Wed, 29 May 2019 08:28:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 08:28:25 +0200
Message-Id: <20190529062832.26483-3-kraxel@redhat.com>
In-Reply-To: <20190529062832.26483-1-kraxel@redhat.com>
References: <20190529062832.26483-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 29 May 2019 06:28:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/9] usb-host: skip reset for untouched devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the guest didn't talk to the device yet, skip the reset.
Without this usb-host devices get resetted a number of times
at boot time for no good reason.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190522094702.17619-3-kraxel@redhat.com
---
 hw/usb/host-libusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 67b7465915f5..4e9a45a5d26f 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1459,6 +1459,9 @@ static void usb_host_handle_reset(USBDevice *udev)
     if (!s->allow_guest_reset) {
         return;
     }
+    if (udev->addr == 0) {
+        return;
+    }
 
     trace_usb_host_reset(s->bus_num, s->addr);
 
-- 
2.18.1


