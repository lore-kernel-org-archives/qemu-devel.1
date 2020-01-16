Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC3DC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC969207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL91XEDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC969207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9rP-0004Vp-TH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is9qF-0003pq-K5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is9qC-0004hp-4Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:26:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is9qC-0004hQ-0U
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579199159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wb3uvWE//pbl5HIWjx8Nx0ie/6KPJsZZo9m0HmU93k=;
 b=gL91XEDclLNsOXktfAhHWcJAU/DMslggevajXDZp08X7fVsLrzGa1QdhCKhqXBuge0ZlQd
 hlZY256eaFFEKxw4cMEhY2XIno1stI4sQ/ag/HlH8raohGTY9yWmEw8xYgwUnH+EstkpAD
 /biqw7YHZPuSfckq/ZRdx8IkhdSTvEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-lvjVnEoAMvSh49Huf_V6Kw-1; Thu, 16 Jan 2020 13:25:58 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so9544375wrt.15
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c/c8V5rf2/aAXQloIrsK2RPGfgbVJD1aae0hGkuaRUc=;
 b=EX78x+RTWAndGcfmbP0Y8XQZcGTqZh58iTYa+jyh1jk5fv3Cu+5ZS8KTrdWO9WAQFX
 jndielqdKhDbCyz3+KRcJrt0J49ckFKIKCMvvDwmlIkQ8ZZ+20NU6q9r/6FSF8DAXFht
 CC2QaX6K1PyOSG0h1btviFqZTrEB8yxBU6mxDzEBXI7tpIX6k3EylbECRUvf1SsI6v9s
 wINBdpLvLwof7Nnwfb3L2zpEq2Ioc+KgipZMGIsEITUmLx2N7ilNeMsoIewG213vFMip
 YtETA3D9LO9f1Yq8p+D4WKRuoEjLxPQFvQYcGIPEmrql3HhcmyJAVTWj4m+RByeYTBkF
 L1Jg==
X-Gm-Message-State: APjAAAVN10pw5kYk7OR+Sx8nTsHklwR1N7ItemtW/i+vfhDlB6mvLzbj
 QF3EOMwCADU/o1e5egoZVBFc0Q9coQJ39pQkavDBsGpj4xryrXKNhONviRdv293rlZGVbVJjjSN
 AKqlLLTZQOy/+Mu4=
X-Received: by 2002:adf:d184:: with SMTP id v4mr4652796wrc.76.1579199156875;
 Thu, 16 Jan 2020 10:25:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw144x1PcEjEHgFGRI3gzp5sO/V4YEQxE/gobRDdPC6z+KmBEBwFmquqVfqE9Tt8QUptSbyJA==
X-Received: by 2002:adf:d184:: with SMTP id v4mr4652773wrc.76.1579199156615;
 Thu, 16 Jan 2020 10:25:56 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id v17sm30106941wrt.91.2020.01.16.10.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:25:55 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: update Leif Lindholm's address
To: Leif Lindholm <leif@nuviainc.com>, qemu-devel@nongnu.org
References: <20200116174226.4780-1-leif@nuviainc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a2fc8a4f-0b56-7868-0e52-51c2abfd97f7@redhat.com>
Date: Thu, 16 Jan 2020 19:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116174226.4780-1-leif@nuviainc.com>
Content-Language: en-US
X-MC-Unique: lvjVnEoAMvSh49Huf_V6Kw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 6:42 PM, Leif Lindholm wrote:
> Update address to reflect new employer.
>=20
> Signed-off-by: Leif Lindholm <leif@nuviainc.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 483edfbc0b..3c8653f26f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -735,7 +735,7 @@ F: include/hw/ssi/imx_spi.h
>   SBSA-REF
>   M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
>   M: Peter Maydell <peter.maydell@linaro.org>
> -R: Leif Lindholm <leif.lindholm@linaro.org>
> +R: Leif Lindholm <leif@nuviainc.com>
>   L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/arm/sbsa-ref.c
>=20

You might want to add yourself a .mailmap entry too:

-- >8 --
diff --git a/.mailmap b/.mailmap
index 3816e4effe..a521c17b44 100644
--- a/.mailmap
+++ b/.mailmap
@@ -44,6 +44,7 @@ Aleksandar Markovic <amarkovic@wavecomp.com>=20
<aleksandar.markovic@imgtec.com>
  Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori=20
<aliguori@us.ibm.com>
  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
+Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
  Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
---

If you ack this snippet maybe a maintainer is willing to amend it to=20
your patch :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


