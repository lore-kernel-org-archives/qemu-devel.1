Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C7C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0A92082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iu2XimD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0A92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17vk-0006wa-PB
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j17ux-0006VN-9s
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j17uw-0005yk-AQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:11:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j17uw-0005yO-3L
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:11:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id a9so10326875wmj.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 04:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ELqzTL4WJEOeGwpgFeLy77FEvzUr6pg05mSePVO7cIg=;
 b=Iu2XimD9aieuxdeSRmdCEj+f1SZEri1i7GiiO19pXO26GmnA0fLIxIC1/E/MT0FNOx
 omfS2CFnmcoxDAnNCuxZUTwVxyCJBskWyZc/f0BFC0GG3U5i8oZQ8a4NQ8pptV1iqqYO
 jiMByT6DsTt3ITWzK5eZu6F+zVlQhYjwNojA6QvIW6d0BAwrdxZVZ81TwX4y2hCK6MZb
 ku4KaV6kikxDKSIdpk3kNh+jIWr4gLLh3whVwp0uPT98+11L+d5e9/vT4bYV8b9ltXuM
 GK/BC4E1+yTDlXvgWQ+o7fT74paGczmHbVS9+E9q4KSH5vGzfPYcUzLoh+id1bOWkeOH
 Fy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ELqzTL4WJEOeGwpgFeLy77FEvzUr6pg05mSePVO7cIg=;
 b=cXe2AkrM2W/DHBalRUvSAEYYRtHuuT8AttKDbWdPsMDXxsCiv3Yj+npfXebuLZ4UAX
 bUUUUVxDQUjGBjNEgfbnSkcRVHY7mYSdKhFtzmDig5me6xisItrs0MqU99oKECxa17S4
 qeKEBjTKqRP4+/AJN/1dXb9fSxXP+lX02SXNwb7Ohd+kf3HGn1Qx4B0/Mc7Ew27Zn3Yg
 9+tGbcUI/rASr0PnyTSPIAgB6Hl8S3XyShKr6TeLU1gokJyH+4HM6t3A+u8Q5+v9+09Z
 j7yBc7RCrK71h/vzw03cADnB/Ub2TrjSnVmbDqL2W01U3+A9rbvZzzJ3Dgpielq9o7nK
 9KIQ==
X-Gm-Message-State: APjAAAWnaRc3B2zjoVRdDmckYmED0jSpxp1GGYD84wzPu8wRfe31wsJm
 FXkdm9Yh5mKgqmvU2xAAP2qm3Q==
X-Google-Smtp-Source: APXvYqzUrm6PIL3szxZ7wSm7VN+ShI2cDqxkwaviaRCMt1uJAQroesDDhrIHnB5FO9qHhdJCRkG3Pw==
X-Received: by 2002:a1c:e388:: with SMTP id
 a130mr15071212wmh.176.1581336716435; 
 Mon, 10 Feb 2020 04:11:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c4sm352676wml.7.2020.02.10.04.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 04:11:55 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5A361FF87;
 Mon, 10 Feb 2020 12:11:47 +0000 (GMT)
References: <20200207210124.141119-1-wainersm@redhat.com>
 <20200207210124.141119-2-wainersm@redhat.com>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 1/1] travis.yml: Fix Travis YAML configuration warnings
In-reply-to: <20200207210124.141119-2-wainersm@redhat.com>
Date: Mon, 10 Feb 2020 12:11:47 +0000
Message-ID: <878sla3am4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> This fixes the following warnings Travis has detected on the
> YAML configuration:
>
> - 'on root: missing os, using the default "linux"'
> - 'on root: the key matrix is an alias for jobs, using jobs'
> - 'on jobs.include.python: unexpected sequence, using the first value (3.=
5)'
> - 'on jobs.include.python: unexpected sequence, using the first value (3.=
6)'
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e

