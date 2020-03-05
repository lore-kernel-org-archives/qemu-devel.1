Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E53BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174AF20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVWY6UUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174AF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9l3f-0002Zz-BG
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 02:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j9l2X-0001oW-Cp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j9l2V-0001OY-L2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:35:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j9l2V-0001Mk-BV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583393726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzIe7FWhzbA/AwipGSqNXHuGmEfmpRdl0ek1z6Bb6dY=;
 b=BVWY6UUjTFaGWaPoswgRfR85fcgeSSagvPvN664LZHoKHY1FJ2CNQwHCXPrDYzbbz7I2ru
 qrtCZQOlMqxVgCy/g7gehdk4Z+Wo7z2ELoGHGiyL4ezwgbtJgthoUXkNh9AUXsnoKRRtCv
 /5sMjI9vjdmi7nzc6IaZzxQdwIe+v8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-xINrJexHP6aV9j82n5KA0Q-1; Thu, 05 Mar 2020 02:35:25 -0500
X-MC-Unique: xINrJexHP6aV9j82n5KA0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3DD28017DF;
 Thu,  5 Mar 2020 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-23.bne.redhat.com [10.64.54.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D12A173874;
 Thu,  5 Mar 2020 07:35:16 +0000 (UTC)
Subject: Re: [PATCH v2] hw/char/pl011: Enable TxFIFO and async transmission
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200224031319.84392-1-gshan@redhat.com>
Message-ID: <46ebeca6-202b-cef1-e972-caed5bfedd0e@redhat.com>
Date: Thu, 5 Mar 2020 18:35:12 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200224031319.84392-1-gshan@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, philmd@redhat.com,
 shan.gavin@gmail.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 2:13 PM, Gavin Shan wrote:
> The depth of TxFIFO can be 1 or 16 depending on LCR[4]. The TxFIFO is
> disabled when its depth is 1. It's nice to have TxFIFO enabled if
> possible because more characters can be piled and transmitted at once,
> which would have less overhead. Besides, we can be blocked because of
> qemu_chr_fe_write_all(), which isn't nice.
> 
> This enables TxFIFO if possible. On ther other hand, the asynchronous
> transmission is enabled if needed, as we did in hw/char/cadence_uart.c
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Put write_{count,fifo} into migration subsection
>      Don't start async IO handle if it has been started, to avoid race
>      Update with PL011_FLAG_{TXFF,TXFE} on changing write_count
> ---
>   hw/char/pl011.c         | 105 +++++++++++++++++++++++++++++++++++++---
>   include/hw/char/pl011.h |   3 ++
>   2 files changed, 102 insertions(+), 6 deletions(-)
> 

ping? :)

> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 13e784f9d9..de5c4254fe 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -169,6 +169,73 @@ static void pl011_set_read_trigger(PL011State *s)
>           s->read_trigger = 1;
>   }
>   
> +static gboolean pl011_xmit(GIOChannel *chan, GIOCondition cond, void *opaque)
> +{
> +    PL011State *s = (PL011State *)opaque;
> +    int ret;
> +
> +    /* Drain FIFO if there is no backend */
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        s->write_count = 0;
> +        s->flags &= ~PL011_FLAG_TXFF;
> +        s->flags |= PL011_FLAG_TXFE;
> +        return FALSE;
> +    }
> +
> +    /* Nothing to do */
> +    if (!s->write_count) {
> +        return FALSE;
> +    }
> +
> +    ret = qemu_chr_fe_write(&s->chr, s->write_fifo, s->write_count);
> +    if (ret > 0) {
> +        s->write_count -= ret;
> +        memmove(s->write_fifo, s->write_fifo + ret, s->write_count);
> +        s->flags &= ~PL011_FLAG_TXFF;
> +        if (!s->write_count) {
> +            s->flags |= PL011_FLAG_TXFE;
> +        }
> +    }
> +
> +    if (s->write_count) {
> +        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                             pl011_xmit, s);
> +        if (!s->watch_tag) {
> +            s->write_count = 0;
> +            s->flags &= ~PL011_FLAG_TXFF;
> +            s->flags |= PL011_FLAG_TXFE;
> +            return FALSE;
> +        }
> +    }
> +
> +    s->int_level |= PL011_INT_TX;
> +    pl011_update(s);
> +    return FALSE;
> +}
> +
> +static void pl011_write_fifo(void *opaque, const unsigned char *buf, int size)
> +{
> +    PL011State *s = (PL011State *)opaque;
> +    int depth = (s->lcr & 0x10) ? 16 : 1;
> +
> +    if (size >= (depth - s->write_count)) {
> +        size = depth - s->write_count;
> +    }
> +
> +    if (size > 0) {
> +        memcpy(s->write_fifo + s->write_count, buf, size);
> +        s->write_count += size;
> +        if (s->write_count >= depth) {
> +            s->flags |= PL011_FLAG_TXFF;
> +        }
> +        s->flags &= ~PL011_FLAG_TXFE;
> +    }
> +
> +    if (!s->watch_tag) {
> +        pl011_xmit(NULL, G_IO_OUT, s);
> +    }
> +}
> +
>   static void pl011_write(void *opaque, hwaddr offset,
>                           uint64_t value, unsigned size)
>   {
> @@ -179,13 +246,8 @@ static void pl011_write(void *opaque, hwaddr offset,
>   
>       switch (offset >> 2) {
>       case 0: /* UARTDR */
> -        /* ??? Check if transmitter is enabled.  */
>           ch = value;
> -        /* XXX this blocks entire thread. Rewrite to use
> -         * qemu_chr_fe_write and background I/O callbacks */
> -        qemu_chr_fe_write_all(&s->chr, &ch, 1);
> -        s->int_level |= PL011_INT_TX;
> -        pl011_update(s);
> +        pl011_write_fifo(opaque, &ch, 1);
>           break;
>       case 1: /* UARTRSR/UARTECR */
>           s->rsr = 0;
> @@ -207,7 +269,16 @@ static void pl011_write(void *opaque, hwaddr offset,
>           if ((s->lcr ^ value) & 0x10) {
>               s->read_count = 0;
>               s->read_pos = 0;
> +
> +            if (s->watch_tag) {
> +                g_source_remove(s->watch_tag);
> +                s->watch_tag = 0;
> +            }
> +            s->write_count = 0;
> +            s->flags &= ~PL011_FLAG_TXFF;
> +            s->flags |= PL011_FLAG_TXFE;
>           }
> +
>           s->lcr = value;
>           pl011_set_read_trigger(s);
>           break;
> @@ -292,6 +363,24 @@ static const MemoryRegionOps pl011_ops = {
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
>   
> +static bool pl011_write_fifo_needed(void *opaque)
> +{
> +    PL011State *s = (PL011State *)opaque;
> +    return s->write_count > 0;
> +}
> +
> +static const VMStateDescription vmstate_pl011_write_fifo = {
> +    .name = "pl011/write_fifo",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pl011_write_fifo_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT32(write_count, PL011State),
> +        VMSTATE_UINT8_ARRAY(write_fifo, PL011State, 16),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_pl011 = {
>       .name = "pl011",
>       .version_id = 2,
> @@ -314,6 +403,10 @@ static const VMStateDescription vmstate_pl011 = {
>           VMSTATE_INT32(read_count, PL011State),
>           VMSTATE_INT32(read_trigger, PL011State),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_pl011_write_fifo,
> +        NULL
>       }
>   };
>   
> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
> index 14187165c6..9d1c24db48 100644
> --- a/include/hw/char/pl011.h
> +++ b/include/hw/char/pl011.h
> @@ -38,6 +38,7 @@ typedef struct PL011State {
>       uint32_t int_enabled;
>       uint32_t int_level;
>       uint32_t read_fifo[16];
> +    uint8_t  write_fifo[16];
>       uint32_t ilpr;
>       uint32_t ibrd;
>       uint32_t fbrd;
> @@ -45,6 +46,8 @@ typedef struct PL011State {
>       int read_pos;
>       int read_count;
>       int read_trigger;
> +    int write_count;
> +    guint watch_tag;
>       CharBackend chr;
>       qemu_irq irq[6];
>       const unsigned char *id;
> 


