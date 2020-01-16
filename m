Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F6C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C0620663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3HL3OeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C0620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is3jl-0006Qs-Rf
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1is3j0-0005CR-Jw
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1is3iw-00065Y-0U
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:54:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1is3iv-000644-Ox
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579175643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AK+TWCMQNLmlsId3w3KtIHnU0uuGounQy25G1kRdzi0=;
 b=A3HL3OeEgcmlBB1pZ4iZszueTTYs2WcoXjwThnU9cDdI0mC2C17KQEiYhKhN/MVE4yo1oy
 ejCx4Hn0wGpeJLym5KHKyMY6u+9hb6zjd7Vj2OD9Vdr5W7WoWVzD0XXGaQl6/lIglSFiyR
 e7m8zuO4Oeoyjp8qyt6E3djildmNGUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-VuqxW2iMN6K7Y6wNsGgkmg-1; Thu, 16 Jan 2020 06:54:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50BCA107ACC7;
 Thu, 16 Jan 2020 11:53:59 +0000 (UTC)
Received: from gondolin (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E726C619DB;
 Thu, 16 Jan 2020 11:53:52 +0000 (UTC)
Date: Thu, 16 Jan 2020 12:53:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200116125349.6a3aeaa9.cohuck@redhat.com>
In-Reply-To: <20200116105842.271179-4-stefanha@redhat.com>
References: <20200116105842.271179-1-stefanha@redhat.com>
 <20200116105842.271179-4-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VuqxW2iMN6K7Y6wNsGgkmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 10:58:40 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Automatically size the number of request virtqueues to match the number
> of vCPUs.  This ensures that completion interrupts are handled on the
> same vCPU that submitted the request.  No IPI is necessary to complete
> an I/O request and performance is improved.
> 
> Remember that virtqueue numbering assumptions are being removed from the
> virtio-pci proxy object, so the Control and Event virtqueues are counted
> by ->get_num_virtqueues() and we only add 1 for the Configuration Change
> interrupt:
> 
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues + 3;
> +        vpci_dev->nvectors = vdc->get_num_virtqueues(VIRTIO_DEVICE(vdev)) + 1;
>      }
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/core/machine.c               |  3 +++
>  hw/scsi/vhost-scsi.c            |  2 ++
>  hw/scsi/vhost-user-scsi.c       |  2 ++
>  hw/scsi/virtio-scsi.c           | 18 ++++++++++++++++++
>  hw/virtio/vhost-scsi-pci.c      |  4 ++--
>  hw/virtio/vhost-user-scsi-pci.c |  4 ++--
>  hw/virtio/virtio-scsi-pci.c     |  4 ++--
>  include/hw/virtio/virtio-scsi.h |  1 +
>  8 files changed, 32 insertions(+), 6 deletions(-)
> 

> @@ -878,6 +879,18 @@ static struct SCSIBusInfo virtio_scsi_scsi_info = {
>      .load_request = virtio_scsi_load_request,
>  };
>  
> +static uint32_t virtio_scsi_get_num_virtqueues(VirtIODevice *vdev)
> +{
> +    VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(vdev);
> +    uint32_t request_queues = s->conf.num_queues;
> +
> +    if (s->conf.num_queues == 1 && s->conf.auto_num_queues) {
> +        request_queues = current_machine->smp.cpus;
> +    }
> +
> +    return VIRTIO_SCSI_VQ_NUM_FIXED + request_queues;

I'm not sure doing this at the device level is the right thing to do.
For now, only virtio-pci will call this function, and there basing the
number of virtqueues off the number of cpus makes sense; but that's a
property of the transport, not of the device.

Consider e.g. a virtio-scsi-ccw device: If we wanted to introduce a way
to automatically pick a good number of virtqueues there, this functions
likely would not return a particularly useful value, as queue interrupt
processing does not really relate to the number of cpus with adapter
interrupts. It's not a problem right now, as only virtio-pci calls
this, but someone looking at this callback is likely getting the
impression that this is a generically useful function.

> +}
> +
>  void virtio_scsi_common_realize(DeviceState *dev,
>                                  VirtIOHandleOutput ctrl,
>                                  VirtIOHandleOutput evt,


