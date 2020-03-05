Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404FAC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4E8207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkLciiEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4E8207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wmL-0003B4-5L
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 15:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j9wlH-0001ch-MT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j9wlG-0000RK-MH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:06:27 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j9wlG-0000Qw-Gt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:06:26 -0500
Received: by mail-pl1-x644.google.com with SMTP id u3so3091472plr.9
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 12:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=aK2JQAB7Q1gn7fdcHul4fN6uds+oVK0UvAfAjO2mZ9Q=;
 b=nkLciiEOFdnmJr4oaNmteD5JKyspPP2UPNugBq1tAic4ve8l5Go3WA297cbIfocXnq
 BMxP9DE+LMWiv5M0NoYtrF2ixRGqcVgpxowEdPeRYaakQIejO/tLvLl2PtMSjTFqmXhI
 tP/cnCetytZdexpXIQtUB7w6Q/t3X4ZE20Sb/BbZ9Au603Z8ZtV8N0iUJvnOgQsIL75G
 psKuKZurxHD7A6TXquL8Z2Q+dXVAjHtL/D976QhA6+cyvwJnuq+nvFDq63WvuA9xFEUe
 uILwGjbduMG1YXCNqMuw9zN27eNRkO3ZJehju+jkVFs/Mjh3pH+D/4Gu1RJmvDosub2H
 ziog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=aK2JQAB7Q1gn7fdcHul4fN6uds+oVK0UvAfAjO2mZ9Q=;
 b=Zn1IBOixyrR0MNFX8KBGHf5EZD7mrLk9fJ2lEuQMnSCzreCvb5JqhksnaM9w3hSeMn
 oxAU31EBSwf4uWXGW00OdCS34zzjAPff6wcpXQdlVmdIp7/g9t45TR+QcvZ71413pFQc
 radaHTYxb7wtgDki4T3+YfPean9ecFiCViI+4nuzP9krgLUq8zDLXK/y1IA2DLCgZoxu
 HGXGTxr3DYmEA8NJGWIlqDL16H1y1wjMy6lwDnGlnwbvQp/DfP7E2OplHAmu/2Qo7zkN
 OODxgW9co0VOCIM1dhHnxiya9yLtmDOj9aSt4KOUHzpwba7dWEY7k/e3ygYFjy52NHcL
 lK9w==
X-Gm-Message-State: ANhLgQ1U49N2Cg/xmja7oyubRgtzBBePkKUCczAp7lj3ijfzfCbgbu5R
 1JtcpyL3PZ7Q9aEEMITCpyoM5Q==
X-Google-Smtp-Source: ADFU+vsOxdipjlXH6tWhcB8BNh2LE6l/eUDwDH4lZXskAUlEvO2bwAXVEzAT0oFf5hTuNGjRjmEtWg==
X-Received: by 2002:a17:90a:22cd:: with SMTP id
 s71mr299051pjc.181.1583438785358; 
 Thu, 05 Mar 2020 12:06:25 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id r13sm6969216pjp.14.2020.03.05.12.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 12:06:24 -0800 (PST)
Date: Thu, 05 Mar 2020 12:06:24 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 12:06:22 PST (-0800)
Subject: Re: [PATCH] RISC-V: Add a missing "," in riscv_excp_names
In-Reply-To: <CAP+75-XPHkSkcOmLct=jerOPx_WmYTc6a-=f2LfvtFku_p1WBw@mail.gmail.com>
CC: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: philmd@redhat.com
Message-ID: <mhng-9606b2d7-09a7-4598-81ad-120a74a40e68@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 05 Mar 2020 09:20:31 PST (-0800), philmd@redhat.com wrote:
> Cc'ing qemu-trivial@ in case there is a pending PR in  progress, it
> might get merged quicker.
>
> On Thu, Mar 5, 2020 at 6:19 PM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> On 3/5/20 5:48 PM, Palmer Dabbelt wrote:
>> > THis would almost certainly cause the exception names to be reported
>> > incorrectly.  Covarity found the issue (CID 1420223).  As per Peter's
>>
>> "This", "Coverity" typos.
>>
>> Fixes: ab67a1d07a4
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks.  I guess I'll just send the PR, as there's really no reason to block
this on the other RISC-V stuff.  It'll just be a single patch PR, so if the
patch goes in some other way then it should be easy to drop.  I usually don't
like rushing these sorts of things, but this one seems pretty safe.

>>
>> > suggestion, I've also added a comma at the end of the list to avoid the issue
>> > reappearing in the future.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> > ---
>> >   target/riscv/cpu.c | 4 ++--
>> >   1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > index c47d10b739..c0b7023100 100644
>> > --- a/target/riscv/cpu.c
>> > +++ b/target/riscv/cpu.c
>> > @@ -66,7 +66,7 @@ const char * const riscv_excp_names[] = {
>> >       "exec_page_fault",
>> >       "load_page_fault",
>> >       "reserved",
>> > -    "store_page_fault"
>> > +    "store_page_fault",
>> >       "reserved",
>> >       "reserved",
>> >       "reserved",
>> > @@ -74,7 +74,7 @@ const char * const riscv_excp_names[] = {
>> >       "guest_exec_page_fault",
>> >       "guest_load_page_fault",
>> >       "reserved",
>> > -    "guest_store_page_fault"
>> > +    "guest_store_page_fault",
>> >   };
>> >
>> >   const char * const riscv_intr_names[] = {
>> >

