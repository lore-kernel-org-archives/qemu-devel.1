Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D942CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52C52073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZU9cwO/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52C52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFVX-00051h-Pc
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jqFPx-0005DX-70
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:31:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jqFPv-0003jj-1L
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593520274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13ky1xAMDjm6BC9UbyOcoOYlgcqcL/dz1aVe9makXSo=;
 b=ZU9cwO/FwmYD87WHojJHvWajH/+ZD5yxhxbPQsMYEQLslA+RrxZoiZj6S5DahK4j6BJuD/
 dY9H8LcRebrMddSp3whQPcaM2cTYETjFF5h2EwcwDEQ43UVo5t2E8I6Ggv++B/t09F3luG
 MGzKyTCqA0Rc+ogEYQV7q1DjqQImPEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-ddGoxLvNP4KRGGAd1ynbaA-1; Tue, 30 Jun 2020 08:30:59 -0400
X-MC-Unique: ddGoxLvNP4KRGGAd1ynbaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E077E107ACCA;
 Tue, 30 Jun 2020 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8553D5C1C5;
 Tue, 30 Jun 2020 12:30:53 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 7/9] tz-ppc: add dummy read/write methods
Date: Tue, 30 Jun 2020 17:57:08 +0530
Message-Id: <20200630122710.1119158-8-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-1-ppandit@redhat.com>
References: <20200630122710.1119158-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
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

Add tz-ppc-dummy mmio read/write methods to avoid assert failure
during initialisation.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/misc/tz-ppc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

Update v3: use g_assert_not_reached()
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09451.html

diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 6431257b52..36495c68e7 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -196,7 +196,21 @@ static bool tz_ppc_dummy_accepts(void *opaque, hwaddr addr,
     g_assert_not_reached();
 }
 
+static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigned size)
+{
+    g_assert_not_reached();
+}
+
+static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
+                                        uint64_t data, unsigned size)
+{
+    g_assert_not_reached();
+}
+
 static const MemoryRegionOps tz_ppc_dummy_ops = {
+    /* define r/w methods to avoid assert failure in memory_region_init_io */
+    .read = tz_ppc_dummy_read,
+    .write = tz_ppc_dummy_write,
     .valid.accepts = tz_ppc_dummy_accepts,
 };
 
-- 
2.26.2


