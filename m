Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3AACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C762084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx/MZJmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C762084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNExF-0002gb-IX
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEVQ-0006x9-G1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEVO-0004tK-6d
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:08:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53849
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEVN-0004tB-Uk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571828921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xaHQctyskDLwRIW1KNuWKPpk2zdbKxiGEFeRak1FKR0=;
 b=bx/MZJmVVbJ75pW/zSv/uMCo7hpvLEO85sm/JlxyIciYzPPGU2ttGOxR4TGrAp1eSv47Zv
 /g6ZgiIoicBxNB6TaDWvuoj9Nv6h79zfEXHMcBP4VOOoTHQNvTpgQy5RRNz2LQtN+cdw3S
 mdNzuCiab/hkDacJSo0L61S6qs+NlFk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-vHZo8FRsNgqYfNV_ji3UXA-1; Wed, 23 Oct 2019 07:08:39 -0400
Received: by mail-wm1-f71.google.com with SMTP id g13so1166467wme.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y2z5AVAZYUT5R5LFM0Mqatb/Cq143VOGCwmmySD8DzM=;
 b=HfcB/JYI9QWfIt/MEaJwXj3s8BqWJmZsmTBHI4uhPuckYN4Kwp6r2LjWBjUmJOCEFF
 pd4qRRTYW09SmL5zQYDZKLx5f/3bj8+qqftXiftqIegOZk1fYzWsnHCkxKnAKpFRX3+B
 5hZN20202Jwj/+j5kCXDW8CrmQZ9vcJX0IvW0++FR2NPhuP2hEQfRWuhjKeu8E9IAONH
 Jbre2zmG8bY6YlDqDmPH9kk/nXRdmiS6yE1X4g9kfVOSn09s2E+4UyXr+i6mBDSpJ1qz
 f/AXP+jux8mhvJRQ418VfgyHqE3GRW4kH1NptydCZ+MWmWLb8fZThcvmPBV3D8JTJHhH
 6oDQ==
X-Gm-Message-State: APjAAAXzbmd60GljX6Kan8u93vnSybw5lnjJpoDzHtBdSQK2qnKHDQcI
 RD+2CS/0hCmg0QPzv/djSS1ri3uAb6ifPkhQIGLkKK1kcOqK2jejbSyg69rdXBxQBHyCif2q6F2
 8Z39E+2+IngaG384=
X-Received: by 2002:adf:f343:: with SMTP id e3mr84290wrp.315.1571828917755;
 Wed, 23 Oct 2019 04:08:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxyuvEL23J7qETjsDaF4qKbdej3gltPeYCm4JeRcHNvYwe7Ef/LNUgFYC5e4zSIjzv8nQPJA==
X-Received: by 2002:adf:f343:: with SMTP id e3mr84268wrp.315.1571828917510;
 Wed, 23 Oct 2019 04:08:37 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id g69sm8550397wme.31.2019.10.23.04.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:08:36 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] ps2: accept 'Set Key Make and Break' commands
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191022205941.23152-1-svens@stackframe.org>
 <20191022205941.23152-4-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c0a0c73a-496f-e6bc-54ce-a6631ef3a81d@redhat.com>
Date: Wed, 23 Oct 2019 13:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022205941.23152-4-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: vHZo8FRsNgqYfNV_ji3UXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sven,

(Please Cc reviewers who previously commented your patch)

On 10/22/19 10:59 PM, Sven Schnelle wrote:
> HP-UX sends both the 'Set key make and break (0xfc) and
> 'Set all key typematic make and break' (0xfa). QEMU response
> with 'Resend' as it doesn't handle these commands. HP-UX than
> reports an PS/2 max retransmission exceeded error. Add these
> commands and just reply with ACK.
>=20
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/input/ps2.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 67f92f6112..0b671b6339 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -49,6 +49,8 @@
>   #define KBD_CMD_RESET_DISABLE=090xF5=09/* reset and disable scanning */
>   #define KBD_CMD_RESET_ENABLE   =090xF6    /* reset and enable scanning =
*/
>   #define KBD_CMD_RESET=09=090xFF=09/* Reset */
> +#define KBD_CMD_SET_MAKE_BREAK  0xFC    /* Set Make and Break mode */
> +#define KBD_CMD_SET_TYPEMATIC   0xFA    /* Set Typematic Make and Break =
mode */
>  =20
>   /* Keyboard Replies */
>   #define KBD_REPLY_POR=09=090xAA=09/* Power on reset */
> @@ -573,6 +575,7 @@ void ps2_write_keyboard(void *opaque, int val)
>           case KBD_CMD_SCANCODE:
>           case KBD_CMD_SET_LEDS:
>           case KBD_CMD_SET_RATE:
> +        case KBD_CMD_SET_MAKE_BREAK:

OK

>               s->common.write_cmd =3D val;
>               ps2_queue(&s->common, KBD_REPLY_ACK);
>               break;
> @@ -592,11 +595,18 @@ void ps2_write_keyboard(void *opaque, int val)
>                   KBD_REPLY_ACK,
>                   KBD_REPLY_POR);
>               break;
> +        case KBD_CMD_SET_TYPEMATIC:
> +            ps2_queue(&s->common, KBD_REPLY_ACK);

I'm not sure, can't this loop?

Can you fold it with the '0x00' case?

> +            break;
>           default:
>               ps2_queue(&s->common, KBD_REPLY_RESEND);
>               break;
>           }
>           break;
> +    case KBD_CMD_SET_MAKE_BREAK:

We can reorder this one in the same case with:

     case KBD_CMD_SET_LEDS:
     case KBD_CMD_SET_RATE:

> +        ps2_queue(&s->common, KBD_REPLY_ACK);
> +        s->common.write_cmd =3D -1;
> +        break;
>       case KBD_CMD_SCANCODE:
>           if (val =3D=3D 0) {
>               if (s->common.queue.count <=3D PS2_QUEUE_SIZE - 2) {
>=20


