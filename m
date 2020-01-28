Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A91C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D8024684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edkZtwxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D8024684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOgA-0004MR-1L
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwOdX-0001Bg-Cv
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwOdU-00033u-NZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:02:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwOdU-00033B-Jd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8rVeBiZwIBoo2EZxhnNWn7cLwjoW1rYqypgsM5f3L8=;
 b=edkZtwxuALvLl3K5qxayV4p8Z+VQmWtZmmhzqcpfnO6B64bxLcGdqf8MFWZuN7Eht1+wJ1
 iyn2pi+PALEB8l7l1vDDnNDVQU0p2xKeNJV0OceLE5KYXSLUReknnJhuoeVKNqv2i1pgDn
 f6GL6jNLrH20Xo/Ef3Chw5F4iKV2RkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-TN550ie-OGSUilxuHFWyPA-1; Tue, 28 Jan 2020 06:02:20 -0500
Received: by mail-wr1-f71.google.com with SMTP id j4so7852705wrs.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6DHwtDpAkWw73IPydwRKPpDr2DZrOHoAhTPFIbOqOBg=;
 b=ahCRTCj+1KCGz+JMi9KUb6C7tazJX/lbMfyUkiRRPdhkilToxIxBAUltvIFSQSeBq+
 HecxCR0Rd6KR76IXyOeUtB+9yd0fSGycohmwZ2mF0HBSQW7hmPtm5pkDcOnTA5xo9SKr
 dMY27aauBe0ne5zzfxIqz+HJzwmKqsMPWQVnKfzbCyYH1mh1aIT719aIAPTbL+0vKnfs
 RcgaAF7B5uhGHwdvntJOtq8CdEOpHJ5Wz5QAO4IitI40J6YMkMs2xRahCI/MTi+lVwN8
 qVpVfq5MBXb1T/1LPUuWTtrcRKsv7R7Xa+oiy7QJf2rp3b+ZAh2AqIhnnssT11AwFFbo
 bcDQ==
X-Gm-Message-State: APjAAAW2VeTQfEGd8YCJUzfiKtpk3evH/ed3zwWC1YEhniiGiSQoEkw6
 xwIfrXTI2lD9bRjL9g1irAwV+N8byP1HAFT7p1JdYlJZc5rqz3+VBdjdzY2hD+W/0jky7fWpFSH
 VkydtPd9OwOcmDio=
X-Received: by 2002:a7b:c216:: with SMTP id x22mr4527358wmi.51.1580209339167; 
 Tue, 28 Jan 2020 03:02:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkGxJzfqy3uNoFdoGnCBh+0iOOCd+rFJ4pAonjgL2M1xL7Q6DXiE9c+hQdvv1+QoWm+Z/irQ==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr4527329wmi.51.1580209338952; 
 Tue, 28 Jan 2020 03:02:18 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z19sm2407137wmi.43.2020.01.28.03.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 03:02:18 -0800 (PST)
Subject: Re: [PATCH v3 03/14] dp8393x: Clean up endianness hacks
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <9c3243048ebb89a2af674847c0570d0c84cc3e79.1579474761.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <204f80b4-89da-e393-8756-7fcdede8618e@redhat.com>
Date: Tue, 28 Jan 2020 12:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9c3243048ebb89a2af674847c0570d0c84cc3e79.1579474761.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: TN550ie-OGSUilxuHFWyPA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 11:59 PM, Finn Thain wrote:
> According to the datasheet, section 3.4.4, "in 32-bit mode ... the SONIC
> always writes long words".
>=20
> Therefore, use the same technique for the 'in_use' field that is used
> everywhere else, and write the full long word.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> ---
> Changed since v1:
>   - Use existing 'address' variable rather than declare a new one.
>=20
> Laurent tells me that a similar clean-up has been tried before.
> He referred me to commit c744cf7879 ("dp8393x: fix dp8393x_receive()")
> and commit 409b52bfe1 ("net/dp8393x: correctly reset in_use field").
> I believe the underlying issue has been fixed by the preceding patch,
> as this no longer breaks NetBSD 5.1.
> ---
>   hw/net/dp8393x.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index b2fd44bc2f..2d2ace2549 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -776,8 +776,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>           return -1;
>       }
>  =20
> -    /* XXX: Check byte ordering */
> -
>       /* Check for EOL */
>       if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
>           /* Are we still in resource exhaustion? */
> @@ -847,15 +845,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>           /* EOL detected */
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
>       } else {
> -        /* Clear in_use, but it is always 16bit wide */
> -        int offset =3D dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
> -        if (s->big_endian && width =3D=3D 2) {
> -            /* we need to adjust the offset of the 16bit field */
> -            offset +=3D sizeof(uint16_t);
> -        }
> -        s->data[0] =3D 0;
> -        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
> -                         (uint8_t *)s->data, sizeof(uint16_t), 1);
> +        /* Clear in_use */
> +        size =3D sizeof(uint16_t) * width;
> +        address =3D dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
> +        dp8393x_put(s, width, 0, 0);
> +        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> +                         (uint8_t *)s->data, size, 1);
>           s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
>           s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->re=
gs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


