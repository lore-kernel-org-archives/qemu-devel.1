Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257FBC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950A120684
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib59w8L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950A120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAaP-00009j-GB
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIAN7-0000vm-T8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:47:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIAN4-00040V-Ix
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600174060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KjG+0/tj55YxO1E0XUO7+Txkie7Mm/HIXVfH8GnHu7k=;
 b=ib59w8L//AVYvTy3T8c/lTS5tWhzfdfZgShXt6LWBuuYd5D28u1mHZB0d0NHDDPThBvzWu
 JOXKbCRV6E/+snnIgaUznrh/CMbmVx5FHcP7LH7HPVFNAgpxSgxUx0puQe4xDCam7fNN8L
 g3Zowruq1CdyylPjGABsvsRRAiPKLR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-rmwM5Vn7MiW1USqd-GiJlA-1; Tue, 15 Sep 2020 08:47:35 -0400
X-MC-Unique: rmwM5Vn7MiW1USqd-GiJlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA493185A0C0;
 Tue, 15 Sep 2020 12:47:34 +0000 (UTC)
Received: from kaapi (ovpn-116-229.sin2.redhat.com [10.67.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0593075143;
 Tue, 15 Sep 2020 12:47:32 +0000 (UTC)
Date: Tue, 15 Sep 2020 18:17:30 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] fdc: check null block pointer before blk_pwrite
In-Reply-To: <20200827113806.1850687-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2009151817040.10832@xnncv>
References: <20200827113806.1850687-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 27 Aug 2020, P J P wrote --+
| While transferring data via fdctrl_write_data(), check that
| current drive does not have a null block pointer. Avoid
| null pointer dereference.
| 
|  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Ffdc_nullptr1
|     ==1658854==Hint: address points to the zero page.
|     #0 blk_inc_in_flight block/block-backend.c:1327
|     #1 blk_prw block/block-backend.c:1299
|     #2 blk_pwrite block/block-backend.c:1464
|     #3 fdctrl_write_data hw/block/fdc.c:2418
|     #4 fdctrl_write hw/block/fdc.c:962
|     #5 portio_write ioport.c:205
|     #6 memory_region_write_accessor memory.c:483
|     #7 access_with_adjusted_size memory.c:544
|     #8 memory_region_dispatch_write memory.c:1476
| 
| Reported-by: Ruhr-University <bugs-syssec@rub.de>
| Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| ---
|  hw/block/fdc.c | 3 ++-
|  1 file changed, 2 insertions(+), 1 deletion(-)
| 
| diff --git a/hw/block/fdc.c b/hw/block/fdc.c
| index e9ed3eef45..dedadac68a 100644
| --- a/hw/block/fdc.c
| +++ b/hw/block/fdc.c
| @@ -2419,7 +2419,8 @@ static void fdctrl_write_data(FDCtrl *fdctrl, uint32_t value)
|          if (pos == FD_SECTOR_LEN - 1 ||
|              fdctrl->data_pos == fdctrl->data_len) {
|              cur_drv = get_cur_drv(fdctrl);
| -            if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
| +            if (cur_drv->blk
| +                && blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
|                             BDRV_SECTOR_SIZE, 0) < 0) {
|                  FLOPPY_DPRINTF("error writing sector %d\n",
|                                 fd_sector(cur_drv));
| 

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


