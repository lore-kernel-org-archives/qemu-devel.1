Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE8FC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0807C2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okBQK4nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0807C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOmq-0001fT-7m
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hnOmc-00017y-5G
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hnOma-0007Ld-PQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:50:22 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hnOma-0007Jo-2m
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:50:20 -0400
Received: by mail-pl1-x644.google.com with SMTP id b3so10242044plr.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vRcmmmidZBO1sdzPHIFCAIh9wKUQjMlDgQeKKeUIXy8=;
 b=okBQK4nm2zcPSiaxpxrASKtyQJ/END1Yq26bg9KvFb/YDZkzsCrxjTD7kfq9jnWLQS
 AEqhA31Jp6r8fFptekuOXv9wRJsl4DAYTzbgZPtVOET3fVSN3kxvGaQImLztpxc3CrHe
 fo2zC4esP/7DWnFiy8C0a9d2Bxk5+AdXd+zTbw4GO51LS8HE/p8/txE7mRBsMWbTaOe1
 xOp4jE69L1EMw4QMRUxnRdW6Y/Rw01CBWVODYjSvzGw8bQxbygO+JkBi5K070lhq9eb8
 SsuGMBdrPV1V0U0AfHjb4uFejjhow9U2zqjobGsMyqAp1h45lrL/QdI/ZQWmkAj+/Cc2
 pD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vRcmmmidZBO1sdzPHIFCAIh9wKUQjMlDgQeKKeUIXy8=;
 b=L1eHI+ozpD6clI5/lWtJVFXNosjPpQ1MYx7XMcH//e/ufMryfwv+OO8XpawRVAHLdo
 yG7w/Py+RAOEu7rYN3gONY4causCFN/xl+t3VwMEnnwOgZKTdnEN3gBdGaewa8rhHAGt
 GRZ+LFuROJRpFtTeQo6X5mqkNcD+E6iOh9hANVQYosm08bcG58pN2WEvL21GRnQZ2p0r
 zSnAfPrD9JOB/uKmha43pU5CWjuEZRpSKkJEEjiaCWh69YhqfwDsBpT5F3UpJhuAXV2U
 bforlpbqUtTzRTWoXYcYptAjiwdVoyXVt+VwIys8g6cJMJYBzVt+A4j4AiM/VBRmqQCN
 g3SA==
X-Gm-Message-State: APjAAAX2jsP6bhb7QRBQ+h5zF7NefmgYS966YobXn7VlZCQYYeYfHkeS
 4+hx1TkDJig1SDfDjsRHA8V4mQ==
X-Google-Smtp-Source: APXvYqzha3i3u/8m5/pGw7dradxalM7V2ONS2WR7lBAE66fjkYIKeE1JomQpdXsHE8VR7gpiHgjJtQ==
X-Received: by 2002:a17:902:7088:: with SMTP id
 z8mr36656722plk.125.1563288617710; 
 Tue, 16 Jul 2019 07:50:17 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.gmail.com with ESMTPSA id f88sm21747331pjg.5.2019.07.16.07.50.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 07:50:17 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190716121352.302-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c3a0e0ba-285f-48e6-17d2-fc68f170645f@linaro.org>
Date: Tue, 16 Jul 2019 07:50:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716121352.302-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [RFC PATCH for 4.1?] target/ppc: move opcode
 decode tables to PowerPCCPU
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
Cc: 1836558@bugs.launchpad.net,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 12:13 PM, Alex Bennée wrote:
> The opcode decode tables aren't really part of the CPUPPCState but an
> internal implementation detail for the translator. This can cause
> problems with memcpy in cpu_copy as any table created during
> ppc_cpu_realize get written over causing a memory leak. To avoid this
> move the tables into PowerPCCPU which is better suited to hold
> internal implementation details.
> 
> Attempts to fix: https://bugs.launchpad.net/qemu/+bug/1836558
> Cc: 1836558@bugs.launchpad.net
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/ppc/cpu.h                |  8 ++++----
>  target/ppc/translate.c          |  3 ++-
>  target/ppc/translate_init.inc.c | 16 +++++++---------
>  3 files changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

