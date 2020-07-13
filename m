Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4400EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2B12072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frt1VY5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2B12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juyci-0003Iu-AF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juyc0-0002pc-LA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:35:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juyby-0001SP-F6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:35:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id f2so16526390wrp.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yc/HtDSq8ibqFtMJDK4A0sVIfrMuxBCmAEjFWbmDoYg=;
 b=frt1VY5Yopk+/vwYEpFvHm958CSpZeLAzT+veA91Q9csIKKIZ4inzcmTJxHlChzBlL
 HXECA4xdhaDevUnldHEMnK3HqqkNQViX7IrTjH4K5yfnGRQ0iLBu9DJU/wmSeyRyi2TH
 mmCok6BPuRxuUGfjYdOzgyd7lRLNWVCtYtddFmCUpbyC9VMp3nj+hYn+Vk20zkRj4QTL
 Nlso8h/01+6OJ/uyQeZBxejzPOmQPW7txdwdPt2HEM+t2aHEUqW6c6igUCmIgakps7Rg
 X3KIbMUtEomavNxvM363/My/MVQFDBTIqHsmVRl42dCs0NVqxNeFWXBtzwZC/txjdYDR
 ryuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yc/HtDSq8ibqFtMJDK4A0sVIfrMuxBCmAEjFWbmDoYg=;
 b=g8iG6vYq7UCKKS6L02Ti4iqVdzGKBRw2wlFqfS0jcVJ9LIgfvvF8LsCgPAuoVv8z9x
 p1izIKBEYTUIg0YAP7tT3Lcgr5qV1u37uuFZOe6nu4c+YsYjyjSwTtgCd5DWrqMEkyVC
 XUZDlP9Ud5eoSIMHqvz4MJ6M+m7B4GlC7IjOTcxm7Ju+2ipZ+j5Vzyaxhhikh2f7NHjA
 foK+ADq1QCFUpKfIUIb2viNKTnweTqg8aTMjw8/iK+jWUNap70oezqi7p8wwEmZY0e8N
 nH8GYi7nI2yc6nyDCSShn4YTVl54ANT1KlCY4QyMdDDC2LnnXUVsa03of/Vl4SUSOFlI
 41nA==
X-Gm-Message-State: AOAM531pWQ4oONdTO95fZGCa/pLF4abYFfhjHbdlVlL8eSST7WWISula
 4m32kTv7DmnaxQ8DufLLqr8CGA==
X-Google-Smtp-Source: ABdhPJzVQBUvKpb4ovC8WVjG+S+ScyaMpqcg3lN40Uo4zeMQQOIWCQIn675F+7GihUoK/ULBnvq/3w==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr78047526wro.125.1594647312668; 
 Mon, 13 Jul 2020 06:35:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a2sm24321742wrn.68.2020.07.13.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 06:35:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B4D01FF7E;
 Mon, 13 Jul 2020 14:35:10 +0100 (BST)
References: <20200710215718.13034-1-jsnow@redhat.com>
 <20200710215718.13034-2-jsnow@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add Python library stanza
In-reply-to: <20200710215718.13034-2-jsnow@redhat.com>
Date: Mon, 13 Jul 2020 14:35:10 +0100
Message-ID: <87365v1qsx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, crosa@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> I'm proposing that I split the actual Python library off from the other
> miscellaneous python scripts we have and declare it maintained. Add
> myself as a maintainer of this folder, along with Cleber.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  MAINTAINERS | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6aa54f7f8f..fe1dcd5a76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2280,11 +2280,18 @@ S: Maintained
>  F: include/sysemu/cryptodev*.h
>  F: backends/cryptodev*.c
>=20=20
> +Python library
> +M: John Snow <jsnow@redhat.com>
> +M: Cleber Rosa <crosa@redhat.com>
> +R: Eduardo Habkost <ehabkost@redhat.com>
> +S: Maintained
> +F: python/*

I don't think that's equivalent to what you drop bellow:

    F:	drivers/net/	all files in and below drivers/net
    F:	drivers/net/*	all files in drivers/net, but not below

So I think you should drop the *

> +T: git https://gitlab.com/jsnow/qemu.git python
> +
>  Python scripts
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Cleber Rosa <crosa@redhat.com>
>  S: Odd fixes
> -F: python/qemu/*py
>  F: scripts/*.py
>  F: tests/*.py

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

