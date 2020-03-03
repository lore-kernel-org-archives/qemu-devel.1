Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDC4214DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8pxvTY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDC4214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94bF-0002e8-AJ
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94W6-0007i3-Un
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94W5-0006C0-V5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60857
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94W5-0006Bd-S9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cb4ZfAWCO9mcSOBb5FJvhksNequRo3224EqHsve4XNM=;
 b=Y8pxvTY4qg2ONQ8vv0hBuZni7ygQvbxkgG1hxW37B0nWVAqGI31JF2V2iBkJDF+JmkVm2R
 PJctwvA6P9ZF0lBwyosa6Cydahqqa+gaJ0PRpLfGheL7M/ydC/M6Z5Q8JR7IwVprezpW2/
 opqSF2URcwzTO36ghp4dH21QHQvCC4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-bWjba_BQMc-GtTg445_e8w-1; Tue, 03 Mar 2020 05:11:07 -0500
X-MC-Unique: bWjba_BQMc-GtTg445_e8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B36B213E4;
 Tue,  3 Mar 2020 10:11:06 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B37E8D553;
 Tue,  3 Mar 2020 10:11:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 09/23] dp8393x: Use long-word-aligned RRA pointers in 32-bit
 mode
Date: Tue,  3 Mar 2020 18:10:28 +0800
Message-Id: <1583230242-14597-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

Section 3.4.1 of the datasheet says,

    The alignment of the RRA is confined to either word or long word
    boundaries, depending upon the data width mode. In 16-bit mode,
    the RRA must be aligned to a word boundary (A0 is always zero)
    and in 32-bit mode, the RRA is aligned to a long word boundary
    (A0 and A1 are always zero).

This constraint has been implemented for 16-bit mode; implement it
for 32-bit mode too.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 6329341..d8bf248 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -665,12 +665,16 @@ static void dp8393x_write(void *opaque, hwaddr addr, =
uint64_t data,
                 qemu_flush_queued_packets(qemu_get_queue(s->nic));
             }
             break;
-        /* Ignore least significant bit */
+        /* The guest is required to store aligned pointers here */
         case SONIC_RSA:
         case SONIC_REA:
         case SONIC_RRP:
         case SONIC_RWP:
-            s->regs[reg] =3D val & 0xfffe;
+            if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
+                s->regs[reg] =3D val & 0xfffc;
+            } else {
+                s->regs[reg] =3D val & 0xfffe;
+            }
             break;
         /* Invert written value for some registers */
         case SONIC_CRCT:
--=20
2.5.0


