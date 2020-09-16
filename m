Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D8C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F8520771
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlAxkVmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F8520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIRlr-0006qr-US
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIRlE-0006P0-9a
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:21:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIRlC-0005uF-MK
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600240905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/ntZJ94sVhml7F6QGwY1ka6seOdgBVzBCWZIpJzkMdg=;
 b=hlAxkVmworZbdZFW/JswmDNH/ERmUq4Mof43jkLWVTrNtFB4LADGRknmro+DPIsUAf3UW6
 v1LIx7gh8cpQ6KRhLit2h93E5IosHqf6g5zfs59MMHnx+4WzDnKK/DXp3ND+ygmh9nrgFF
 jbiSbFUV1WiwdqR0nqZaDV2hc8bY34k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-NSK8_db-NH2ybo880qfICg-1; Wed, 16 Sep 2020 03:21:43 -0400
X-MC-Unique: NSK8_db-NH2ybo880qfICg-1
Received: by mail-wr1-f71.google.com with SMTP id 33so2179504wrk.12
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 00:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/ntZJ94sVhml7F6QGwY1ka6seOdgBVzBCWZIpJzkMdg=;
 b=iSLqqxNC16HTqgdB752Os0/LYuTiG2sJJrPxlEPvJslCSr1K7i4tGcgUKnTqBFpKes
 DNombqXFVNnXBC8FQVeniJx4VWHsBEamD0P1kOWV+F86jhyf3MKIcU29cP/L36UN3hRv
 tdhmuXb9ho9LzhVy5w0TsrFjLsOmJ+6nmq6C7WNXLL/RZ2i4ikamo4EPiskmoJyy/NJN
 ZiImU9xUckknG7gTkMQ+CjuAU2h575WzipD5cGOAHksdCzM+o58TuE+gs27JdXRaw9KR
 cu3CVHBxwWtUm1VSILt+WEba27Zh/WUNwpSXf24218HgouU2cTpEQcLBPT8wdbeLI9zi
 jCwA==
X-Gm-Message-State: AOAM531aDCNFttODW8/slf76INjsfMXddmp9WcvrYYsJr67QdnvRVB1h
 z7YXzX5OBwLIPxalXzXLmT0o0kltRbJmSylfuMUUalgSdhWiYClvJz6z1jcLQUk/LqAlh6EwEwH
 KfAhn892IS3bOzXY=
X-Received: by 2002:adf:8405:: with SMTP id 5mr26544675wrf.143.1600240902584; 
 Wed, 16 Sep 2020 00:21:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxveW5ZKttEfu6YcpwQp97AFO4qzv+g2WbKR94OvaPDa2bskx5HAVRXek7bCtck0hCXJNX1g==
X-Received: by 2002:adf:8405:: with SMTP id 5mr26544650wrf.143.1600240902384; 
 Wed, 16 Sep 2020 00:21:42 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u12sm3553135wrt.81.2020.09.16.00.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 00:21:41 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] s390x/pci: Add routine to get the vfio dma
 available count
To: Matthew Rosato <mjrosato@linux.ibm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
 <1600197283-25274-5-git-send-email-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <0b28ae63-faad-953d-85c2-04bcdefeb7bf@redhat.com>
Date: Wed, 16 Sep 2020 09:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600197283-25274-5-git-send-email-mjrosato@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 schnelle@linux.ibm.com, david@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 9:14 PM, Matthew Rosato wrote:
> Create new files for separating out vfio-specific work for s390
> pci. Add the first such routine, which issues VFIO_IOMMU_GET_INFO
> ioctl to collect the current dma available count.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/meson.build     |  1 +
>  hw/s390x/s390-pci-vfio.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-pci-vfio.h | 17 +++++++++++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 hw/s390x/s390-pci-vfio.c
>  create mode 100644 hw/s390x/s390-pci-vfio.h
> 
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index b63782d..ed2f66b 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -10,6 +10,7 @@ s390x_ss.add(files(
>    's390-ccw.c',
>    's390-pci-bus.c',
>    's390-pci-inst.c',
> +  's390-pci-vfio.c',
>    's390-skeys.c',
>    's390-stattrib.c',
>    's390-virtio-hcall.c',
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> new file mode 100644
> index 0000000..75e3ac1
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
> +#include "s390-pci-vfio.h"
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
> +    int ret;
> +
> +    assert(avail);
> +
> +    argsz = sizeof(struct vfio_iommu_type1_info);
> +    info = g_malloc0(argsz);
> +    info->argsz = argsz;
> +    /*
> +     * If the specified argsz is not large enough to contain all
> +     * capabilities it will be updated upon return.  In this case
> +     * use the updated value to get the entire capability chain.
> +     */
> +    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> +    if (argsz != info->argsz) {
> +        argsz = info->argsz;
> +        info = g_realloc(info, argsz);

Do we need to bzero [sizeof(struct vfio_iommu_type1_info)..argsz[?

> +        info->argsz = argsz;
> +        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> +    }
> +
> +    if (ret) {
> +        return false;
> +    }
> +
> +    /* If the capability exists, update with the current value */
> +    return vfio_get_info_dma_avail(info, avail);
> +}
> +
> diff --git a/hw/s390x/s390-pci-vfio.h b/hw/s390x/s390-pci-vfio.h
> new file mode 100644
> index 0000000..2a5a261
> --- /dev/null
> +++ b/hw/s390x/s390-pci-vfio.h
> @@ -0,0 +1,17 @@
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
> +#ifndef HW_S390_PCI_VFIO_H
> +#define HW_S390_PCI_VFIO_H
> +
> +bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
> +
> +#endif
> 


