Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1863FC34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB71215A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKarGdQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB71215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lxk-0004ub-1R
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lw6-00034w-0S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lw5-0005oy-59
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:20:05 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lw4-0005oT-W6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:20:05 -0500
Received: by mail-pf1-x441.google.com with SMTP id 4so9392949pfz.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hzTIdW+N/nWpYWYby+GawA5ZxYAm16eUN6mlnMyVQVY=;
 b=xKarGdQJkC0wkG5tnmHssj8yHkAHWLvv+SMDtd8eM/Q5mdGUlZHncpaB/jzgkSGEBX
 CT+PMQNIS3IXMiHonNNzEWuCxfvUWodjidoIxJwxtRNYBAaCvIvkvwt1j3i/CfK17FqW
 6p3jN6uQ2ssJ4uRTeYvC6MHvEbimrWGPeLItLyhUmgPmy6VxHVfas2AX9sMXcJ9Ez03C
 keXxNEeLN0Y0dAKCGLtoFCd6ENnXoRpZxVj7Zqf9PIbXUE6Wn+osidwsh+GIUS4BMXpY
 iuRNikg+wXUjvMSr8QNdMlqr2TR9FXBzTS8WAm1rTp6S3cVoRCNoJsjbkYP1cGU5+WHq
 H/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hzTIdW+N/nWpYWYby+GawA5ZxYAm16eUN6mlnMyVQVY=;
 b=tvj0OsT1e4TD7j3sNkMA9bzKv4a1nbbKdlv/s0MlXknxiyyy5yD0Jv/fFUoKZaptTO
 npiHf27CZZqmC+CC+y/xO5r42g2h3k9I6B0mwd1hzwJKLqTgh6ZZpvoI2HjncT+FB0Rl
 kxu1uRLBoCCymy8hPLmXi8ECCz10LjhBxDZGmr9MqAiwumkyhGB4eizX+TQdGp0a+vRp
 ubhBD880Q7YZsPeDNMHmSz2dzokjQPrBTyiRlUhjZOHhd30wDrlyZSGdEuJt2ai+XOXJ
 pePFyy/5vZP2deLjEGUd4cam3Q2rwUz5W0ySM7uFBS51HaPyM/HA+sdF8AABSWcyEsJX
 C12g==
X-Gm-Message-State: APjAAAVfZR8KMHdiupX70fVDWk1RQiDF2kSFfP6wSXAPYR69kyxBRvwo
 pBkw21kJPCPUSd24CfsN16E/9w==
X-Google-Smtp-Source: APXvYqwbQfuk4PiKMhhsAT/oa+LfG0RSpIo48RaJF+Z91BjKauYqqXhfHE0yXLg2KskF1PFq4hGZVw==
X-Received: by 2002:aa7:96b6:: with SMTP id g22mr17848876pfk.206.1581967203973; 
 Mon, 17 Feb 2020 11:20:03 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y64sm1619842pgb.25.2020.02.17.11.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:20:03 -0800 (PST)
Subject: Re: [PATCH v5 32/79] arm/vexpress: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-33-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7f13a9c9-4769-ac76-a9ac-ce0989da0731@linaro.org>
Date: Mon, 17 Feb 2020 11:20:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-33-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~




