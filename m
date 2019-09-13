Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC3C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A020D2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3f2F0bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A020D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lLA-0007d8-JM
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lDQ-0000oj-5X
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lDP-0004B1-0D
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:02:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8lDO-0004AX-PZ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:02:18 -0400
Received: by mail-oi1-x242.google.com with SMTP id w17so2155906oiw.8
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Qr3ZNGKXSM/zMmqNE1C/HtVK3Szcs5QqXxuxJEUtTpk=;
 b=V3f2F0bjZ9PycjbUNQdRehgxaam7l3AxT7cBLimoWbu+M+aRmAlEX0o4MQypBeR2hw
 TwacFey2fXLgesYXTB7t8e9tJ1X/kvwefmh0DubGizAFpfnrSSYRJGWq2LzLAhdVlPqI
 GN1MldUmk/l92kDyy+3LNFRHb0au58UI/97kEu/CClDSOGO00R4EEmzJEYXjncQy3gA2
 ZJnyKQy/9P8obZKGPv+bHd1++a0faRyGU3tEw5oQXvui2wcYB4fRoE060kC60H8WJlzW
 kNJWJefJ+o/JjUAjjk2+bBQjCMC/vSjjrXnZLw5aBMBUemE+r8bDd6bXDXbT4183DnH1
 xe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qr3ZNGKXSM/zMmqNE1C/HtVK3Szcs5QqXxuxJEUtTpk=;
 b=QqJaNNNWKL6xH9MdpoTs6t2YLNliQJ5yRdqSa6AchH/M1nK8L8uIjo0+usCBLDvzO6
 Nr8jqFHUU1zyhkD9X+NpNzTeKD86P6AwNXG1wEIPDe/uUPEsQGBmSKY1IhDoTX+e4A5x
 4s0tj3Nt/OiY3YhOaYWhhbnNARC6sSqkwNTMn9+fTA4NBFhhvoutq2E8BPD4dz5EurX2
 ymjfZCznNaGJcw/03emFccK+R7gngNWMwK2CEdp2wvp/5SbjT3IY74oTMqvoIaBIeHDu
 V7OuH3fRzWIe/egz+KsrzfssVt6LJzPsh95+5Vs9Nsg2ZTn0tMMah05PYyS8gVuCE45t
 hBUg==
X-Gm-Message-State: APjAAAXkdz6YgLUuX+RbBq6icxCURHx0E57xuD+1TYtt46x5dI+drcCV
 v1tDDPQvMZSknHSA4chseH+f/xjy1wE+ByH8zcODdg==
X-Google-Smtp-Source: APXvYqyjuhmL9o6onv1ivRkrpzxEOEC67f6t22u2jfmf7tTUDpY853b7mKjNr4FulZZNU1Gp7lCLPJCLd1wn2pWAyCg=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr3090985oif.98.1568379737991; 
 Fri, 13 Sep 2019 06:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-2-alex.bennee@linaro.org>
In-Reply-To: <20190911164959.11003-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:02:07 +0100
Message-ID: <CAFEAcA9ifMtjh80FvmhbYNB=5DtE=82xQqqUUmUE81UMyC_j1Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5 1/5] tests/tcg: clean-up some comments
 after the de-tangling
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 17:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> These were missed in the recent de-tangling so have been updated to be
> more actuate. I've also built up ARM_TESTS in a manner similar to
> AARCH64_TESTS for better consistency.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

