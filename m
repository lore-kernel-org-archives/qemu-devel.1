Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F4C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E072073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhG4mknX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E072073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icV8B-0004d6-7T
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icV7H-00046x-GH
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icV7G-0004Yh-DL
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:54:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icV7G-0004YX-6k
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:54:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so7073881wmc.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 05:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dSSbcgmdVMXVBu0McqC6DQ+FnuwnC2+7IbOSf3VeioM=;
 b=FhG4mknXXJ9WpfLwJBRGENKOa4of2rzsuBaHfBrh+HRqKzuO5dm+Di6iu/P0zMn0Nh
 8FYv0/m3jpzojvtrdYVmZTrbiAxs0MyGlxQ56E+e/WmmdND9/JuWxYiHaaffLtreZ4KU
 0CegzfqGzHO87IihwmX55vyV6EZ8RgCJEr6tWKoWRn5DnFjhNU/2ZecxPPHMAdrb1By1
 MBUQlIm6s+HDYyC0WDsysvehz3rjDDhA7damRwsY87Lu1lYqjF/a8TFQ1/FoKfGpbrc0
 9Ha172Vwmr0z7ngh1iojcHWcICI3IU9JM1XPZB/WNncy/Ia16E/ptzKuh5Cg0XSMP7nM
 LJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dSSbcgmdVMXVBu0McqC6DQ+FnuwnC2+7IbOSf3VeioM=;
 b=KsRUguxAVwV3oBwYmRLHLguyjtm145XW1S+Oo+Z8Q/aKHX9Ukje4kx5UYG0eXS8VZT
 qvgEJFhsB6ivzsd7MBEPhxDhEq6/36VmCmh1xxzepl8lNj4oSZeHScJrxE+bulXJKt7I
 eskK6jWLUyaMAzxmud/xWXNl01b9zrDerCN+/kNzCy0ZawUDp3GDmPALML3r1uiXVcBF
 nwnhqPDj1M9aeamYQPWQ9OVmLpsmPfPRONWQlr51vaijAPleZ9PLtOmDp9lobgv8uppq
 mlVWbAOg8G3z+ZxFa+YPieTu2FfE/zN48N9YRcs7gD86XnrbG2T5kGoEvwcahNMDConA
 My8g==
X-Gm-Message-State: APjAAAXRzMKOWaBH2caFwF2JPsnPuGgdggsFPQUpTSbNcppejmcGtGiZ
 4XyXjtWOTIOKim/7VI1SLlMsMw==
X-Google-Smtp-Source: APXvYqybtcCj0Ed/06kjDCvVxWYdZt6o21SzCSWnzQjnfL1o6aF0OUtvC75sreQqVPXpZNohhD+HqA==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr5346609wmc.168.1575467692800; 
 Wed, 04 Dec 2019 05:54:52 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm6604145wmi.25.2019.12.04.05.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 05:54:51 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3D591FF87;
 Wed,  4 Dec 2019 13:54:50 +0000 (GMT)
References: <87lfrtbtj6.fsf@linaro.org>
 <20191204083133.6198-1-thuth@redhat.com>
 <c727fe15-2448-22c5-2b0a-0ceb7bee2586@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] travis.yml: Run tcg tests with tci
In-reply-to: <c727fe15-2448-22c5-2b0a-0ceb7bee2586@linaro.org>
Date: Wed, 04 Dec 2019 13:54:50 +0000
Message-ID: <87h82g8ac5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/4/19 12:31 AM, Thomas Huth wrote:
>> -    # We manually include builds which we disable "make check" for
>> +    # Check the TCG interpreter (TCI)
>>      - env:
>> -        - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
>> -        - TEST_CMD=3D""
>> +        - CONFIG=3D"--enable-debug --enable-tcg-interpreter --disable-k=
vm
>
> While we're changing things, the interpreter will go much faster with
> optimization enabled.  We can change this to --enable-debug-tcg, which le=
aves
> the asserts enabled, but compiles with -O2.

I've amended the commit in my tree - no need to resend.
>
>
> r~


--=20
Alex Benn=C3=A9e

