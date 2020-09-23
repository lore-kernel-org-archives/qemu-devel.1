Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F93C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2758206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXh3NOG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2758206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6Rl-0005AM-Tj
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kL6Pz-0003sq-S7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:10:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kL6Px-0002WA-If
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600873848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk4+XO5HvnuWYFX+u+IugfZI6yXxdo25BFa52zre30w=;
 b=SXh3NOG08++IT5Zzl7kWVh7NgDslbLMYnYWKQhjRZ8feBjpg2I+ct5eyzqd0Tzuzl9JQbB
 t4Tohesol76J7B9LUab/4jG8Pt/rRvq22o80fg/eq80F+LKeBZm9B/ryTvJ+p/K5nYRYXa
 FrlSoePKthMoQBWPMEf57NO/5f5RdY8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-SbuR0ssgPteJFS35pyTf-Q-1; Wed, 23 Sep 2020 11:10:46 -0400
X-MC-Unique: SbuR0ssgPteJFS35pyTf-Q-1
Received: by mail-wr1-f71.google.com with SMTP id s8so8921170wrb.15
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Vixv2H86teg9JZ2SudgTkpGv9xEO7CzqkRlsiCuudKM=;
 b=hqPKlPIIny5XbXMqek7sYwcdCnfWKP4gSDHqNyIbvoTHavjk5n/Me9sv2mCfmM3gPf
 NvFuvBt78lssPhIDJLdLmWFdCxkL3Zr0ccSfx4eNvsOCIvqP9xIfa7Y+R2jBQ1zz6WBu
 GyQ+CsZEifOAwr/AxrKSBNPj00wtKjjtw0VY5BD4mKOx9A/aN5KgD6hd9csO8MOeGptp
 S0VSuAQoAgOwr9bEenbk7QYCxvPwQy8Ca98CXBt7gr/rYUbSM2K9cpXZWATq1MWgS5En
 MvaDB3TNQFIaC9556LN0O2HdmT3zFMVk+tZDUXmW3dC/63kaO/MZBTUyZKTGzQ+HLlpS
 +bDg==
X-Gm-Message-State: AOAM531WxjJu3/sP+XD5VWSaAuVafxqhXuP/yETdHejadiiPjgE1Qzn5
 9yU/oBAv5U1qRDYJLYqpLqSKq+SRhB7TBK7e0vwwh+4LcFChlewPe/dAqwUm3+W9ujwvtxefb7O
 u4c0iiMVmskGDZ+Y=
X-Received: by 2002:adf:fa52:: with SMTP id y18mr128047wrr.264.1600873844857; 
 Wed, 23 Sep 2020 08:10:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXQq4tgnFHDIm+kx56vqUIbaGecqP8D9SD5kuNkaKU4w1KGqZIXFCAwzKTTXXGCyBgwVdkTw==
X-Received: by 2002:adf:fa52:: with SMTP id y18mr128005wrr.264.1600873844612; 
 Wed, 23 Sep 2020 08:10:44 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id z83sm132727wmb.4.2020.09.23.08.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 08:10:43 -0700 (PDT)
Date: Wed, 23 Sep 2020 11:10:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 11/20] multi-process: introduce proxy object
Message-ID: <20200923111006-mutt-send-email-mst@kernel.org>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-12-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-12-elena.ufimtseva@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:11:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 11:12:22AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> Defines a PCI Device proxy object as a child of TYPE_PCI_DEVICE.
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>


Hmm I think this device needs to block migration. And maybe the pci host
device needs to do it too?

