Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C8AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A166A22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkY7nR68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A166A22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwb1-0006Xi-Nu
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZwaH-00063G-Bl
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZwaF-0004cj-In
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604410966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ob8DE56cKkMPfj3XS8ezXBBQuuxqfUCp44p9I9eVQu8=;
 b=XkY7nR68Vj9EykRYv864WdHQLdsS23CZTXTyZe1U81sjUSWLQnda8jprXWhirBmFQlenFm
 QI3rI0diN1iuKrLvNjunEipPoa9rE0Q+CkHxvaupjMplOn4T0bELRL8U+uuVECwtquOJ7i
 6HExB2zqHD6BMWqD9qzYTmpl73Z5OAs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-WFHs7sTWMg-g6cTV4vLUUw-1; Tue, 03 Nov 2020 08:42:45 -0500
X-MC-Unique: WFHs7sTWMg-g6cTV4vLUUw-1
Received: by mail-wm1-f71.google.com with SMTP id u207so4614485wmu.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 05:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ob8DE56cKkMPfj3XS8ezXBBQuuxqfUCp44p9I9eVQu8=;
 b=jvYRfg9k5QpmU9kALtuVEBLNStrkFWzt4kcaLXD9xMOFlpGXlgugpawacCSNrFlmto
 ZUImwhAonaptM6r4b4YJmH6p3958p2U8KuAjeKwmAMwgi48FqecuWSEn3ZaKra3ARmzU
 37YrPhSxaVuXqodOkosC//FsU3YwoUZeJdmzON3gX0TF2Vva7A13FtFbgPqCMagxtNbD
 so1DEdjOM35TcYAaeDvX3cSZPlBNpLG7xTsKB/7l5irAm+TICUjv853N/XOj4ASq9WTY
 iA+JtA2Al4xmflj4bNkSC4bAhDgBauxuUSV9nc3vAyb9O33OmFV9NtEkmtIN+dC0vyH7
 81GA==
X-Gm-Message-State: AOAM533oPj4eiQHWEQbgD9kxXE1Q+/bN+13NRMqE5IpkoLT2KNrNGmlm
 cxelCfY78hNF+SZf1zneUycfoka2OB+/TRWONaPzC/cNOA91/br2qKWMztbKtP1SCIOZAtdmvX1
 udzkH5xWv9IllmJg=
X-Received: by 2002:a7b:ce0e:: with SMTP id m14mr3875247wmc.17.1604410961382; 
 Tue, 03 Nov 2020 05:42:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4QV4UcsD2l4MwgDwSfm3RVNnT7Du4v7aWvaSZy2RkorYIal7kInBKKfkU3Lzat7pCu83BZQ==
X-Received: by 2002:a7b:ce0e:: with SMTP id m14mr3875234wmc.17.1604410961220; 
 Tue, 03 Nov 2020 05:42:41 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f3sm103791wrw.81.2020.11.03.05.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 05:42:40 -0800 (PST)
Subject: Re: [PATCH for-5.2] s390x: fix build for --without-default-devices
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20201103123237.718242-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49d6535b-d681-e0b9-c45e-05b935dec12c@redhat.com>
Date: Tue, 3 Nov 2020 14:42:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103123237.718242-1-cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 1:32 PM, Cornelia Huck wrote:
> s390-pci-vfio.c calls into the vfio code, so we need it to be
> built conditionally on vfio (which implies CONFIG_LINUX).
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Fixes: cd7498d07fbb ("s390x/pci: Add routine to get the vfio dma available count")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/meson.build             | 2 +-
>  include/hw/s390x/s390-pci-vfio.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index f4663a835514..2a7818d94b94 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -27,7 +27,7 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>  ))
>  s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
>  s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
> -s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c'))
> +s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
>  
>  virtio_ss = ss.source_set()
>  virtio_ss.add(files('virtio-ccw.c'))
> diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
> index c7984905b3b7..ff708aef500f 100644
> --- a/include/hw/s390x/s390-pci-vfio.h
> +++ b/include/hw/s390x/s390-pci-vfio.h
> @@ -13,8 +13,9 @@
>  #define HW_S390_PCI_VFIO_H
>  
>  #include "hw/s390x/s390-pci-bus.h"
> +#include CONFIG_DEVICES

This odd include should come with a comment IMHO.

This fixes the issue, thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
> -#ifdef CONFIG_LINUX
> +#ifdef CONFIG_VFIO
>  bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
>  S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
>                                            S390PCIBusDevice *pbdev);
> 


