Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70235C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 07:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B0920708
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Khjbq2EF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B0920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJuEk-0006pa-RP
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 03:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJuDT-00067A-Ay
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 03:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJuDR-0001Pn-8w
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 03:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600588616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipTvR/BnUwqSV2bZqkU7boM1FnL1aMFHwITwd7O+KBc=;
 b=Khjbq2EFZKkGjSF8cNtHlbdQcAoVPcCLbA+Jc5GXQzmOcr5P9/wU4zlRglI17IM5fiCnnX
 nK4VZLmD66CTkKCoiirQrmoNih3EJqdId4Anxt9YhjrEjxweun6KfUUzHlFvil567rb+XY
 ca0NNRIpzAJ50Shs+INadpgQhbK+ruo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-8oXeuuEVNvqYA1CGHKtvoQ-1; Sun, 20 Sep 2020 03:56:52 -0400
X-MC-Unique: 8oXeuuEVNvqYA1CGHKtvoQ-1
Received: by mail-wr1-f69.google.com with SMTP id y3so4330382wrl.21
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 00:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ipTvR/BnUwqSV2bZqkU7boM1FnL1aMFHwITwd7O+KBc=;
 b=PQQhOcLh8d4ZnifqXaUM4R1my24iMYXFv2ESOo+mNrjRlyTu2zR54UAwjaomeCUBjj
 MGkZeQk+uQWjfRjTFNM7MZruOsmlgJ5AR84AUL8szOPrSKeZNTf27dQzF0Hi5XVrHi0N
 TmlxrkhQhD9MLuqsOATJEsM84dUgNXvZRYR4No2oT6ucHehK/w3KOrqIMwLlC6mECyhN
 U5ebBYaQTQebEUW1lse+Vw+Q98A80XDFyvVDW6BY3XFV4lIjGI/GOs5QbANHyoJLwCoe
 y7gHtoUA4RDRfGbLI8iD/UHfAI1f7wdOrpLj5w+6O8TQpxTjEulPwPq4cjE4P0qdMLaM
 HDWA==
X-Gm-Message-State: AOAM5314ceU6GBDd4Ri+Dsa0gZkogMESZOy2j64kdanbQHcv5RhcZblF
 8+uP066CViBFojSSf5tvbdhoSI9K2m+3rgoGXnOoSEcaSEmSinmSlKktUZvoW0TX/Ri1q7hZ+rm
 xW2UQDPV6v3+8QVw=
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr23818513wme.136.1600588611524; 
 Sun, 20 Sep 2020 00:56:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLCGPF3lAHIwyS5eQFe1utFZ172ZdfekyGd+7M0RRL7bO9ImUfj8yUxsvF1uzdPtJ+RHuX/A==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr23818488wme.136.1600588611333; 
 Sun, 20 Sep 2020 00:56:51 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id f14sm15456840wrt.53.2020.09.20.00.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 00:56:50 -0700 (PDT)
Subject: Re: [RFC 0/4] Add a 'in_mmio' device flag to avoid the DMA to MMIO
To: Li Qiang <liq3ea@163.com>, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, kraxel@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
References: <20200908164157.47108-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ea35f00-3388-22b3-6961-169d2b8a55b7@redhat.com>
Date: Sun, 20 Sep 2020 09:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908164157.47108-1-liq3ea@163.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 02:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 18:41, Li Qiang wrote:
> Currently the qemu device fuzzer find some DMA to MMIO issue. If the
> device handling MMIO currently trigger a DMA which the address is MMIO,
> this will reenter the device MMIO handler. As some of the device doesn't
> consider this it will sometimes crash the qemu.
> 
> This patch tries to solve this by adding a per-device flag 'in_mmio'.
> When the memory core dispatch MMIO it will check/set this flag and when
> it leaves it will clean this flag.
> 
> 
> Li Qiang (4):
>   memory: add memory_region_init_io_with_dev interface
>   memory: avoid reenter the device's MMIO handler while processing MMIO
>   e1000e: use the new memory_region_init_io_with_dev interface
>   hcd-xhci: use the new memory_region_init_io_with_dev interface
> 
>  hw/net/e1000e.c        |  8 ++++----
>  hw/usb/hcd-xhci.c      | 25 ++++++++++++++---------
>  include/exec/memory.h  |  9 +++++++++
>  include/hw/qdev-core.h |  1 +
>  softmmu/memory.c       | 46 +++++++++++++++++++++++++++++++++++++++---
>  5 files changed, 72 insertions(+), 17 deletions(-)
> 

I don't think this is a good solution.  These are device bugs and they
need to be fixed.

Paolo


