Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7942C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8F420706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8qtvIDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8F420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEve-0003Wj-QY
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEub-0002U4-Eq
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEuZ-0001qK-TU
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:25:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEuZ-0001nf-I4
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576358714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5oBDMa4KtrZ2kufsgL8Sh4aJRNLiLuB6uqjhW7GJYk=;
 b=L8qtvIDq9K1Ey3wBz4X+atd349FHnRTqHSbvj7IQxXbPkSHEVVvRXleumhjUC59Ejgc6Db
 y2cyf27ITZB6UgS6uvBrnozSeICGZnkW1f0fTon3vbK0/hvslW2XxZMwSlxNnZQmmewP2v
 Kso8+6MqzQMf+ANsAQ7KpCKjLZbsZSQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-1FXbIV_4Mf-eJ-2p_zg-EQ-1; Sat, 14 Dec 2019 08:21:49 -0500
Received: by mail-wr1-f71.google.com with SMTP id c17so977136wrp.10
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d7RtwqDg2DrajbSySBsHDz5ogUz2pQQIW9Bw5eEjeBM=;
 b=K4NQMWyZ57eV0FvkRT2W7IgXfOjQcV0M1enYHlANGfsy4RQ47VFT0owWdSxNDYRrJL
 0XNYE7G1dlIvxJIf7Rvd4P/spGUeZBMzmbpoHl5kYVgtA8qj5SiDdFzRzE/gjDUxbVgX
 nay6uAnKiizhjqJ0nN3hdatT73o7YL3ig/QQe2CoTP9uLJSrDK7FepaDX4SrhOfKPbBJ
 s3kA/XbHdxnY8HwJQS24iYbNO43raP2Jc85/tfQ1OB6rEzfWkCmpg74oQXatCDBlRy4F
 4mW+GlwpGot4YwsbVUQn/FyEvb+1hkbX7Rrw0rS+5dIjK8ZsrvCLVUXLtwmuZ6uGLGnB
 JEXQ==
X-Gm-Message-State: APjAAAWwJaN1HAIzZAzKW+sj6BwjSMICvKojGP8gCNTM2O/lngpLP0gf
 5k801x9MOQValKt7dXYoeZpxZmR3jc9POOKdVCBtxiYeN4HIBbGbszmyby/qb/xn4295kv1FnjG
 MkJQBrFEoGU7bgwE=
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr18294731wrm.324.1576329708243; 
 Sat, 14 Dec 2019 05:21:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvguYKymq3AdD+i7VJXMMfVJYgWAqgsgsP7ZIBMZYYgkvJiOLvcY+6+ftb23hUuhKQjJWtTg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr18294710wrm.324.1576329708062; 
 Sat, 14 Dec 2019 05:21:48 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x10sm13877865wrv.60.2019.12.14.05.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:21:47 -0800 (PST)
Subject: Re: [PATCH 10/10] dp8393x: Don't clobber packet checksum
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <25b17f31c0bf60f6f1a2915709e9ee2d57f7f230.1576286757.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <edadb5b3-c5e0-bd04-7226-3b93eeecb177@redhat.com>
Date: Sat, 14 Dec 2019 14:21:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <25b17f31c0bf60f6f1a2915709e9ee2d57f7f230.1576286757.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: 1FXbIV_4Mf-eJ-2p_zg-EQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Herve Poussineau <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/14/19 2:25 AM, Finn Thain wrote:
> A received packet consumes pkt_size bytes in the buffer and the frame
> checksum that's appended to it consumes another 4 bytes. The Receive
> Buffer Address register takes the former quantity into account but
> not the latter. So the next packet written to the buffer overwrites
> the frame checksum. Fix this.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>   hw/net/dp8393x.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 8e66b1f5de..9f4162c98c 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -810,6 +810,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>       address +=3D rx_len;
>       address_space_rw(&s->as, address,
>           MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
> +    address +=3D 4;
>       rx_len +=3D 4;
>       s->regs[SONIC_CRBA1] =3D address >> 16;
>       s->regs[SONIC_CRBA0] =3D address & 0xffff;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


