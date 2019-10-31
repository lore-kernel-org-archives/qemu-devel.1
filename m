Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81472CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 09:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC7520862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 09:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOw8MzRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC7520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7E3-0001Ds-JP
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 05:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Bq-0000ek-9t
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Bm-0000W9-Na
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:56:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ7Bm-0000Qe-Gr
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:56:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id e11so5502981wrv.4
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=onOEzDjQoEwPHIy8bY5t/qK3xa+GpBJQPVbzx3TyYAs=;
 b=JOw8MzRs5JHLexxvisY2oxIptMCLfRbQsxuPJ14fkRk0A/sUw5RCu6YR/FygufRWXW
 S7IMsgHQ8lzV2mKmiEQx7Aju/R1FX0vX/kL3/q1f9lgIZBQFMFudXiVNiT7wAj5VBpkZ
 U6S8Kt0eo6UNcRXJLNoL7NsenT9yKGzSfHX6t8kn5yCJGhf4LahbbHpZVbUJaUt1nsCY
 LRzxYDyCSyVY86xWb+Q6UBoQIfsKfrIcM6l6kZumSc+jH6VfvCVRHKMptWm+kTXp8Xqv
 z8CnyGlLOmwrhfR0zUvHpMPPPPLnUKPm1BlNBu68Cus18OHORu6p9NghZoHliWTnWn8L
 TKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=onOEzDjQoEwPHIy8bY5t/qK3xa+GpBJQPVbzx3TyYAs=;
 b=pdSXg02J23RT2UEUY0ERH17xpUqz0CEpLY32MRR1D7WmkCYm/2+nY+MAXXJIJ0NPNe
 IKf7qlOKYoiFexvw74epClOUd7XsR0ho8HGEYI3AX4lmyKNnrc52SWUwX7mRfdpAE+m1
 lcmDgWIuskwnDV8FOOOAOYbHhmtZC5zL8fTG4y3N04CWzU7kcSj1LEAwgIEEzYnx97zA
 AnznDuiXMInj+4VsRulpeWRwFgyCZ00U1EEacE5/HsYqKlN7Pf76IB5fq0NYHXI4Pnly
 2lNEnhttCK+ntgNXqOG1IWo8MG4J4EMoX4dvt+cWpvESzKJEhkY2IOGP8S3ZUHcJMHe/
 mCVA==
X-Gm-Message-State: APjAAAXIhlLTgi7Dd5U6KiUNGlIrcszZBMTPctbbDF7c+MGV13Zc9dQ+
 zkfuDP5CMIRFC/Pw7gbt98/H1UybCGb/gQ==
X-Google-Smtp-Source: APXvYqwugLJ/PEpM81Gq/12hDifnx7OvUcJXI0SSUA4FXgfVkPEtmMCh5TJ0mNW26KhHcYAjWkq9NA==
X-Received: by 2002:adf:ab41:: with SMTP id r1mr4905042wrc.281.1572515777702; 
 Thu, 31 Oct 2019 02:56:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l8sm3547657wru.22.2019.10.31.02.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 02:56:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF4BD1FF87;
 Thu, 31 Oct 2019 09:56:15 +0000 (GMT)
References: <20191030151740.14326-1-berrange@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests: fix conditional for disabling XTS test
In-reply-to: <20191030151740.14326-1-berrange@redhat.com>
Date: Thu, 31 Oct 2019 09:56:15 +0000
Message-ID: <875zk58chs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Queued to testing/next, thanks.

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

