Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C30C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F4620716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1CIsw+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F4620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4Aq-0007mW-2Z
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw4AD-0007LD-R8
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw4AB-0003bY-Q2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:10:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34321
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw4AB-0003ai-N2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580130646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uxvZFay6N93u8IhS4o9XRA3k6uRFZAIjKs5xbkT94o=;
 b=E1CIsw+HJx0nZ7XSxqEi8bsqGIYa36q7hb3D1lZosMGfKj8aFMR+gu3rgAXAt+JsatxIxv
 Pwb5mqiX7a2YrwWOi3jU0Y73UNTZRqP/TxR/mpGiiLEJJcDOz3bjaIH0m3bauRusEvp0W8
 vWvH0XnNGgHWDZM1w1ktWrZgGTxbsEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-kcf_gN2DPVaZyZo6bHSKLg-1; Mon, 27 Jan 2020 08:10:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 285BF477;
 Mon, 27 Jan 2020 13:10:42 +0000 (UTC)
Received: from gondolin (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 447E4863CF;
 Mon, 27 Jan 2020 13:10:34 +0000 (UTC)
Date: Mon, 27 Jan 2020 14:10:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200127141031.6e108839.cohuck@redhat.com>
In-Reply-To: <20200124100159.736209-3-stefanha@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kcf_gN2DPVaZyZo6bHSKLg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 10:01:57 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Automatically size the number of request virtqueues to match the number

"If the pci transport is used, ..." ?

> of vCPUs.  This ensures that completion interrupts are handled on the
> same vCPU that submitted the request.  No IPI is necessary to complete
> an I/O request and performance is improved.

"For other transports, the number of request queues continues to
default to 1." ?

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/core/machine.c               |  3 +++
>  hw/scsi/vhost-scsi.c            |  3 ++-
>  hw/scsi/vhost-user-scsi.c       |  3 ++-
>  hw/scsi/virtio-scsi.c           |  6 +++++-
>  hw/virtio/vhost-scsi-pci.c      | 10 ++++++++--
>  hw/virtio/vhost-user-scsi-pci.c | 10 ++++++++--
>  hw/virtio/virtio-scsi-pci.c     | 10 ++++++++--
>  include/hw/virtio/virtio-scsi.h |  2 ++
>  8 files changed, 38 insertions(+), 9 deletions(-)
> 
(...)
> diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
> index e8dfbfc60f..38a8f0c3ef 100644
> --- a/hw/virtio/vhost-scsi-pci.c
> +++ b/hw/virtio/vhost-scsi-pci.c
> @@ -17,6 +17,7 @@
>  #include "qemu/osdep.h"
>  
>  #include "standard-headers/linux/virtio_pci.h"
> +#include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/vhost-scsi.h"
>  #include "qapi/error.h"
> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VHostSCSIPCI *dev = VHOST_SCSI_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> -    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
> +    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.parent_obj.conf;
> +
> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> +    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> +        conf->num_queues = current_machine->smp.cpus;

This now maps the request vqs 1:1 to the vcpus. What about the fixed
vqs? If they don't really matter, amend the comment to explain that?

> +    }
>  
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues + 3;
> +        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>  
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));


