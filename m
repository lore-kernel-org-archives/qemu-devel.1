Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438ECC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 02:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E7D20675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 02:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1tWmV9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E7D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB7oM-0007Vu-2f
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 22:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1jB7nV-0006aG-BB
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1jB7nT-0003ZE-AY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:05:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1jB7nT-0003XP-5v
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583719534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NVD5c+HmZmp6E/+XviRWF4heSJnwRKd5Y1lYYgE9IY=;
 b=I1tWmV9+uuDzI/tmnOjJLwD32IwmXSo0p7unisVLPyiGdijU+/BX2R1Fw4o7M/Ex9D+Ph0
 kQk3tO9r5HnEgfM49MyFy8DhIEwCj4DCCZyBIQl9HEHnV5/8w4WLiQn0hMna8SP51kR/+u
 LUizn9WZNGuw7NUOsrn1pUy7Po49LPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-eiJ1RjLqMIa6GIfuiuoGEg-1; Sun, 08 Mar 2020 21:05:12 -0400
X-MC-Unique: eiJ1RjLqMIa6GIfuiuoGEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58A58A0CBF;
 Mon,  9 Mar 2020 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-34.bne.redhat.com [10.64.54.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2688F60BE2;
 Mon,  9 Mar 2020 01:05:08 +0000 (UTC)
Subject: Re: [PATCH v2] hw/char/pl011: Enable TxFIFO and async transmission
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200224031319.84392-1-gshan@redhat.com>
 <CAJ+F1C+NiqauJzufJ5qeR78UPBgAZ3tEBSnJu0Y-hv0-nYHuhA@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <4f191b2b-ece8-f809-e9a0-c4b4758fcfd4@redhat.com>
Date: Mon, 9 Mar 2020 12:05:07 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+NiqauJzufJ5qeR78UPBgAZ3tEBSnJu0Y-hv0-nYHuhA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>,
 "open list:ARM" <qemu-arm@nongnu.org>, shan.gavin@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/20 10:15 PM, Marc-Andr=C3=A9 Lureau wrote:
>=20
> On Mon, Feb 24, 2020 at 4:13 AM Gavin Shan <gshan@redhat.com> wrote:
>>
>> The depth of TxFIFO can be 1 or 16 depending on LCR[4]. The TxFIFO is
>> disabled when its depth is 1. It's nice to have TxFIFO enabled if
>> possible because more characters can be piled and transmitted at once,
>> which would have less overhead. Besides, we can be blocked because of
>> qemu_chr_fe_write_all(), which isn't nice.
>>
>> This enables TxFIFO if possible. On ther other hand, the asynchronous
>> transmission is enabled if needed, as we did in hw/char/cadence_uart.c
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v2: Put write_{count,fifo} into migration subsection
>>      Don't start async IO handle if it has been started, to avoid race
>>      Update with PL011_FLAG_{TXFF,TXFE} on changing write_count
>> ---
>>   hw/char/pl011.c         | 105 +++++++++++++++++++++++++++++++++++++---
>>   include/hw/char/pl011.h |   3 ++
>>   2 files changed, 102 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>> index 13e784f9d9..de5c4254fe 100644
>> --- a/hw/char/pl011.c
>> +++ b/hw/char/pl011.c
>> @@ -169,6 +169,73 @@ static void pl011_set_read_trigger(PL011State *s)
>>           s->read_trigger =3D 1;
>>   }
>>
>> +static gboolean pl011_xmit(GIOChannel *chan, GIOCondition cond, void *o=
paque)
>> +{
>> +    PL011State *s =3D (PL011State *)opaque;
>=20
> Useless casts, perhaps use PL011() instead?
>=20

Yes, PL011() makes the code a bit more safer. It will be used in next respi=
n.

>> +    int ret;
>> +
>> +    /* Drain FIFO if there is no backend */
>> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
>> +        s->write_count =3D 0;
>> +        s->flags &=3D ~PL011_FLAG_TXFF;
>> +        s->flags |=3D PL011_FLAG_TXFE;
>> +        return FALSE;
>=20
> Perhaps use G_SOURCE_REMOVE ?
>=20

Yes, it's more precise even it's equal to false. It will be used in next re=
spin.

>> +    }
>> +
>> +    /* Nothing to do */
>> +    if (!s->write_count) {
>> +        return FALSE;
>> +    }
>> +
>> +    ret =3D qemu_chr_fe_write(&s->chr, s->write_fifo, s->write_count);
>> +    if (ret > 0) {
>> +        s->write_count -=3D ret;
>> +        memmove(s->write_fifo, s->write_fifo + ret, s->write_count);
>> +        s->flags &=3D ~PL011_FLAG_TXFF;
>> +        if (!s->write_count) {
>> +            s->flags |=3D PL011_FLAG_TXFE;
>> +        }
>> +    }
>> +
>> +    if (s->write_count) {
>> +        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO=
_HUP,
>> +                                             pl011_xmit, s);
>> +        if (!s->watch_tag) {
>> +            s->write_count =3D 0;
>> +            s->flags &=3D ~PL011_FLAG_TXFF;
>> +            s->flags |=3D PL011_FLAG_TXFE;
>> +            return FALSE;
>> +        }
>> +    }
>> +
>> +    s->int_level |=3D PL011_INT_TX;
>> +    pl011_update(s);
>> +    return FALSE;
>> +}
>> +
>> +static void pl011_write_fifo(void *opaque, const unsigned char *buf, in=
t size)
>> +{
>> +    PL011State *s =3D (PL011State *)opaque;
>> +    int depth =3D (s->lcr & 0x10) ? 16 : 1;
>> +
>> +    if (size >=3D (depth - s->write_count)) {
>=20
> parenthesis could be dropped
>=20

It's really personal taste, but it will be dropped in next respin :)

>> +        size =3D depth - s->write_count;
>> +    }
>> +
>=20
> Why make a function that accepts size !=3D 1 (and may silently drop
> data), when the only caller is pl011_write_fifo(opaque, &ch, 1); ?
>=20
>> +    if (size > 0) {
>=20
> I don't think other cases are supposed to happen.
>=20

The function will be reused when loopback mode is enabled in future. The
received characters could be sent in batch mode in loopback mode. So we
have variable size here. The caller won't lose data by checking the amount
of characters are sent successfully. Also, the check on @size makes the cod=
e
looks complete and lets keep it.

>> +        memcpy(s->write_fifo + s->write_count, buf, size);
>> +        s->write_count +=3D size;
>> +        if (s->write_count >=3D depth) {
>> +            s->flags |=3D PL011_FLAG_TXFF;
>> +        }
>> +        s->flags &=3D ~PL011_FLAG_TXFE;
>> +    }
>> +
>> +    if (!s->watch_tag) {
>> +        pl011_xmit(NULL, G_IO_OUT, s);
>> +    }
>> +}
>> +
>>   static void pl011_write(void *opaque, hwaddr offset,
>>                           uint64_t value, unsigned size)
>>   {
>> @@ -179,13 +246,8 @@ static void pl011_write(void *opaque, hwaddr offset=
,
>>
>>       switch (offset >> 2) {
>>       case 0: /* UARTDR */
>> -        /* ??? Check if transmitter is enabled.  */
>>           ch =3D value;
>> -        /* XXX this blocks entire thread. Rewrite to use
>> -         * qemu_chr_fe_write and background I/O callbacks */
>> -        qemu_chr_fe_write_all(&s->chr, &ch, 1);
>> -        s->int_level |=3D PL011_INT_TX;
>> -        pl011_update(s);
>> +        pl011_write_fifo(opaque, &ch, 1);
>>           break;
>>       case 1: /* UARTRSR/UARTECR */
>>           s->rsr =3D 0;
>> @@ -207,7 +269,16 @@ static void pl011_write(void *opaque, hwaddr offset=
,
>>           if ((s->lcr ^ value) & 0x10) {
>>               s->read_count =3D 0;
>>               s->read_pos =3D 0;
>> +
>> +            if (s->watch_tag) {
>> +                g_source_remove(s->watch_tag);
>> +                s->watch_tag =3D 0;
>> +            }
>> +            s->write_count =3D 0;
>> +            s->flags &=3D ~PL011_FLAG_TXFF;
>> +            s->flags |=3D PL011_FLAG_TXFE;
>>           }
>> +
>>           s->lcr =3D value;
>>           pl011_set_read_trigger(s);
>>           break;
>> @@ -292,6 +363,24 @@ static const MemoryRegionOps pl011_ops =3D {
>>       .endianness =3D DEVICE_NATIVE_ENDIAN,
>>   };
>>
>> +static bool pl011_write_fifo_needed(void *opaque)
>> +{
>> +    PL011State *s =3D (PL011State *)opaque;
>> +    return s->write_count > 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_pl011_write_fifo =3D {
>> +    .name =3D "pl011/write_fifo",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D pl011_write_fifo_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_INT32(write_count, PL011State),
>> +        VMSTATE_UINT8_ARRAY(write_fifo, PL011State, 16),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static const VMStateDescription vmstate_pl011 =3D {
>>       .name =3D "pl011",
>>       .version_id =3D 2,
>> @@ -314,6 +403,10 @@ static const VMStateDescription vmstate_pl011 =3D {
>>           VMSTATE_INT32(read_count, PL011State),
>>           VMSTATE_INT32(read_trigger, PL011State),
>>           VMSTATE_END_OF_LIST()
>> +    },
>> +    .subsections =3D (const VMStateDescription * []) {
>> +        &vmstate_pl011_write_fifo,
>> +        NULL
>>       }
>>   };
>>
>> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
>> index 14187165c6..9d1c24db48 100644
>> --- a/include/hw/char/pl011.h
>> +++ b/include/hw/char/pl011.h
>> @@ -38,6 +38,7 @@ typedef struct PL011State {
>>       uint32_t int_enabled;
>>       uint32_t int_level;
>>       uint32_t read_fifo[16];
>> +    uint8_t  write_fifo[16];
>>       uint32_t ilpr;
>>       uint32_t ibrd;
>>       uint32_t fbrd;
>> @@ -45,6 +46,8 @@ typedef struct PL011State {
>>       int read_pos;
>>       int read_count;
>>       int read_trigger;
>> +    int write_count;
>> +    guint watch_tag;
>>       CharBackend chr;
>>       qemu_irq irq[6];
>>       const unsigned char *id;
>> --
>> 2.23.0
>>
>>
>=20
> Looks ok otherwise
>=20

Thanks for your comments. I will post v3 after you think it's fine to chang=
e
the code as above :)

Thanks,
Gavin


