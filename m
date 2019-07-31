Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C86C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADB220679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMGedzLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADB220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hswCZ-0003Wa-2y
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 17:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50617)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hswC0-00035A-L4
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hswBz-0004Pm-Lk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:31:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hswBz-0004OP-EU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:31:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so32564973pff.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xBJrYmRCZ64I/3La6VVvbsmnrtT8xAr/Hm5TrJb/b9Q=;
 b=qMGedzLDR52NCe3vGpBvlYuQ5yaX/bD4dHzgWghKKD6Ydbhe67pTnDPXvFav5aAxvI
 3/IRCnsG0ajdOpYD0lvG/cuL1uC/f42u1TW701tWqRo5QxsDUWDAZPNehVQv5NL9G4k6
 1oOdEwqF81nGq9snD0IWaD8P/C0l7dwCdZ6hqzkFmvuaBXIaucflDGRIhmgMktvbJA9i
 lXXySQ4M+AhqtKg9cfBY3bsgJsRLQkxYPWcxIpwAUEtD0wIkTY3q+M3IIrXLo+K0pn5w
 2NBywrjAcH+Co95CaWOn4TQh9udHqecrxpELAA2N+VVV8oyy/owLkHZzqd6DT2yd8OIG
 5W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xBJrYmRCZ64I/3La6VVvbsmnrtT8xAr/Hm5TrJb/b9Q=;
 b=aMsgcTODnnZmfWlyPjWio7ORG0Qf56X/iA2eDlMFauuch+U1+510qnjYwVipO8PS0O
 fBwLd0rmDEo75Jquqoonr0OIFyHRCRnn4DA8aLO/5Ne5hn8cTI/qqqFf1otIRlHFho3F
 m2SuqwGb/yW62rA0JQaREnOTYqwZtkFfMeKsdbomM4RUdWFI+8OjBt8hQGwPGe/5Fy4X
 G2cFoV0erh/8ous9PPlgygWjGHNTPTrT6FmF9kFnZhZBDkeEpRxiQzO/GX9ZSsDzJQsI
 oAX6H97ETyv18ya9+qC8g4TSMz9MstcPfHqZc7X1TBgm2iB9wbE3myyyJ05T6Beaye9e
 6qSQ==
X-Gm-Message-State: APjAAAVl2kSnlTmDV7h2S4fdgoXuYn4kVggVsdQxEb80lintzHxGLyKg
 Vtn05RQ8Q2cr3scgDFPesnQ8qQ==
X-Google-Smtp-Source: APXvYqxAUxVrCP+CqJQnES0vFzq6drLiCFeG72PqalqPjrGXvkVLPDxnv5y+CxyssH/dZyYzYqzOWQ==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr26837755pgf.340.1564608686031; 
 Wed, 31 Jul 2019 14:31:26 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n128sm24761369pfn.46.2019.07.31.14.31.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 14:31:25 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-23-jan.bobek@gmail.com>
 <1691a32a-e0a2-931b-2d17-4dae8dde7c7e@linaro.org>
 <CAL1e-=h2eHpH2KAtT+orB9gbqnaqTVYf+W_eVfmNrj+jxVsnnA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bf8155f6-4f03-dcb6-5159-5f10dd0211a0@linaro.org>
Date: Wed, 31 Jul 2019 14:31:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h2eHpH2KAtT+orB9gbqnaqTVYf+W_eVfmNrj+jxVsnnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH v1 22/22] target/i386: reimplement
 (V)P(EQ, CMP)(B, W, D)
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 1:09 PM, Aleksandar Markovic wrote:
> 
> 
> On Wed, Jul 31, 2019 at 9:51 PM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 7/31/19 10:57 AM, Jan Bobek wrote:
>     > +static inline void gen_gvec_cmpeq(unsigned vece, uint32_t dofs,
>     > +                                  uint32_t aofs, uint32_t bofs,
>     > +                                  uint32_t oprsz, uint32_t maxsz)
>     > +{
>     > +    tcg_gen_gvec_cmp(TCG_COND_EQ, vece, dofs, aofs, bofs, oprsz, maxsz);
>     > +}
>     ...
>     > +static inline void gen_gvec_cmpgt(unsigned vece, uint32_t dofs,
>     > +                                  uint32_t aofs, uint32_t bofs,
>     > +                                  uint32_t oprsz, uint32_t maxsz)
>     > +{
>     > +    tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz);
>     > +}
> 
>     Drop the inlines.
> 
> 
> Why? The compiler will decide at the end of the day, but at least "inline" here
> says that the code author thinks that inlining is desirable, logical, and expected
> in these cases, which is in turn a valuable information for the code reader.

In this case it is in fact a lie that will only confuse the reader, as it did
you.  Functions whose address are passed as a callback, as these are, are
always forced out of line.

But beyond that, clang diagnoses unused static inline within *.c while gcc does
not (I'm not sure I agree with clang, but it is what it is).  By leaving off
the inline, but compilers will diagnose when code rearrangement leaves a
function unused.


r~

