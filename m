Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C13EC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F11E24681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BER/Qc8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F11E24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOwx-0000tO-8v
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwOwB-0008Ba-CC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwOwA-0001ve-5Q
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:21:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwOwA-0001vP-2G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580210501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xl0AGvDGESJZM3pYxC4MoVZ+NmyQ3avCEV2OSBOjAvM=;
 b=BER/Qc8ISemlYDQG/v8aP5M4hfDpgTGGLO8TNhKBQLkplfB9HgqcbFO63WYGw3+7PObWu0
 Zxi4XZUEXnUgj6tv44MJDmYHJehQRcQBWayI/NK5+Ki7ojikC0BYEHg6jAga1Cdyk1gsWA
 EjKxK0suf94q+Fj+OGghLF1Re3pxXW4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-UT3os18cNXO40zGmPFt-vQ-1; Tue, 28 Jan 2020 06:21:39 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so7825183wrx.22
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Os7trfyMxqeoJLW6G2Xm7YUeldL4MySAizGdMy8/HhA=;
 b=DQFca2XwFd8JnhXsTEqVdObR5QI/6z1OxV3vHYZpzRWoiQ4aYZhb8BUSj+ewq3/bqQ
 FP/oSrpxyMVMmPsvln4Q4+Jf/d4rcSYrlqpYBrjSolkA4vBSx8F7DjvsHTDD8MvxVmNg
 0pqcc2BXo4aLBs90ffFQ+eaqhGs5s6ojeptMfZNxI6PjyQ/bQoT+kRf3sSzA+vvLkmp4
 PAWi+8E1/GUsL0e3RAyFHpwdamPIIr/lHGdL4Vmu5gF7+aaDFZ0xm84BKJKBGb968CGh
 ZzvETdtSBTkXp+BNLJjEU3FtMrZHFASlzEzdWoYYSzFt9aN9adMUi9l7oEATvIx/k/FX
 Cb7g==
X-Gm-Message-State: APjAAAVrtpFQtkFiKcwIX0OCKnBmZt6XYewsxE2SwVQjJXRLrEdBX6bw
 TWfPQyn/7jLOHe07t8kwZNXCzE8XkPvTqmv9wRDIM7aQEJPuDgn6U9iFbzI9mdqRNcNia3iGsbp
 iroZBOrn7UrTXkO0=
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr4441078wme.82.1580210497798;
 Tue, 28 Jan 2020 03:21:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqnMN/7NXQiVXTc29T2uKJ1HhdTZnn+QZ+wwtcxms2LqYorKOJlJ6YreAtGmWOYW0pSPXdPw==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr4441031wme.82.1580210497464;
 Tue, 28 Jan 2020 03:21:37 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f18sm1711453wrt.75.2020.01.28.03.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 03:21:36 -0800 (PST)
Subject: Re: [PATCH v3 01/14] dp8393x: Mask EOL bit from descriptor addresses
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <e5d4133abf4ecbb37d4abc45d7166cbd3cfac1d4.1579474761.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7b06341-d433-1f39-19ad-cbe52106398c@redhat.com>
Date: Tue, 28 Jan 2020 12:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e5d4133abf4ecbb37d4abc45d7166cbd3cfac1d4.1579474761.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: UT3os18cNXO40zGmPFt-vQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Finn,

On 1/19/20 11:59 PM, Finn Thain wrote:
> The Least Significant bit of a descriptor address register is used as
> an EOL flag. It has to be masked when the register value is to be used
> as an actual address for copying memory around. But when the registers
> are to be updated the EOL bit should not be masked.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> ---
> Changed since v1:
>   - Added macros to name constants as requested by Philippe Mathieu-Daud=
=C3=A9.
> ---
>   hw/net/dp8393x.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index cdc2631c0c..14901c1445 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -145,6 +145,9 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __=
VA_ARGS__); } while (0)
>   #define SONIC_ISR_PINT   0x0800
>   #define SONIC_ISR_LCD    0x1000
>  =20
> +#define SONIC_DESC_EOL   0x0001
> +#define SONIC_DESC_ADDR  0xFFFE

I'd rather not add SONIC_DESC_ADDR and use ~SONIC_DESC_EOL instead.

Please consider it if you respin the series.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
>   #define TYPE_DP8393X "dp8393x"
>   #define DP8393X(obj) OBJECT_CHECK(dp8393xState, (obj), TYPE_DP8393X)
>  =20
> @@ -197,7 +200,8 @@ static uint32_t dp8393x_crba(dp8393xState *s)
>  =20
>   static uint32_t dp8393x_crda(dp8393xState *s)
>   {
> -    return (s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA];
> +    return (s->regs[SONIC_URDA] << 16) |
> +           (s->regs[SONIC_CRDA] & SONIC_DESC_ADDR);
>   }
>  =20
>   static uint32_t dp8393x_rbwc(dp8393xState *s)
> @@ -217,7 +221,8 @@ static uint32_t dp8393x_tsa(dp8393xState *s)
>  =20
>   static uint32_t dp8393x_ttda(dp8393xState *s)
>   {
> -    return (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA];
> +    return (s->regs[SONIC_UTDA] << 16) |
> +           (s->regs[SONIC_TTDA] & SONIC_DESC_ADDR);
>   }
>  =20
>   static uint32_t dp8393x_wt(dp8393xState *s)
> @@ -506,8 +511,8 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
>                                sizeof(uint16_t) *
>                                (4 + 3 * s->regs[SONIC_TFC]) * width,
>                   MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> -            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
> -            if (dp8393x_get(s, width, 0) & 0x1) {
> +            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0);
> +            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
>                   /* EOL detected */
>                   break;
>               }
> @@ -763,13 +768,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>       /* XXX: Check byte ordering */
>  =20
>       /* Check for EOL */
> -    if (s->regs[SONIC_LLFA] & 0x1) {
> +    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
>           /* Are we still in resource exhaustion? */
>           size =3D sizeof(uint16_t) * 1 * width;
>           address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
>           address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>                            (uint8_t *)s->data, size, 0);
> -        if (dp8393x_get(s, width, 0) & 0x1) {
> +        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
>               /* Still EOL ; stop reception */
>               return -1;
>           } else {
> @@ -827,7 +832,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>       address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * w=
idth,
>           MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
>       s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
> -    if (s->regs[SONIC_LLFA] & 0x1) {
> +    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
>           /* EOL detected */
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
>       } else {
>=20


