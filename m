Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 20:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AE220734
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 20:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh2Kvi6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AE220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgZzn-0008CJ-0q
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 16:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgZwv-0004S2-AM
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 16:25:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53252
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgZwt-0000oo-S9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 16:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591215919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCgG8ISubrM+kJIfJPC1zMNcLWZ+ZYJCZY8lISrvEqE=;
 b=Zh2Kvi6APC3bTaUvvECvmVbUArOoFTHfMPs0aSFndAIimh+HDbiTdf0bViCgmfMDYCJSSc
 MI21pYTxWkiNacDZ3IaOUtFwvcjkIM41A1bMIHTxZX90Rw5Z3qtWSBwMI3BKHSK4Ntk/lQ
 6b5snypHzN6naiC/fKKSU85I6S4766E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-pVUvss3MMKi0Jk4BvytXXw-1; Wed, 03 Jun 2020 16:25:15 -0400
X-MC-Unique: pVUvss3MMKi0Jk4BvytXXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C241864ACA;
 Wed,  3 Jun 2020 20:25:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33B265C3E7;
 Wed,  3 Jun 2020 20:25:05 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 1/2] ait-vga: check address before reading configuration
 bytes
Date: Thu,  4 Jun 2020 01:52:50 +0530
Message-Id: <20200603202251.1199170-2-ppandit@redhat.com>
In-Reply-To: <20200603202251.1199170-1-ppandit@redhat.com>
References: <20200603202251.1199170-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 15:26:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/ati.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Update v2: add check to avoid OOB PCI configuration space access
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html

diff --git a/hw/display/ati.c b/hw/display/ati.c
index bda4a2d816..6671959e5d 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -384,7 +384,10 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val = s->regs.crtc_pitch;
         break;
     case 0xf00 ... 0xfff:
-        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
+        addr = addr - 0xf00;
+        if (addr + size <= 0xff) {
+            val = pci_default_read_config(&s->dev, addr, size);
+        }
         break;
     case CUR_OFFSET:
         val = s->regs.cur_offset;
-- 
2.26.2


