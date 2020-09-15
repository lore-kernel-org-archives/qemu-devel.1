Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B2C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8365206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnEHAFTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8365206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIFh7-0003Wy-UR
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIFe7-00012N-Ig
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 14:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIFe5-0004Je-AB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 14:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600194335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbW5dAGjykzIBhl5ukmXUfXgvbqIXU0mt8/3b/qic5I=;
 b=cnEHAFTS7fk7rOAjSwhT3zpI52361eNh1xe6ZDntig7lCPL41xQa0X9CZnVX5GipgCKn/N
 pNJpxdQWSUXce8LdsejlqsFrdHgA9UOselU70t/25Z7slMitJ3XZ3r12+ieHV5yOQR4Jw7
 7HYeikJsx4mN452b2wHxjn2emlWVuqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-ORnHc6ETOnqYMB_DteQPnQ-1; Tue, 15 Sep 2020 14:25:32 -0400
X-MC-Unique: ORnHc6ETOnqYMB_DteQPnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C29689BBA9;
 Tue, 15 Sep 2020 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-229.sin2.redhat.com
 [10.67.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8538060CD0;
 Tue, 15 Sep 2020 18:25:10 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/2] hw: usb: hcd-ohci: check for processed TD before retire
Date: Tue, 15 Sep 2020 23:52:59 +0530
Message-Id: <20200915182259.68522-3-ppandit@redhat.com>
In-Reply-To: <20200915182259.68522-1-ppandit@redhat.com>
References: <20200915182259.68522-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Ren <yunye.ry@alibaba-inc.com>,
 Yongkang Jia <j_kangel@163.com>, Gaoning Pan <pgn@zju.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While servicing OHCI transfer descriptors(TD), ohci_service_iso_td
retires a TD if it has passed its time frame. It does not check if
the TD was already processed once and holds an error code in TD_CC.
It may happen if the TD list has a loop. Add check to avoid an
infinite loop condition.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/usb/hcd-ohci.c | 4 ++++
 1 file changed, 4 insertions(+)

Update v2: one patch for loop issue
  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg05145.html

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 9dc59101f9..8b912e95d3 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -691,6 +691,10 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
            the next ISO TD of the same ED */
         trace_usb_ohci_iso_td_relative_frame_number_big(relative_frame_number,
                                                         frame_count);
+        if (OHCI_CC_DATAOVERRUN == OHCI_BM(iso_td.flags, TD_CC)) {
+            /* avoid infinite loop */
+            return 1;
+        }
         OHCI_SET_BM(iso_td.flags, TD_CC, OHCI_CC_DATAOVERRUN);
         ed->head &= ~OHCI_DPTR_MASK;
         ed->head |= (iso_td.next & OHCI_DPTR_MASK);
-- 
2.26.2


