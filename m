Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF9C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEC420727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ4n4k+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEC420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2DZ-0002Mr-E0
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1xz-0001gp-Ke
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1xy-0002Wg-H8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:04:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1xy-0002WJ-8C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:04:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id f7so2269835wml.4
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=naHXYiAQQj95mPskYrvlj4n8/vg+KXMbd7zFJGbkX88=;
 b=OJ4n4k+ty5WbvSdU5yxdqGO/LV4vVhqd9ZjU115na1c//OpHcuj9vYcVhZPbs+sRiY
 dj42XmzrH3bNE8epao36oi5QF6x8SulLgPC2fHe5IrBI6fk9SCiZaIme47zZh2Lw1vM/
 zbgPN6sB7bGBy3ZkItuDHZ/Gz+EXbs2s5VWo8W38gE70/UnCi4K/5AYYf5HZQvGK/G9j
 5FoUSkKMVCrJAAcFGZISaiWlqB3Ju39xVFKnaMoXQ8p9OifFUhISUCkyI1T48+q4IqhN
 QDfG/FPhpxXZke6Hf7LijwTwjUq+8PjuMJtsnW5st3FpAd1BfNGWB74bbRDYynnbo3qH
 +qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=naHXYiAQQj95mPskYrvlj4n8/vg+KXMbd7zFJGbkX88=;
 b=X5Q+hKjIOujnxoU7plvzLyj0rkJ3Cfd8SCeGPLQUp1dDC80YsztgYGxekgwzxjgf+9
 8sQCCzCIT9s/eYrfZ9so6/iinQe0ED8mBV2WCIGiGzEBsNppQejk+YHU8RteWHinuryP
 nfP2N4Os4bFsVEMxEn/ROzzGWxAGvRn9/4FmbiZzjZeSIskNZA7GYT39xsuqZKebfxlE
 mvmAucwDXOY6ckRk1SOMtSZzH17ERpPiHYYNzIu5NNdrFs5SneJN7TSd96LBmDYbx3+m
 0xw+yCxVFNQbLP+tRUHJjfsPYWXu3a9RosxUflKnz8jrBKinSv2Vu0dR58skwvlBb6vg
 /AtA==
X-Gm-Message-State: ANhLgQ3m3xIgfSv/Qrqp9DJHYp5ecl0/DzL75cqU0LplYcTMdn0oewGV
 9X8mtq/ztEw8pRiOKsXSLzGx0g==
X-Google-Smtp-Source: ADFU+vsiNUJPKMGUZCwfvaALSwDPga35gECdCM6EtPfwHctgMA/pxh6bcNndlGLcwTW6NMCE02u9/Q==
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr4054133wmj.147.1583935449014; 
 Wed, 11 Mar 2020 07:04:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f4sm15175548wrt.24.2020.03.11.07.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 07:04:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75E091FF7E;
 Wed, 11 Mar 2020 14:04:06 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 00/18] Add Allwinner H3 SoC and Orange Pi PC Machine
In-reply-to: <20200310213203.18730-1-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 14:04:06 +0000
Message-ID: <87o8t3f0o9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> Dear QEMU developers,
>
> Hereby I would like to contribute the following set of patches to QEMU
> which add support for the Allwinner H3 System on Chip and the
> Orange Pi PC machine. The following features and devices are supported:
<snip>

I've finished my pass through and I think everything has a review tag
now. As there are some small fixes needed you can you do a v8 respin
which Peter can apply to target-arm/next.

--=20
Alex Benn=C3=A9e

