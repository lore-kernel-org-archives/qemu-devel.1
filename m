Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC887C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF3C223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6g/Bcq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF3C223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0B5-0000Ng-3Y
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW00r-0003cz-Ah
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW00n-0001nO-H9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603470831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMkVZ0mdAHUCTxa9eerU4dpPkPAUtI9yBAMQDW3B4Ls=;
 b=N6g/Bcq4ndZad+dPSzr00sAmdnagbhgOof8uMLuJEUQfKBbHgSYtCMTgwdBcfArirB3Xou
 VXmGgclKbRve0o8RGH1WvDwxMxT+p+hlleWCdTcskwci8yzq2ykQaEXEGotmOredj1tqfJ
 QlP4PiMoeyQVbxhw83sW+8Vb8dBqtUs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-ieVJLfSVPuqRxEdwuFD3Ig-1; Fri, 23 Oct 2020 12:33:50 -0400
X-MC-Unique: ieVJLfSVPuqRxEdwuFD3Ig-1
Received: by mail-wm1-f69.google.com with SMTP id 13so656525wmf.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IMkVZ0mdAHUCTxa9eerU4dpPkPAUtI9yBAMQDW3B4Ls=;
 b=ua5kg/FxMo8yJLEf7DuivUy87fqKnQO0dN0mRDvuAxmXaVki1ZUy85TJjAt01doqbk
 nFukpSN1kfYsVM5d42UsVyl3ZfnsxExIpMwpbmi5F9cRX9FoppvJeNGsJluJ5kbuashN
 opuIgPv0JN+EcNjJ+xl8rbIW1iywUHxjv9kxCMhk4q5F2tb1HHvxK1K5PbiFEgzKhOw/
 N9QR/qN5W+aC4XXCuvXuPF0bv3re+EUj790xehlMHlnCYcnqj/8qCEp7i+/QllM9TfnB
 rXtiY5HPdjlgizMK2cPXeO6hCYS4Tekq+47pbySjGEAWH+Bl0RGFFo2l+DG6h5k46Xmy
 2msQ==
X-Gm-Message-State: AOAM531t2psQkpD4Mbe1QPM2G8dapea5kH6f8TzkFMUM8BjgXZMcO+ct
 hlM4t6jcS+VsL2wkeKOtkX4KuZ26vpdiWx2vt1jwqNOME7Ww3mi3bLbmyzi+UizAm/0/zJpRZL7
 bc/98tbRxTeAG9vE=
X-Received: by 2002:adf:a455:: with SMTP id e21mr3876157wra.158.1603470828807; 
 Fri, 23 Oct 2020 09:33:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm459hc68eq2w4nt7FcFrrL06/qTlx/flKBF2EYxI/80/IbOSHvett4qw9MlmELZ/r7zunUA==
X-Received: by 2002:adf:a455:: with SMTP id e21mr3876119wra.158.1603470828569; 
 Fri, 23 Oct 2020 09:33:48 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j13sm4252449wru.86.2020.10.23.09.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 09:33:47 -0700 (PDT)
Subject: Re: [PATCH v11 04/19] multi-process: setup a machine object for
 remote device process
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org,
 thuth@redhat.com
References: <cover.1602784930.git.jag.raman@oracle.com>
 <6108ad0ea3d2fdd561bb873321c51725a7e5c82b.1602784930.git.jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76dcc5cf-a704-b69f-b352-6fc5eabbd206@redhat.com>
Date: Fri, 23 Oct 2020 18:33:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6108ad0ea3d2fdd561bb873321c51725a7e5c82b.1602784930.git.jag.raman@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 8:04 PM, Jagannathan Raman wrote:
> remote-machine object sets up various subsystems of the remote
> device process. Instantiate PCI host bridge object and initialize RAM, IO &
> PCI memory regions.
> 
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS                  |  2 ++
>   hw/i386/meson.build          |  1 +
>   hw/i386/remote.c             | 69 ++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/i386/remote.h     | 28 ++++++++++++++++++
>   include/hw/pci-host/remote.h |  1 +
>   5 files changed, 101 insertions(+)
>   create mode 100644 hw/i386/remote.c
>   create mode 100644 include/hw/i386/remote.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb1d701..12945ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3102,6 +3102,8 @@ M: John G Johnson <john.g.johnson@oracle.com>
>   S: Maintained
>   F: hw/pci-host/remote.c
>   F: include/hw/pci-host/remote.h
> +F: hw/i386/remote.c
> +F: include/hw/i386/remote.h
>   
>   Build and test automation
>   -------------------------
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index e5d109f..d9d4f40 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
>     'pc_sysfw.c',
>     'acpi-build.c',
>     'port92.c'))
> +i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
>   
>   subdir('kvm')
>   subdir('xen')
> diff --git a/hw/i386/remote.c b/hw/i386/remote.c
> new file mode 100644
> index 0000000..a67be33
> --- /dev/null
> +++ b/hw/i386/remote.c
> @@ -0,0 +1,69 @@
> +/*
> + * Machine for remote device
> + *
> + *  This machine type is used by the remote device process in multi-process
> + *  QEMU. QEMU device models depend on parent busses, interrupt controllers,
> + *  memory regions, etc. The remote machine type offers this environment so
> + *  that QEMU device models can be used as remote devices.
> + *
> + * Copyright © 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include "hw/i386/remote.h"
> +#include "exec/address-spaces.h"
> +#include "exec/memory.h"
> +#include "qapi/error.h"
> +
> +static void remote_machine_init(MachineState *machine)
> +{
> +    MemoryRegion *system_memory, *system_io, *pci_memory;
> +    RemoteMachineState *s = REMOTE_MACHINE(machine);
> +    RemotePCIHost *rem_host;
> +
> +    system_memory = get_system_memory();
> +    system_io = get_system_io();
> +
> +    pci_memory = g_new(MemoryRegion, 1);
> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> +
> +    rem_host = REMOTE_HOST_DEVICE(qdev_new(TYPE_REMOTE_HOST_DEVICE));
> +
> +    rem_host->mr_pci_mem = pci_memory;
> +    rem_host->mr_sys_mem = system_memory;
> +    rem_host->mr_sys_io = system_io;
> +
> +    s->host = rem_host;
> +
> +    object_property_add_child(OBJECT(s), "remote-device", OBJECT(rem_host));
> +    memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, -1);
> +
> +    qdev_realize(DEVICE(rem_host), sysbus_get_default(), &error_fatal);
> +}

Nothing is x86-specific in this machine. Why not make it a generic
machine, like the 'none' one?


