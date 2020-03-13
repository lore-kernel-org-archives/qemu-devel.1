Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C130C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266EC20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1g3+DBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266EC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmZO-0001tZ-8p
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCmYj-0001QB-4x
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCmYh-0008Pw-Gx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:49:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCmYh-0008MO-9Z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:49:11 -0400
Received: by mail-pf1-x442.google.com with SMTP id z65so5442021pfz.8
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=22czK8c6PYmQT3CIcKF+GmgqHPCijfV5vZhAGAsn0Tk=;
 b=q1g3+DBr4M7WQ0vOLTEqDk9o41HpC9I1sPNkqP6bAWQbKHYDsTXfLq8gtRlrwOAlQc
 ma5XloH7hVLV3Lbm6twGPrseNF0GHNwfa/fgbq9f/rZNeNowgHuJvrVK8IWdHUL3fHym
 HkC6/XTCfD2SrozIMpZsNZwwO5H61cPjKiSBh4OPWS+QhyMHodcJWkhCfJRs0XxLkDFS
 aG2lYlAG5qACZM6YJmaAuDD2J+xyAmzZG/nSvcIJMMT+NhwzgpNbeEhHRdtCUWLPCCvI
 YooL5gVHgQrKiKWxWKPbFTimtgVL7lHVlQzaGtHKk9r90omUed2T2NEp/OQS/rp7N/NC
 B25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22czK8c6PYmQT3CIcKF+GmgqHPCijfV5vZhAGAsn0Tk=;
 b=JFyBPMAz00HzrMJhuKAs7JC1GoekBg2UxAmHg7y6MitCmpJdVXTZX8MDxHLSAZs9KU
 CDSMCmxVQLJVrKkpRVn3QzpdlbyN2vOA7I/bH3oa/kd/QCz2SfpYdOl6TKLHhenFa1BD
 oOvvZ0gKZh78Q6FXE6aS6QEWmqv9kNXnGvEg64QJOBezfx8f5k2zHa97CwhHbbOwlfeR
 4ssYzxve+/CPi+nR2HnpjO905pvBh+O3XxQiy055UgUqWGdU5oWiVgovTP7BFwJBq9W7
 LKOTq4EOn6eEAtOzs4enF0s0FT+8Sd+6N2VraxTtV3DGswOldzYpB8P5QGRj2jifEm+e
 kuOQ==
X-Gm-Message-State: ANhLgQ1eJNRe+B92jIaNyRj1s3pWcVu9rh0SEW1Guhd83QakFZ06O/Oi
 DgwvJlJLjf7Uy5bLW67NerrCwgIDUJE=
X-Google-Smtp-Source: ADFU+vvbALVJIZU9UY0gJljkkgZJcYG9pKBlMrrtqVArNgEsw1LwP0BHiNfI86JQeKWn1qSZAMLmOQ==
X-Received: by 2002:aa7:914b:: with SMTP id 11mr14687896pfi.69.1584114549359; 
 Fri, 13 Mar 2020 08:49:09 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 26sm29120970pgs.85.2020.03.13.08.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 08:49:08 -0700 (PDT)
Subject: Re: [RFC] [PATCH 0/5] ARMv8.5-MemTag disassembly
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
References: <2159383.tmy0LfLZHX@basile.remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <886d0295-9fed-2e81-ce5e-54668755029e@linaro.org>
Date: Fri, 13 Mar 2020 08:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2159383.tmy0LfLZHX@basile.remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 6:59 AM, Rémi Denis-Courmont wrote:
> For proper storage and checking of memory tags, MTE == 2 would be
> necessary. I have some code (on top of this RFC but not included) to add the
> tag allocation logic. But I have no clue how to actually store the tags in QEMU
> system mode at this point, so it's mostly dead code.

I have implemented this, and posted version 6 yesterday.
Peter gave you the link.

> In user mode, it seems impossible anyway, as tags are indexed by physical, not
> virtual address and QEMU cannot know which virtual memory address may
> physically alias another within the user process.

I have implemented this as well, with a made-up ABI controlled by a
command-line option, which only works with non-shared memory.  Because the
memory is non-shared, we know a priori that it does not alias another address.

Version 5 was posted in October:

https://patchew.org/QEMU/20191015163507.12153-1-richard.henderson@linaro.org/

My branch referenced in that cover letter is still available.

You will be interested to follow the Linux kernel development of this feature
and the user-space ABI:

http://lists.infradead.org/pipermail/linux-arm-kernel/2020-February/714413.html

In particular, only anonymous memory and files in filesystems backed by ram
will be supported.  Userspace will get an error if they attempt to enable
PROT_MTE on a VMA that does not support tags.

When I update my mte user branch, I will only support anonymous memory, since I
cannot share my on-the-side data structure for tags between aarch64-linux-user
processes, whether or not they are in a tmpfs filesystem.


r~

