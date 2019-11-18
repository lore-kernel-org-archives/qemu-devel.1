Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B3C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89BC206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfnZKmsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89BC206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWg7d-0004UY-MH
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 07:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWg6h-0003ct-ER
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWg6f-0001hG-PP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:26:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWg6f-0001gl-GB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574079972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ib5KKhD5HJk0z9NsNcG+DYUAl/uqORxihVH5ZKzHyY8=;
 b=PfnZKmsHs2p5/KCbh6yBGjc9+Lc9DbsDVoUdAp1k7XA1t1W3un2wXzy8vlmlbwBugxSV3/
 rDlr71dq6qGOqaxmmLZLMsyKmS+4twWFCmMt8fiHPeigZ60cyRAFsAStDYLQr+o5+NavQa
 OyNVdOxJpH6vpQsBHoV0Db8h0o4dygw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-P298iz7LPo69tFa6dXHO9g-1; Mon, 18 Nov 2019 07:26:11 -0500
Received: by mail-wr1-f72.google.com with SMTP id c16so15244512wro.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 04:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k3zctEOJ/bTdP4mIF4ywjSUD0sBgS+dq3Ce/p9kgI94=;
 b=eiPOhagNtEWelMc2VYjPqa23TwXRnJQjkgWmgOnuXFkoQ0PCleVWdN75dY8ggXReiM
 MbP10BMU36Pmk9g3WwjUaIe+Jg+mPwOkxrs6Xj3XHywstPF5Agf2RN7I/V0cv8M9Tybm
 cJtED3EO/3+PHLE9Moz8+qFHzUvQQOdX9kTIhmxpTAFZu1WOPagfWa3GGpxv1eCMeXEn
 iC2t+OF4jND897cJCx+U3fecTFtWlgpTYLCwxaI65ffWF8lIaTUKdBmF+acI35KzohVT
 C5AeouxmW9JSOlkG9Pcw8BOyH7C2H6tEIEmCVAiHFEAEpdeBYUrKSBlOMzw1mbhwVQtf
 058A==
X-Gm-Message-State: APjAAAVpVsIWlXXk9pP/2i3ln6cDXVzHykS0tLFoiRrchteA7jVbciWL
 CPGk59/XfVpq5jbw/gIEf0+Xea3T2FpUVNQrk5d018HlYcrU4xenJVRTsYrKKU8oLEuhr0/K/N2
 b7TAPIrO8z0nD8dQ=
X-Received: by 2002:a1c:7701:: with SMTP id t1mr31250533wmi.113.1574079970120; 
 Mon, 18 Nov 2019 04:26:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJV0z2Tj4vVSxYg6gLNZzLq/P82KJ0E/dg75/0Qg/iEV1tGkQ+weouSCb9xyAvPP0b9FBYZQ==
X-Received: by 2002:a1c:7701:: with SMTP id t1mr31250514wmi.113.1574079969955; 
 Mon, 18 Nov 2019 04:26:09 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id d7sm23350868wrx.11.2019.11.18.04.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 04:26:09 -0800 (PST)
Subject: Re: [PATCH 1/3] MAINTAINERS: Add hw/sd/ssi-sd.c in the SD section
To: qemu-devel@nongnu.org
References: <20191012065426.10772-1-philmd@redhat.com>
 <20191012065426.10772-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <46d94900-e916-54e2-06e6-1963fbed3bb8@redhat.com>
Date: Mon, 18 Nov 2019 13:26:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191012065426.10772-2-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: P298iz7LPo69tFa6dXHO9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 10/12/19 8:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The hw/sd/ssi-sd.c file is orphean, add it to the SD section.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ca814850e..47eae9fc46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1445,6 +1445,7 @@ S: Odd Fixes
>   F: include/hw/sd/sd*
>   F: hw/sd/core.c
>   F: hw/sd/sd*
> +F: hw/sd/ssi-sd.c
>   F: tests/sd*
>  =20
>   USB
>=20


