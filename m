Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9088EC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6BC20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNC2/4f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6BC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1YaP-0008Rb-Ib
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1YZf-00081t-T5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1YZf-00015B-1j
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:39:47 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1YZe-00014o-SH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:39:47 -0500
Received: by mail-oi1-x244.google.com with SMTP id z2so13383388oih.6
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=835VrAYfuU9yayxmQiXrCOSw1gMGnQZIpK8TEK6gcoY=;
 b=FNC2/4f7+UEFKPk1ayz8opX4ygIyg3gtr4R7ysHj5BT4/NiJl/h1cuz3bb+fIs20v6
 5oo9lSNlA0yukTO8Md8yUJsq/US9qfvw4BvDZ9rTWyFRKECWyqSmEbf3yLs/fYjTpnmJ
 FoS85NQ13SFSXGstft2H/yRMtJpzWFFXMozpaA1nU6bTTxR94loetGHW1mncPmVUpevM
 VfDeZV5ChnNvT0tFDZ6Ugz5Xphmpeu6d2Fq2iKNrhR+SyHm6EG6MtzlyIMliT/gQwmhS
 WqLLcmNDLen3bqPldCspoSy3TXt3K3EAF9VgkMYPZlxc0X9IxYwiF/lshEEwlEAv/eJE
 Ci/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=835VrAYfuU9yayxmQiXrCOSw1gMGnQZIpK8TEK6gcoY=;
 b=s8BsLQ6mN4TLL4RCRWgAmvUAY1eRxwMgF0i/4BeHSexUO96KJkBaDnAab6Z9ULIBwU
 sWytewWRRSg51H7k37JWC4jfdeoB4V550x7Cmun0giO6C5gEZfEG+pvMkTJmIub6TOSn
 oYmBoCKjkqKV8JEGMkPCtNfLj0jf72f3VMcd6RZd4l7yA1PcnvjOga3x9Sh9V2+rC7Ql
 Xi3zH/AfmecBEExEbA+nZfitDkVeaUoYjFTHKJIvp/5VXEKgBua/zKEy0rrENJCruwZ7
 eFZXD65SWHRILqVcl0RL72rYKaTAotOqW+Jn5oXQS2hzhhOSOejW0IV3E1HCpRc1+q6u
 0Alg==
X-Gm-Message-State: APjAAAVh4w81+sXqpRevH6sFbjSCIFZ844blilXdJM+EDNgk4/EbJ9vO
 YOdh+WIacivleZilf4e9QYYWOSxqGnc932a55gWBig==
X-Google-Smtp-Source: APXvYqz6kSIQBI2FS54WfuJo6MK8UqNX8LiTzQJrzS6uQ9RjgR8bmBX5aJPtHjcyVflt4/fvWkjp+XCJUHN72xPbvhw=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr3468820oid.98.1581439186083;
 Tue, 11 Feb 2020 08:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-3-laurent@vivier.eu>
In-Reply-To: <20200204171053.1718013-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 16:39:35 +0000
Message-ID: <CAFEAcA92G9n31D-fnD8PE98C=HfZhKr1tVAdCmoNhJTyKDentw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] linux-user: cleanup signal.c
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 at 17:11, Laurent Vivier <laurent@vivier.eu> wrote:
>
> No functional changes. Prepare the field for future fixes.
>
> Remove memset(.., 0, ...) that is useless on a static array
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     v2: replace i, j by target_sig, host_sig
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

