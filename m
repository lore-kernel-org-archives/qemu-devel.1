Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CDAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C9B20756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8Qmr2U7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C9B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahVW-0004h4-A1
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS6-0008D0-Vx
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS1-0005xH-Vu
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589814789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ldHYNRCCIyCjzZACk5BSdTldkMiO0XhPJ88/SX/DWp8=;
 b=b8Qmr2U7jeKwE3tDdD6JE875ypGSKjbvYny5VP62Wta5qoi6svp2646Rzi5+m/r+Gf8GJY
 w+qPmkNQYC34Q3c7ReDuraZOEu4tVBIPJbjQn3dZaGSVtMq7338tulJgqMIcCyMFi7erbL
 Xdt5X/atSrkQaqFOD3m5lUqHQ2SEp/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-pLmnozaoP9ueV0CW8_RSEQ-1; Mon, 18 May 2020 11:13:05 -0400
X-MC-Unique: pLmnozaoP9ueV0CW8_RSEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D707B107ACCD;
 Mon, 18 May 2020 15:13:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37C335C1B2;
 Mon, 18 May 2020 15:12:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8319817477; Mon, 18 May 2020 17:12:55 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] ati-vga: Do not allow unaligned access via index register
Date: Mon, 18 May 2020 17:12:48 +0200
Message-Id: <20200518151255.10785-2-kraxel@redhat.com>
In-Reply-To: <20200518151255.10785-1-kraxel@redhat.com>
References: <20200518151255.10785-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

According to docs bits 1 and 0 of MM_INDEX are hard coded to 0 so
unaligned access via this register should not be possible.
This also fixes problems reported in bug #1878134.

Buglink: https://bugs.launchpad.net/qemu/+bug/1878134
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Acked-by: Alexander Bulekov <alxndr@bu.edu>
Message-id: 20200516132352.39E9374594E@zero.eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 58ec8291d460..065f197678e4 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -511,7 +511,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     }
     switch (addr) {
     case MM_INDEX:
-        s->regs.mm_index = data;
+        s->regs.mm_index = data & ~3;
         break;
     case MM_DATA ... MM_DATA + 3:
         /* indexed access to regs or memory */
-- 
2.18.4


