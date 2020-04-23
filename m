Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFDC55192
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA742076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoooT5n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA742076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZgi-0005Ag-Dk
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRZg6-0004co-1b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRZg5-0005bh-2v
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:05:57 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRZg4-0005b2-Ma
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:05:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id e20so5265337otk.12
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EE+V4lph8j5aosFBB+StB7HloVKwTivpUyCdP1a6Nbo=;
 b=DoooT5n11EQDRhYw1GfbwXAP2Tv6+yZ1jNMyWnN7QbTog9UWYjz5y1MAZ/p83KSRY8
 oOmISdt2EBKZw1WKHLA9jQl0Ibo70UIDC7hoxLpiZRgCwvMv1wmOjptDQWekijQtbIJa
 7I3/Se+V3Ra1ow8QRpXQhf2CIjVknSNzT7lmajHHxiPrA0l5ipeNVwaxthJFSStex6qu
 Bfwo31Wwp9pkphRB0PVqjEJ6Is+1rsKfxLSBQj8qGCBPo5l1hG8wiOHqDFkh2zoCFu0j
 j1Slxgyy1FzZ8J774yU3F2oJY1xkd+pX9T12ecKUCyzyMzWiBk8VbZjssNDEZVCaBpHR
 WHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EE+V4lph8j5aosFBB+StB7HloVKwTivpUyCdP1a6Nbo=;
 b=LxadB5UJADXyZWXHD1qDeWaTmqWxtJ10TRinlPX7IEMWeKz6HFTKLO2Dapgj1ZzmAf
 7oML1kgNxZOUeFW94Y1qo1YSnH/c0MbYaMnXU41E7SRuh7o8LWQwlwJishyNur9aBLBX
 TJrR1x8afsPmB5QNc3p0S41MW0zbDVY1UIO/HRlgRd2VDqVsoDWgvKWuVDvlEa1dC/7u
 96TyRES3QDD06caAVo9nq+2OnkAn5Ex+hNasEkSKlHGYCR2eZYnuY4r/ugT4TgbRUM3x
 0miDhaeNbWPaBxTYXnWh0tegHb2Y2SP2A9trMNsN86PszvP8BJTlF7TCLMtM0+UJk0Il
 fY7Q==
X-Gm-Message-State: AGi0PuYd35xsSE14s2Ybk2bNh/3sV08AI2sc3B65puWJcTq4o5/xO2S1
 giqgMkBHxol4Pxjym0AYtQQfeQSD/2Qk1vvX2n35iw==
X-Google-Smtp-Source: APiQypKgDsR6ExCMZZDEqbeKuqUw4RTzMOkLPWYDoANrYTzAkWX7dIyk0HE4TkCFqpip0Jmk+4THJ6BLfEcZDg7fNxA=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr2980768otb.135.1587639954975; 
 Thu, 23 Apr 2020 04:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200311040923.29115-1-gshan@redhat.com>
In-Reply-To: <20200311040923.29115-1-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 12:05:42 +0100
Message-ID: <CAFEAcA8jukGvWA1J8k4VvDT=pbeK2X7_GJOKX6Wy0gEy3K_+bA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/pl011: Enable TxFIFO and async transmission
To: Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 04:09, Gavin Shan <gshan@redhat.com> wrote:
>
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
> v3: Use PL011() to do data type conversion
>     Return G_SOURCE_REMOVE when the backend is disconnected in pl011_xmit()
>     Drop parenthesis in the condition validating @size in pl011_write_fifo()
> ---
>  hw/char/pl011.c         | 105 +++++++++++++++++++++++++++++++++++++---
>  include/hw/char/pl011.h |   3 ++
>  2 files changed, 102 insertions(+), 6 deletions(-)

Thanks for this patch. I have some comments on some bits of the
code below.

> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 13e784f9d9..dccb8c42b0 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -169,6 +169,73 @@ static void pl011_set_read_trigger(PL011State *s)
>          s->read_trigger = 1;
>  }
>
> +static gboolean pl011_xmit(GIOChannel *chan, GIOCondition cond, void *opaque)
> +{
> +    PL011State *s = PL011(opaque);
> +    int ret;
> +
> +    /* Drain FIFO if there is no backend */
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        s->write_count = 0;
> +        s->flags &= ~PL011_FLAG_TXFF;
> +        s->flags |= PL011_FLAG_TXFE;
> +        return G_SOURCE_REMOVE;
> +    }

This "handle no backend" code isn't necessary. There was a
period of time when it was, because some of the qemu_chr_fe_*
functions did the wrong thing if called on a CharBackend with
a NULL Chardev, which is why some code in the tree checks it,
but we fixed that. If there's no backend then both
qemu_chr_fe_write() and qemu_chr_fe_add_watch() will return 0
without doing anything, which will make us drain the FIFO
via the "!s->watch_tag" code path below.

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

Handling of INT_TX is more complicated when the FIFO is
enabled: the UARTIFLS.TXIFLSEL bits define at what point
we should raise the TX interrupt as the FIFO drains
(eg you can make it interrupt as the FIFO passes through
the "half full" point, or when it gets <= 1/8th full, etc).
Watch out that the definition is that the interrupt is raised
as the FIFO fill level progresses through the trigger
level, which is not the same as "is the FIFO fill level
less than or equal to the trigger level now?".

> +    pl011_update(s);
> +    return FALSE;
> +}
> +
> +static void pl011_write_fifo(void *opaque, const unsigned char *buf, int size)
> +{
> +    PL011State *s = PL011(opaque);
> +    int depth = (s->lcr & 0x10) ? 16 : 1;
> +
> +    if (size >= depth - s->write_count) {
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

It looks like we only ever call pl011_write_fifo() with
a size of 1 -- should we just make it directly take
a single 'uint8_t ch' to write to the FIFO? It would
simplify some of this code I think.

The UARTFR.BUSY bit should be set to 1 as soon as the UART
gets data into the tx FIFO and then cleared only when the
data has all been transmitted. We didn't need to worry about
that when we blocked until the data was sent (the guest could
not execute at a point where it would see BUSY=1), but now
we model the tx FIFO we need to update the BUSY bit (both
in this function to set it and then in anywhere that
empties the FIFO to clear it).

> +
>  static void pl011_write(void *opaque, hwaddr offset,
>                          uint64_t value, unsigned size)
>  {
> @@ -179,13 +246,8 @@ static void pl011_write(void *opaque, hwaddr offset,
>
>      switch (offset >> 2) {
>      case 0: /* UARTDR */
> -        /* ??? Check if transmitter is enabled.  */

This ??? comment is about the fact that we don't check
UARTCR.TXE (the transmit enable bit). Your patch doesn't
add support for that (which is fine, it's entirely separate
from the FIFO stuff), so it shouldn't delete the comment.

>          ch = value;
> -        /* XXX this blocks entire thread. Rewrite to use
> -         * qemu_chr_fe_write and background I/O callbacks */
> -        qemu_chr_fe_write_all(&s->chr, &ch, 1);
> -        s->int_level |= PL011_INT_TX;
> -        pl011_update(s);
> +        pl011_write_fifo(opaque, &ch, 1);
>          break;
>      case 1: /* UARTRSR/UARTECR */
>          s->rsr = 0;
> @@ -207,7 +269,16 @@ static void pl011_write(void *opaque, hwaddr offset,
>          if ((s->lcr ^ value) & 0x10) {
>              s->read_count = 0;
>              s->read_pos = 0;
> +
> +            if (s->watch_tag) {
> +                g_source_remove(s->watch_tag);
> +                s->watch_tag = 0;
> +            }
> +            s->write_count = 0;
> +            s->flags &= ~PL011_FLAG_TXFF;
> +            s->flags |= PL011_FLAG_TXFE;
>          }
> +
>          s->lcr = value;
>          pl011_set_read_trigger(s);
>          break;
> @@ -292,6 +363,24 @@ static const MemoryRegionOps pl011_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };

thanks
-- PMM

