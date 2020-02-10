Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86B0C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A8F20661
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kf5+LXIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A8F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CKQ-0003SX-1I
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j1CJU-0002jW-16
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j1CJS-0001zQ-Ku
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:53:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j1CJS-0001tf-DD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:53:34 -0500
Received: by mail-wr1-x442.google.com with SMTP id t3so8668008wru.7
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iteVHGYLnklTManvwh+8fHXaEW+9cXnP28s2cRX7pps=;
 b=kf5+LXIa6VQAjzNOmupiREaLavPf6e1jjSnoysMLxsOy7B4HtRpMfngEQLxkBDA6mC
 9TjFTStnw4uz9H/drZbzqoohpvZ1NZW3EUgJHLnITGQHB7Cc3zTOpSDur9xkuiJypaVw
 o7pjEQ3hBCHzODcs+Ka8YWoLUePWpPvFebV+Djm5NWTh4U0fbnHQ9qxRtL/Pi4JiRFrX
 64OshpatgieEi9E4swDnW+hzKy29NZKpBx0IzIcX918T7F2BiXEEP0cqsjDpSoMruq9a
 U0WpNi21R4acdic9RG47T1Fr2A9kH4fFewFKJnSJKXNsXbKbf09d6Jcmp+ctzBBat9Hi
 U8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iteVHGYLnklTManvwh+8fHXaEW+9cXnP28s2cRX7pps=;
 b=GTdS202O6XVuA8ENFUaEixCtDsBOYFXIrcL5Rb9FOLrDr9l36D6Qm99K3PdenflXIp
 AUXgXAud1xh1spdMKiKP87nFgZxzu5oDP7US5hTrI4T0OiVQSQttXE4E0Nsm7hgTxD/T
 e8Yw7VcG1CjAfwiU4lIK+fwWwjWe3KcKSS/HFEIJcOmMLUT0DrSUW7t4hgEg/uvCxOyY
 GKA2kt7VNNT1/YULnl13erMypX3HNP/8HGl6j+wUhFKe68W1sf2IhGtXXz4v9pazpF0F
 ScHFJKLVVic1gAXCq/R8vb+vzXdmoWtEbZZMkovGivwOxi8umPUvxGTMVSM3mECET458
 Q/Yw==
X-Gm-Message-State: APjAAAVJBRhnVea/4mqJWO9FtDqlzyebfS3DtFxNrDsPHBVp0C102JIP
 x1ryivujr86nNKal8vSaEkCZO6jTQ6Y=
X-Google-Smtp-Source: APXvYqy6taXnzYl9ETol6dLMAca04077QwrCtvMT4YzVRn80Sv/Dufr0QaUE0x1J45QLlSg/RCSpgA==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr2965124wru.154.1581353610816; 
 Mon, 10 Feb 2020 08:53:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d22sm1271672wmd.39.2020.02.10.08.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 08:53:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 160061FF87;
 Mon, 10 Feb 2020 16:53:29 +0000 (GMT)
References: <20200210155115.9371-1-thuth@redhat.com>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add Philippe,
 Alex and Wainer to the Gitlab-CI section
In-reply-to: <20200210155115.9371-1-thuth@redhat.com>
Date: Mon, 10 Feb 2020 16:53:29 +0000
Message-ID: <8736bi2xkm.fsf@zen.linaroharston>
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Initially, I was the only one who was using Gitlab while most developers
> had their git trees still on other systems, but that has changed nowadays.
> There is now much more interest in the Gitlab-CI today, so it would be
> good to have more than only one maintainer / reviewer for the gitlab-ci.y=
ml
> file. Alex, Wainer and Philippe kindly offered their help here, so let's
> add them to the corresponding section in the MAINTAINERS file now.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Wainer Moschetta <wainersm@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e72b5e5f69..64ef7a1906 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2743,6 +2743,9 @@ W: https://cirrus-ci.com/github/qemu/qemu
>=20=20
>  GitLab Continuous Integration
>  M: Thomas Huth <thuth@redhat.com>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +R: Wainer dos Santos Moschetta <wainersm@redhat.com>
>  S: Maintained
>  F: .gitlab-ci.yml


--=20
Alex Benn=C3=A9e

