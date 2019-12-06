Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6768C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6B92173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpckPagM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6B92173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idG0q-0008JE-5N
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEu0-00019i-G3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEtw-0004fs-CU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:48:15 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEtv-0004ct-4i
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:48:12 -0500
Received: by mail-oi1-x241.google.com with SMTP id i1so6356843oie.8
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cYXyl8AMCk5ToB9fyPwohHN+Sd1sgQsQirBd7UyHPFk=;
 b=HpckPagMtDVfW21+RGXHGUL3MffnE2Q0RVPX5nHcCmDwveTkYH5y59BkHJgbYEi0UL
 fcGmF5HmxJjfJcgjCRtZhDy+XIYk1ja+JfuFb8LBrAGiea4FlPe1xiTxjKnWINy6xhb6
 LGxbDKpprGMd5zS+/q78/l6iDLCwL1rxW7Ld1NvVbKJ7pKD6m72ZuFSNRMPTEXSK6rNf
 DQk5haXynfV2fKy0k1SPPHnqyvUZZWammFwbuL3OKrTIAvtiSsOCqLZ63O0ts2amUHG4
 /OXIfBr73MDOYl7OxgMJW/kut1/HpKDxLyBBAaOCaNvMinOvRBD30QFGeWyF2JjiPoBp
 eXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cYXyl8AMCk5ToB9fyPwohHN+Sd1sgQsQirBd7UyHPFk=;
 b=phDmEjWEb8rE2QRGKFRcGy2+4BaHkHSEoNKDFkM4ww+BOtVzFIMQnSEkxwDkMGNms9
 ksvIZvFZX3ETGUYAJL0iyD/UbtYWCgGYsAXrPjbU2bIIj933ZSS6apSnrM5OiPjk+gaq
 pEsCbjOaEHxwgGKqm1RDBxQOC1MGYe47/HclbhZ2YzlgbaqT6V5RjAVbuP7wTzVOL2n2
 wAQYX36TKqNbIMMccayOgP9yO+zbfNdaGzWFxBUnpbYgIfLxsoCVq892XTJ9Ru5zyjVg
 fMJgVWEiikz2QJ/E4Fi4g91zcHvWqPi8MzESjT4msCC6QtaAV+qSypK2YVx5YLq+5GBq
 htog==
X-Gm-Message-State: APjAAAVQJ1/KbQsnFkffFXl8zU+yP7o03s59SayiAvlAZSAtqe34XKl7
 GN/33BvAaDTBsDcEzt4itDwoBRMKf8XRwW1vAOQFOB9m
X-Google-Smtp-Source: APXvYqzrVr7yYZEn0SeqYkBsZHcRAjWhB/d0WyO5uPWKEGNz+OP50Qh6OvoL/BpqLwMHi8eSpZn6MVH0IAz7nOgh9Cw=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr12409527oih.98.1575637968500; 
 Fri, 06 Dec 2019 05:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20191119141211.25716-1-clg@kaod.org>
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 13:12:37 +0000
Message-ID: <CAFEAcA9GANxjJ1yJ7Wvaj1Yt=7QXc6_A32wa9gayfcupAfme7w@mail.gmail.com>
Subject: Re: [PATCH 00/17] aspeed: extensions and fixes
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 14:12, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hi,
>
> Here is a series adding :
>
>  - support for pool buffer transfers in the I2C controller
>  - fixes for the AST2600 and for the SMC controller
>  - a new Tacoma BMC board using the AST2600 SoC.
>  - misc small cleanups

Applied to target-arm.next for 5.0; thanks.

-- PMM

