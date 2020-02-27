Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F5C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D377E24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNJZHVt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D377E24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I9i-0003BV-2Q
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7I8u-0002FL-Lu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7I8t-0003fx-DP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:19:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7I8t-0003eV-5h
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:19:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id m3so3183786wmi.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vLmvs05i9+uOUgE5FPuOrMEdPV3Xgh5AZzSByUzDhmQ=;
 b=LNJZHVt9b5TesS8YCPdneUr9nB0BUN8h88K7tPUbO4uX/kQ41PYuTmC7wxXbQOnQ3d
 jxqKtwuvm7cyubTV9u9ROu+mnFItYTi5iLEwlBvFS0AtgQBKbWTidyWlLvMMjhdkvOtP
 k1zbPsK3k9JpyAphthGMtkh6ca+9PqSIBeP3pcTGolCOYRS4DA4cXkX8WDhLjGFBDmbl
 LemU9ndAneKW7iGtaontWItvWuWVJQXee55RzlO1P6gbgu+Ds7l53OYgnrF2qGCe60rP
 qnmtLaLXTjeHEESdx+8IspiuDO98vnoN2alzUKZWk29sDNN+6iPn96bk0sQK309k8omi
 6DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vLmvs05i9+uOUgE5FPuOrMEdPV3Xgh5AZzSByUzDhmQ=;
 b=ilxUFOn8odzHe9JTEwiUcW7NYikO4hcQVE7VcbJ+AXdDg63r8rvyaEllmdmRdTe394
 uYq48BmDuOs6bJ7oO2qbw+0+noLzODEzYIY9OeMsmvor4ARW1Kgo+5QR46ziNzVwFxMT
 71At0qlV0dp/PDioheIaNWnxUV04lxQgihYEd4AfLAyiAtfUNvO0yOSRrJPIYNymQ8pS
 F0XAM4KLKMHqvdkGMUHtTZ9DtwlOVmTWczt4uSUwNYb2Ave0a2Y81NWj9YgngQxJUn5n
 SELfJ+58toJPDqPkltvtxsUi1aQG96nSo5pxXFi3lBaOUkhpOUg7ByUPEaG8IYznQgFL
 hZnw==
X-Gm-Message-State: APjAAAUd4Zp8lUIMExfw59293Ru5IGzNVAn9yrpfy4G1HI4kvwztJ9Tc
 Ew/Mt0IcVIE8ORZhFpeoGB+rMA==
X-Google-Smtp-Source: APXvYqxJXzusppW8Hqi39hdC9RIco49kt4MxxYnjio203tbtoyGiqFE+fAWeWA2PVkxz+wl3wsLqew==
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr4889109wme.62.1582805989756; 
 Thu, 27 Feb 2020 04:19:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r1sm7343933wrx.11.2020.02.27.04.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 04:19:48 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A5F5F1FF87;
 Thu, 27 Feb 2020 12:19:43 +0000 (GMT)
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
 <CAPan3WqTdC9+Vc3SvUEs+KUW7Ow-MuyJ0PewUH6aPNs44LdJsg@mail.gmail.com>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
In-reply-to: <CAPan3WqTdC9+Vc3SvUEs+KUW7Ow-MuyJ0PewUH6aPNs44LdJsg@mail.gmail.com>
Date: Thu, 27 Feb 2020 12:19:43 +0000
Message-ID: <87tv3cw7c0.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> Hi Alex,
>
> On Wed, Feb 26, 2020 at 7:13 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>> While 32mb is certainly usable a full system boot ends up flushing the
>> codegen buffer nearly 100 times. Increase the default on 64 bit hosts
>> to take advantage of all that spare memory. After this change I can
>> boot my tests system without any TB flushes.
>>
>
> That great, with this change I'm seeing a performance improvement when
> running the avocado tests for cubieboard.
> It runs about 4-5 seconds faster. My host is Ubuntu 18.04 on 64-bit.
>
> I don't know much about the internals of TCG nor how it actually uses the
> cache,
> but it seems logical to me that increasing the cache size would improve
> performance.
>
> What I'm wondering is: will this also result in TCG translating larger
> chunks in one shot, so potentially
> taking more time to do the translation? If so, could it perhaps affect mo=
re
> latency sensitive code?

No - the size of the translation blocks is governed by the guest code
and where it ends a basic block. In system mode we also care about
crossing guest page boundaries.

>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>
>
>> ---
>>  accel/tcg/translate-all.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> index 4ce5d1b3931..f7baa512059 100644
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -929,7 +929,11 @@ static void page_lock_pair(PageDesc **ret_p1,
>> tb_page_addr_t phys1,
>>  # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>>  #endif
>>
>> +#if TCG_TARGET_REG_BITS =3D=3D 32
>>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
>> +#else
>> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2 * GiB)
>> +#endif
>>
>
> The qemu process now takes up more virtual memory, about ~2.5GiB in my
> test, which can be expected with this change.
>
> Is it very likely that the TCG cache will be filled quickly and completel=
y?
> I'm asking because I also use Qemu to do automated testing
> where the nodes are 64-bit but each have only 2GiB physical RAM.

Well so this is the interesting question and as ever it depends.

For system emulation the buffer will just slowly fill-up over time until
exhausted and which point it will flush and reset. Each time the guest
needs to flush a page and load fresh code in we will generate more
translated code. If the guest isn't under load and never uses all it's
RAM for code then in theory the pages of the mmap that are never filled
never need to be actualised by the host kernel.

You can view the behaviour by running "info jit" from the HMP monitor in
your tests. The "TB Flush" value shows the number of times this has
happened along with other information about translation state.

>
> Regards,
> Niek
>
>
>>
>>  #define DEFAULT_CODE_GEN_BUFFER_SIZE \
>>    (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
>> --
>> 2.20.1
>>
>>
>>


--=20
Alex Benn=C3=A9e

