Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A37AC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336B8206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzeEDKvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336B8206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQx3d-0001Z3-5E
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 13:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQx2k-0000qw-JT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQx2V-00031s-Ot
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:50:46 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jQx2V-0002z3-9l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:50:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id o10so3871496pgb.6
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jjTBpe+N8kwhwYaR4vyHJeWZqdLLUK+lLBHqXqykPug=;
 b=OzeEDKvMw/QwqrGX4ioM+ECf+ELb6foDlF5JEEwlFL2evqeqhMuGx49wCcxEKpOb/n
 b+XTI7jdSb+kWmyRRAPm+X2DGccQKdIm123dq2xdpRM3kRP7NQ0qwXa7+tT7IoKifm0i
 WHoUFV0bmUxPqZ2+AKBNhT2jZeTFs+F/n25hNZxGsWcGNB5KF86nk66rF/nY+dwe7iOO
 M0xHwXBZYBTuPjptoYNXPSJQWc/flcPRjSeRx3QByBY+wijlNI4NoHAGdoT2C4LXRaYG
 IftkRtshpheMGlOhTw/06UeuWPIk3y5KhidvsY9eb3YAYZKKyph9YTanyfYNWJn97MQ/
 ABsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jjTBpe+N8kwhwYaR4vyHJeWZqdLLUK+lLBHqXqykPug=;
 b=VODEFWgLGWM5XLzjNnUdzmMzYUBywWJqmsX3+v21y2Uxa93huT3eqRPCXEvaiGC8HP
 f8qHEV9yJ3ZY9ZJy2qzylVi+UH9vi1cI61p8IILpsbokUihQTPNvmtMxaJibBrDwAU7j
 H1t3/ioOO2ZsCo6gkzFkO+T+tbhzEIvgNPOJDToJX4lI0EwwwiqWVT1whQ8nZQfGNKly
 mrDyoEB/hujJQtZ0QC2vLjCrPs2RgQ3gTbrQlt018KGB/aPVfzfdXNTLFPyS9kr0XrfU
 yJCx0IfyqlCd3iF5RDTxuwySlU80FR1bw9cd281hTsyL8MpbmaVv2xpJk5aaJ57AYMPM
 ku5g==
X-Gm-Message-State: AGi0PuZTEDFNsrMEWmP/uzB7USKE7/tfVqx05ajNVH2Ad7EMC5okA0a4
 uyikNEJ5UKO25w8pb8ZNLXBkZr766UA=
X-Google-Smtp-Source: APiQypJwA3Qe3Hq5HUBmR380hPBYarYmgleHuqR8SFeN9HlA1WizIhbZHw5wYk1MilTw8Mnci1lilg==
X-Received: by 2002:a63:5a5f:: with SMTP id k31mr22869876pgm.109.1587491428669; 
 Tue, 21 Apr 2020 10:50:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d17sm2830708pgk.5.2020.04.21.10.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 10:50:27 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/ppc: Use tcg_gen_gvec_dup_imm
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-4-richard.henderson@linaro.org>
 <87368yfntf.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81b5dff6-b7f3-a536-87a0-778ec26d20cb@linaro.org>
Date: Tue, 21 Apr 2020 10:50:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87368yfntf.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 david@gibson.dropbear.id.au, zhiwei_liu@c-sky.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 3:34 AM, Alex Bennée wrote:
>> +GEN_VXFORM_VSPLTI(vspltisb, MO_8, 6, 12);
>> +GEN_VXFORM_VSPLTI(vspltish, MO_16, 6, 13);
>> +GEN_VXFORM_VSPLTI(vspltisw, MO_32, 6, 14);
> 
> There are unused parameters opc2/opc3 parameters here.

Yes, but all of the other GEN_* macros retain them as well.
Without looking at the actual history, I'd say once upon a time they were
actually used, but we've now split opcode from implementation.

> With the removed extra unused macro params:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

I wouldn't do that without David's approval.  And possibly stripping out the
opcodes everywhere else.


r~

