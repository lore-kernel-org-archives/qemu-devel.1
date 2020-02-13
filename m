Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE199C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 19:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BC42168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 19:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQgQQ/WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BC42168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Jm7-0006zY-Mw
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 14:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2Jl1-00067R-RN
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2Jl0-0006Iz-LD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:02:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2Jl0-0006H4-H5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 14:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581620557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5l0cpDNs72SdYpxM3AvRXNh6WU6PsGxpi4pOcJdpyM=;
 b=OQgQQ/WJprERvkZFJW4MLWXKP/d3zNb+gaSHJhQ6VPeRmM+et9XtC0u4/l0eOCzcOS6+oo
 ScZ8UF2jiGpUt8H7crSnBxS7iwLntnrqr2Dvn7kxORKSnYbgG0verEK6LEGgg1hQWa42Iv
 YX+Ns75TpKftRoSm/oH0LVAPMkybFMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-LoqaqoVFOM6iZIhkzGBM5w-1; Thu, 13 Feb 2020 14:02:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id a12so2754155wrn.19
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 11:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J6P5diqcf5X9RET4FJh19AItd0eodJa51znqthgQRcE=;
 b=BS/aT1qvc8l0Uv3eX1CQntcIkRdx4Dlq4wWdQR/DBttg/VHl86muEuTLpzPRp5QJWw
 IbHHwR2g/pECdj0bbTPD6sZJLXhrjN2gpl1BZmMST3j8SFwVeurzxgwR5BrSPI2lrl+x
 vpbS+GvDtS8H7csdnQhcJ0YqgiQJetA87mKalC3h04y0eBDTw7TiX33+7rHYEgotHgKd
 lTKg5FBp/AOy2swgfCBdFALQ8wFWeiAo/F3JHeEX6Ux4d+sWCxEzx09rPPLdZ9p9LC/n
 Qw9etYQEMUVGGVhhZUYDpsAov8gypN92PPgYmzjfaccWNeAiS7nvxuVJhVkMGCH/wY38
 z8OQ==
X-Gm-Message-State: APjAAAW9Bnw+S3cRz6f1/sTIyztblUY8uf5g4pjW/xZBQrleXOtEkwd+
 412+duAAkzlrad0S72nBzTJyLrcy8Wl1TIxi20dWX8zB8Khmel5oRUio4DnzQV6h/GipicaGM0M
 Dd/yC7bzYORSvTAw=
X-Received: by 2002:a5d:5647:: with SMTP id j7mr23166889wrw.265.1581620552633; 
 Thu, 13 Feb 2020 11:02:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxka+K6cLsHv1a2uMBCTG7uDeYetBGx6x6eaN5HuKATZdCiZfs/tsdzdGSwHrP4PtbPh2MOzA==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr23166869wrw.265.1581620552440; 
 Thu, 13 Feb 2020 11:02:32 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h2sm4143707wrt.45.2020.02.13.11.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 11:02:31 -0800 (PST)
Subject: Re: [PATCH v2 17/30] qapi/migration.json: Replace _this_ with *this*
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-18-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41398e32-fc7f-21d4-2318-18e6453d4fee@redhat.com>
Date: Thu, 13 Feb 2020 20:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213175647.17628-18-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: LoqaqoVFOM6iZIhkzGBM5w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 6:56 PM, Peter Maydell wrote:
> The MigrationInfo::setup-time documentation is the only place where
> we use _this_ inline markup for emphasis, commonly rendered in
> italics.  rST doesn't recognize that markup and emits literal
> underscores.
>=20
> Switch to *this* instead.  Changes markup to strong emphasis with
> Texinfo, commonly rendered as bold.  With rST, it will go right back
> to emphasis / italics.
>=20
> rST also uses **this** for strong (commonly rendered bold) where
> Texinfo uses *this*. We have one place in the doc comments
> which uses strong/bold markup, in qapi/introspect.json:
>      Note: the QAPI schema is also used to help define *internal*
>=20
> When we switch to rST that will be rendered as emphasis / italics.
> Markus (who wrote that) thinks that using emphasis / italics
> there is an improvement, so we leave that markup alone.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> v1->v2: updated commit message. Paras 1 and 2 are from Markus;
> paras 3 and 4 are new, and mention a non-change agreed in
> the thread off the cover letter of the v1 patch series.
> ---
>   qapi/migration.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 11033b7a8e6..52f34299698 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -178,8 +178,8 @@
>   #                     expected downtime in milliseconds for the guest i=
n last walk
>   #                     of the dirty bitmap. (since 1.3)
>   #
> -# @setup-time: amount of setup time in milliseconds _before_ the
> -#              iterations begin but _after_ the QMP command is issued. T=
his is designed
> +# @setup-time: amount of setup time in milliseconds *before* the
> +#              iterations begin but *after* the QMP command is issued. T=
his is designed
>   #              to provide an accounting of any activities (such as RDMA=
 pinning) which
>   #              may be expensive, but do not actually occur during the i=
terative
>   #              migration rounds themselves. (since 1.6)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


