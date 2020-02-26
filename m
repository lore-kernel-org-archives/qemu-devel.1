Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794A2C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4530C2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiU4WHtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4530C2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6xRz-0001dr-Gi
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 09:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6xR9-00012F-7r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6xR5-0000nv-Kn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:13:18 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6xR5-0000kO-Bj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:13:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id a5so3243990wmb.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 06:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=q/vX08qXyPKR9hdS5IWeoNkVAVG21O2AzKW+3FKHvgQ=;
 b=TiU4WHtDsl1xt0Aoh2AIG3tFoC+2QPPcrxOsxdzf2euK6AOM2PX7tKKzkFqq8cHMsw
 8wZa0YTOfHx/Agu62/qcFYi22kj4mNDUFknxVVKa9i7KQBoKA1B2dHw14ke3P4i4hTqR
 lJlDZoQcj/sZdGju91ESbJ8TIGHeStMI8ojd7iwg3WmJvwbopNHpUtL+BQrhUSc7G5Xm
 IsuxbAXviAgGjFLs+eDNsOIzoSxJClFsBcbYY3aoXPglyzneyAHQYlyFDwAP3rEhtdT6
 j59xl5av41NJThsMbtMlQ5hNkwgDNt+/lOhHtLZdBu/nAZa4iIwzJ1kp0iuzNWi1Wb7b
 8Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=q/vX08qXyPKR9hdS5IWeoNkVAVG21O2AzKW+3FKHvgQ=;
 b=rq+6t915AhOLql9N6x8KbBRErQQ60n2nTSi5vBMxqzWgigSXNrBnX2xkgYlODtx2wh
 jbNrnPFvKXTm/Zp9cJQUHgKfFp5oxSo3bXeWUdaaSeQS18Ik9lMRIDBHOhRba1tMciRG
 x9/pno/RIUoFgwViN6KZKy98TEqgup9973BoM8NL5oSOKIEk2B75s2d1CeKq18jKQrtD
 vUmOG4bFL+NFKD7a+BZUvynUdoDY0IGboDoj+ceNJAvVioVLKgepp2Gt2blUjIPU1TIj
 QbamzcOquqDVjcde15STyC/WfRw92EKCIWh39ss9s0OztoBTU79SdVcQo1c+0jvRQ1xa
 Y4PA==
X-Gm-Message-State: APjAAAUmk3Gu3kxdT1f4rcQe8x6Os3bwoSkNTiGFigbgdZ/IW/8unarR
 JvSKIJ8bDtAgcHJrLJoSYKiLww==
X-Google-Smtp-Source: APXvYqz3MlqwpEBnPvIDlYL1K1FGtjNMBfkS3ZZQLVgXwq23GbNGVaKvPW/OgNmiAubEfffrSKwaZA==
X-Received: by 2002:a05:600c:290e:: with SMTP id
 i14mr5691745wmd.24.1582726393543; 
 Wed, 26 Feb 2020 06:13:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e8sm3421973wrr.69.2020.02.26.06.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 06:13:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 751801FF87;
 Wed, 26 Feb 2020 14:13:11 +0000 (GMT)
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <20200226101948.786be4b0@redhat.com>
 <CAFEAcA80K+h-nkiHrh15mmgomBaqDpdhRwb34zwKqF31dp3KDw@mail.gmail.com>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Sudden slowdown of ARM emulation in master
In-reply-to: <CAFEAcA80K+h-nkiHrh15mmgomBaqDpdhRwb34zwKqF31dp3KDw@mail.gmail.com>
Date: Wed, 26 Feb 2020 14:13:11 +0000
Message-ID: <87k149xwqw.fsf@linaro.org>
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 26 Feb 2020 at 09:19, Igor Mammedov <imammedo@redhat.com> wrote:
>>
>> On Wed, 26 Feb 2020 00:07:55 +0100
>> Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>>
>> > Hello Igor and Paolo,
>>
>> does following hack solves issue?
>>
>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> index a08ab11f65..ab2448c5aa 100644
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t tb_=
size)
>>          /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
>>             static buffer, we could size this on RESERVED_VA, on the text
>>             segment size of the executable, or continue to use the defau=
lt.  */
>> -        tb_size =3D (unsigned long)(ram_size / 4);
>> +        tb_size =3D MAX_CODE_GEN_BUFFER_SIZE;
>>  #endif
>>      }
>>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>
> Cc'ing Richard to ask: does it still make sense for TCG
> to pick a codegen buffer size based on the guest RAM size?

Arguably you would never get more than ram_size * tcg gen overhead of
active TBs at any one point although you can come up with pathological
patterns where only a subset of pages are flushed in and out at a time.

However the backing for the code is mmap'ed anyway so surely the kernel
can work out the kinks here. We will never allocate more than the code
generator can generate jumps for anyway.

Looking at the SoftMMU version of alloc_code_gen_buffer it looks like
everything now falls under the:

  # if defined(__PIE__) || defined(__PIC__)

leg so there is a bunch of code to be deleted there. The remaining
question is what to do for linux-user because there is a bit more logic
to deal with some corner cases on the static code generation buffer.

I'd be tempted to rename DEFAULT_CODE_GEN_BUFFER_SIZE to
SMALL_CODE_GEN_BUFFER_SIZE and only bother with a static allocation for
32 bit linux-user hosts. Otherwise why not default to
MAX_CODE_GEN_BUFFER_SIZE on 64 bit systems and let the kernel deal with
it?

> (We should fix the regression anyway, but it surprised me
> slightly to find a config detail of the guest machine being
> used here.)
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

