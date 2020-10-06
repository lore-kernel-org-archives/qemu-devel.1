Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9355C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BFF2078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2bLdb3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BFF2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlOe-0007NP-Tr
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPlCL-0007XV-9b
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPlCJ-0007u6-2G
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtHDWeHzF5RmSRN7Zn51lQt7lObIFNSLYM1dZxlY6+o=;
 b=d2bLdb3FFpWztfvqF9ptJv55uXmlJXsAKpLmpKmAJ6cs9Jo6Oo3a0L7GBtwwtyy83m/RY6
 7KokPvooIUZhGBXTq4Fmqp3CmbqisQHs4kdJXdN41vF7tqguFbjBcPOMEGUaSWyKFwU23x
 Ey4xQhuUo93txDiJkMK48MxzFOBJF0c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-1ExA92fKNwmHaHSO8SNLYQ-1; Tue, 06 Oct 2020 07:31:56 -0400
X-MC-Unique: 1ExA92fKNwmHaHSO8SNLYQ-1
Received: by mail-wm1-f72.google.com with SMTP id 13so1013620wmf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZtHDWeHzF5RmSRN7Zn51lQt7lObIFNSLYM1dZxlY6+o=;
 b=CjW7Fx0yAmtr/hlHciQI9eY91T6+bTbpTdGSBG+HHH0KVn3OxVo0Cglj+bjlLhi0ok
 NMYyYi8q21QnaU9QV6BMbTjG/UviG0g7DId5FouT4kSFcu6YOiFCiW3DfIpf/zACnSgz
 d6fsz7bxoh/pLLGW/RRrkp+SYB/t/Lyny0uRUBMj4pZjFSUWr+FFdlhQmSCZj4bCxNw6
 No8qqO0es9cRi6Ex+9pp0u4VdPTeNogUbhcBqE78xAHA+p0PXGRHS8kIKGvczVNfXElX
 A2MfHHfLDrN7WWiHTTdi8r7esduKnJR9MfM/XGmjM7F72swt4JgxL9U9s6F28q3m33y0
 DPxg==
X-Gm-Message-State: AOAM530yz6iQ+6bf9QHjY82YN+0ieEWM0bYSuDAOpb/Z3HVsm83mnfHU
 fOAE/NLx7mke81+CKWiKGibHjJCf8IYH9o02yN9HDcRSMJesy9PWh86WJS5tynhujLe1Rbra5IT
 qh2GhI3ypS216aFI=
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr4198889wrq.381.1601983914775; 
 Tue, 06 Oct 2020 04:31:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4FVJysAXwQpWdPzJPvKNfEfN1Ho9NzgZ3WezaxObGI7qyMbBqOkSpfOzFpfpO5nxiGX4Yog==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr4198862wrq.381.1601983914470; 
 Tue, 06 Oct 2020 04:31:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id u81sm3393679wmg.43.2020.10.06.04.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:31:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006111909.2302081-1-philmd@redhat.com>
 <20201006111909.2302081-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73dd0b58-b52c-a0ba-988a-430205a3a2e6@redhat.com>
Date: Tue, 6 Oct 2020 13:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006111909.2302081-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 13:19, Philippe Mathieu-Daudé wrote:
> While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
> by a device only available using system-mode (fw_cfg), it is
> implemented by a crypto component (tls-cipher-suites) which
> is always available when crypto is used.
> 
> Commit 69699f3055 introduced the following error in the
> qemu-storage-daemon binary:
> 
>   $ echo -e \
>     '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
>     | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
>   {"return": {}}
>   missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>   Aborted (core dumped)
> 
> Since QOM dependencies are resolved at runtime, this issue
> could not be triggered at linktime, and we don't have test
> running the qemu-storage-daemon binary.
> 
> Fix by always registering the QOM interface.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg-interface.c | 15 +++++++++++++++
>  hw/nvram/fw_cfg.c           |  7 -------
>  MAINTAINERS                 |  2 +-
>  hw/nvram/meson.build        |  3 +++
>  4 files changed, 19 insertions(+), 8 deletions(-)
>  create mode 100644 hw/nvram/fw_cfg-interface.c
> 
> diff --git a/hw/nvram/fw_cfg-interface.c b/hw/nvram/fw_cfg-interface.c
> new file mode 100644
> index 0000000000..2b19502ffe
> --- /dev/null
> +++ b/hw/nvram/fw_cfg-interface.c
> @@ -0,0 +1,15 @@
> +#include "qemu/osdep.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +static const TypeInfo fw_cfg_data_generator_interface_info = {
> +    .parent = TYPE_INTERFACE,
> +    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
> +    .class_size = sizeof(FWCfgDataGeneratorClass),
> +};
> +
> +static void fw_cfg_register_types(void)
> +{
> +    type_register_static(&fw_cfg_data_generator_interface_info);
> +}
> +
> +type_init(fw_cfg_register_types)
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 0e95d057fd..08539a1aab 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1360,18 +1360,11 @@ static const TypeInfo fw_cfg_mem_info = {
>      .class_init    = fw_cfg_mem_class_init,
>  };
>  
> -static const TypeInfo fw_cfg_data_generator_interface_info = {
> -    .parent = TYPE_INTERFACE,
> -    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
> -    .class_size = sizeof(FWCfgDataGeneratorClass),
> -};
> -
>  static void fw_cfg_register_types(void)
>  {
>      type_register_static(&fw_cfg_info);
>      type_register_static(&fw_cfg_io_info);
>      type_register_static(&fw_cfg_mem_info);
> -    type_register_static(&fw_cfg_data_generator_interface_info);
>  }
>  
>  type_init(fw_cfg_register_types)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b76fb31861..a45d908ebd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2054,7 +2054,7 @@ R: Laszlo Ersek <lersek@redhat.com>
>  R: Gerd Hoffmann <kraxel@redhat.com>
>  S: Supported
>  F: docs/specs/fw_cfg.txt
> -F: hw/nvram/fw_cfg.c
> +F: hw/nvram/fw_cfg*.c
>  F: stubs/fw_cfg.c
>  F: include/hw/nvram/fw_cfg.h
>  F: include/standard-headers/linux/qemu_fw_cfg.h
> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
> index 1f2ed013b2..fd2951a860 100644
> --- a/hw/nvram/meson.build
> +++ b/hw/nvram/meson.build
> @@ -1,3 +1,6 @@
> +# QOM interfaces must be available anytime QOM is used.
> +qom_ss.add(files('fw_cfg-interface.c'))
> +
>  softmmu_ss.add(files('fw_cfg.c'))
>  softmmu_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
>  softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


