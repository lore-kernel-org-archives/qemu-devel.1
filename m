Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EBDC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB9C2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZubSaLDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB9C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTIIY-0001OD-T1
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTIET-0006bU-Vs
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTIER-0002Yf-5u
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602825886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUtfh1pV9AgOvU32xZbNDmGEjWY9r+mwPr+Y3A74t4M=;
 b=ZubSaLDnzQl7pPQQw2ySzX5EeKo5tM5Ob7Phr8e2xykH74QI1zg6Z3MJee9qXBtEAWs9v4
 4WN1F9sq4gv1O2tqNDfjJ1qyBdzWEbJbwzdcM4fTCPHeoR7AH/3sSkkBriGquT0YfgrZrp
 4mq946IC0G3dhWSDkX/svYzX4ETpymA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-6_XEUnjMPUyw1Y0bOCL4Pw-1; Fri, 16 Oct 2020 01:24:41 -0400
X-MC-Unique: 6_XEUnjMPUyw1Y0bOCL4Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4352D8015A6;
 Fri, 16 Oct 2020 05:24:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9D65D9DD;
 Fri, 16 Oct 2020 05:24:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 169219D8F; Fri, 16 Oct 2020 07:24:36 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] hw/usb/hcd-dwc2: fix divide-by-zero in dwc2_handle_packet()
Date: Fri, 16 Oct 2020 07:24:35 +0200
Message-Id: <20201016052435.26180-4-kraxel@redhat.com>
In-Reply-To: <20201016052435.26180-1-kraxel@redhat.com>
References: <20201016052435.26180-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 01:24:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Gaoning Pan <gaoning.pgn@antgroup.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Xingwei Lin <linyi.lxw@antfin.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mauro Matteo Cascella <mcascell@redhat.com>

Check the value of mps to avoid potential divide-by-zero later in the function.
Since HCCHAR_MPS is guest controllable, this prevents a malicious/buggy guest
from crashing the QEMU process on the host.

Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>
Reported-by: Gaoning Pan <gaoning.pgn@antgroup.com>
Reported-by: Xingwei Lin <linyi.lxw@antfin.com>
Message-id: 20201015075957.268823-1-mcascell@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-dwc2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 64c23c1ed084..e1d96acf7ecf 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -250,6 +250,12 @@ static void dwc2_handle_packet(DWC2State *s, uint32_t devadr, USBDevice *dev,
     trace_usb_dwc2_handle_packet(chan, dev, &p->packet, epnum, types[eptype],
                                  dirs[epdir], mps, len, pcnt);
 
+    if (mps == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: Bad HCCHAR_MPS set to zero\n", __func__);
+        return;
+    }
+
     if (eptype == USB_ENDPOINT_XFER_CONTROL && pid == TSIZ_SC_MC_PID_SETUP) {
         pid = USB_TOKEN_SETUP;
     } else {
-- 
2.27.0


