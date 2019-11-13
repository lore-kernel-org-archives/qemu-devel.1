Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86519C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F3A2247C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoZs+5pR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F3A2247C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvRB-0004te-HX
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUvQL-0004GK-3i
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUvQK-0007zW-3k
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:23:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUvQJ-0007zB-Ve
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573662195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgoF8E4Yne5VhEuuG4d9vx31ZDE3hDjwBqVa0mKf8so=;
 b=HoZs+5pRjhJV5duYgNRROF/xyeh8lI68eH+gvzfiCCL9ErmSEqAeAmDpdQqkBM4yoO0Nls
 JlgyNSKq9acY3tZDs0ji1+0p5f/qmkcSdEE1klEWOzTQWvhtIj+FszG5br6mgLqY7bo3UV
 COLaHthAzTOyGNa6muFHbA9OIIYBe0E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-2iwWwihSPOismPy5LWQLXA-1; Wed, 13 Nov 2019 11:23:14 -0500
Received: by mail-wm1-f70.google.com with SMTP id g14so1627245wmk.9
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 08:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yypu2xCV+xXLYydQQgJ5QFBb37BwpWizbLxbpPE4kfo=;
 b=IYzP8qlNOD3ucKzhnCk9www4vPiQJeH7V9oj2vX1DJ1e3//JUHKvj2sCV+4kIKkkUv
 FVW6bK7u8x5B3sRsQPeQxTa8unA66JnA6UDDqvoUVg26repnPP/3Ke0+aaKN8daAzeSA
 bFedEy3Utk/UU1kelYyzsPmcUX6rM+dV5EN6xoL+Ick6qH1acVlsGnbWa+Hvymb/9eah
 xG791unv3U9lD1lCICJ3/0TV84DenQCwTX5HWatRtZxHTjCAgR8i+CTw1eNMoaJQQn5Y
 FR+pfoWK+uOGhmpG4RUx6v7wiLO7z8Fziku+B2q4IR+zHY+jFWzLLeU1Xs3yLInOf1Ur
 TQVg==
X-Gm-Message-State: APjAAAVpXBY0q7cvdEM8GtvqQXr/lSDTmDRU7XwcbmddqvFDapm2th6o
 0CvpmTXrX68EfVAie4n0CbnIaEEnP5AFRmOE0FWl8u4cBv5voZytugskYUs2j0SKqWMWT1FDBFm
 sRM+/dSo8RliTlOs=
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr3573757wrw.280.1573662193215; 
 Wed, 13 Nov 2019 08:23:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqw53oCpS/Hy+3WC4TWjBPmgqFV/AGaVKZI+ipcgzGjABu/b8XOs4tcek8i3KCSGT7QnVc4QUw==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr3573730wrw.280.1573662193043; 
 Wed, 13 Nov 2019 08:23:13 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id p14sm3489412wrq.72.2019.11.13.08.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 08:23:12 -0800 (PST)
Subject: Re: [PATCH v1 2/5] docs/devel: rename plugins.rst to tcg-plugins.rst
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9fa870a6-afcd-e00e-b9f2-d26d7661a48e@redhat.com>
Date: Wed, 13 Nov 2019 17:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191113115952.775-3-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: 2iwWwihSPOismPy5LWQLXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 12:59 PM, Alex Benn=C3=A9e wrote:
> This makes it a bit clearer what this is about.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   docs/devel/index.rst                        | 2 +-
>   docs/devel/{plugins.rst =3D> tcg-plugins.rst} | 0
>   MAINTAINERS                                 | 1 +
>   3 files changed, 2 insertions(+), 1 deletion(-)
>   rename docs/devel/{plugins.rst =3D> tcg-plugins.rst} (100%)
>=20
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 2ff058bae38..c86a3cdff2f 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -22,4 +22,4 @@ Contents:
>      decodetree
>      secure-coding-practices
>      tcg
> -   plugins
> +   tcg-plugins
> diff --git a/docs/devel/plugins.rst b/docs/devel/tcg-plugins.rst
> similarity index 100%
> rename from docs/devel/plugins.rst
> rename to docs/devel/tcg-plugins.rst
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff8d0d29f4b..b160d817208 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2369,6 +2369,7 @@ F: tcg/
>   TCG Plugins
>   M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>   S: Maintained
> +F: docs/devel/tcg-plugins.rst
>   F: plugins/

What about (other patch):

   plugins/ -> tcg/plugins/

>   F: tests/plugin

tests/plugin/ -> tests/tcg/plugins/

Anyway for this patch:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


