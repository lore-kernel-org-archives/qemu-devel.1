Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F37C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72667206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGY2uJYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72667206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS4JL-0005cC-Kd
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS4Ii-000515-La
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS4Ih-0001tw-OZ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:47:52 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:33527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS4Ih-0001sX-8s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:47:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id d17so5122142pgo.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KuTTFO43o9MfknGoL+yTL5uD1zG6DHtUR0zb320AZRs=;
 b=zGY2uJYvOt2XVNJptThZDXcWvsXVjbZ26CDTRsFsoJMZIlSrtM/9KxKFdEMsCikd2V
 0FOqg+BRLyyhBsQhNAtyeplvPEPInWPRAen9Kkg5QBnN6PtdXJrap9JF5jum1nsWyViA
 6JkHh7aZOaAVrBkZ03XSGKkOzMr0mMni1Z2ExsAS9bRyeUqKxgKNzHoXmnByWccx9X6X
 J6OQI1dxvSa5dhPPWhzWF/Tohvpwt13v3NLGytWC2kwGWdzDL3M0mpUydNV7gh1cLfOk
 Vz23CwnbZElEk2n/BzNwlTSnfC3H8y5E+6+/7unx+rj7rn+gel8aYETVaC0IZVIBI+e0
 LxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KuTTFO43o9MfknGoL+yTL5uD1zG6DHtUR0zb320AZRs=;
 b=M+JUaEvHGFAIhwWXfJ0c5Hhs+oe10eEYrh4SNWaiqG1fZ+nfaIs2/uQvzAx5aIouPG
 3ndB7YrsXX25SG7tsXQG+ghp7ofNBarxGDYcaXU6nG/rj8fbjLms5n4k4aaFPChurQf5
 uGKONMUfAZfxyS6Fu/q56loBgfti2D20wMvQMldiqgi2CwI7sgzf+esQR0RoZ/UHZ1m5
 Czeu20Ru++Qk2N1c13kMnWmJvmtEEtTbXlJRPOEnS6ljaq6oxKGlfPuhGGfomLqKT9Wi
 U0XnFUE3Z6/zBOV4nh5buJQ4vJcoY9pjuFLuKIQDfAnbYVgcxNxJzSkroqv7m+pwRzg9
 BSiQ==
X-Gm-Message-State: AGi0PuZOOAM2TBi+r+Y8E9QHYOkhjmmYS/0Trk159n6wzzPBK04V5387
 pkWnHfWR5+f5KvQDcOZPymxhcg==
X-Google-Smtp-Source: APiQypIxBb6YjUx0cO+57QsH+oWV1VYwzq5a+yKq2Kq5YSoLLCmwFXu5YsqEHdsxb99n8fgu8mQQrw==
X-Received: by 2002:a63:721a:: with SMTP id n26mr11121359pgc.386.1587757668942; 
 Fri, 24 Apr 2020 12:47:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id e135sm6475236pfh.37.2020.04.24.12.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 12:47:48 -0700 (PDT)
Subject: Re: tst-arm-mte bug: PSTATE.TCO is cleared on exceptions
From: Richard Henderson <richard.henderson@linaro.org>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <20200420102902.GE15401@arm.com>
 <a36c670a-5cef-f8c6-ce1d-4fbb28f9488d@linaro.org>
Message-ID: <ec85fd40-229b-c965-1f58-d4cbe825419c@linaro.org>
Date: Fri, 24 Apr 2020 12:47:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a36c670a-5cef-f8c6-ce1d-4fbb28f9488d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::535
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 9:39 PM, Richard Henderson wrote:
> On 4/20/20 3:29 AM, Szabolcs Nagy wrote:
>> i'm using the branch at
>>
>> https://github.com/rth7680/qemu/tree/tgt-arm-mte
>>
>> to test armv8.5-a mte and hope this is ok to report bugs here.
>>
>> i'm doing tests in qemu-system-aarch64 with linux userspace
>> code and it seems TCO bit gets cleared after syscalls or other
>> kernel entry, but PSTATE is expected to be restored, so i
>> suspect it is a qemu bug.
>>
>> i think the architecture saves/restores PSTATE using SPSR_ELx
>> on exceptions.
> 
> Yep.  I failed to update aarch64_pstate_valid_mask for TCO.
> Will fix.  Thanks,

Fixed on the branch.

I still need to work out how best to plumb the arm,armv8.5-memtag property so
the devel/mte-v3 kernel branch isn't usable as-is for the moment.  For myself,
I've just commented that test out for now.


r~

