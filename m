Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EEEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840E420716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbBv/Bur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840E420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqNp-0007PO-HD
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwqN0-0006qi-Qn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwqMz-0003XE-Mm
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:39:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwqMz-0003X3-J3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580315953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKfF0MZ3HXCNfmg5aoszqlZX0PWbwegwtp28yOqUqEQ=;
 b=HbBv/BurdIn2laeqYvKx4NKBK3Uiwetqm20u3BmUaPUTa4VTiHeDr6bBpbiQYBImQLkRFJ
 jw84pn530afNBbRgqZ3CWHDkn1g+ofIRLRq3iSVzqIhthJtdvYfX8uEwM/JF4/W8ZHG3L9
 hyKIPJNZPvJggTHf4yqXMYEEprboLz8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-5uUmkYBFNViiV5SBxKbx1g-1; Wed, 29 Jan 2020 11:38:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so75170wrm.17
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 08:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BTKgG5+ZQjP1T1V1c9FKMZTWgpTC2CWHL3hbpBmO52I=;
 b=aABu0rd9v/Ep50TJHvgavOhA9RC0btfezlaPGKGQ0Wzdhg7AogRTGLkmfHfeVH9wBE
 X7rysQVcdy2BvVMnOG/y83X6Lu8RPclFw1kKvarow5NPkW/elZDiltKls53icVBNRBGM
 KJZs+tVOE5GfMnMPutKrg9cCpY2DdNeDhb492McC7RGF4O7nq9Nc2dBAZeUEGJXWAzTT
 t61//dvWcE1DJjftLd0KPcuV+WsT7cLPb7RY/ewN5jxQ3R5UW9Jv77IAAkBxfBTtdOyb
 DtKvFevwX0m8olxokIoAmtnqFYSh6tqJCIYnznbohO7kJCBPJAgPCsrPP6nRdbEWXyq4
 tQoQ==
X-Gm-Message-State: APjAAAXcIwlFpl2l+xZON0M/9Ct4z2fzSX99lXDOsX9Ue3kjhv1rws6u
 2WYPF9kLcI1maVkOKnY0/s744qPzTx0uzRApl5Z2TIAah5iDOSMP/fevs8/6wo1ocOsVOleg7Ja
 xU1ghXtH0UVcefUo=
X-Received: by 2002:a5d:620b:: with SMTP id y11mr35792437wru.230.1580315935032; 
 Wed, 29 Jan 2020 08:38:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzU4ZAYJl0kvdHJKlftpyAU6MCIdMeCBteK3kM4w/BE6YKBkwcj9ekKk2Rnuq6Q5nvhH9O9LQ==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr35792416wru.230.1580315934839; 
 Wed, 29 Jan 2020 08:38:54 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q11sm3531455wrp.24.2020.01.29.08.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 08:38:54 -0800 (PST)
Subject: Re: [PATCH v4 05/14] dp8393x: Update LLFA and CRDA registers from rx
 descriptor
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <dae9a2e3f6cdd403e6afab901b234a8b7f3289b8.1580290069.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <89052ffa-385e-f892-8b60-4de22192ccd9@redhat.com>
Date: Wed, 29 Jan 2020 17:38:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <dae9a2e3f6cdd403e6afab901b234a8b7f3289b8.1580290069.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: 5uUmkYBFNViiV5SBxKbx1g-1
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

On 1/29/20 10:27 AM, Finn Thain wrote:
> Follow the algorithm given in the National Semiconductor DP83932C
> datasheet in section 3.4.7:
>=20
>      At the next reception, the SONIC re-reads the last RXpkt.link field,
>      and updates its CRDA register to point to the next descriptor.
>=20
> The chip is designed to allow the host to provide a new list of
> descriptors in this way.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> ---
> Changed since v1:
>   - Update CRDA register from LLFA register after EOL is cleared.
> ---
>   hw/net/dp8393x.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index ece72cbf42..249be403af 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -784,12 +784,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>           address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
>           address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>                            (uint8_t *)s->data, size, 0);
> -        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
> +        s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
> +        if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
>               /* Still EOL ; stop reception */
>               return -1;
> -        } else {
> -            s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
>           }
> +        /* Link has been updated by host */
> +        s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>       }
>  =20
>       /* Save current position */
> @@ -837,7 +838,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>       address_space_rw(&s->as, dp8393x_crda(s),
>           MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
>  =20
> -    /* Move to next descriptor */
> +    /* Check link field */
>       size =3D sizeof(uint16_t) * width;
>       address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * w=
idth,
>           MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> @@ -852,6 +853,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>           dp8393x_put(s, width, 0, 0);
>           address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>                            (uint8_t *)s->data, size, 1);
> +
> +        /* Move to next descriptor */
>           s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
>           s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->re=
gs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
>=20


