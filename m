Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE1CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 06:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E892083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 06:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOc8OEpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E892083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ3ac-0001a5-B1
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 02:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ3Zu-00013Y-L8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ3Zt-0004xb-D5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:05:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ3Zt-0004xC-6X
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 02:05:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id e6so3006181wrw.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 23:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UjcUtIr6XmY9qWkR1APWnOEkfLVuQl4jmgDsfP1ZVCc=;
 b=nOc8OEpiP+O1elcrwiWFh4GsMl+lYy0QGs4EVvRS3o+p0NwFyJBOMu5sRfe+ycYONv
 MlF6XIvWRIpFs/s2zyz4u9Szon9S6xxYlE0PE9ZAi6yB6s4z6PFnu8lKiPzap8PI1gTR
 jSMTlt4cLF2At0Q8ABxhDHU3u2Gz6l1h34jDX01u1po8BP9VWZPOPsaulIM02NdAGVTX
 aVJKJNN8yHJj/8b/IOiiWdwn+R+1S3cNQgnWKGG1UxMBtXJrH0f2oGlqorlwEITnGzLi
 FTWpxWecl8mgBVmdJJ7Nzy+vqJhQ8jhL5XlS8KLgmkQDLwcqdOVNxALXXVZUVfm01a8L
 +DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UjcUtIr6XmY9qWkR1APWnOEkfLVuQl4jmgDsfP1ZVCc=;
 b=f8Oa5RXME8Fwlh4znzDgFOO9SYjQN/dmVkN+CoxvN9WB1JpwidndOJf6ljYwD6yMuI
 vXupry9E3iGtmIabCpSPFytzCAkqfkVXpLxeD83SztV8OhgDG0WfkfjJR76xgkUiLAfH
 zUagA3iIbiQTiw4FNUZ4CDrr4VKjU0HI38VU5ujW9/Mtq3OLrcy+EMmYnDkHJUZWaleb
 EIVSV5X03+ZCC6CUzZZvZ+umxtwNMYdLbDASFOQbvgXei6SCzmuCM/swE3HAafPrz7Hj
 YdTrKOFTZy1lsSRRH4XKs0wWCA7xpAL3E/aooZ+V7fJK0GkMgu4GXAWyR2sRzSgFIkYz
 1HBQ==
X-Gm-Message-State: APjAAAWJcEcjMvCq4MDYOOcffyw8w553oRgI1pZ52Lq6LqO05n0lWvXm
 Jm9rGs5zisjyo//UTcz4CiBfFmP9sL3jLw==
X-Google-Smtp-Source: APXvYqzoldxJJPFwDkkSu6kCSWVgWYfzRa1k9iB1jFukli5UlHgLKx4QIJIw2AUfEYb3kSAiTPFOCw==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr3593764wro.305.1572501899049; 
 Wed, 30 Oct 2019 23:04:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 200sm3032606wme.32.2019.10.30.23.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 23:04:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 212D01FF87;
 Thu, 31 Oct 2019 06:04:57 +0000 (GMT)
References: <20191030151740.14326-1-berrange@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests: fix conditional for disabling XTS test
In-reply-to: <20191030151740.14326-1-berrange@redhat.com>
Date: Thu, 31 Oct 2019 06:04:56 +0000
Message-ID: <87k18l8n7b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The intent is to only enable the XTS test if both CONFIG_BLOCK
> and CONFIG_QEMU_PRIVATE_XTS are set to 'y'.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 34ec03391c..99ac57fa1d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -140,7 +140,7 @@ check-unit-y +=3D tests/test-base64$(EXESUF)
>  check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_=
GCRYPT))) +=3D tests/test-crypto-pbkdf$(EXESUF)
>  check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-ivgen$(EXESUF)
>  check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-afsplit$(EXESUF)
> -check-unit-$(if $(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) +=3D tests/t=
est-crypto-xts$(EXESUF)
> +check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) +=3D =
tests/test-crypto-xts$(EXESUF)
>  check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-block$(EXESUF)
>  check-unit-y +=3D tests/test-logging$(EXESUF)
>  check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) +=3D tests=
/test-replication$(EXESUF)


--
Alex Benn=C3=A9e

