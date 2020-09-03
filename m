Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE49F20767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mi9OEDr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn5B-0005Kp-Vl
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDn47-0003gz-Qz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:06:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDn45-0005Xi-Og
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjiAEK31J/u5zRUhQGGvKGZ9FU4hoyVjLvqwM89fyIg=;
 b=Mi9OEDr+wb6hagyJmAJoGLbeKFh8o7OwteDQf2DWIErrfYwb/+8Hf56atjhJqBv942vk7U
 Q2sUwuDdpVUvlIDCN+1Ww6ei3DnmD9BBvOZm0rQlMycM7M2EadiHEsR7L2cN+G07dvjA32
 1xSqqFRai6061vClnxaPEEFuv9k2HX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-Tj7sxe3XOh-kNLo4i67wgA-1; Thu, 03 Sep 2020 07:05:57 -0400
X-MC-Unique: Tj7sxe3XOh-kNLo4i67wgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8B5A85C732;
 Thu,  3 Sep 2020 11:05:55 +0000 (UTC)
Received: from kaapi (ovpn-113-31.rdu2.redhat.com [10.10.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C01AC7E313;
 Thu,  3 Sep 2020 11:05:52 +0000 (UTC)
Date: Thu, 3 Sep 2020 16:35:49 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/ide: check null block pointer before blk_drain
In-Reply-To: <CAAdtpL6o7_Cvnui+dsaobNaY93Noj7fcLWYx37mEGd3kTBv56Q@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2009031631370.2047119@xnncv>
References: <20200827114428.1850912-1-ppandit@redhat.com>
 <CAAdtpL6o7_Cvnui+dsaobNaY93Noj7fcLWYx37mEGd3kTBv56Q@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-2011053036-1599131155=:2047119"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-2011053036-1599131155=:2047119
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

+-- On Mon, 31 Aug 2020, Philippe Mathieu-Daudé wrote --+
| > +++ b/hw/ide/core.c
| > @@ -718,7 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
| > -    if (s->bus->dma->aiocb) {
| > +    if (s->blk && s->bus->dma->aiocb) {
| 
| But s->blk mustn't be null here... IMHO we should assert() here and add a
| check earlier.

===
diff --git a/hw/ide/core.c b/hw/ide/core.c
index f76f7e5234..8105187f49 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -718,6 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
      * whole DMA operation will be submitted to disk with a single
      * aio operation with preadv/pwritev.
      */
+    assert(s->blk);
     if (s->bus->dma->aiocb) {
         trace_ide_cancel_dma_sync_remaining();
         blk_drain(s->blk);
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index b50091b615..51bb9c9abc 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -295,8 +295,11 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
     /* Ignore writes to SSBM if it keeps the old value */
     if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
         if (!(val & BM_CMD_START)) {
-            ide_cancel_dma_sync(idebus_active_if(bm->bus));
-            bm->status &= ~BM_STATUS_DMAING;
+            IDEState *s = idebus_active_if(bm->bus);
+            if (s->blk) {
+                ide_cancel_dma_sync(s);
+                bm->status &= ~BM_STATUS_DMAING;
+            }
         } else {
             bm->cur_addr = bm->addr;
             if (!(bm->status & BM_STATUS_DMAING)) {
===


Does it look okay?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-2011053036-1599131155=:2047119--


