Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDDF20702
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cItlFbG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDDF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joAlg-0007ZY-Hq
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joAdw-0004W4-0C
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:01:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23165
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joAdt-0004jO-ML
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593025265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4loFTY4oY+modSCblVskwyCO4SWjwGRGpQh2kNPT3Dw=;
 b=cItlFbG2hAFBVVNqGk4H+qMa8Ji+dfFY/9l9dAHDoCR3NAWIYBtrOVulNGu64iOTYrIyQa
 NwZuCXz+SGKVvWdW1UTeNDIlvTAv2gbwv0oyFdGj9GTdblGywVl8dASFlUM3QPcm8+xduu
 dUjgnwhGReWOUhY3KRFcHXUaqM/+QLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-CFpL2iGaPEu3_IE4cdb0LQ-1; Wed, 24 Jun 2020 14:58:19 -0400
X-MC-Unique: CFpL2iGaPEu3_IE4cdb0LQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C485F10059B9;
 Wed, 24 Jun 2020 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BAA61DC;
 Wed, 24 Jun 2020 18:58:10 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
Date: Thu, 25 Jun 2020 00:25:19 +0530
Message-Id: <20200624185523.762240-6-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-1-ppandit@redhat.com>
References: <20200624185523.762240-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Add nrf51_soc mmio read method to avoid NULL pointer dereference
issue.

Reported-by: Lei Sun <slei.casper@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/nvram/nrf51_nvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Update v2: return ldl_le_p()
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04972.html

diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index f2283c1a8d..8000ed530a 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -273,6 +273,13 @@ static const MemoryRegionOps io_ops = {
         .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static uint64_t flash_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NRF51NVMState *s = NRF51_NVM(opaque);
+
+    assert(offset + size <= s->flash_size);
+    return ldl_le_p(s->storage + offset);
+}
 
 static void flash_write(void *opaque, hwaddr offset, uint64_t value,
         unsigned int size)
@@ -300,6 +307,7 @@ static void flash_write(void *opaque, hwaddr offset, uint64_t value,
 
 
 static const MemoryRegionOps flash_ops = {
+    .read = flash_read,
     .write = flash_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-- 
2.26.2


