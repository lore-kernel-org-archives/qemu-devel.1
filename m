Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39683C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A26218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="un8RjPa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A26218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjNSl-0001Ep-5T
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 08:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjNPh-0008MY-1s
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjNPV-0003e4-OL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:34:00 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjNPT-0002T8-Va
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:33:52 -0400
Received: by mail-ot1-x344.google.com with SMTP id n5so8922878otk.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=67ZuVADbRpMGPM71S3Z2TgMm/VhVY5QeT9oUhn/cK7c=;
 b=un8RjPa/8e+A/jMCgqDn86eFUVrzgKILCG78wGz+qFjtK2aJIvFfNUX3YyZa4Pl71m
 8GA4ujNcFsYLhF93K8Ym7G/vfBW6/gFUJdwHe4peVvqrpxXy7v6NsHVd19AtTIDceNgK
 IpwSIQ2OkxhwVDDGbM+a9Pv5m8CGqE6jZL0BY0sxEU24Mr2iHE0b0zjhEO+Bd0ZW1+iC
 D/xNu/+UZrGBpsp6Q6u37bePXQ8nVTdcylFGWmD5wIGZk8ytWF2Ekt/4QvfMQNczxYo/
 JDA/O37oQWTGF2qt3nw4KcC/m5pPrMQtqicqblmhV31pL32AHmvmyBteQyMbYgRWmylz
 YtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=67ZuVADbRpMGPM71S3Z2TgMm/VhVY5QeT9oUhn/cK7c=;
 b=h9XdAjOB+og2/+bS9h7u0WC/ebTYIKx7zwsr97cZvjwO+mJX8/2w/7enZV+uv+6LAu
 q0Mc5CAJioWWbWxuKnpbayIV48rFAd4kcO75EqwdELgpAmjAc5V1EiB/2+0JWAN7slbp
 KUnJKTUGYEzx3bMK/9PIzXg8nNS1GCWS6Cy9plGgzISHzDrbR3OrkknPN5aL6sYYmDeM
 CkoTIi5bfotzoalnDw8eCF6mkj03dLUAcatqZDMyyeQB9kCSbezaEVl1a+wfT+7ByfHA
 XxeNz8khAoGqr5Bnzfjk8c3NX9jn1Zf5qLy5FO0jKROJ8qYqKnMgoYitsF5T+ch5Zh4t
 WS+A==
X-Gm-Message-State: APjAAAXALVS+KkIwe1B0gzOnHjnwow7cAAULc9fcD6cn422sFO+igh8I
 rcn2JyBCu9dPTwJqEm8bKq26N9XR2QQYLHIuadvsDg==
X-Google-Smtp-Source: APXvYqxBIcT+zkpsRxP97fUIS9J6hi2ekz5aToaeGQCM/a9I+0R9b7KIwl0oT9yzOnUjUhAEdzv12IDTm01P7ro8M90=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr2444381otj.97.1562330015458; 
 Fri, 05 Jul 2019 05:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190705101816.10291-1-alex.bennee@linaro.org>
In-Reply-To: <20190705101816.10291-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 13:33:24 +0100
Message-ID: <CAFEAcA8uXiVemzf7C+-p7g2Qzr9_WDOthi5RBmBhTek1MrhMNA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL v3 00/19] testing/next for 4.1 (tests/vm,
 Travis and hyperv build fix)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 11:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 57dfc2c4d51e770ed3f617e5d1456d1e2bacf3=
f0:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90704-1' into staging (2019-07-04 17:32:24 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-050719-3
>
> for you to fetch changes up to 1f4abd81f7dfeb9d622b37368bef22a6481ebc66:
>
>   migration: move port_attr inside CONFIG_LINUX (2019-07-04 19:23:07 +010=
0)
>
> ----------------------------------------------------------------
> Various testing fixes:
>
>    - tests/vm updates and clean-ups
>    - tests/vm serial autobuild on host (-netbsd v3)
>    - ensure MacOS builds do "brew update"
>    - ensure we test --static user builds
>    - fix hyperv compile failure
>    - fix missing var warning for OpenBSD (v2)
>
> This brings my testing back to green on all CI services. Please note
> the BSD installs will throw out some warnings during the setup phase.
> They shouldn't re-occur once the images are built. NetBSD has been
> dropped for now given slow install issues.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

