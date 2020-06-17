Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9E2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5597A2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd7yh5HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5597A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlQu0-0007VA-Vv
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jlQq8-0001RS-EJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:42:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jlQq6-0002xd-U5
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592372541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9Uf99ruqFduJMxH6Qvqbix/JbNg2q9u7s/EVuRNmos=;
 b=Vd7yh5HD2IPJRNw9BqRMzamLGERDcJZh4tbLMFEEc4kUh+pWpDpUMCNZexuvZp/Th30kbq
 BNoU4JVsxX8BGwp+iXE+Ov9Yx8J24TfmPnM+2vWRkFehi9JNU+87+W1ZG95qybOpXgaXG0
 vnzk0PYKvKpPPem8WscyXg8s3jnZsQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-QgV_EMCnPGiuoCxItA3wPw-1; Wed, 17 Jun 2020 01:42:19 -0400
X-MC-Unique: QgV_EMCnPGiuoCxItA3wPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA7001883620;
 Wed, 17 Jun 2020 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-83.bne.redhat.com [10.64.54.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B77F19D7B;
 Wed, 17 Jun 2020 05:42:11 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/6] vfio: add quirk device write method
Date: Wed, 17 Jun 2020 11:09:30 +0530
Message-Id: <20200617053934.122642-4-ppandit@redhat.com>
In-Reply-To: <20200617053934.122642-1-ppandit@redhat.com>
References: <20200617053934.122642-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Add vfio quirk device mmio write method to avoid NULL pointer
dereference issue.

Reported-by: Lei Sun <slei.casper@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/vfio/pci-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f2155ddb1d..5bd98885d5 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "exec/memop.h"
 #include "qemu/units.h"
+#include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -263,8 +264,15 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque,
     return data;
 }
 
+static void vfio_ati_3c3_quirk_write(void *opaque, hwaddr addr,
+                                        uint64_t data, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
+}
+
 static const MemoryRegionOps vfio_ati_3c3_quirk = {
     .read = vfio_ati_3c3_quirk_read,
+    .write = vfio_ati_3c3_quirk_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
2.26.2


