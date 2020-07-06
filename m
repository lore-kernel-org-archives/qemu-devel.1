Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA97A20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmJ9U+Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA97A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsT46-00073H-04
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 11:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jsT3S-0006XR-PM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:29:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jsT3R-0004I2-8Z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594049352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fue+J+SZ+TQDmSB0+3L8vErWlImPiK/hYfN6zC83Q4g=;
 b=AmJ9U+Ot+UkZHcaEnjDX0DRmMOwJjduW4a2lILXR++zJn7cCvstbz9XYcxphLv5Gi7J6yn
 JOuR1peAUtOkSeyjCHCyROHgxFZ+dhRA20BfV8T/9igDKG/Lw8XHWz3PCB/oWZhCLDBMSK
 pPp3gEsadSlS5Uy7LPEFqF5+vRVsQ0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-0DfCHj40NE-sE7mqyIK4mQ-1; Mon, 06 Jul 2020 11:29:08 -0400
X-MC-Unique: 0DfCHj40NE-sE7mqyIK4mQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E993107B274;
 Mon,  6 Jul 2020 15:29:07 +0000 (UTC)
Received: from gondolin (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF46275E3D;
 Mon,  6 Jul 2020 15:28:54 +0000 (UTC)
Date: Mon, 6 Jul 2020 17:28:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 11/21] virtio-pci: Proxy for virtio-mem
Message-ID: <20200706172851.2d3062d9.cohuck@redhat.com>
In-Reply-To: <20200626072248.78761-12-david@redhat.com>
References: <20200626072248.78761-1-david@redhat.com>
 <20200626072248.78761-12-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, "Michael S .
 Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 09:22:38 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's add a proxy for virtio-mem, make it a memory device, and
> pass-through the properties.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/Makefile.objs    |   1 +
>  hw/virtio/virtio-mem-pci.c | 129 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-mem-pci.h |  33 ++++++++++
>  include/hw/pci/pci.h       |   1 +
>  4 files changed, 164 insertions(+)
>  create mode 100644 hw/virtio/virtio-mem-pci.c
>  create mode 100644 hw/virtio/virtio-mem-pci.h

(...)

> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> new file mode 100644
> index 0000000000..b325303b32
> --- /dev/null
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -0,0 +1,129 @@
> +/*
> + * Virtio MEM PCI device
> + *
> + * Copyright (C) 2020 Red Hat, Inc.
> + *
> + * Authors:
> + *  David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "virtio-mem-pci.h"
> +#include "hw/mem/memory-device.h"
> +#include "qapi/error.h"
> +
> +static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&mem_pci->vdev);
> +

As we were having that discussion for other devices recently: I think
you want to use 

    virtio_pci_force_virtio_1(vpci_dev);

here. (Or do it via the names in the type, as virtio-fs does, but I
think I like forcing it better.)

> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}


