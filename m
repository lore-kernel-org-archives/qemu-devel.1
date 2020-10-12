Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC60C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A762920838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOKgIZT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A762920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzPK-0003nV-PI
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kRzO5-0002o4-Dd
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kRzO1-0003SG-GO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602515111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yt1ZwtxxiBdAmwBQdlo5rlU+bu9ghVvP39xTdU72bBY=;
 b=dOKgIZT/+cGY6gCue4R1xlKjOwu2QbG8Qd+DYWkjmLj79/yrxu8nGh3+Q9SISLHg++9waW
 Z2Bbcu4ZhPnWWxBjO4ovRgVHj45aBiV3RokxokOE6AExZY9HmYkFiIwmP9zdNOOl/4LeKT
 9ZJn6OVOPomQWSvnMSa9mn0RMQM8Q+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-whiQv5YrML2s0euWTQtt0g-1; Mon, 12 Oct 2020 11:05:09 -0400
X-MC-Unique: whiQv5YrML2s0euWTQtt0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41FAAAFD31;
 Mon, 12 Oct 2020 15:04:55 +0000 (UTC)
Received: from f32-work.redhat.com (unknown [10.40.193.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B29CA6E718;
 Mon, 12 Oct 2020 15:04:21 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/usb/hcd-dwc2: fix divide-by-zero in dwc2_handle_packet()
Date: Mon, 12 Oct 2020 17:03:56 +0200
Message-Id: <20201012150356.79670-1-mcascell@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcascell@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: gaoning.pgn@antgroup.com, mcascell@redhat.com, linyi.lxw@antfin.com,
 kraxel@redhat.com, pauldzim@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check the value of mps before it is used as divisor. Since HCCHAR_MPS is guest
controllable, this prevents a malicious/buggy guest from crashing the QEMU
process on the host.

Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Gaoning Pan <gaoning.pgn@antgroup.com>
Reported-by: Xingwei Lin <linyi.lxw@antfin.com>
---
 hw/usb/hcd-dwc2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 97688d21bf..91476fd781 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -324,6 +324,12 @@ babble:
             }
         }
 
+        if (mps == 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: Bad HCCHAR_MPS set to zero\n", __func__);
+            return;
+        }
+
         tpcnt = actual / mps;
         if (actual % mps) {
             tpcnt++;
-- 
2.26.2


