Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCC0C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F7A20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ep1dk8GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F7A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvGL-0000KC-Uo
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvFH-0008LL-F4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvFG-0004yS-8q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:15:51 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyvFF-0004tg-Cx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:15:50 -0500
Received: by mail-oi1-x242.google.com with SMTP id j132so17846170oih.9
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 02:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FJaSu6C0aPghGbgkToQnC6VIyarhL7kmYcSo2PMNtf0=;
 b=Ep1dk8GCSyyTrRBkU0u6tHTb8K2akvF7flNaz7tzR3CYJfNVnW0J7lDUF6orcytlEq
 miKDrPyCzrSBU+cjMfZbn+Ocyju3OSbvuF6hAsS/cgJKxpan+Jfm+GwBhH5t4QSTDJLj
 8yfZiK9hIF0ZkW0IeMLQwIC6VMLQS99Qm9KwK4Lu/ow9bqA9lHrJ47GzEjjJm2uOKwmj
 kygasmkqdoX92sc5g7Jn1mFUT8pfLzOVu2Pz3bO7TNoT6xVdVNLFUJxhp594TSNJsJ3l
 6M5aS/juUd22cTMWOYKB11bQrj7L2wKC9EuSMS4jViJqA+luQ0qVR/RzqZZFMObplB4v
 xF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FJaSu6C0aPghGbgkToQnC6VIyarhL7kmYcSo2PMNtf0=;
 b=OMUOdU4g7M+86hOZOS9WKeVCMgamZl4ysvOHmCgetGIMUO8wLkGOlxn5HzuTayrWmE
 PIv1rCx909Scg/o8lc1nlU7GO2fWOwwKnqeFYuk7due83jgNzRCAmjz8mlFxa1kz3ujZ
 6QbT4LIx9cjJqx7P4te8zSAd9FT3u3EbzgfmdcEuD8gfRPtWxa5R+hKNUWYaNvBMEgJr
 Wh5okbQ1bizkDaq0Q0j78NESjH1WP2N6lU6FbNX4w8c8Ad4uYnYYHGTwV2FTbedHpUE+
 5IatardxhTFbAI+rS0O1rdmJ5Etnvsf5Nacy+OlE0sxlCf3Oc3ruNfPcNb7kfyql8Fp9
 vp+Q==
X-Gm-Message-State: APjAAAUcAXO86A+6lw1SDz5fGAoEnr/eCwqgO3RtS3SsUo4KEhP1CYt7
 9VwRMaXlkoi7YM009lrtWdJXcfDu2AEM0b+DotDnDA==
X-Google-Smtp-Source: APXvYqxrCsVLH7Vip9BV5o4IEzya1CMI9jGp1ySGGR9lmHQjkJHZWK80PDRW8l2xzMD8HoI6he5QQLYK3xg1UfvTyKs=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr2966705oid.98.1580811347892;
 Tue, 04 Feb 2020 02:15:47 -0800 (PST)
MIME-Version: 1.0
References: <mailman.343.1580584897.2411.qemu-devel@nongnu.org>
 <CAKyx-3NZ9Tne+WKkA7wAtyFqZ6roN_gS7rF59ZRjECCkx0qKaQ@mail.gmail.com>
In-Reply-To: <CAKyx-3NZ9Tne+WKkA7wAtyFqZ6roN_gS7rF59ZRjECCkx0qKaQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2020 10:15:36 +0000
Message-ID: <CAFEAcA8c6_ESiGCY5somH7LiDYGhW37QCAJDAUZ545b+VDoJSQ@mail.gmail.com>
Subject: Re: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
To: G 3 <programmingkidx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 19:59, G 3 <programmingkidx@gmail.com> wrote:
>> Our official OSX support policy covers the last two released versions.
>> Currently that is 10.14 and 10.15.  We also may work on older versions, but
>> don't guarantee it.
>>
>> In commit 50290c002c045280f8d in mid-2019 we introduced some uses of
>> CLOCK_MONOTONIC which incidentally broke compilation for pre-10.12 OSX
>> versions (see LP:1861551). We don't intend to fix that, so we might
>> as well drop the code in ui/cocoa.m which caters for pre-10.12
>> versions as well. (For reference, 10.11 fell out of Apple extended
>> security support in September 2018.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> The bug report is recent, but this was also pointed out on
>> the mailing list back in June 2019. Since nobody has cared
>> to try to fix it, we clearly don't care about 10.11 in
>> practice as well as in theory.]

> Why would you want to inconvenience the Mac users? This is unacceptable.
> I and many other Mac users would not be able to use the newer versions of QEMU
> anymore. Keeping Mac OS 10.10 and up support doesn't seem like a burden. This
> patch should not be applied.

The rationale is in the commit message -- QEMU *already* does not
build on 10.11, and it has not done so for more than six months, and
none of these Mac users has submitted a patch to try to fix it.
"Last two versions only" is our support policy for OSX for a reason,
and the reason is that there just aren't very many people running
OSX and actively working on QEMU. Of those, even fewer will
be still running OSX versions that are no longer being supported
for security fixes by Apple.

thanks
-- PMM

