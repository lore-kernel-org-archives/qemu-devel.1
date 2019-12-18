Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A62C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453DA2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFMeUIQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453DA2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihd5Q-0005Xe-0z
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihd0Z-00084F-Pd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihd0Y-0001Gt-GV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihd0X-0001D6-V8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576689669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDnsYuHXcA5F8gE2N73wPFpPTrE4itMcCBaT7un2uo4=;
 b=HFMeUIQOFxor/XWBjAxueHBJQ0ybS4oDD/mz7RHhMlnfmWv87ngV5e5F2pQV6wULymIXFS
 43SQeMGlxC7e+yEjt/tvu+Ozd1oTCRxHXs8yZR9DkpXFGOacFkTbfYs6yPCy3okhR8Tr2e
 s+vGlLy0hBBxAhgKvq6WUR+iXRWh1f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-BtuITw_uP1CcHTYkWpaBgQ-1; Wed, 18 Dec 2019 12:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B16218543A1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 17:21:07 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64FD11000322;
 Wed, 18 Dec 2019 17:21:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 06/14] ccid-card-passthru: Explicit we ignore
 QEMUChrEvent in IOEventHandler
Date: Wed, 18 Dec 2019 18:20:01 +0100
Message-Id: <20191218172009.8868-7-philmd@redhat.com>
In-Reply-To: <20191218172009.8868-1-philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BtuITw_uP1CcHTYkWpaBgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit all the events ignored by this frontend, to silent the
following GCC warning:

  hw/usb/ccid-card-passthru.c: In function =E2=80=98ccid_card_vscard_event=
=E2=80=99:
  hw/usb/ccid-card-passthru.c:314:5: error: enumeration value =E2=80=98CHR_=
EVENT_MUX_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
    314 |     switch (event) {
        |     ^~~~~~
  hw/usb/ccid-card-passthru.c:314:5: error: enumeration value =E2=80=98CHR_=
EVENT_MUX_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
  hw/usb/ccid-card-passthru.c:314:5: error: enumeration value =E2=80=98CHR_=
EVENT_CLOSED=E2=80=99 not handled in switch [-Werror=3Dswitch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Add all missing enums

Cc: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 267ed9a8a0..e53696c07a 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -318,6 +318,11 @@ static void ccid_card_vscard_event(void *opaque, int e=
vent)
     case CHR_EVENT_OPENED:
         DPRINTF(card, D_INFO, "%s: CHR_EVENT_OPENED\n", __func__);
         break;
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_CLOSED:
+        /* Ignore */
+        break;
     }
 }
=20
--=20
2.21.0


