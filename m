Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79B1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003182072D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXJ4H/Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003182072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFeX-0000qH-Od
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFcJ-0007xp-83; Tue, 13 Oct 2020 04:25:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFcH-0003Vk-QL; Tue, 13 Oct 2020 04:25:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id x7so14290965wrl.3;
 Tue, 13 Oct 2020 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+/akLS4HgcKb/+GVxTP1sipY/A+eHMQumuOweWL/vL4=;
 b=EXJ4H/IsjlpQ9qvkhB9h9Mbm8KYl27sTFcEXdnR7BdkBNeLMS6i4X9t2XL1ZHwv9xj
 sG6AwhKjR39S1pIhi6UuVbC9F3EFOZWnNwxS96NvIBhI8KB0CANcPwfo2Rsjo7x4c/Kp
 pU3rhyQUQfdRQkGSMgeyfxZ0+hBSuj2kgWcIGSSlJXvI4mZAUt3OAAg6sIjZ1GjdLqQX
 Imf6P+0MHa8R6OFSspnUA+AV1We5zxtPrqhfck+APx186Yr21HXNVnZj0tJUNwqK9Nv3
 /Q6ENTrg5JTCwg/Lc1WgoIgLxSZVmZPXHA3wO3TKowjgG7/p/Uv+OODH/QYo9bwWvy6/
 /ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+/akLS4HgcKb/+GVxTP1sipY/A+eHMQumuOweWL/vL4=;
 b=L/J5qNLpWM7DauH2gbw1Ong3BjywnqbGV7bv1Xah2DcvQn9d1pNk1vS0RQxZY57hC4
 pAoLgojJwg+dyTyKMhputsSPSbGqmiFFNMVTvQ9pqaL7RJQOG49I+3cbdHkOohyKWDND
 nAc9vpaSkrUMTKhbjjI4Q2hfUdFfXl/EgCEGt2DwU1+/NHfojffxpSJ+N5cuGYCve0E7
 nHkBS11OLC/hBgXrZiBlKJNRxwB5rLyDqSEWMkunGlokgorlTfSdO6XCLXGS+wamtjfL
 7V3hZ/bgla1CK4LB1aSFK43R2cXpwsqPqPHVXmz+rGhbrlOTvqt+6QhrUxSW6brDHt6S
 ZNqw==
X-Gm-Message-State: AOAM532K/VhZKyab0EBYxXLzR4jgvS1gk/vWU/vwZau0zGwveGlVp62u
 8OndvOxSDXNMYfZexJ6wjfQKZDCZsLQ=
X-Google-Smtp-Source: ABdhPJxcCDkt0dnrUHMMIYv6iO3jLjLrj66R7jBwLONO18Ttdzjgpbkesb9rpUoVaxlAUkl6yuoJ4w==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr15848574wrg.403.1602577503801; 
 Tue, 13 Oct 2020 01:25:03 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i126sm27840244wmi.0.2020.10.13.01.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:25:03 -0700 (PDT)
Subject: Re: [PATCH] hw/intc: Move sifive_plic.h to the include directory
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1602577156-66090-1-git-send-email-bin.meng@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b9e1770f-531a-7c6f-0fcd-f8d2da4deb94@amsat.org>
Date: Tue, 13 Oct 2020 10:25:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602577156-66090-1-git-send-email-bin.meng@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 10:19 AM, Bin Meng wrote:
> sifive_plic.h should be put in the include directory.

Maybe:

"Since sifive_plic.h is used by hw/intc/sifive_plic.c,
  it has to be in the public include directory. Move it."

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Fixes: 84fcf3c15111 ("hw/riscv: Move sifive_plic model to hw/intc")
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>   {hw => include/hw}/intc/sifive_plic.h | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename {hw => include/hw}/intc/sifive_plic.h (100%)
> 
> diff --git a/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
> similarity index 100%
> rename from hw/intc/sifive_plic.h
> rename to include/hw/intc/sifive_plic.h
> 


