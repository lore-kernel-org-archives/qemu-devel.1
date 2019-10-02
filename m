Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56270C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2007A21783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAg9r+UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2007A21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFkP5-0007I8-0c
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 15:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFkNz-0006om-Bv
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFkNx-0006Tq-EQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:34:07 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFkNx-0006TW-70
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:34:05 -0400
Received: by mail-pg1-x543.google.com with SMTP id y35so129056pgl.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/emTy/X2u8H2Kx2MK4ciGkdwVLEO2QNY9Tghq7PxAq0=;
 b=ZAg9r+UFp5Wge4k3c+/xZqHwrBfkwkit3UYOp4lHRHk7vYWqVjToS4Up6gDP86SAKW
 gJwF+/EMU/sZdsmk4LNN4RI0Yu5R8zfN39v/HtFwR0L9Zjoly6Cd0H+gHin6jtt1eLRZ
 C6WzNZWkBgJfFOy5Lz0X44VREnQCT+JjCmSu2qOTm+yVRMVnMpPDDgh3UWvJkAK5iX/w
 6C3QT/sTPLAP3ioKQHFsuHEN4+cq/1idMnR7Lw2k+caRNMpP6excGbMST3mQcf80QKT4
 ICHlR29miGybfHa7UtoBqcpJAf9u5S2+9pn9F/q+z+U+i2II2SdcGbNJnoLJTJUnHV+H
 WPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/emTy/X2u8H2Kx2MK4ciGkdwVLEO2QNY9Tghq7PxAq0=;
 b=d2AJMhVy4Bf8DJZ5vbSvYRZIBMVbCfVZJbw983Iui0xKevm1fp/rNzRpmH7hk1OSnx
 9n2Oxjf0v1KSA4CedsPcBM3CjZ+8iSfx11spbqUY5TXyUZ88Lvzyw/GBB8fCuK/Ms1y5
 GiytnLLg+2tLJgBWDC9BTqwluEDeOJul1kZLWj5mqGrv0c6CYwIvF/1k40BZZjgS3HkX
 q6vU0PeXT9H669c0f3g/JpHTcsrRAz7Wx4SI6xm5ke23J2xH3qce2Ycv3r4jDHNTM/RP
 76bQdr6Pxst41qNcoWf/UpsdRAD9XTJOXWEGz/1S0IBeRzsIc2KZAkJ9zx9z4j++eYbZ
 SpTg==
X-Gm-Message-State: APjAAAVOe3rQo5cVNdq35aRA2zfcCFtJskQ4IhzvNZIIMGejGM3cMywj
 A4kE6yyIHbVHegvo3UOiB0GkIw==
X-Google-Smtp-Source: APXvYqz9CTIwPlZaXVnCeOj3cIdDzZlPXPrNN0T4V3rA3epDqZChGJsQFvxOPQpoEP0+mGg9ghrxSw==
X-Received: by 2002:a63:ca06:: with SMTP id n6mr5361495pgi.17.1570044843849;
 Wed, 02 Oct 2019 12:34:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id fa24sm63791pjb.13.2019.10.02.12.34.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 12:34:03 -0700 (PDT)
Subject: Re: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191002082636.7739-1-david@redhat.com>
 <87zhijjwph.fsf@linaro.org> <0479ad1f-348e-ed40-c2c6-aef168afdb7e@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <379c2065-adfe-0847-46f3-7f25c7650df9@linaro.org>
Date: Wed, 2 Oct 2019 12:34:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0479ad1f-348e-ed40-c2c6-aef168afdb7e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 9:47 AM, Richard Henderson wrote:
> There is still the special case of EXECUTE of MVCL, which I suspect must have
> some failure mode that we're not considering -- the setting and clearing of
> ex_value can't help.  I have a suspicion that we need to special case that
> within helper_ex, just so that ex_value doesn't enter into it.

I had a walk and a think.  I now believe that we're ok:

(1) TB with EXECUTE runs, at address Ae

    - env->psw_addr stored with Ae.
    - helper_ex() runs, memory address Am computed
      from D2a(X2a,B2a) or from psw.addr+RI2.
    - env->ex_value stored with memory value modified by R1a

(2) TB of executee runs,

    - env->ex_value stored with 0.
    - helper_mvcl() runs, using and updating R1b, R1b+1, R2b, R2b+1.

(3a) helper_mvcl() completes,

     - TB of executee continues, psw.addr += ilen.
     - Next instruction is the one following EXECUTE.

(3b) helper_mvcl() exits to main loop,

     - cpu_loop_exit_restore() unwinds psw.addr = Ae.
     - Next instruction is the EXECUTE itself...
     - goto 1.

If we can agree that the result is undefined if registers R1a, X2a, B2a overlap
R1b, R1b+1, R2b, R2b+1, or if the memory address Am is modified by the
interrupted MVCL, then we're ok.


r~

