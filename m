Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27EECA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7C92086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="qYDgMG4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7C92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQUaF-0005RQ-Kj
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1iQUZK-0004pW-AS
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1iQUZI-0000b3-Kk
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:54:14 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:52208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1iQUZI-0000Xj-2y; Fri, 01 Nov 2019 06:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mnOV9ENqE62Uow/Y1aJdT07AkXE3ZMskP0qHufjBVn8=; b=qYDgMG4lU/oOBSOHT8vZ6qIdZq
 tvPWn6z6KAPsOytjgWNwo4zaOAr/FFvtUNzFhGC+mkkXUcfUh1OPTrTav4X9XBB/tvaP+y+cTy1if
 9ruZnVN4qS7dpiQaGhRF8MwkK3eL0Evv6uYAsaa3cSEFlHthdBLeV4iwYG3ppL2kqx+I=;
Received: from [2a01:e35:2e3e:3c40:810c:5dc0:a5b7:d589]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1iQUZC-0005sM-KG; Fri, 01 Nov 2019 10:54:08 +0000
Subject: Re: [PATCH v2] fdc/i8257: implement verify transfer mode
To: Sven Schnelle <svens@stackframe.org>, John Snow <jsnow@redhat.com>
References: <20191030082827.10010-1-svens@stackframe.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <2531480a-e678-9a8e-13c8-1d7dc8acaa7e@reactos.org>
Date: Fri, 1 Nov 2019 11:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030082827.10010-1-svens@stackframe.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/10/2019 à 09:28, Sven Schnelle a écrit :
> While working on the Tulip driver i tried to write some Teledisk images to
> a floppy image which didn't work. Turned out that Teledisk checks the written
> data by issuing a READ command to the FDC but running the DMA controller
> in VERIFY mode. As we ignored the DMA request in that case, the DMA transfer
> never finished, and Teledisk reported an error.
> 
> The i8257 spec says about verify transfers:
> 
> 3) DMA verify, which does not actually involve the transfer of data. When an
> 8257 channel is in the DMA verify mode, it will respond the same as described
> for transfer operations, except that no memory or I/O read/write control signals
> will be generated.
> 
> Hervé proposed to remove all the dma_mode_ok stuff from fdc to have a more
> clear boundary between DMA and FDC, so this patch also does that.
> 
> Suggested-by: Hervé Poussineau <hpoussin@reactos.org>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/block/fdc.c       | 39 +++++++++++++++------------------------
>   hw/dma/i8257.c       | 20 +++++++++++++-------
>   include/hw/isa/isa.h |  1 -
>   3 files changed, 28 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index ac5d31e8c1..18fd22bfb7 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -1716,9 +1716,8 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
>       if (fdctrl->dor & FD_DOR_DMAEN) {
>           IsaDmaTransferMode dma_mode;

You need to remove this dma_mode variable because you don't set it anymore.

>           IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
> -        bool dma_mode_ok;
> +
>           /* DMA transfer are enabled. Check if DMA channel is well programmed */

Second part of this comment should be removed.

> -        dma_mode = k->get_transfer_mode(fdctrl->dma, fdctrl->dma_chann);
>           FLOPPY_DPRINTF("dma_mode=%d direction=%d (%d - %d)\n",
>                          dma_mode, direction,
>                          (128 << fdctrl->fifo[5]) *

You need to remove dma_mode variable from printf statement, as you removed the variable.

> @@ -1727,40 +1726,32 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
>           case FD_DIR_SCANE:
>           case FD_DIR_SCANL:
>           case FD_DIR_SCANH:
> -            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_VERIFY);
>               break;
>           case FD_DIR_WRITE:
> -            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_WRITE);
>               break;
>           case FD_DIR_READ:
> -            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_READ);
>               break;
>           case FD_DIR_VERIFY:
> -            dma_mode_ok = true;
>               break;
>           default:
> -            dma_mode_ok = false;
>               break;
>           }

Now that you have removed the dma_mode_ok instructions, you have a switch where all cases do nothing.
Please completly remove the switch statement.

