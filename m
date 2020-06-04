Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD29C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46937206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MceMJLPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46937206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgneF-0008Nl-JU
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgnZB-0005f3-9C
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:57:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgnZ9-00039N-Fe
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591268261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1zPM2PKgSEf9ui2KnXlcervnxLv540QvKlbqjUv8V3Q=;
 b=MceMJLPbu19dGKqDNvWbgz8dKzEuyIfN5PzwhsWnX4lNbUFE5dFD7CY/2aR6+xs3B2M/pi
 /o1R5QpJnM1v1SDunkv0Smlyel7NQCgE+8wb1C+nkN4br7hKPxwHFTln0yk/Kz3tS2Ik5j
 Xp/ysgShVg7GwdtbUAQU6rz5dIAbn2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-uiLsLrFMNdqlvAfQfiMuWg-1; Thu, 04 Jun 2020 06:57:37 -0400
X-MC-Unique: uiLsLrFMNdqlvAfQfiMuWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A6F7100726F;
 Thu,  4 Jun 2020 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-200.sin2.redhat.com
 [10.67.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1420610F2;
 Thu,  4 Jun 2020 10:57:26 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3] ati-vga: check address before reading configuration bytes
 (CVE-2020-13791)
Date: Thu,  4 Jun 2020 16:25:24 +0530
Message-Id: <20200604105524.46158-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reading PCI configuration bytes, a guest may send an
address towards the end of the configuration space. It may lead
to an OOB access issue. Add check to ensure 'address + size' is
within PCI configuration space.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Reported-by: Yi Ren <c4tren@gmail.com>
Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/ati.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Update v3: avoid modifying 'addr' variable
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00834.html

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 67604e68de..b4d0fd88b7 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -387,7 +387,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val = s->regs.crtc_pitch;
         break;
     case 0xf00 ... 0xfff:
-        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
+        if ((addr - 0xf00) + size <= pci_config_size(&s->dev)) {
+            val = pci_default_read_config(&s->dev, addr - 0xf00, size);
+        }
         break;
     case CUR_OFFSET:
         val = s->regs.cur_offset;
-- 
2.26.2


