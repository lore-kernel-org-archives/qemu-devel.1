Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76B1C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC702054F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrYRPiLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC702054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07LD-0008S2-Js
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i07Ii-0004wy-Tw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i07Ih-0003RC-Su
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:48:04 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:34207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i07Ih-0003Qa-Mc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:48:03 -0400
Received: by mail-pg1-x530.google.com with SMTP id n9so3566410pgc.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=28sHWhf+yzSPD5yPH7PidjYS8+op7J8b7bPyQiW5moY=;
 b=BrYRPiLNta/IQYGzc055ClPjDkkKO6aSz8dSr5TCGCuzjiKOQmKyaMuc/T13gSg7m4
 itqcaGfGijP0jZXLYA5NdpTFTRppUshdxDuggNxFPxPB87UfLUooCbEqZWlV8Lr0DLXp
 0MhWYdz1WqyFVqkTxwx81qNzge2hazhIqjOkWZhmFy1t4Aji1AZBSU7ii2ij9Pxpq/eE
 FhYZGaCvRHQwMFLirXnFLz/qoRzY73cj4cGGesA4wqdN8u9+SHZBO/3cx5L9smQ43yMT
 v5JUw3KkpzqyeKCmzXu6jZB8xmSUF1+SQ200nUAPWZFOtsNUASpnhV2x6ugIbFAT6h6Q
 hzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=28sHWhf+yzSPD5yPH7PidjYS8+op7J8b7bPyQiW5moY=;
 b=etPI6dpDqFGnAiBrAmDK00gj8P/jF9gE1tiCs9Ui1BXMwzIT/XHsMdYxa7GJE5xLkC
 vGKWas7FbV3HiZQH33E1427UxvG3d4EFUpMd8VubbjdbrW4KwktrUpuTqO1zGHnzO6nt
 I3+Ps11cKGKp1jHcI32sOjSFsB/3y4SSjin3Z/sye9RCoili6IzuUDEm5ICmlPA6p1Sf
 Y9QuvFqcfILmBUZYl0q4i9TxLiQpxqhhs+ggg/LBGHFGVKKSR7H/IBCwngmc8jDKBr4q
 tmSRV0OfZTpEAWuwMGUMYIQeL7KSn6NS6EgsO2HUPXt7ttgEJR79Md0n51SRoBCG2og2
 /1qA==
X-Gm-Message-State: APjAAAWPjEj+kIORYwsxuTRn1pfggEV+DThxnmdqanvAcO0Qax4MkqUb
 185ubtKFbL9Ea8Y20PFQE+2Cmw==
X-Google-Smtp-Source: APXvYqyVnqbvhBKoTBTM4Ctxx7H8h/sENeaEypsjCI1yYK5/v6QdAJyTdMsF0++qvzix4hl690K6kQ==
X-Received: by 2002:a17:90a:ac14:: with SMTP id
 o20mr875950pjq.143.1566319682557; 
 Tue, 20 Aug 2019 09:48:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v18sm20400397pgl.87.2019.08.20.09.48.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 09:48:01 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
 <CAL1e-=hx9bLLOZiwa2UySt98T3HGWhshwwm2j0wTp5JSjJxG-Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d8a9fe9b-4293-5714-8434-aff1ebebc415@linaro.org>
Date: Tue, 20 Aug 2019 09:47:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hx9bLLOZiwa2UySt98T3HGWhshwwm2j0wTp5JSjJxG-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 9:15 AM, Aleksandar Markovic wrote:
>     > tcg_gen_gather_i32
>     > tcg_gen_gather_i64
>     > tcg_gen_gather_tl
> 
>     I'm not sure how "gather" applies.
> 
> 
> gather = come together; assemble or accumulate

Sure, but...

>     To me this sounds like a vector
>     scatter/gather operation, where N different addresses are used to load the N
>     elements of the vector.

... it also has a completely different well-known meaning.


>     Hmm, "pick" doesn't mean anything to me. 
> 
> 
> and "extl" does?

Sure: "EXTract Low".  Paired with "EXTract High" it certainly makes sense.


> I was hoping we would remove "sextract" (well, it is funny a little bit
> definitely, but if there are zillion occurrences, and used everyday, it just
> stops being funny, and is somewhat distracting...), however it looks we will
> get "sextend", and "sextend2", and "sex_h" and "sex_l"...

Why mention all of these brand new straw-man variants?  Anyway, we are not
children, giggling at a sequence of letters taken out of context.


r~