> ---
>  MAINTAINERS            |  2 +
>  hw/pci/meson.build     |  1 +
>  hw/pci/proxy.c         | 84 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/proxy.h | 34 +++++++++++++++++
>  4 files changed, 121 insertions(+)
>  create mode 100644 hw/pci/proxy.c
>  create mode 100644 include/hw/pci/proxy.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14b8c005fc..7b2096b300 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3052,6 +3052,8 @@ F: include/hw/i386/remote-obj.h
>  F: hw/i386/remote-obj.c
>  F: include/hw/i386/remote-memory.h
>  F: hw/i386/remote-memory.c
> +F: hw/pci/proxy.c
> +F: include/hw/pci/proxy.h
>  
>  Build and test automation
>  -------------------------
> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
> index 5c4bbac817..0df30172b5 100644
> --- a/hw/pci/meson.build
> +++ b/hw/pci/meson.build
> @@ -12,6 +12,7 @@ pci_ss.add(files(
>  # allow plugging PCIe devices into PCI buses, include them even if
>  # CONFIG_PCI_EXPRESS=n.
>  pci_ss.add(files('pcie.c', 'pcie_aer.c'))
> +pci_ss.add(when: 'CONFIG_MPQEMU', if_true: files('proxy.c'))
>  softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
>  softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>  
> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
> new file mode 100644
> index 0000000000..1bff744bd6
> --- /dev/null
> +++ b/hw/pci/proxy.c
> @@ -0,0 +1,84 @@
> +/*
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
> +#include "hw/pci/proxy.h"
> +#include "hw/pci/pci.h"
> +#include "qapi/error.h"
> +#include "io/channel-util.h"
> +#include "hw/qdev-properties.h"
> +#include "monitor/monitor.h"
> +
> +static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
> +{
> +    pdev->ioc = qio_channel_new_fd(fd, errp);
> +}
> +
> +static Property proxy_properties[] = {
> +    DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
> +{
> +    PCIProxyDev *dev = PCI_PROXY_DEV(device);
> +    int fd;
> +
> +    if (dev->fd) {
> +        fd = monitor_fd_param(cur_mon, dev->fd, errp);
> +        if (fd == -1) {
> +            error_prepend(errp, "proxy: unable to parse fd: ");
> +            return;
> +        }
> +        proxy_set_socket(dev, fd, errp);
> +    } else {
> +        error_setg(errp, "fd parameter not specified for %s",
> +                   DEVICE(device)->id);
> +        return;
> +    }
> +
> +    qemu_mutex_init(&dev->io_mutex);
> +    qio_channel_set_blocking(dev->ioc, true, NULL);
> +}
> +
> +static void pci_proxy_dev_exit(PCIDevice *pdev)
> +{
> +    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
> +
> +    qio_channel_close(dev->ioc, NULL);
> +}
> +
> +static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = pci_proxy_dev_realize;
> +    k->exit = pci_proxy_dev_exit;
> +    device_class_set_props(dc, proxy_properties);
> +}
> +
> +static const TypeInfo pci_proxy_dev_type_info = {
> +    .name          = TYPE_PCI_PROXY_DEV,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(PCIProxyDev),
> +    .class_init    = pci_proxy_dev_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void pci_proxy_dev_register_types(void)
> +{
> +    type_register_static(&pci_proxy_dev_type_info);
> +}
> +
> +type_init(pci_proxy_dev_register_types)
> diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
> new file mode 100644
> index 0000000000..4ae7becf34
> --- /dev/null
> +++ b/include/hw/pci/proxy.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright © 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef PROXY_H
> +#define PROXY_H
> +
> +#include "hw/pci/pci.h"
> +#include "io/channel.h"
> +
> +#define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
> +
> +#define PCI_PROXY_DEV(obj) \
> +            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
> +
> +typedef struct PCIProxyDev {
> +    PCIDevice parent_dev;
> +    char *fd;
> +
> +    /*
> +     * Mutex used to protect the QIOChannel fd from
> +     * the concurrent access by the VCPUs since proxy
> +     * blocks while awaiting for the replies from the
> +     * process remote.
> +     */
> +    QemuMutex io_mutex;
> +    QIOChannel *ioc;
> +} PCIProxyDev;
> +
> +#endif /* PROXY_H */
> -- 
> 2.25.GIT


