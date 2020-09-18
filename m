Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90156C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084E720771
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiQZZGsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084E720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCZn-00076l-RX
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kJCY9-0005xb-Qc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kJCY6-0003qR-MV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600420762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PksSjBjOETRU/ovNpBfjGeqq9YIN0iy6VLSx2AxKE2E=;
 b=DiQZZGsb0K8VH4KAggn3ZAUqV6vWbYiiFEysWWVoUlPBUqHreuc0mwROA4LlIRUi0oAM4c
 hgGfPJBX5U2Av6dTzwv3AuRgrEOtQOXqpVSDNo9va+np0dLq4y/hA2ZJwbgT476KHZdEni
 s2UWshuX/RAaeYUo9aTldCVilGMFnjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-L98focMDOTa6uYmRqyupjQ-1; Fri, 18 Sep 2020 05:19:18 -0400
X-MC-Unique: L98focMDOTa6uYmRqyupjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56CD410074DB;
 Fri, 18 Sep 2020 09:19:16 +0000 (UTC)
Received: from gondolin (ovpn-112-191.ams2.redhat.com [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3B9E19D6C;
 Fri, 18 Sep 2020 09:19:03 +0000 (UTC)
Date: Fri, 18 Sep 2020 11:19:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3 2/4] vhost-vsock-pci: force virtio version 1
Message-ID: <20200918111901.7b8862b3.cohuck@redhat.com>
In-Reply-To: <20200918074710.27810-3-sgarzare@redhat.com>
References: <20200918074710.27810-1-sgarzare@redhat.com>
 <20200918074710.27810-3-sgarzare@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Qian Cai <caiqian@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 09:47:08 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> accidentally on") added a safety check that requires to set
> 'disable-legacy=on' on vhost-vsock-pci device:
> 
>     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
>         qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
>         device is modern-only, use disable-legacy=on
> 
> virtio-vsock was introduced after the release of VIRTIO 1.0
> specifications, so it should be 'modern-only'.
> In addition Cornelia verified that forcing a legacy mode on
> vhost-vsock-pci device using x86-64 host and s390x guest, so with
> different endianness, produces strange behaviours.
> 
> This patch forces virtio version 1 and removes the 'transitional_name'
> property removing the need to specify 'disable-legacy=on' on
> vhost-vsock-pci device.
> 
> To avoid migration issues, we force virtio version 1 only when
> legacy check is enabled in the new machine types (>= 5.1).
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Qian Cai <caiqian@redhat.com>
> Reported-by: Qinghua Cheng <qcheng@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1868449
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
>  - forced virtio version 1 only with new machine types
> v2:
>  - fixed commit message [Cornelia]
> ---
>  hw/virtio/vhost-vsock-pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
> index e56067b427..205da8d1f5 100644
> --- a/hw/virtio/vhost-vsock-pci.c
> +++ b/hw/virtio/vhost-vsock-pci.c
> @@ -44,6 +44,15 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> +    VirtIODevice *virtio_dev = VIRTIO_DEVICE(vdev);
> +
> +    /*
> +     * To avoid migration issues, we force virtio version 1 only when
> +     * legacy check is enabled in the new machine types (>= 5.1).
> +     */
> +    if (!virtio_legacy_check_disabled(virtio_dev)) {
> +        virtio_pci_force_virtio_1(vpci_dev);
> +    }
>  
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>  }
> @@ -73,7 +82,6 @@ static void vhost_vsock_pci_instance_init(Object *obj)
>  static const VirtioPCIDeviceTypeInfo vhost_vsock_pci_info = {
>      .base_name             = TYPE_VHOST_VSOCK_PCI,
>      .generic_name          = "vhost-vsock-pci",
> -    .transitional_name     = "vhost-vsock-pci-transitional",

Hm... this means that vhost-vsock-pci-transitional won't work on compat
machines, which could also lead to migration compatibility issues (I
think?)

Is this way of specifying the device sufficiently uncommon so that we
can ignore that?


>      .non_transitional_name = "vhost-vsock-pci-non-transitional",
>      .instance_size = sizeof(VHostVSockPCI),
>      .instance_init = vhost_vsock_pci_instance_init,


