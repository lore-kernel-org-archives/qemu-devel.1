Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B3C54FD5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 02:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D61420714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 02:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2eRhKyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D61420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGvrU-0005tf-79
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 22:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1jGvqd-0005Mj-FH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1jGvqb-0005VT-If
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:32:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37825)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1jGvqb-0005UP-9q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585103567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfvdA6fl0nGiCwzGaUVcG2y7t0dMnDN1knHz/pUXHD8=;
 b=E2eRhKyfMxcIhqm1tMJScAXAelLaZqGfUxR2dtq+wgNYBwBg1Qwk5KwWeMNfBy3ERELQ9P
 BUUIlPsO8QzZXJ2ajdhGUJgHmyOqJP0+tj5l/vcH3YqIfr5B8Gcoj1/xJQWmBs82HL+T/T
 adv/pG3q8NAxlKL6jNYovTY/aohPkkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-yI709ja9MEezamytUEt5IQ-1; Tue, 24 Mar 2020 22:32:46 -0400
X-MC-Unique: yI709ja9MEezamytUEt5IQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA331005513;
 Wed, 25 Mar 2020 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-53.bne.redhat.com [10.64.54.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C759B5C241;
 Wed, 25 Mar 2020 02:32:42 +0000 (UTC)
Subject: Re: [PATCH v3] hw/char/pl011: Enable TxFIFO and async transmission
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200311040923.29115-1-gshan@redhat.com>
Message-ID: <4c32dbe0-7d96-5e60-addc-b1bf43e17f47@redhat.com>
Date: Wed, 25 Mar 2020 13:32:39 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200311040923.29115-1-gshan@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/11/20 3:09 PM, Gavin Shan wrote:
> The depth of TxFIFO can be 1 or 16 depending on LCR[4]. The TxFIFO is
> disabled when its depth is 1. It's nice to have TxFIFO enabled if
> possible because more characters can be piled and transmitted at once,
> which would have less overhead. Besides, we can be blocked because of
> qemu_chr_fe_write_all(), which isn't nice.
>=20
> This enables TxFIFO if possible. On ther other hand, the asynchronous
> transmission is enabled if needed, as we did in hw/char/cadence_uart.c
>=20
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v3: Use PL011() to do data type conversion
>      Return G_SOURCE_REMOVE when the backend is disconnected in pl011_xmi=
t()
>      Drop parenthesis in the condition validating @size in pl011_write_fi=
fo()
> ---
>   hw/char/pl011.c         | 105 +++++++++++++++++++++++++++++++++++++---
>   include/hw/char/pl011.h |   3 ++
>   2 files changed, 102 insertions(+), 6 deletions(-)
>=20

Marc-Andr=C3=A9, ping. Could you please review when you get a chance? Thank=
s in
advance :)

> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 13e784f9d9..dccb8c42b0 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -169,6 +169,73 @@ static void pl011_set_read_trigger(PL011State *s)
>           s->read_trigger =3D 1;
>   }
>  =20
> +static gboolean pl011_xmit(GIOChannel *chan, GIOCondition cond, void *op=
aque)
> +{
> +    PL011State *s =3D PL011(opaque);
> +    int ret;
> +
> +    /* Drain FIFO if there is no backend */
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        s->write_count =3D 0;
> +        s->flags &=3D ~PL011_FLAG_TXFF;
> +        s->flags |=3D PL011_FLAG_TXFE;
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    /* Nothing to do */
> +    if (!s->write_count) {
> +        return FALSE;
> +    }
> +
> +    ret =3D qemu_chr_fe_write(&s->chr, s->write_fifo, s->write_count);
> +    if (ret > 0) {
> +        s->write_count -=3D ret;
> +        memmove(s->write_fifo, s->write_fifo + ret, s->write_count);
> +        s->flags &=3D ~PL011_FLAG_TXFF;
> +        if (!s->write_count) {
> +            s->flags |=3D PL011_FLAG_TXFE;
> +        }
> +    }
> +
> +    if (s->write_count) {
> +        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_=
HUP,
> +                                             pl011_xmit, s);
> +        if (!s->watch_tag) {
> +            s->write_count =3D 0;
> +            s->flags &=3D ~PL011_FLAG_TXFF;
> +            s->flags |=3D PL011_FLAG_TXFE;
> +            return FALSE;
> +        }
> +    }
> +
> +    s->int_level |=3D PL011_INT_TX;
> +    pl011_update(s);
> +    return FALSE;
> +}
> +
> +static void pl011_write_fifo(void *opaque, const unsigned char *buf, int=
 size)
> +{
> +    PL011State *s =3D PL011(opaque);
> +    int depth =3D (s->lcr & 0x10) ? 16 : 1;
> +
> +    if (size >=3D depth - s->write_count) {
> +        size =3D depth - s->write_count;
> +    }
> +
> +    if (size > 0) {
> +        memcpy(s->write_fifo + s->write_count, buf, size);
> +        s->write_count +=3D size;
> +        if (s->write_count >=3D depth) {
> +            s->flags |=3D PL011_FLAG_TXFF;
> +        }
> +        s->flags &=3D ~PL011_FLAG_TXFE;
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
>  =20
>       switch (offset >> 2) {
>       case 0: /* UARTDR */
> -        /* ??? Check if transmitter is enabled.  */
>           ch =3D value;
> -        /* XXX this blocks entire thread. Rewrite to use
> -         * qemu_chr_fe_write and background I/O callbacks */
> -        qemu_chr_fe_write_all(&s->chr, &ch, 1);
> -        s->int_level |=3D PL011_INT_TX;
> -        pl011_update(s);
> +        pl011_write_fifo(opaque, &ch, 1);
>           break;
>       case 1: /* UARTRSR/UARTECR */
>           s->rsr =3D 0;
> @@ -207,7 +269,16 @@ static void pl011_write(void *opaque, hwaddr offset,
>           if ((s->lcr ^ value) & 0x10) {
>               s->read_count =3D 0;
>               s->read_pos =3D 0;
> +
> +            if (s->watch_tag) {
> +                g_source_remove(s->watch_tag);
> +                s->watch_tag =3D 0;
> +            }
> +            s->write_count =3D 0;
> +            s->flags &=3D ~PL011_FLAG_TXFF;
> +            s->flags |=3D PL011_FLAG_TXFE;
>           }
> +
>           s->lcr =3D value;
>           pl011_set_read_trigger(s);
>           break;
> @@ -292,6 +363,24 @@ static const MemoryRegionOps pl011_ops =3D {
>       .endianness =3D DEVICE_NATIVE_ENDIAN,
>   };
>  =20
> +static bool pl011_write_fifo_needed(void *opaque)
> +{
> +    PL011State *s =3D PL011(opaque);
> +    return s->write_count > 0;
> +}
> +
> +static const VMStateDescription vmstate_pl011_write_fifo =3D {
> +    .name =3D "pl011/write_fifo",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D pl011_write_fifo_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_INT32(write_count, PL011State),
> +        VMSTATE_UINT8_ARRAY(write_fifo, PL011State, 16),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_pl011 =3D {
>       .name =3D "pl011",
>       .version_id =3D 2,
> @@ -314,6 +403,10 @@ static const VMStateDescription vmstate_pl011 =3D {
>           VMSTATE_INT32(read_count, PL011State),
>           VMSTATE_INT32(read_trigger, PL011State),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription * []) {
> +        &vmstate_pl011_write_fifo,
> +        NULL
>       }
>   };
>  =20
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
>=20


