Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA07BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34632067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYJ7oTAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34632067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqB7i-0004La-VK
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 03:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqB74-0003on-Qx
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:55:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqB71-0000HB-Pb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593503726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=QhpHK0hz/1qqZ+0A9UexLkg2JaOeD1v6ot/WkgFYu+0=;
 b=cYJ7oTAKNIOLLhF8xakyxwI8V3HZ4WaIxS/eu9UVtZqwtAlmgsxMqsx7jTj9IF/e00joIX
 VbfV1kcX35amS3bxBOA7hTLbwxMu6+ctEPAQaLXNgtu5gCCFyv1BVOZjwTDpBufMEKEYiB
 XgUYjYmNeIlZcTMLu2LhGXO8oqefGGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-ai_9jPmSPdyjPqqqMmKtcQ-1; Tue, 30 Jun 2020 03:55:24 -0400
X-MC-Unique: ai_9jPmSPdyjPqqqMmKtcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3CD7193F565;
 Tue, 30 Jun 2020 07:55:23 +0000 (UTC)
Received: from thuth.com (ovpn-112-46.ams2.redhat.com [10.36.112.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6347166E;
 Tue, 30 Jun 2020 07:55:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/can: Add missing fallthrough statements
Date: Tue, 30 Jun 2020 09:55:20 +0200
Message-Id: <20200630075520.29825-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add fallthrough annotations to be able to compile the code without
warnings when using -Wimplicit-fallthrough in our CFLAGS. Looking
at the code, it seems like the fallthrough is indeed intended here,
so the comments should be appropriate.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/can/can_sja1000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index ea915a023a..299932998a 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -523,6 +523,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
             break;
         case 16: /* RX frame information addr16-28. */
             s->status_pel |= (1 << 5); /* Set transmit status. */
+            /* fallthrough */
         case 17 ... 28:
             if (s->mode & 0x01) { /* Reset mode */
                 if (addr < 24) {
@@ -620,6 +621,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
             break;
         case 10:
             s->status_bas |= (1 << 5); /* Set transmit status. */
+            /* fallthrough */
         case 11 ... 19:
             if ((s->control & 0x01) == 0) { /* Operation mode */
                 s->tx_buff[addr - 10] = val; /* Store to TX buffer directly. */
-- 
2.18.1


