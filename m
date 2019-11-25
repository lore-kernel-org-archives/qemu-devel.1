Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E36C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A9C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHst0nz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A9C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFVj-00067P-Cz
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZFV2-0005b7-0E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZFUz-00051u-SA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:37:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZFUz-00051N-Hp
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574692676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hsw8NPiqyei91AbNhk+xI6160rJpYS1CAA8ChIKlB78=;
 b=AHst0nz26P9JmmIjgTa8ns1ZWVruOzcrZSL+lHHW+4RjX76Qhp7YoGadz3uByJXtIuOtSC
 hJnxtdrl+VCtaTZlj0KWFEBdq8ooizMugleSvE+p6pvG5ONxNGSVG5yJui1k6E3IMIiFnd
 skrxhhwjkLoWYF/nQXrj2Uok+gCeCyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-0zmDW8fLPHCOyiCbkUIekg-1; Mon, 25 Nov 2019 09:37:55 -0500
Received: by mail-wm1-f72.google.com with SMTP id 199so6686545wmb.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qabj9JKhJMdJxB6TzpdZMSM9Ng0LxKPIQ4EJMOK4RIY=;
 b=VBBAg+ttNfjDakdpYe3aEEoqlLHRcNR4K/gX/CTLKZDZU0CmJODKuXJlfIRmBb+hVo
 wNF35aPV+mU8ngg6Xj0fLsQgNikYvJYSJQ0DTJeQNMMLPodbKLe/AZrZyzypx5XL3VC0
 EsW6OeHoc+dSKZVp9LDnoV4A8FmS5kl2Xsae8b1im+f9XmB9RXFjSrnl9cTrHD/aIyk7
 6ovLXMmy+w3XJ1eB8f73lvl3X9PG5XO7WevpajGnaTuI1+z4Zus/KCqmEJklbPn+GW4B
 PgdpiWo6oMxjwgqfmgSJ0twNAtkiiSrp3FLqdGl5dFN2AYQljPjH4KHggzMsyXDX7lT2
 dbQg==
X-Gm-Message-State: APjAAAU/uu+kJOaja4H7KtdCn/sxIbz9MenXPiT3xh3IH8n7Ig0pFt0x
 15BI5l6fsCjDlddIINiF18ez3F5OmW0v9/MYTTpj3LrSEZVKMGgIYUufMHRFx4xJtR9TqzyLN7l
 gEZNpOYShvb12O44=
X-Received: by 2002:a1c:2dd0:: with SMTP id t199mr28489645wmt.58.1574692673968; 
 Mon, 25 Nov 2019 06:37:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyncxzSLqEtqlrgq8hNatlOYsdHE5OYlVxPfsVXiyLB6k4l7V+lbdwiF/YLFKKt2XYQ9fE+VA==
X-Received: by 2002:a1c:2dd0:: with SMTP id t199mr28489616wmt.58.1574692673669; 
 Mon, 25 Nov 2019 06:37:53 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id y6sm10931170wrr.19.2019.11.25.06.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 06:37:53 -0800 (PST)
Subject: Re: [PATCH] mos6522: update counters when timer interrupts are off
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191125141414.5015-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a274a621-b9ed-1090-23af-cf4d46a266b3@redhat.com>
Date: Mon, 25 Nov 2019 15:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125141414.5015-1-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: 0zmDW8fLPHCOyiCbkUIekg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 3:14 PM, Laurent Vivier wrote:
> Even if the interrupts are off, counters must be updated because
> they are running anyway and kernel can try to read them
> (it's the case with g3beige kernel).
>=20
> Reported-by: Andrew Randrianasulu <randrianasulu@gmail.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/misc/mos6522.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index aa3bfe1afd..cecf0be59e 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -113,6 +113,10 @@ static int64_t get_next_irq_time(MOS6522State *s, MO=
S6522Timer *ti,
>       int64_t d, next_time;
>       unsigned int counter;
>  =20

Can you add a comment here such "Clock disabled. This is the longest=20
time before expiration" or better?

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +    if (ti->frequency =3D=3D 0) {
> +        return INT64_MAX;
> +    }
> +
>       /* current counter value */
>       d =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_tim=
e,
>                    ti->frequency, NANOSECONDS_PER_SECOND);
> @@ -149,10 +153,10 @@ static void mos6522_timer1_update(MOS6522State *s, =
MOS6522Timer *ti,
>       if (!ti->timer) {
>           return;
>       }
> +    ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>       if ((s->ier & T1_INT) =3D=3D 0 || (s->acr & T1MODE) !=3D T1MODE_CON=
T) {
>           timer_del(ti->timer);
>       } else {
> -        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>           timer_mod(ti->timer, ti->next_irq_time);
>       }
>   }
> @@ -163,10 +167,10 @@ static void mos6522_timer2_update(MOS6522State *s, =
MOS6522Timer *ti,
>       if (!ti->timer) {
>           return;
>       }
> +    ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>       if ((s->ier & T2_INT) =3D=3D 0) {
>           timer_del(ti->timer);
>       } else {
> -        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>           timer_mod(ti->timer, ti->next_irq_time);
>       }
>   }
>=20


