Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343BAC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FFC206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyYC4T2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FFC206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8T9I-0001xf-5I
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8T8D-0001Ns-7W
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8T8B-0005oT-NY
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:43:44 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8T8B-0005md-Gv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:43:43 -0400
Received: by mail-qk1-x743.google.com with SMTP id q203so25328960qke.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/xZLhTQMjOLFgw9gz6bIaHfiQ4VR054PG3MfPmMmCeU=;
 b=tyYC4T2/YBI4rP4i1UMr8vFBmw5nubJjsiayq6cLOiDIe2JY5N27N+HzZGtwI4n7jN
 EScQZPCYsWpwmYoEj+gHDkDXgWDltFKHjyrl0wL5iNKCFPHXpi+QTP3NuN0WaPpek273
 0JYwLsCH+AoyGeE31N/UWvVPlwgmv0LlTwEcWFjfQC2u7w4UfuvD+A3gubInL8qck78B
 t3j4zfsfC0G0IbdkhxpAYitnquMPFRZBi+xW9ucFzYTQMGlyp/3WgYvs4dMc1jiTXSZa
 9MAUJBpmXbFlBR3A8FPGmK+mRxmcPxfkRg3OHgBNI9Kr4DAh3w0Y194SQHhSDtGNcXZ7
 r+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/xZLhTQMjOLFgw9gz6bIaHfiQ4VR054PG3MfPmMmCeU=;
 b=V8fptd6WyQLnvU1qPden8572GGfiZOJAkPk/EE+Ol2XfgVcuQO9/Jve1D6zreJ7zTy
 wjXb6qQxhVDHLNpkygI1rDHhbBbH/X8xW98K3VOywYUra+oWWrNggMe+6UIKlKhYyb8I
 X50MmLW8teBP1rjpVm43r6J/BDaisVDe95FBlyxPm4Syf2LLWYL+5HEfmqj23YyB1LRn
 zAitS21n/8um5Xsol+CgmBrQGi7FivlKJx+ChEMKalyuYNaiudqPq28H0flYjZHAWF4i
 TULiCeKlhcG+HTDrt+DWi1IgRytMm3HycQhsG/Lg/YvCgs5bP2+6joGjkKbobmVnVmna
 5V3w==
X-Gm-Message-State: APjAAAVijw2ZNby5aqO+A4o0uzVDYZlsQ1kwqWGpTm2A8Fca5c2WoGuH
 BXYKOh9pz0Ga4m/XKBW558nxQAxGHUc04w==
X-Google-Smtp-Source: APXvYqwfZsNYCobtaQC4zJMUdBvj9ji4MfN+IrXvS+S0bC7OTqLthrT+65+o74mmg1PNMNMtyDp/1w==
X-Received: by 2002:a05:620a:40e:: with SMTP id
 14mr42038251qkp.432.1568310221884; 
 Thu, 12 Sep 2019 10:43:41 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id m22sm11167723qkk.28.2019.09.12.10.43.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 10:43:40 -0700 (PDT)
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 'Paolo Bonzini' <pbonzini@redhat.com>, peter.maydell@linaro.org
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
 <1566284395-30287-16-git-send-email-pbonzini@redhat.com>
 <46af8966edd45c163d7d0bd974f557cd@ispras.ru>
 <000901d56936$e10a0b60$a31e2220$@ru>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ae45ff2c-70d2-da6d-5f65-2d842f060af0@linaro.org>
Date: Thu, 12 Sep 2019 13:43:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <000901d56936$e10a0b60$a31e2220$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PULL 15/36] memory: fix race between TCG and
 accesses to dirty bitmap
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

On 9/12/19 2:54 AM, Pavel Dovgalyuk wrote:
> Ping.
> 
> 
> Pavel Dovgalyuk
> 
>> -----Original Message-----
>> From: dovgaluk [mailto:dovgaluk@ispras.ru]
>> Sent: Monday, August 26, 2019 3:19 PM
>> To: Paolo Bonzini; pavel.dovgaluk@ispras.ru
>> Cc: qemu-devel@nongnu.org; Qemu-devel
>> Subject: Re: [Qemu-devel] [PULL 15/36] memory: fix race between TCG and accesses to dirty
>> bitmap
>>
>> This patch breaks the execution recording.
>> While vCPU tries to lock replay mutex in main while loop,
>> vga causes dirty memory sync and do_run_on_cpu call.
>> This call waits for vCPU to process the work queue.
>>
>> Pavel Dovgalyuk
>>
>> Paolo Bonzini писал 2019-08-20 09:59:
>>> There is a race between TCG and accesses to the dirty log:
>>>
>>>       vCPU thread                  reader thread
>>>       -----------------------      -----------------------
>>>       TLB check -> slow path
>>>         notdirty_mem_write
>>>           write to RAM
>>>           set dirty flag
>>>                                    clear dirty flag
>>>       TLB check -> fast path
>>>                                    read memory
>>>         write to RAM
>>>
>>> Fortunately, in order to fix it, no change is required to the
>>> vCPU thread.  However, the reader thread must delay the read after
>>> the vCPU thread has finished the write.  This can be approximated
>>> conservatively by run_on_cpu, which waits for the end of the current
>>> translation block.

If we are going to delay any read of the dirty flags until vCPU has completed
any active TranslationBlock, then we can simplify the TCG operation so that we
do not (ab)use the mmio path, and can promote this into the tlb slow path as we
have recently done with watchpoints.  C.f.

commit 50b107c5d617eaf93301cef20221312e7a986701
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Sat Aug 24 09:51:09 2019 -0700

    cputlb: Handle watchpoints via TLB_WATCHPOINT

That would greatly simplify things from my perspective, for vector and
block-type operations such as we have recently been discussing for S390.  It
would mean that the *only* time we go through TLB_MMIO is for true mmio.

Have I understood your proposal here properly?


r~

