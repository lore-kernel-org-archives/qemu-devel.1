Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B50C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C99E20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsdCnTCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspnh-0004y2-B9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jspmU-0003wM-Vp
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:45:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jspmT-0002Ix-7c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594136712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEdP4I8aMDYa8nu/w9TG99nR0IbwTAxsF0urigC3Meg=;
 b=GsdCnTCiFI1qzKmoVLmudAPrS/of7NdgvZ+3gG4sMidYaJrLdpkG2oomeaYCZgHPCHcZmO
 Vn2xNEcW6CXrDgF1+eYdEvnhy+pbSkNSEPt+KFhGo+UnKQ6fbpxtjJgbpYYZcjFD37GCqm
 gX8WnXxZKvhmvye5LdUCI819dzkYYKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-wyw05sfQNHaQpegA0r27Ew-1; Tue, 07 Jul 2020 11:45:08 -0400
X-MC-Unique: wyw05sfQNHaQpegA0r27Ew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A5B31902EA1;
 Tue,  7 Jul 2020 15:45:07 +0000 (UTC)
Received: from gondolin (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2A4F5C1B2;
 Tue,  7 Jul 2020 15:44:56 +0000 (UTC)
Date: Tue, 7 Jul 2020 17:44:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200707174453.50c3ec85.cohuck@redhat.com>
In-Reply-To: <20200706135650.438362-4-stefanha@redhat.com>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-4-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 Jul 2020 14:56:48 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

Maybe mention 'pci' in the subject as well?

> Automatically size the number of virtio-scsi-pci, vhost-scsi-pci, and
> vhost-user-scsi-pci request virtqueues to match the number of vCPUs.
> Other transports continue to default to 1 request virtqueue.
> 
> A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
> handled on the same vCPU that submitted the request.  No IPI is
> necessary to complete an I/O request and performance is improved.  The
> maximum number of MSI-X vectors and virtqueues limit are respected.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/virtio/virtio-scsi.h |  2 ++
>  hw/core/machine.c               |  3 +++
>  hw/scsi/vhost-scsi.c            |  3 ++-
>  hw/scsi/vhost-user-scsi.c       |  3 ++-
>  hw/scsi/virtio-scsi.c           |  6 +++++-
>  hw/virtio/vhost-scsi-pci.c      | 10 +++++++---
>  hw/virtio/vhost-user-scsi-pci.c | 10 +++++++---
>  hw/virtio/virtio-scsi-pci.c     | 10 +++++++---
>  8 files changed, 35 insertions(+), 12 deletions(-)

(...)

> diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
> index 3ff9eb7ef6..fa4b3bfb50 100644
> --- a/hw/virtio/virtio-scsi-pci.c
> +++ b/hw/virtio/virtio-scsi-pci.c
> @@ -46,13 +46,17 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VirtIOSCSIPCI *dev = VIRTIO_SCSI_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> -    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
>      DeviceState *proxy = DEVICE(vpci_dev);
> +    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.conf;
>      char *bus_name;
>  
> +    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> +        conf->num_queues =
> +            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
> +    }
> +
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues +
> -                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
> +        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>  
>      /*

One corner case where the setup may end up being a bit odd is a
situation where nvectors was specified, but num_queues was not, and the
device suddenly ends up with more queues than vectors. But I don't see
a reason why you would want to specify nvectors but not num_queues in a
real word scenario, so I think we can ignore that corner case.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


