Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183FAC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 05:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42B720CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 05:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A86mzctf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42B720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6SzE-0008VM-0r
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 00:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j6Syd-0007sT-HR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j6Syc-0006A1-IG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:41:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j6Syc-00069n-FF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582609310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vk9ybKTfqFyPt8H/hWiVLqk4DQGRcqNb//UpSaxQcqg=;
 b=A86mzctf6rgBoJ+A2+BzR191GlrZhKNKhQ8Yi/5luQADYp3LJHRWRCupE6yRGiUADO+baR
 rTYlBqCA1NMUMaNqBi+OkIG3HHwpRjQSzxjt50T1jXCrlXsGkBHnzZfdYxol/r5ji3uCQ8
 KR5Q0iFTdW8qkPO9e3wJm5iJ2MBgUY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-kyLzb73-OY-lN27p22XJJQ-1; Tue, 25 Feb 2020 00:41:46 -0500
X-MC-Unique: kyLzb73-OY-lN27p22XJJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FADC18AB2C0;
 Tue, 25 Feb 2020 05:41:44 +0000 (UTC)
Received: from [10.72.13.170] (ovpn-13-170.pek2.redhat.com [10.72.13.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9018A5C651;
 Tue, 25 Feb 2020 05:41:39 +0000 (UTC)
Subject: Re: [PATCH] hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200225025923.19328-1-kuhn.chenqun@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9206dda7-0e12-b68e-87ca-1985b61381bc@redhat.com>
Date: Tue, 25 Feb 2020 13:41:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200225025923.19328-1-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, peter.chubb@nicta.com.au,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/25 =E4=B8=8A=E5=8D=8810:59, Chen Qun wrote:
> The current code causes clang static code analyzer generate warning:
> hw/net/imx_fec.c:858:9: warning: Value stored to 'value' is never read
>          value =3D value & 0x0000000f;
>          ^       ~~~~~~~~~~~~~~~~~~
> hw/net/imx_fec.c:864:9: warning: Value stored to 'value' is never read
>          value =3D value & 0x000000fd;
>          ^       ~~~~~~~~~~~~~~~~~~
>
> According to the definition of the function, the two =E2=80=9Cvalue=E2=80=
=9D assignments
>   should be written to registers.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> I'm not sure if this modification is correct, just from the function
>   definition, it is correct.
> ---
>   hw/net/imx_fec.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 6a124a154a..92f6215712 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -855,13 +855,13 @@ static void imx_enet_write(IMXFECState *s, uint32_t=
 index, uint32_t value)
>           break;
>       case ENET_TGSR:
>           /* implement clear timer flag */
> -        value =3D value & 0x0000000f;
> +        s->regs[index] =3D value & 0x0000000f;
>           break;
>       case ENET_TCSR0:
>       case ENET_TCSR1:
>       case ENET_TCSR2:
>       case ENET_TCSR3:
> -        value =3D value & 0x000000fd;
> +        s->regs[index] =3D value & 0x000000fd;
>           break;
>       case ENET_TCCR0:
>       case ENET_TCCR1:


Applied.

Thanks