> -        if (dma_mode_ok) {
> -            /* No access is allowed until DMA transfer has completed */
> -            fdctrl->msr &= ~FD_MSR_RQM;
> -            if (direction != FD_DIR_VERIFY) {
> -                /* Now, we just have to wait for the DMA controller to
> -                 * recall us...
> -                 */
> -                k->hold_DREQ(fdctrl->dma, fdctrl->dma_chann);
> -                k->schedule(fdctrl->dma);
> -            } else {
> -                /* Start transfer */
> -                fdctrl_transfer_handler(fdctrl, fdctrl->dma_chann, 0,
> -                                        fdctrl->data_len);
> -            }
> -            return;
> +
> +        /* No access is allowed until DMA transfer has completed */
> +        fdctrl->msr &= ~FD_MSR_RQM;
> +        if (direction != FD_DIR_VERIFY) {
> +            /*
> +             * Now, we just have to wait for the DMA controller to
> +             * recall us...
> +             */
> +            k->hold_DREQ(fdctrl->dma, fdctrl->dma_chann);
> +            k->schedule(fdctrl->dma);
>           } else {
> -            FLOPPY_DPRINTF("bad dma_mode=%d direction=%d\n", dma_mode,
> -                           direction);
> +            /* Start transfer */
> +            fdctrl_transfer_handler(fdctrl, fdctrl->dma_chann, 0,
> +                    fdctrl->data_len);
>           }
> +        return;
>       }
>       FLOPPY_DPRINTF("start non-DMA transfer\n");
>       fdctrl->msr |= FD_MSR_NONDMA | FD_MSR_RQM;
> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
> index 792f617eb4..85dad3d391 100644
> --- a/hw/dma/i8257.c
> +++ b/hw/dma/i8257.c
> @@ -292,12 +292,6 @@ static uint64_t i8257_read_cont(void *opaque, hwaddr nport, unsigned size)
>       return val;
>   }
>   
> -static IsaDmaTransferMode i8257_dma_get_transfer_mode(IsaDma *obj, int nchan)
> -{
> -    I8257State *d = I8257(obj);
> -    return (d->regs[nchan & 3].mode >> 2) & 3;
> -}
> -
>   static bool i8257_dma_has_autoinitialization(IsaDma *obj, int nchan)
>   {
>       I8257State *d = I8257(obj);
> @@ -400,6 +394,11 @@ static void i8257_dma_register_channel(IsaDma *obj, int nchan,
>       r->opaque = opaque;
>   }
>   
> +static bool i8257_is_verify_transfer(I8257Regs *r)
> +{
> +    return (r->mode & 0x0c) == 0;
> +}
> +
>   static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
>                                    int len)
>   {
> @@ -407,6 +406,10 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
>       I8257Regs *r = &d->regs[nchan & 3];
>       hwaddr addr = ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[ADDR];
>   
> +    if (i8257_is_verify_transfer(r)) {
> +        return len;
> +    }
> +
>       if (r->mode & 0x20) {
>           int i;
>           uint8_t *p = buf;
> @@ -431,6 +434,10 @@ static int i8257_dma_write_memory(IsaDma *obj, int nchan, void *buf, int pos,
>       I8257Regs *r = &s->regs[nchan & 3];
>       hwaddr addr = ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[ADDR];
>   
> +    if (i8257_is_verify_transfer(r)) {
> +        return len;
> +    }
> +
>       if (r->mode & 0x20) {
>           int i;
>           uint8_t *p = buf;
> @@ -597,7 +604,6 @@ static void i8257_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_i8257;
>       dc->props = i8257_properties;
>   
> -    idc->get_transfer_mode = i8257_dma_get_transfer_mode;
>       idc->has_autoinitialization = i8257_dma_has_autoinitialization;
>       idc->read_memory = i8257_dma_read_memory;
>       idc->write_memory = i8257_dma_write_memory;
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 018ada4f6f..f516e253c5 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -56,7 +56,6 @@ typedef int (*IsaDmaTransferHandler)(void *opaque, int nchan, int pos,
>   typedef struct IsaDmaClass {
>       InterfaceClass parent;
>   
> -    IsaDmaTransferMode (*get_transfer_mode)(IsaDma *obj, int nchan);
>       bool (*has_autoinitialization)(IsaDma *obj, int nchan);
>       int (*read_memory)(IsaDma *obj, int nchan, void *buf, int pos, int len);
>       int (*write_memory)(IsaDma *obj, int nchan, void *buf, int pos, int len);
> 

Otherwise, the i8257.c parts look good. This might fix some other devices (except fdc) which might use VERIFY mode.

Hervé

