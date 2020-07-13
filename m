Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41479C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C24F2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG38H0Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C24F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzDO-0001G1-8G
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAb-0004bw-1L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAY-0006ZP-Oi
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594649456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlJIwCwQW1W3rAyO+86ewr2+LfAHR18BgiVMnndpaQo=;
 b=ZG38H0Sabu/f1kLGWTENIS6j4PiBZD2DQogOchFCn944am7LARIeSpbSnTDe21Mslih8VS
 UrWtKQUhQ8xullGRKZogbPZd+myXZjawcA9w2yJRdC4sz+clxDoIvQg9G57buNQXg9new6
 1sbgXGIPRNBJvgRyxmAiBx3pVNCwI7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-X8gs0IhONUa5oiVYaEZ79g-1; Mon, 13 Jul 2020 10:10:55 -0400
X-MC-Unique: X8gs0IhONUa5oiVYaEZ79g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 300911009441
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:10:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 095681000235;
 Mon, 13 Jul 2020 14:10:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3AF643F131; Mon, 13 Jul 2020 16:10:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] usb: fix usb-host build on windows.
Date: Mon, 13 Jul 2020 16:10:49 +0200
Message-Id: <20200713141049.2241-5-kraxel@redhat.com>
In-Reply-To: <20200713141049.2241-1-kraxel@redhat.com>
References: <20200713141049.2241-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems the new API is not available on windows.
Update #ifdefs accordingly.

Fixes: 9f815e83e983 ("usb: add hostdevice property to usb-host")
Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Message-id: 20200624134510.9381-1-kraxel@redhat.com
---
 hw/usb/host-libusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index ad7ed8fb0c67..c474551d8456 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -907,7 +907,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
             goto fail;
         }
     } else {
-#if LIBUSB_API_VERSION >= 0x01000107
+#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
         trace_usb_host_open_hostfd(hostfd);
 
         rc = libusb_wrap_sys_device(ctx, hostfd, &s->dh);
@@ -1107,7 +1107,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
     QTAILQ_INIT(&s->isorings);
     s->hostfd = -1;
 
-#if LIBUSB_API_VERSION >= 0x01000107
+#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
     if (s->hostdevice) {
         int fd;
         s->needs_autoscan = false;
-- 
2.18.4


