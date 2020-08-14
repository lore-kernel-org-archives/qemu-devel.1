Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61B1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F16D20771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIfWT/fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F16D20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e0g-0004WD-Jp
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6dzY-0003ut-Ub
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:59:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6dzX-0003RC-F0
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:59:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id t14so8624652wmi.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ji1ko9vpk19uFPhsEdQhHCJvX7AH6GDLdEydPoJFjsI=;
 b=eIfWT/fSu5TVWQP2RFRKJhOVl4Gjkr9ekXunr2bvOFz5YkHrXHuGySr5+pzTxEslc5
 V9QSDU4Lg0w0VB8Xhwf3mH4/Q3qnq93ovowx5Im7KH+2LeDXTvrehHfdIx05XFbg1CxU
 8nc/FrrCHKdURqEKltwBirQ141XrolUrqrzBV6tDuKA7OFrV+JJXBuMjP85NQuTUBk4D
 KSMKqkxJ+sKx09QqwNikFA8iCFBPaSS9SnGPjw1AhZSATliQGZbRcMrw++H2YbxlK0Ou
 EERTAghXvIReG3ANKba7dQtnN7/uRVNTN/YvtN0aV/0xsUu0at4drEpJwnms7MnJQoOu
 WGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ji1ko9vpk19uFPhsEdQhHCJvX7AH6GDLdEydPoJFjsI=;
 b=byq955x3H2fe7fhtSw/0Kov7V/p0SFxzovrJkDD1VW9d+lHKT6J8OWyy4F+LRJZ6pG
 xuEShTmLEOPEL8U8Z8hS3Zz30QB43W97NY/1fFSsRvv9FFLKFcUQ7iSLPBDjTBM8t7Ir
 4l04BuE8h6q1oA7RzqP0yFNmhXAyaa3wIlrwnNIHCwyes2fQuMxTxATWUoKtqHUJPSMB
 3eBsF6R3XS7CJIbxf83Ng93bgFZSsrvdM5z8m4SuRKlDx+odiB9ZhqtUMagPW5/AOPLC
 ahIB67IeUw0QqHMJMc/n/LfKC9nnWezrh3llEScXS5hCGGMuofrGw7jEtYV9DJH5c3U7
 matw==
X-Gm-Message-State: AOAM531KQ6ilNgWTMRQFIUZNCN+oh9atmz4dO4taEdqldqHSDLQlbYIN
 xBTD4JVMMkmCfyHEjXBzicg=
X-Google-Smtp-Source: ABdhPJwRf2amAZ/I4dSmmynDNo0K2+jGq8zgwVLc8Y0CjwOd1Pf5QBvgYaUT700VxX8W1A2xA2Z1IQ==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr3582709wmb.25.1597427985951; 
 Fri, 14 Aug 2020 10:59:45 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y142sm17437558wmd.3.2020.08.14.10.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:59:45 -0700 (PDT)
Subject: Re: [PATCH 11/41] versatile: Fix typo in PCI_VPB_HOST definition
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-12-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4cef7686-6450-1485-9d26-499e1f9f3bab@amsat.org>
Date: Fri, 14 Aug 2020 19:59:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-12-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/pci-host/versatile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index 616882a80d..7e4aa467a2 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -161,7 +161,7 @@ static const VMStateDescription pci_vpb_vmstate = {
>  
>  #define TYPE_VERSATILE_PCI_HOST "versatile_pci_host"
>  #define PCI_VPB_HOST(obj) \
> -    OBJECT_CHECK(PCIDevice, (obj), TYPE_VERSATILE_PCIHOST)
> +    OBJECT_CHECK(PCIDevice, (obj), TYPE_VERSATILE_PCI_HOST)

Uh, since cd93dbf375 ("versatile_pci: Update to realize and instance
init functions") 7 years ago...

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>  typedef enum {
>      PCI_IMAP0 = 0x0,
> 


