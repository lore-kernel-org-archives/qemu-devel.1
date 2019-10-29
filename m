Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57843CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 19:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE6E20679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="Ft5w/OnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE6E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPWuW-0004cp-Sf
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 15:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1iPWsp-0003Ut-Hi
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 15:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1iPWsm-0005tq-T7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 15:10:23 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:56086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1iPWsh-0005Vp-PI; Tue, 29 Oct 2019 15:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CL6KrJ+a0Zn6CAHj5C75lfwuzH+mCEzbVYVrO/bSTfk=; b=Ft5w/OnX98MPxODPARcU5W9CrS
 b2woFYFPPbTSOVoAuNsqidwLTViJgqnKDdofAYkmcH6/vM0/sJBJGHfEvBXHdtoJdB7BYCb0h0bnt
 rcfTBnVjmfcndmGAl5RPrpCOEoZmJetIdsFfE2XpjGC5OiAW5p9JbNbMhmUCyg10i5/c=;
Received: from [2a01:e35:2e3e:3c40:810c:5dc0:a5b7:d589]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1iPWsa-0006hs-MN; Tue, 29 Oct 2019 19:10:10 +0000
Subject: Re: [PATCH] fdc: support READ command with VERIFY DMA mode
To: John Snow <jsnow@redhat.com>, Sven Schnelle <svens@stackframe.org>
References: <20191020063800.29208-1-svens@stackframe.org>
 <9dce5dd0-1816-c0eb-4774-3020adc07cc0@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <ded2c05b-6b90-f3ad-0ef8-044b2c2b028c@reactos.org>
Date: Tue, 29 Oct 2019 20:10:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9dce5dd0-1816-c0eb-4774-3020adc07cc0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "open list:Floppy" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/10/2019 à 12:00, John Snow a écrit :
 >
 >
 > On 10/20/19 2:38 AM, Sven Schnelle wrote:
 >> While working on the Tulip driver i tried to write some Teledisk images to
 >> a floppy image which didn't work. Turned out that Teledisk checks the written
 >> data by issuing a READ command to the FDC but running the DMA controller
 >> in VERIFY mode. As we ignored the DMA request in that case, the DMA transfer
 >> never finished, and Teledisk reported an error.
 >>
 >
 > CC hpoussin@reactos.org, who sometimes submits patches here too.
 >
 >> Signed-off-by: Sven Schnelle <svens@stackframe.org>
 >> ---
 >>   hw/block/fdc.c | 10 +++++++---
 >>   1 file changed, 7 insertions(+), 3 deletions(-)
 >>
 >> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
 >> index ac5d31e8c1..8a1228df78 100644
 >> --- a/hw/block/fdc.c
 >> +++ b/hw/block/fdc.c
 >> @@ -1733,7 +1733,8 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
 >>               dma_mode_ok = (dma_mode == ISADMA_TRANSFER_WRITE);
 >>               break;
 >>           case FD_DIR_READ:
 >> -            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_READ);
 >> +            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_READ) ||
 >> +                          (dma_mode == ISADMA_TRANSFER_VERIFY);
 >
 > So we're enabling DMA when the command is an FD_DIR_READ command and the
 > dma_mode is VERIFY. Those read commands are:
 >
 > READ
 > READ TRACK
 > READ DELETED DATA

OK for this part. However, in an ideal emulation world, the floppy drive controller shouldn't know
what is the current DMA mode.
I would remove this whole dma_mode_ok thing, and always assume that operating system does a sane thing.
Then, get_transfer_mode() callback and the ISADMA_TRANSFER_* defines can also be removed.

 >
 >>               break;
 >>           case FD_DIR_VERIFY:
 >>               dma_mode_ok = true;
 >> @@ -1835,8 +1836,11 @@ static int fdctrl_transfer_handler (void *opaque, int nchan,
 >>           switch (fdctrl->data_dir) {
 >>           case FD_DIR_READ:
 >>               /* READ commands */
 >> -            k->write_memory(fdctrl->dma, nchan, fdctrl->fifo + rel_pos,
 >> -                            fdctrl->data_pos, len);
 >> +            if (k->get_transfer_mode(fdctrl->dma, fdctrl->dma_chann) !=
 >> +                ISADMA_TRANSFER_VERIFY) {
 >> +                k->write_memory(fdctrl->dma, nchan, fdctrl->fifo + rel_pos,
 >> +                        fdctrl->data_pos, len);
 >> +            }
 >
 > Would it horrify you to know I don't know how the VERIFY mode should
 > work? It's always nice when you google i8257 to look for information and
 > the top page of results are all QEMU patches.
 >
 > The i8257 spec says this:
 >
 > (3) DMA verify, which does not actually involve the
 > transfer of data. When an 8257 channel is in the DMA verify
 > mode, it will respond the same as described for transfer
 > operations, except that no memory or I/O read/write
 > control signals will be generated,
 >
 > Alright, looks good to me -- my question is if there aren't other
 > commands where we want to give this same treatment, but then again...
 > we've made it to 2019 without them, so...

It doesn't seem good to me, as it fixes VERIFY mode only for fdc.
Can you try to remove this part, and replace it by the following one (not tested) ?

--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -428,6 +428,11 @@ static int i8257_dma_write_memory(IsaDma *obj, int nchan, void *buf, int pos,
      I8257Regs *r = &s->regs[nchan & 3];
      hwaddr addr = ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[ADDR];

+    if (r->mode & 0xc0 == 0x00) {
+       /* VERIFY mode, do nothing */
+        return len;
+    }
+
      if (r->mode & 0x20) {
          int i;
          uint8_t *p = buf;

We may also fix i8257_dma_{read,write}_memory to correctly check for mode and refuse to
do anything if mode is wrong.

 >
 >>               break;
 >>           case FD_DIR_WRITE:
 >>               /* WRITE commands */
 >>
 >
 > Reviewed-by: John Snow <jsnow@redhat.com>
 >
 >

Hervé

