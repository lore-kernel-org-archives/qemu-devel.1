Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8865CC5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D28A206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoPw00X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D28A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT6FI-00060U-E0
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 12:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jT6BS-0008F2-8u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jT6BN-0004AO-3Y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:00:36 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jT6BM-00049H-FZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:00:32 -0400
Received: by mail-pj1-x1044.google.com with SMTP id e6so7609561pjt.4
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F+/K3Z872EDXQDgaag5cAOSBjkaI2e3LPcXJOZLxUh8=;
 b=RoPw00X4i7H5a5Lo/cTItbCrjoFfme9323D3ozVCE5j5ukcPwMsgr8TJXerJunXfCH
 QNSHD73DpSA7E8LC6zMLyITmqpqk0VrB9MzaU0HJMn7NpLClGBjNTL2cUla12gT2p0Aw
 aci2js9N9uEk7R947/WKvmHY9on62/KLXLf6FNEs1iH8hP41y/qNKc6sn9sNe4HgvME1
 QjwI6xhjNOVXixnwYwRTno+Eom+nSqHaVkN+i2Q7d5XVUmEQEsXDArPI59x+Dkk6pEOe
 S5MvIiunujo0k5KOTCfsY43PMwwKB3NTbcCeDwSMxzOUty3RLl2KEyRU9ElloV8ynbh9
 hFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F+/K3Z872EDXQDgaag5cAOSBjkaI2e3LPcXJOZLxUh8=;
 b=n+zZKesHPcT4nuMXKWURlrzAbNIi2LMtue6g9I/jhBfdGlBZF6RnzXhN4ZLwdT5cN1
 pqiWQc8v58y25/LFE41qUm3L7ck7DHev7pWVA+LLrZ72dJDTj2khrWACm9Fob3kRHtw+
 ktgNVl0x77ryfP+3wt0sD9WtvYOgVzwA5RKndwakYyoTM698v+tWhEU2q2nbeTSLDmRz
 V7u/ThrZRY+MUFETGsq3syF5JwKh55j+LlIwr+aca7iUnHpXmbtwdiJ6yF7kZlAbmBGb
 DLqceG7OTxUty17CCaOVRIFJVxuH4XLPErsoE7Aib+rXUakS+nAUqBFEByG8ZorFACWl
 dkmw==
X-Gm-Message-State: AGi0Pub7Qxd8lfsfI1TxtC7XFTkuAp/L8/V1jklYKpP7HHKEMC/gy/Vm
 xEuL87Pku3HF66YRoTu0gutyACzcf0g=
X-Google-Smtp-Source: APiQypLDdrmGF+6jA166Dl44u8wAyO9JI8L00NlwhTtsKzwE6fY+Wl12Itj6y3+2dKFgG4teCm3WrQ==
X-Received: by 2002:a17:90a:de8d:: with SMTP id
 n13mr10993010pjv.173.1588003227101; 
 Mon, 27 Apr 2020 09:00:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l64sm12091347pjb.44.2020.04.27.09.00.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 09:00:26 -0700 (PDT)
Subject: Re: [PATCH v3 04/18] accel/tcg: Add probe_access_flags
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-5-richard.henderson@linaro.org>
 <CAFEAcA_ugvJWmN8fNbvZYJvOtyv6uPAumQ8UPtK-k9nqN=uerQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69d6cc05-2610-d81b-df8f-0f8d723530af@linaro.org>
Date: Mon, 27 Apr 2020 09:00:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ugvJWmN8fNbvZYJvOtyv6uPAumQ8UPtK-k9nqN=uerQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:48 AM, Peter Maydell wrote:
> probe_access() handles watchpoints. Why doesn't probe_access_flags()
> have to do that?

Because we are explicitly deferring that work to the caller.  That's a good
fraction of the point of the new interface.

>> +        /* Handle clean RAM pages.  */
>> +        if (flags & TLB_NOTDIRTY) {
>> +            notdirty_write(env_cpu(env), addr, 1, iotlbentry, retaddr);
>> +        }
>> +
>> +        /* Handle watchpoints.  */
>> +        if (flags & TLB_WATCHPOINT) {
>> +            int wp_access = (access_type == MMU_DATA_STORE
>> +                             ? BP_MEM_WRITE : BP_MEM_READ);
>> +            cpu_check_watchpoint(env_cpu(env), addr, size,
>> +                                 iotlbentry->attrs, wp_access, retaddr);
>> +        }
> 
> The old code checked for watchpoints first, and then handled notdirty-writes,
> which seems like the more correct order. Why has the new
> version switched them around?

Not an intentional change, but I shouldn't think it would matter in the end.

> The probe_access_internal() doc comment doesn't say that it
> guarantees to set host to NULL for the TLB_MMIO/TLB_INVALID_MASK
> cases, but we implicitly rely on it here.

Eh?  probe_access_internal doesn't have a doc comment.  Call that a bug if you
like, but you seem to be talking about something else.

>> +void *probe_access(CPUArchState *env, target_ulong addr, int size,
>> +                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
>> +{
>> +    void *host;
>> +
>> +    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
>> +    probe_access_flags(env, addr, access_type, mmu_idx, false, &host, retaddr);
>> +    return host;
> 
> The old code returned NULL for a zero size; the new version does not.

Granted.

> The old code passed size into cc->tlb_fill; the new version does not.
> The old code passed size into page_check_range(); the new version does not.

This is the user-only version, and size is not used for tlb_fill.  It is only
trivially used in page_change_range; we have just verified that addr+size does
not cross a page boundary.


r~

