Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02977224B2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tx5dgfce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02977224B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLFZ-0000qC-A9
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLDH-0007D8-2z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:43:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLDF-0001Ol-8t
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:43:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id d1so1792792plr.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LaymbafiOWcJLlHvWfftD4ZEH6QqzyKcrvc/ye3Z+KQ=;
 b=Tx5dgfcect/pT34P1zIypaUOEMx+XAjBcEfdKW2iqTasy7Wgz/0keJIWsf5mH5dIGl
 9MPVoL/h3Vu4bnEJ6BYNIMC5wy3ggeqzPfbFtjEM+VAAx+foeS7VCZ0aSeUorfPt7Ad1
 YpOX+01/FZpTL7pHWz3WWc7jGJbuuL1C1+BOj0zQQKnAqo800C2sd0dW+bYg4nIQpoew
 zmJw6SWIEFJd7M0xbjZJsGUjfJTAMT8MXBrgo2qk7kMPL76q0r7t8Gg9I6ioSSUW5PeM
 aS6YuIvHxPYrLg8BW0KWk7hgILaExY7TYoAps4IcBO3r2dvt/Y2QeZkXmxMGmJCcaGae
 Fmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LaymbafiOWcJLlHvWfftD4ZEH6QqzyKcrvc/ye3Z+KQ=;
 b=YxK7Dm1GGqc/48z6WGUDLCPuh2yEHEHVDLT+vlpi976wDqQ5hki8YngGgFAR/DxR0L
 +1672rROABucw56M6+3xDhyrmF2ubQqfuzWK9V3+ZjwHtAA3N8pmYyk4HmXQ9ErkiqDv
 3fTOjOXKNaHCI0ds8Zq9pBgjxWXK5gM6PfHElcGYXpHrkyl4/nu76vTwt14qpRREnJ1D
 R4Bc+R7S5N7qs7VCuy5A3SLm9XcpZLdYUw73z4NHCK2iiSkSk+AMA5O/S7JZkefFckzN
 WT8LjtQgfTjTPHWtERsy3X9YyJAxqL4o97EAl3CXoCp9L0l0+AnsbjrXUS4gJKdxLaPG
 PaUA==
X-Gm-Message-State: AOAM530+IQMQLYiKlxcMeJ3CADXW+1DBpvmfiofumQTjnSq9Zmu41oRI
 jCjGcYJtXqmFEtovumVe9rCazA==
X-Google-Smtp-Source: ABdhPJzCmYAyZfC3PmAvaZKgQo0Ul8eOncNAv7YoufI9VIkUNbk3fBepFWVJfqp5CfQQ7TV3F2E3ow==
X-Received: by 2002:a17:902:bc44:: with SMTP id
 t4mr3989063plz.290.1594734191995; 
 Tue, 14 Jul 2020 06:43:11 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id nk22sm2760067pjb.51.2020.07.14.06.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:43:11 -0700 (PDT)
Subject: Re: [PATCH] virtfs-proxy-helper: Remove the superfluous break
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600429-23052-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa1bcca2-5413-c847-01a2-27d5b8965149@linaro.org>
Date: Tue, 14 Jul 2020 06:43:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600429-23052-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:33 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove the superfluous break, as there is a "return" before it.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  fsdev/virtfs-proxy-helper.c | 1 -
>  1 file changed, 1 deletion(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

