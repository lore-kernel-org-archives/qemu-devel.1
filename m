Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D386C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D78C2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mqb+aQX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D78C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnnK3-0008KF-Dr
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 14:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnnJK-0007hr-FO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:06:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:39591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnnJI-0005y0-Gn
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:06:18 -0400
Received: by mail-pj1-x102f.google.com with SMTP id b92so209037pjc.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sqH3myKxhwObTCSAf3M49mrxAdHCZocAEtDKioaAzH8=;
 b=Mqb+aQX8+FwMdtN+whrVdpi0VyHLUP5/6/c0pC5qyGH9fp4X30+vLVpZ0QEQPWglF4
 SO4GYoxudjxtIXDHxl3PF8lNPTHKViwP4MeC7tmzg3gIwJdQaNOrA31sZ5u3AkULl01i
 wJaxE6f1npqV94XT0tTMz+pjCkgjheTAkQ3SpcKwXFFH1J9bvAfdBiVzxIMuLOfc/vPI
 mYnGv8oxXfOWk+p12WRy95+OBGjW0+wQg75Qxb9tcOCXNoClV0Gji63LAT7P4N/UfPhA
 JnW5dcJNAJGAgAj5LFoIDYgXgi6wao1EsBFtdqB6aOIIYef7OLMXuxm1AdccI59SJMjm
 fNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sqH3myKxhwObTCSAf3M49mrxAdHCZocAEtDKioaAzH8=;
 b=jUT2tXrxOIjcPdT7g5kN5N0GJjq2/sJoiTjV4qDs/I8p1j0EXwbYbR9Vsy9LZqHB1t
 ck+sQvLKPMprIWrWqImCdiNNqjsjiXBqVAaiS9DGXPJifBGPsEI7bA0LmB7+WUWsCUdI
 bJlrYnFu4vYtur4C+r3Jog3S3wTqGKCIIswXZU5b6WgAcBAJvClCySMhWvQ4XPcircs+
 r4scCWHt/s+KAZaTRS26fFMnYTOxlv1zcp2ePGl4v7+WJrepNnYwoDjwJiacbuyMb2a9
 zrW7ja0UV/cEedIsI22bowM/OY7lZDeE8CRAvfVYzGcUKfMpnx2/dpzAH63sT7GhKRJz
 33IA==
X-Gm-Message-State: AOAM530RplBb3uhplozO7cjQlG4LnLg/gIxOdXChpT3sTWDjJ0X26/RQ
 Gmd07cMeiwERI20bIUJZA2UdmBxTCTc=
X-Google-Smtp-Source: ABdhPJy6/k1407Pee3u5W04DUs7mxkWyhM65112tDKxfNOg/7iVwyuMDWi8XCKXK+bsc0OV6eRK2WA==
X-Received: by 2002:a17:902:7c87:: with SMTP id
 y7mr5260707pll.240.1592935574065; 
 Tue, 23 Jun 2020 11:06:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h13sm17610374pfk.25.2020.06.23.11.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 11:06:13 -0700 (PDT)
Subject: Re: [PATCH v3 25/25] ppc64: Clean up reginfo handling
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-26-richard.henderson@linaro.org>
 <87sgel7k2f.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9296458-a20f-6174-8a91-9bedbd662f99@linaro.org>
Date: Tue, 23 Jun 2020 11:06:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87sgel7k2f.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On 6/23/20 10:45 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Several of the gp_reg[] elements are not relevant -- e.g. orig r3,
>> which is related to system calls.  Omit those from the original
>> reginfo_init(), so that any differences are automatically hidden.
>>
>> Do not only compare bit 4 of CCR -- this register is 32 bits wide
>> with 8 cr subfields.  We should compare all of them.
>>
>> Tidy reginfo_dump() output.  Especially, do not dump the non-
>> relevant fields.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I guess this means any traces that exist will need to be redone?

Well, that's true anyway because of the format change.

r~

