Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2897C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D901E20715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcGmikML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D901E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafhQ-0002La-Qz
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafW1-0003yH-AH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafVz-0004Cy-6m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80TCQjbrNZc8Tey16FVCT4I0xjHk1IwJPsVUBnQHORE=;
 b=WcGmikMLf4kiku4eROMWCERLWV9wSSaiYzbdnwoLARwEYis1bCSwTIYQE4aE2fiQpTvTpB
 NSed5dqfyuIGWkRR42IPzHM1QPPST+9cnbRUoVrfsmh3bKJwTafdhYbAKlb7ySyODVEWzS
 7DhTm9iPiUsV66fMrX+Z3BPifDnYH58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-6_mOLDQ0OGGA8mofjr6U0A-1; Thu, 05 Nov 2020 08:41:17 -0500
X-MC-Unique: 6_mOLDQ0OGGA8mofjr6U0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3AEE87951B
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 13:41:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BBE473679;
 Thu,  5 Nov 2020 13:41:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B98239AE2; Thu,  5 Nov 2020 14:41:12 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] usb-storage: fill csw on cancel
Date: Thu,  5 Nov 2020 14:41:10 +0100
Message-Id: <20201105134112.25119-5-kraxel@redhat.com>
In-Reply-To: <20201105134112.25119-1-kraxel@redhat.com>
References: <20201105134112.25119-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When scsi requests are canceled fill the csw
(command status word) accordingly.

Buglink: https://bugs.launchpad.net/qemu/+bug/1901981
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-storage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 360e8ca8f2bd..f0f005869d25 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -327,6 +327,10 @@ static void usb_msd_request_cancelled(SCSIRequest *req)
     trace_usb_msd_cmd_cancel(req->tag);
 
     if (req == s->req) {
+        s->csw.sig = cpu_to_le32(0x53425355);
+        s->csw.tag = cpu_to_le32(req->tag);
+        s->csw.status = 1; /* error */
+
         scsi_req_unref(s->req);
         s->req = NULL;
         s->scsi_len = 0;
-- 
2.27.0


