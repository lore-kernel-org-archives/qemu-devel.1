Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87956C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E08721019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTbZOmp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E08721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Bc6-0005RY-Dt
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BUt-0006NC-Rl
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BUs-0002HO-UH
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:29:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1BUs-0002Gl-Mu
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:29:02 -0400
Received: by mail-pl1-x643.google.com with SMTP id y1so5744386plp.9
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xmxj/V96xc4Nk2eeI7CcokgCy1z4OBxlwAVs8OWgshQ=;
 b=iTbZOmp5q3hp00bh+z75bq+SEETahXaGkGhVridmojse5RbY1/VpN0reJYC3iNNRLM
 PY17xwm15THNbrsTnd0EWU9LeLVSaHpvTKYuf6xS2gHMguaJWZobdlfNR+RQKsvEIieB
 /1qoN8UUo8cAiuYnycQuORXbhpd6M5H/beEGFQ2ZndZ7f8QVVU7KHWspwZgCT/Ign5fk
 /Q6OLMPynyYd7npQKvuTD1sx9SnwlARYnNHU44SPk5JS8ago3S2OEFxNLu2/B09nGL/h
 QWhRmF5/INKKM+L58aGakJAb+hiSyuFTmJlv3AMF4Ms7iHVfOjPCj4Mc0GAzzajPVT9I
 54fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xmxj/V96xc4Nk2eeI7CcokgCy1z4OBxlwAVs8OWgshQ=;
 b=Q3v5EG5qD+wC5FN+E7SAdaHGYkPIzUDtTCbYdqtTW3xU81tdIXSfEFCsRyBonPgj78
 Jhqo8+3ps64fzm8uwKbowR2f2Ud2mZB+0ffrxTHc5OV7JDx0AjrDRq9eyOzV9dyxrbM7
 J9SbUnMsjXm6L+xcXj3JjHZhDu8DjGdxgYAblLiugKSci+DJzsCI1lbAI+0O+GxvNODp
 iuktnBnjex8TfzgWrM8pACFt/6ZHqyeqSYCDEOmhA8EnivgwulDOpfPNtcjZ058CLfmI
 fhR+fsmdh0I1xuRoRUXMuMWk5zH/DEi7t98zxJIG1QZt6n5GSI1j/QR7kN9Gx21WkWkt
 K4Dw==
X-Gm-Message-State: APjAAAVDyoEAnu+blXzn0Nzjg58KFLrJsOZaLXFbz3tVXu0fVDNdXdxU
 f8Y/Voc2QIqdXFRUXeZtUUPk2w==
X-Google-Smtp-Source: APXvYqzaJdWi8COqV5OqxVslqcRB4+bJTSEciUeYD5Kyk16C/be13orMdgWQcWYaxIJceqlriXBzpA==
X-Received: by 2002:a17:902:3003:: with SMTP id
 u3mr5370034plb.161.1566574141594; 
 Fri, 23 Aug 2019 08:29:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b126sm6408507pfa.177.2019.08.23.08.29.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 08:29:00 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ae881524-d745-c8e1-5765-157962d2b157@linaro.org>
Date: Fri, 23 Aug 2019 08:28:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v1 4/9] tcg: Enforce single page access in
 probe_write() for !CONFIG_USER_ONLY
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> While the CONFIG_USER_ONLY variant can handle multiple pages (no MMU), the
> !CONFIG_USER_ONLY variant can't and won't. We'll want to convert
> probe_write() to return a host address (similar to tlb_vaddr_to_host())
> soon. This only works on page granularity.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/tcg/cputlb.c | 2 ++
>  1 file changed, 2 insertions(+)

As I just mentioned in the previous, I think the two implementations should match.

Anyway, the "multiple pages" thing above still means exactly two, since if
there were three pages involved we were only probing two of them, and the third
could still be unmapped.


r~

