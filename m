Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F14C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 18:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3746C21741
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=phystech-edu.20150623.gappssmtp.com header.i=@phystech-edu.20150623.gappssmtp.com header.b="qdILqmxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3746C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=phystech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9uUO-0007Zs-EL
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1k9uTV-00078X-Vg
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 14:12:13 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1k9uTS-0004UC-CM
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 14:12:12 -0400
Received: by mail-lj1-x244.google.com with SMTP id y2so7153422ljc.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phystech-edu.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=0m32BZE+ohl5d1Ao7wYbkSyAX1U7L+wteh33DHoAQAU=;
 b=qdILqmxf6FEiO2fstQaBC+TNIvDhJ3LgSgo881JcjnfQlbxe4J2WzNVtOw86WT8+gp
 hJvGKSXHWoaQ4xzF9G5GIFxb/ZB76JF6Dl9qEB2uUBx8qg53npv5kWrPz2kzxaM4zffl
 h4i+EuF9+T41+JYpQWDuJmsUk5t0EV38XouqXSCfUix2lfrpXu3/U/Va5vjmhAJcNe4L
 qHrac+tgZWXdwSIC4P/3yISxQIAWm7dc4gKN8UdGnx4F5R4K8as6FKnmE/60J2WIMdi0
 irIWf/RrNT+J3TrgbGn/XBO1RI3EHJt/3yh26PaOhBIiLH4Lw9dI58ZjAshD82vALZ5e
 bNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=0m32BZE+ohl5d1Ao7wYbkSyAX1U7L+wteh33DHoAQAU=;
 b=K7jWuyJd5hoyl3dkIF/Qax3SygJl63/fvZK7NLLUftSnc+2Z/sfruXEnqi5ZqSazRJ
 B1aJ9KcEavUtFba5WUQv9tSuIee7pP2znoTSIUTTjsatbzBe5VNC00DrH3Gu390dw6y8
 hTRiqpr8TmK8bnxy/Qvy+9e0j+LaEVnYAz8fOtkxAmoXjd395SPIXcwCuzvwr5D/mNqN
 sCDn2xHDLUxxVDCVLg5hVNLgjHpgu6s/jHgXpl2iLZlbFWb2mwoQkP1nc/BOTyYkGoBf
 q51Tp0JTNN4WpAzhuo/gG2ED9qD+zC8XdO8WpP4epscCybHm6MvW+G/G+Vg1/64GJn3r
 9bbA==
X-Gm-Message-State: AOAM533i8mc19IWEoFLmW9Bz4pyWbT+EibwS/LXrgva7EpwQ8XzyjbUy
 JzLC/nCscBF5gj4gDf5J32GEZg==
X-Google-Smtp-Source: ABdhPJysU/nxgl79O/TI34FdCT05Kij7EP4637xh9t99vq9Kj+sYYeC8vHSuwSiCeODmsnKloFDBow==
X-Received: by 2002:a2e:a16e:: with SMTP id u14mr949647ljl.230.1598206327296; 
 Sun, 23 Aug 2020 11:12:07 -0700 (PDT)
Received: from localhost ([178.176.74.168])
 by smtp.gmail.com with ESMTPSA id c4sm1718349ljk.70.2020.08.23.11.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2020 11:12:07 -0700 (PDT)
Date: Sun, 23 Aug 2020 21:12:03 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 03/12] elf2dmp/qemu_elf: Plug memleak in QEMU_Elf_init
Message-ID: <20200823211203.71930bf7@phystech.edu>
In-Reply-To: <20200814160241.7915-4-pannengyuan@huawei.com>
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-4-pannengyuan@huawei.com>
Organization: MIPT
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=viktor.prutyanov@phystech.edu; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kuhn.chenqun@huawei.com, euler.robot@huawei.com, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Aug 2020 12:02:32 -0400
Pan Nengyuan <pannengyuan@huawei.com> wrote:

> Missing g_error_free in QEMU_Elf_init() error path. Fix that.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> ---
>  contrib/elf2dmp/qemu_elf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
> index 0db7816586..b601b6d7ba 100644
> --- a/contrib/elf2dmp/qemu_elf.c
> +++ b/contrib/elf2dmp/qemu_elf.c
> @@ -126,6 +126,7 @@ int QEMU_Elf_init(QEMU_Elf *qe, const char
> *filename) qe->gmf = g_mapped_file_new(filename, TRUE, &gerr);
>      if (gerr) {
>          eprintf("Failed to map ELF dump file \'%s\'\n", filename);
> +        g_error_free(gerr);
>          return 1;
>      }
>  

Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

-- 
Viktor Prutyanov

