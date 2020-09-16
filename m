Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94923C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415BD223EA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIVc3GQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415BD223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIakO-000740-5u
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIaiq-0005C8-Hl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIaio-0005Nj-NS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sYm1l5EYSHhjLYsHCWeMbwuD9LSZQ5+tMb8TWqnxYY=;
 b=iIVc3GQJQHNvPcrqIZKFUBSXvB11tr18lsBg2SVx+TCNw+qbrgUzrjCI32nAgHBO3kap+7
 XyHFvLgdwElX/ChCtmnpVp7OwfDK3R4qHTR5lbpHwa0VGwHvoynk6UCN/9XsGt1xi3mn+O
 coR3uU9Uy9i/b2fZRx5flmZEqZhxHS8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-gNNWjlWfMDy4D3XIjTWlzA-1; Wed, 16 Sep 2020 12:55:51 -0400
X-MC-Unique: gNNWjlWfMDy4D3XIjTWlzA-1
Received: by mail-wr1-f70.google.com with SMTP id y3so2777853wrl.21
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3sYm1l5EYSHhjLYsHCWeMbwuD9LSZQ5+tMb8TWqnxYY=;
 b=XXyQq82BhyH6UJrx+wsfF/hPT05q9pwBg/N9VHDzWPElI7BIPtALqREhiwXaGPcQok
 hn6R1qJLXSTXkoZwYMAwiRXXJ2nKV0Qnn/ss5eGFOlvv77FF2RHOg0a9GdIRde2mwl/S
 de68j+8vhhzvv/XyvMI7KRLL9eL+VMvkLvDbK9LwUbCpJV7orol5S/Lq1eF7BWCEUczd
 GRxkrJ0j0iJ9QhmLnzRzUisLj/AIeu/hedh+jGvxndimL04NEsPRfxqdb9TmGyPNxE9X
 OWq5Nlupw8d3I/bTpDYXaeCXnQOI6+oTyTMD4Zxo+wMtgI72V7LahQtD7bH0TBtY2i+I
 xKUQ==
X-Gm-Message-State: AOAM531ho3l2eyQxYmrnP40CfFnooi5vV/O96/2KbTgsFRUpIj+HVLcz
 QdRvlfNAK9qq0tVmbSSNcI2erAJnSkVnfcCHSLYtAURWOYyFN1O9TVIWWztxCpX/yykVwboSoNa
 DQT/HE96uiOVL7JI=
X-Received: by 2002:a1c:678a:: with SMTP id b132mr6025778wmc.10.1600275350223; 
 Wed, 16 Sep 2020 09:55:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx87Hr/v2p/Un8UOkycLUHO0a8boSP7Qjrz9rywcUGZfeW+IRU6rmRdRvv4Fk5+PaakyKEIyg==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr6025753wmc.10.1600275349971; 
 Wed, 16 Sep 2020 09:55:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cf8e:a9a0:1aed:9a37?
 ([2001:b07:6468:f312:cf8e:a9a0:1aed:9a37])
 by smtp.gmail.com with ESMTPSA id n66sm6539991wmb.35.2020.09.16.09.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 09:55:49 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] hw/i386/q35: Remove unreachable Xen code on Q35
 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200722082517.18708-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a921f1b-b559-6c0c-641b-4451ae3ec479@redhat.com>
Date: Wed, 16 Sep 2020 18:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200722082517.18708-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/20 10:25, Philippe Mathieu-Daudé wrote:
> Xen accelerator requires specific changes to a machine to be able
> to use it. See for example the 'Xen PC' machine configure its PCI
> bus calling pc_xen_hvm_init_pci(). There is no 'Xen Q35' machine
> declared. This code was probably added while introducing the Q35
> machine, based on the existing PC machine (see commit df2d8b3ed4
> "Introduce q35 pc based chipset emulator"). Remove the unreachable
> code to simplify this file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/i386/pc_q35.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index a3e607a544..12f5934241 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -34,9 +34,7 @@
>  #include "sysemu/arch_init.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/rtc/mc146818rtc.h"
> -#include "hw/xen/xen.h"
>  #include "sysemu/kvm.h"
> -#include "sysemu/xen.h"
>  #include "hw/kvm/clock.h"
>  #include "hw/pci-host/q35.h"
>  #include "hw/qdev-properties.h"
> @@ -179,10 +177,6 @@ static void pc_q35_init(MachineState *machine)
>          x86ms->below_4g_mem_size = machine->ram_size;
>      }
>  
> -    if (xen_enabled()) {
> -        xen_hvm_init(pcms, &ram_memory);
> -    }
> -
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
>  
>      kvmclock_create();
> @@ -208,10 +202,7 @@ static void pc_q35_init(MachineState *machine)
>      }
>  
>      /* allocate ram and load rom/bios */
> -    if (!xen_enabled()) {
> -        pc_memory_init(pcms, get_system_memory(),
> -                       rom_memory, &ram_memory);
> -    }
> +    pc_memory_init(pcms, get_system_memory(), rom_memory, &ram_memory);
>  
>      /* create pci host bus */
>      q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
> @@ -271,7 +262,7 @@ static void pc_q35_init(MachineState *machine)
>  
>      assert(pcms->vmport != ON_OFF_AUTO__MAX);
>      if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> -        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> +        pcms->vmport = ON_OFF_AUTO_ON;
>      }
>  
>      /* init basic PC hardware */
> 

Queued, thanks.

Paolo


