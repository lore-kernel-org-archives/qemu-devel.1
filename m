Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBFBC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 04:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326A124676
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 04:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoYzD6Bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326A124676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBWHL-0004wx-3Q
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 00:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBWGU-0004JW-Fq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 00:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBWGT-0005PJ-8H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 00:13:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBWGT-0005Mb-0J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 00:13:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id p14so5860300pfn.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=13LZGGSje/BizSMjRtHM4ssIOqPqkxSLbX+zU/X8Cro=;
 b=XoYzD6BxkXnjKdvnhpdcWXjgzVskuk6yo4ti98ERidB+joYNCre6B4JCgYS+CsES8y
 g09YJqLmGeVi9cIEo/uMe5Go4ycuCngNLLjIv8PPY4AqA4bTuJY2pUZp02f2QanBBncA
 1sSGe/8+WZkjij92pU1Kx4UgUB5Eqj8p3ltDNixLK7S+T/f7RRPSXdaysfpBQho8u+Vx
 OzREAQPBNsRutAkfSa0sYFb4TRQ7LlSH3lu/1byS/OQ4yYC41wwdkOSYL75lrcgbc+Ly
 uGEy+T6s45YqrO6cDIVLZlHbbtuG+8RsGGc/auo/Cgv6srHpc1zVl97kOEeE7cxV8/2w
 cfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=13LZGGSje/BizSMjRtHM4ssIOqPqkxSLbX+zU/X8Cro=;
 b=o5VrRpiB7Y796k7vzlm5UbWhTnUusR8dPJ7dy6YNCr0OvRtYI11/I5v/69IWkrpqtl
 /Ol7pemUWLPKiCljAZkUleM590CilmIiXeEI/pw1D7OYJ2tJTRkj8xCEGC9UuzCLlesB
 4f+XikSVfBkH1pRb514RYmMIp6DiGZ8PaPBtpea6HDsSFEDr5stQS8+lKG89uUUQRUDI
 z1+PT3yOI/ZsVqScGN+EhsBwvq13F7yb9d9KW9FHb6Ivznx+HMwCXenSO5sb7fSn1clw
 +11kc3t/24PS9TzT3Zr6BCTz5Jxlf/ZEXlA4YFbyspNZYGduHgXzYXQdguloNVeuL/wg
 DZFg==
X-Gm-Message-State: ANhLgQ2ndmbNNN70GXTQX7J5BlvpuQr9PhTTxAbR61qNr33SGmb9fjx9
 0HgYDSQ1SgY4WpmHzF9LrMt8tQ==
X-Google-Smtp-Source: ADFU+vvRIVHmNx3FVuJ+pP0VMipoRMQG5+6YIIyIYuaGUQgIywlltOjGSJC7IvKYbB7HIvoKDUhUHQ==
X-Received: by 2002:a05:6a00:42:: with SMTP id
 i2mr6720553pfk.108.1583813587580; 
 Mon, 09 Mar 2020 21:13:07 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id a9sm972915pjh.6.2020.03.09.21.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 21:13:06 -0700 (PDT)
Subject: Re: [PATCH] target/ppc: Fix rlwinm on ppc64
To: Vitaly Chikunov <vt@altlinux.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200309204557.14836-1-vt@altlinux.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbf91244-ad5d-0d3b-7c0b-e11a6e0192a2@linaro.org>
Date: Mon, 9 Mar 2020 21:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309204557.14836-1-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 1:45 PM, Vitaly Chikunov wrote:
> rlwinm cannot just AND with Mask if shift value is zero on ppc64 when
> Mask Begin is greater than Mask End and high bits are set to 1.
> 
> Note that PowerISA 3.0B says that for `rlwinm' ROTL32 is used, and
> ROTL32 is defined (in 3.3.14) so that rotated value should have two
> copies of lower word of the source value.
> 
> This seems to be another incarnation of the fix from 820724d170
> ("target-ppc: Fix rlwimi, rlwinm, rlwnm again"), except I leave
> optimization when Mask value is less than 32 bits.
> 
> Fixes: 7b4d326f47 ("target-ppc: Use the new deposit and extract ops")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

