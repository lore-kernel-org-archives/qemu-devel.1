Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB7C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9F02240C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJbb4wzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9F02240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeD7-0006D8-CJ
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUe71-0008FZ-43
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:58:43 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUe6y-0005gI-RG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:58:42 -0400
Received: by mail-pf1-x444.google.com with SMTP id b26so883635pff.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7xKf2cUnKA/wiF9gMLnFvixn7Px2PC3pQBbqIKE814Y=;
 b=EJbb4wzZMIAwQtYg9wj0DlNS9c8rmZ6CWVTaOLJUiiONKqR6EcK0SKtlJN4r/OWGEg
 H53+aaf0M3ikT3SJzH8muDmWgd3BuA8Bk9kgO7BVUmvBGS1BMZKgl7LowAIsHm2lThnX
 3vus36rMOKXopuD3kLDJrAJFuOzB67Bw87GH8wWl5OUin9QoV0dnRTdxIdCXmewC/nn9
 a+eicJwFUdm4vKV0HhUB/SP0+EpEfOJ5f8NlwA6TnJyiygfgQ9NFNJgnOdWUeSDcvKcV
 tY3r1Is9NGno/LxKhXEcRVFZ1wqhucbG5XVOp+sc5OrZuhWavZL02XbpTVLLDFsVi65g
 XqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7xKf2cUnKA/wiF9gMLnFvixn7Px2PC3pQBbqIKE814Y=;
 b=uT2/XQ+kD5QfKE+i2LIfhXzWDSPMPkoM/bsXGRXNluQRAIiGn5n4tbFF+MZCChGO1h
 gFXybzZ0mUN3/Cj3NCvZiR32Cw3EIDwf3wkP2O0wFj97MuG9phc9mfZFTbN9nDAZ/FlN
 /W9QGL/9PNNdTri6D3WfJtBYMg9HImbRrrlXgiilxZyKpwSQuFwXuqgj4/Cxqkv2hSqw
 iKU5zsE2/Gi5m/TyxOP755EV25kXN79n3zWBfpnM9N+CnhGzYiCFmlbP++o9zaY7ikK1
 himcHgVaG+e5N/rFvKtKnxXNDQUTxKoWh+8HJbLbvlOCvSImMu9mgSgvdqCA82Oz8ooZ
 p2cA==
X-Gm-Message-State: AOAM53340NLUezajKccoFpgh/LKxnS43a83e2Qvd4h2p02Pz08Cpekas
 diEBX/wM1goedw+tc6C5EhXpFQ==
X-Google-Smtp-Source: ABdhPJyEQVVxb21S1DrsGhuru3HNJArm/uf/yqwCa7Gg9qW5YJpgMegqozFAqmtEA/2ytWheYFz7lg==
X-Received: by 2002:a65:688a:: with SMTP id e10mr89033pgt.347.1603148319093;
 Mon, 19 Oct 2020 15:58:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm34750pfj.114.2020.10.19.15.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 15:58:38 -0700 (PDT)
Subject: Re: [RFC] Don't lookup full CPU state in the indirect branch fast
 path on AArch64 when running in user mode.
To: Owen Anderson <oanderso@google.com>
References: <CAKs3XfJPrMGxdAouGCje3ppnWKA6fXpNaywQ5rj9u45VkPuUXg@mail.gmail.com>
 <7c416109-6431-076e-2284-0f8406931ab9@linaro.org>
 <CAKs3XfKMpTaAO6vj-V--zp_zY_Jm9HKkgkpCbCCKCQHSDT8y3g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <942d4ac4-e624-11f6-f3c8-28d64ab568d5@linaro.org>
Date: Mon, 19 Oct 2020 15:58:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKs3XfKMpTaAO6vj-V--zp_zY_Jm9HKkgkpCbCCKCQHSDT8y3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 3:44 PM, Owen Anderson wrote:
> My use case is currently using QEMU 4.0, but we will be moving to QEMU
> 4.2 soon.  I do not have --enable-tcg-debug enabled.
> e979972a6a1 does look promising, and like it might deliver increased
> performance for our use case. It looks like the code in 4.0 is doing a
> lot more work gathering the flags values from a variety of places.

Yes, before 4.2, we did a *lot* more work gathering flags, and the overhead you
see roughly corresponds with what I saw.


r~

