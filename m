Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60766C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2892F21907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfPFOBxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2892F21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYFc-0003Dy-90
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAYD5-0001UR-7x
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAYD3-000177-WF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:33:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAYD3-00016W-N8
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:33:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id l3so6502379wru.7
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OD6zMBBBA2SPvg+dgmK0PnpVRUNPk5uQqjsyJ0wj+CQ=;
 b=OfPFOBxAaFgn6Zx/jtn0nLAwWGOKLn14+axTDFlUUpGHBMlnlwGzOGG1IDa6GoU0Qd
 +siKHbiEBQZQZ5BECCM/z1EexrlpLY/3dbhoToYB4QNDfQDSH6bud1g5HqZvGyPqvaGC
 1ByOTSIvue6OrPnmvJhw2GWWFtcE9yvDNor2DZyTQ8loMaQDCQzWxqLOBSGtaUdcDEhz
 1jErD6rPusnv4QXpvZSbd/adCe8G6N387/XLimi9UKBZzmWRpT0TlUaH0oJkgwutmbpa
 EC8WYHZe44SlWZqGfxK5rZcHpEXFFtpLC5vspdttdHabsdD6UNB1V5iXle8xXa2Y7PzS
 OQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OD6zMBBBA2SPvg+dgmK0PnpVRUNPk5uQqjsyJ0wj+CQ=;
 b=CXMAV98dlul9yR83X2u91Gvw4ihkNE8zfRDPA8OUtpdQZsGILEr2ZMIjDediE5SPnj
 7et9iJd/mvTT7KEHwbma8mVB1wKLzjYtTkt0lGTYs+DuK2Z7F0sHYkISY/KubHFU90+Q
 EoBiNryGs97i6VCAhHBt/khTN68qbpkH4HnSIxQt7QbaUY/qOjVVzDk75YpaKKIVqCrR
 b7etEibpp+EbxgJDB0BnmXspBRRpw69ZNYpCJd9qrsqjLm5BRxs9ODDGkbJIUFGQG9Bt
 N+Xtv1NMMLjWXnaHz6rXR/tFyAdH8rg1B6QiO8gLvbmFbtBDKToZUyfLmtKNyPWIJD5I
 BOjA==
X-Gm-Message-State: APjAAAU9480HT4P6oQG8m4KOEibCYtd5zg9y9GF8oLf0rFGOLIpk9x22
 HiiwQ1zMxDiE98wnfze2u8LG5w==
X-Google-Smtp-Source: APXvYqwzmgIreP409JKpBJEGpDwojmE2v9JGCOhv1HEIrQI7je9JFN85N+/ZPBudw10ZbqfhPAnpmg==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr2800501wro.93.1568806400301; 
 Wed, 18 Sep 2019 04:33:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l1sm5586160wrb.1.2019.09.18.04.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 04:33:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C90DB1FF87;
 Wed, 18 Sep 2019 12:33:18 +0100 (BST)
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-8-alex.bennee@linaro.org>
 <afd9bc85-9c79-a456-73c1-fc19e97d1acd@linaro.org>
 <877e661vur.fsf@linaro.org>
 <93ff7174-77c0-d2eb-eac2-d3eef7e88a14@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <93ff7174-77c0-d2eb-eac2-d3eef7e88a14@linaro.org>
Date: Wed, 18 Sep 2019 12:33:18 +0100
Message-ID: <87zhj1zvnl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 7/9] tests/tcg: add float_madds test to
 multiarch
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/17/19 5:00 PM, Alex Benn=C3=A9e wrote:
>>>> +    add_f32_const(0x8p-152);
>>>> +    add_f32_const(0x8p-152);
>>>> +    add_f32_const(0x8p-152);
>>>
>>> Why are you adding 3 of the same?
>>
>> To replicate the 1841491 test case where the same number is used for
>> a/b/c
>
> Then we really ought to be more explicit about that.

I guess - I was hoping to piggy back on the general case. Maybe we
should just split that into a separate test case. We can at least re-use
the format and flag printing code and drop the behind the scenes magic
to "join" the constant table with extra test values.

> You're not doing full permutations on the sets of numbers, so does increm=
enting
> a random index really test what you intended?

I did initially do the full permutation but for madds it all adds up
quite quickly. The shuffle we do here is a bit of a comprise, so it
shuffles the various nan forms before nans with -inf and -large and
finally a bunch of real numbers (subnormals in the middle). It gives a
reasonably broad coverage without going nuts.

>
>>>> +#if defined(__arm__)
>>>> +                r =3D __builtin_fmaf(a, b, c);
>>>> +#else
>>>> +                r =3D __builtin_fmaf(a, b, c);
>>>> +#endif
>>>
>>> Eh?
>>
>> Ahh I was going to hardcode the arm madd instruction in as the builtin
>> wasn't expanding. I tried setting -march in the CFLAGS but that didn't
>> trigger it either on my buster arm-hf compiler. Any ideas how to get the
>> compiler to do the right thing?
>
> I think you want -mfpu=3Dneon-vfpv4.

Ahh that worked. I would have hoped that v8 would be enough to spit out
aarch32 code which has to have VFPv4 for A profile right?

Anyway I'll use that for now.

>
>
> r~


--
Alex Benn=C3=A9e

