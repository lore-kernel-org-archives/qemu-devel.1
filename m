Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02CDC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DD020838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXd0szwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DD020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeSk-0002ig-MD
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyeRt-0002I0-VL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyeRr-0005rZ-Py
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:19:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyeRr-0005mN-Mc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580746779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zaz2Kx17/BYVLkO9mDlw8JTRZd8sVdQDzmBUfAgalZM=;
 b=UXd0szwpy7VvMY1UKB8Eq+qq2fFQ2vvEbToGNBSdbTIVGeibXLcikTq+JDGoJs7sJGCcre
 gX/X7931+1Z64t508PgtsVihhu5dK4RHnE+j3zTfEyrN4OeTt4gY/iFNtSRnCXyLYOqjVj
 eySotXtNcd6j4Y9S/U9nHc2RTxvRZ28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-KggFmDvhO72_1n75qdtxEQ-1; Mon, 03 Feb 2020 11:19:36 -0500
Received: by mail-wm1-f69.google.com with SMTP id b133so4226045wmb.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tFWypYmzw4tyj9keJeeI6MmB3L1wjUJH2u9WZ6jlS7E=;
 b=gOS+LnBwAj/XboVkOYOqOuUVcXkcWlr/wij/AEE/Q1MlBCfNqM/d5MNR6pnHBD60lA
 UIvT+Ld78wc/lWfwYCZe5+uPry8P3jlbAzkXug/kWc/Op2pElqhQl4qwhgJluEhH1UXz
 QWIlRj+9KHX2CJWiA1gEVv+b3z1Kerx/DNvZXGRqomtMW1dK3Bz32tGX/m6NQtYElDl/
 dTbo7RiVicQYoiKPIMs4TbnVSc5wGoS8odhv7v8MBipFwyaWWAE8UpF6dbs1WGWIsugY
 eYLnAjaU/8h+KmBeMXfKCAj8gqYyDDPzPQGGKvhQdh/4V4ph/fMb/lPNCk1mDd41VdOr
 mk2A==
X-Gm-Message-State: APjAAAVgzhkhEOgwodPaAX+RXae+CEBGd5UJDr05PkPHvVJjGwD2nKhU
 6kv+7khR+rZ1T7jx+imFxD0+R5mH4SM5KEWT5kamn23+Wqqy5aGCYBQDGnntVm4zHDeFjhBERUi
 L2YZrrEDAYToJXtw=
X-Received: by 2002:adf:9b87:: with SMTP id d7mr17042858wrc.64.1580746774951; 
 Mon, 03 Feb 2020 08:19:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzO7mCiGKU2djOtJthGzyyYtwv+Y+57rK6OptT5PwqyddlDMUaG2Tx7eQBq6SWaIqV+8/SLNQ==
X-Received: by 2002:adf:9b87:: with SMTP id d7mr17042845wrc.64.1580746774762; 
 Mon, 03 Feb 2020 08:19:34 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id y7sm288996wmd.1.2020.02.03.08.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 08:19:33 -0800 (PST)
Subject: Re: [PATCH] Makefile: Fix typo in dependency list for interop manpages
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200203154232.10648-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aaa7f202-4241-d16e-9550-83bb24b2dbb7@redhat.com>
Date: Mon, 3 Feb 2020 17:19:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203154232.10648-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: KggFmDvhO72_1n75qdtxEQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 4:42 PM, Peter Maydell wrote:
> Fix a typo in the dependency list for the manpages built from the
> 'interop' manual, which meant we were accidentally not including
> the .hx file in the dependency list.
>=20
> Fixes: e13c59fa4414215500e6
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Oops...
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 1f37523b528..588a2993d93 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1052,7 +1052,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual=
-deps,system)
>  =20
>   $(call define-manpage-rule,interop,\
>          qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1 virtfs-proxy-h=
elper.1,\
> -       $(SRC_PATH/qemu-img-cmds.hx))
> +       $(SRC_PATH)/qemu-img-cmds.hx)
>  =20
>   $(call define-manpage-rule,system,qemu-block-drivers.7)
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


