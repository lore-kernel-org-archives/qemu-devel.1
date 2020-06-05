Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E76DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1DB2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS4oElmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1DB2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGVS-0007Q7-8H
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGUL-00067V-2B
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:50:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGUK-0006k7-0o
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:50:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id x207so5315046pfc.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8qSmgDz3wcVqNMWxsKKNfMlSiZrh6LfOJQfbQnyXY28=;
 b=hS4oElmdnMViQbOp4/gqKuKAx6DW3fub1uLnRZJFEWiJGewh+mDk4hHF/36ZRb6xy+
 pfKCfxn1FFdLeq1Z2n2vTLvcU/k89mbRsBuIDPIn/E6SKNCyNxftUbWoO9K86bkwR1Qz
 jFBB4E1GLDJImnMA5aZHEovCCXqoMjJ/LeQjPAgc6ES2vB03ARhBwFBt1pU3sLFCQpdx
 V16o++7fKvoqUwWQuSMb+gAyocQiaPbAe2iekHXtS/lzm89vGCh+oqedgUNfzsp/HozQ
 KB0sx00g+Sl9q6FzXxd7FtnVAUeXfTGale4ThLjq76KCQof70HWY3bgOsLJDNxqn4NcQ
 WK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8qSmgDz3wcVqNMWxsKKNfMlSiZrh6LfOJQfbQnyXY28=;
 b=hsVOZRtTP4u2/2joUcy7DXGzOyHSLmnMSzz37Xb3PBZ3FivjnYzVVZ5JkYI/PbKsM/
 jgcPYWOil8Oo1urC55VSjqER2uunjT6ZMrNI8Gx09tWViziZaK++DovOHw/RQLfM33iX
 LZyATr9ahvkVUv8dUjIrneMsqyH+DPRIjjQ8gQ3AW+WGoyq/oPTDmmeHeq9TQbL5PH1Q
 +TqWhjKN3QbIHuoRtFcYTbVXTr28Cc2Id1LXFatxVOLo990rWcIH1zegfkPO/LvOznMd
 vZRSdq3VG5ad/oTIvRH/4WrXVkpPytzAY1o8HiuHx6rRaRtOTGl9o0oZiuBIDGlYCw10
 7h8A==
X-Gm-Message-State: AOAM532Tmg2CA73PZ+ex3luhw7IqTa4sX42mUmGUon1y1HKdjakrOEgi
 BeNEwKs7QB+q+RY7E9Vb+sYCeg==
X-Google-Smtp-Source: ABdhPJwB3PIH+OT9Uz40cOWWeOW5/3MJqq/7rH6sTaKasWfeyTX16HUn2c6Mu199VDycVk9UexwZvQ==
X-Received: by 2002:a63:7b51:: with SMTP id k17mr10580882pgn.422.1591379438569; 
 Fri, 05 Jun 2020 10:50:38 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y186sm211551pfy.66.2020.06.05.10.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 10:50:37 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] target/riscv: Report errors validating 2nd-stage
 PTEs
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1591319882.git.alistair@alistair23.me>
 <e8f3f03935697c721a5bb3e720d57e78e53ffe19.1591319882.git.alistair@alistair23.me>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <395d2d95-c0cd-d74b-d5d4-34c693b0acb7@linaro.org>
Date: Fri, 5 Jun 2020 10:50:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e8f3f03935697c721a5bb3e720d57e78e53ffe19.1591319882.git.alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, anup.pate@wdc.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 6:20 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


