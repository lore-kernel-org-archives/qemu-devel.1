Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6815DC4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3746C2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XodH/6Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3746C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8THa-0006OJ-D2
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8TGr-0005kF-44
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8TGp-0001Go-Ug
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:52:40 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8TGp-0001GK-LG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:52:39 -0400
Received: by mail-qt1-x844.google.com with SMTP id v11so30555882qto.13
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4DscHssQlyyvcD/YsiJ9lfjnYwlz2SOBt2IH9CNtKls=;
 b=XodH/6LzOXs6mxD9cSVvgeLEYxkHw/Um3td0+XW4ytEmmATGatrWLK51ZbKhAbnkmW
 IQU2AKryjTjfdSfz0XsKFg6qH62OIEzBx44HAXh/Pfxdzu9R27I8g8Sjm+shWdDV4SIc
 Ybk4mLEpgdbSkk8kb+YwbvPdNHMYzsSmjScg83lgjFe2y1p0ie8YI25f8xFj4sPG3mGJ
 YW/Z7laDy+LpCb1QZEndLoHS8sakGzsXLaqkIcF+TccQy/TAHxTxwozc/Gb+N9tBtWqm
 qmZ2WzWjh/5w0NdVryWN6tDdIZmbZqOQL9xRBmgQLXwz3+FoUO9oLEaXrQscy5jRdaSe
 fQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4DscHssQlyyvcD/YsiJ9lfjnYwlz2SOBt2IH9CNtKls=;
 b=jmzOVs5Kq/hdkybZhzGFNMoE3gTC8DVd3cVM+nOwdjlb3HOQmnyErJNuvDxNWJNsey
 YrUwmbwdJITSxa7hw+8s9sVBOr/zjR73f9FFXOlCtcZ4VBG78s0qbM4OM3mQSs6Gxerb
 f3YyLqYcqXu+OHHQ8jks6e3x+pAEnlE0YvOgpCWB3XbPHJ+UCYwsqWmNtpPcgFHXkMK/
 jKXCScDLYYliyjBchauw627jlSIbrVFIS9KkBdYSIqZDorxxsHCPzKIZoo5bcNsSORDj
 HF2opufGYMR3cV8vddHKucpqSFHRhMXElNlxBeRtslbgY9N8uPRJ0iwFnkb1RXs7A+oc
 1nXg==
X-Gm-Message-State: APjAAAVANcSyMvIpbip+NqVYHa2XLF5mMClLyBNQK8bnArSse2IeBnTx
 qpCPe2iv1kC+0y2iT0262SFDUA==
X-Google-Smtp-Source: APXvYqzaB+WepuehCgpco+DdEGR8od5qML7L8X6rmTHilBOGtySDqFUcEpXqNJHBXHXACL8ZBCFaag==
X-Received: by 2002:ac8:748c:: with SMTP id v12mr42694057qtq.23.1568310758187; 
 Thu, 12 Sep 2019 10:52:38 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id 20sm12375128qkn.4.2019.09.12.10.52.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 10:52:37 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190912141820.30702-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1a1b3b4a-05c8-72a0-d7f8-310813863f58@linaro.org>
Date: Thu, 12 Sep 2019 13:52:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912141820.30702-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH] memory: inline and optimize devend_memop
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
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 10:18 AM, Paolo Bonzini wrote:
> devend_memop can rely on the fact that the result is always either
> 0 or MO_BSWAP, corresponding respectively to host endianness and
> the opposite.  Native (target) endianness in turn can be either
> the host endianness, in which case MO_BSWAP is only returned for
> host-opposite endianness, or the opposite, in which case 0 is only
> returned for host endianness.
> 
> With this in mind, devend_memop can be compiled as a setcond+shift
> for every target.  Do this and, while at it, move it to
> include/exec/memory.h since !NEED_CPU_H files do not (and should not)
> need it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/exec/memory.h | 19 ++++++++++++++++++-
>  memory.c              | 18 ------------------
>  2 files changed, 18 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

