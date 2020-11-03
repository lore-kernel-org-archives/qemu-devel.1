Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA3FC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 05:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4A222277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 05:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbZEqxK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4A222277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpD6-00032J-Go
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 00:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZpC9-0002ax-5b
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 00:49:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZpC4-0005MK-UJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 00:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604382559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slkw40GiSFImTtuFhIDhMgV9WcWE8cDO1CbJj6ZgsJo=;
 b=HbZEqxK4qmw9o/zJtj2XS544H/eikeh/SAh3ss/ve4zV1CRJTnQQCwjoM/9X9eM1bL9Z17
 y9Y/Qpa4to6/oOp0ssz23ZdbxvXE/77YJ0VmsiT9YArLiCOgBvGHPjNK1bmXj+k9QM9TNh
 SUoRTwQDiNKoWhwkuRW6EmXULa49GMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-bYiU8vfPPe-ZFTJJv8WFTw-1; Tue, 03 Nov 2020 00:49:17 -0500
X-MC-Unique: bYiU8vfPPe-ZFTJJv8WFTw-1
Received: by mail-wr1-f72.google.com with SMTP id f11so7361267wro.15
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 21:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=slkw40GiSFImTtuFhIDhMgV9WcWE8cDO1CbJj6ZgsJo=;
 b=lXC9lZtZTBXwycOvjI+XTOQesLeCyYpuRVAxbwfiY7LckKbv5PZ8EvfSnVIRI8v9kh
 VA0glcZkkZCKGZ692HMzwRLPD+v3R3EyF17qjXIOWtzTbaPzaNUvvG0ltntQuFBmK4aD
 7RjWMiKQXh1+CImBzpKDDx49VBmwnWBFw4oxgFs63oQxktOf8WnxDZjoLvKHX1Z+qKJp
 OC9Lle7I/Hauk/EnNkQDTLhpB0KNComeuVoxsUHhOlH199S7Fwh0g7WpoRdTEf7dIb5Y
 uKHwRJhH4dYNYGdaxYYQzy86Hd/sxH5hpyU1iYVppNWGLTid6eQpN2sIUdhhr0Rd48i0
 Whzg==
X-Gm-Message-State: AOAM530QXeE0mK6ny5rJufUlgig8OGJ1xpxQKJHmMN8vjUx03gFTtCzE
 T9RC4o6AE4dbXcljl7FKbZg3cGo+6cWPbxzfMmTHPCxW5PWspIkzXo4RsPZHYIlt2TeNdUDw7eo
 DNdpxc7BHiJUtTb0=
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr25183053wru.296.1604382556018; 
 Mon, 02 Nov 2020 21:49:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/xL8uPSV0AzykfXdTZHv++rz3uuXKTXEnnSM9Oc8Kp0jk5PHD4AcbuOfJ1+q2tsXHy58h6Q==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr25183042wru.296.1604382555828; 
 Mon, 02 Nov 2020 21:49:15 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t11sm1675709wmf.35.2020.11.02.21.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 21:49:15 -0800 (PST)
Subject: Re: [PULL v3 23/32] s390x/pci: Add routine to get the vfio dma
 available count
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
 <160426454077.24886.1574050205264167707.stgit@gimli.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85a0a8e1-1081-12c8-c37b-4a7e919b421a@redhat.com>
Date: Tue, 3 Nov 2020 06:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160426454077.24886.1574050205264167707.stgit@gimli.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Matthew,

On 11/1/20 10:02 PM, Alex Williamson wrote:
> From: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Create new files for separating out vfio-specific work for s390
> pci. Add the first such routine, which issues VFIO_IOMMU_GET_INFO
> ioctl to collect the current dma available count.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [aw: Fix non-Linux build with CONFIG_LINUX]
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/s390x/meson.build             |    1 +
>  hw/s390x/s390-pci-vfio.c         |   54 ++++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390-pci-vfio.h |   24 +++++++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 hw/s390x/s390-pci-vfio.c
>  create mode 100644 include/hw/s390x/s390-pci-vfio.h
> 
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 948ceae7a7b3..f4663a835514 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -27,6 +27,7 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>  ))
>  s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
>  s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
> +s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c'))
>  
>  virtio_ss = ss.source_set()
>  virtio_ss.add(files('virtio-ccw.c'))
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> new file mode 100644
> index 000000000000..cb3f4d98adf8
> --- /dev/null
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -0,0 +1,54 @@
> +/*
> + * s390 vfio-pci interfaces
> + *
> + * Copyright 2020 IBM Corp.
> + * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include <sys/ioctl.h>
> +
> +#include "qemu/osdep.h"
> +#include "hw/s390x/s390-pci-vfio.h"
> +#include "hw/vfio/vfio-common.h"
> +
> +/*
> + * Get the current DMA available count from vfio.  Returns true if vfio is
> + * limiting DMA requests, false otherwise.  The current available count read
> + * from vfio is returned in avail.
> + */
> +bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
> +{
> +    g_autofree struct vfio_iommu_type1_info *info;
> +    uint32_t argsz;
> +
> +    assert(avail);
> +
> +    argsz = sizeof(struct vfio_iommu_type1_info);
> +    info = g_malloc0(argsz);
> +
> +    /*
> +     * If the specified argsz is not large enough to contain all capabilities
> +     * it will be updated upon return from the ioctl.  Retry until we have
> +     * a big enough buffer to hold the entire capability chain.
> +     */
> +retry:
> +    info->argsz = argsz;
> +
> +    if (ioctl(fd, VFIO_IOMMU_GET_INFO, info)) {
> +        return false;
> +    }
> +
> +    if (info->argsz > argsz) {
> +        argsz = info->argsz;
> +        info = g_realloc(info, argsz);
> +        goto retry;
> +    }
> +
> +    /* If the capability exists, update with the current value */
> +    return vfio_get_info_dma_avail(info, avail);
> +}

--without-default-devices configuration is broken, bisected
to this commit:

hw/s390x/s390-pci-vfio.c:52: undefined reference to
`vfio_get_info_dma_avail'

Can you have a look please?

Thanks.


