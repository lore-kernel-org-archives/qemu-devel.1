Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98461CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D34B20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM4wHoCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D34B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTs3-0000Bs-8W
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elohimes@gmail.com>) id 1iNTpl-0006Vd-F6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1iNTpk-0003ye-3v
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:30:45 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1iNTpj-0003yE-UG
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:30:44 -0400
Received: by mail-qt1-x843.google.com with SMTP id z22so15195151qtq.11
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 20:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mcgumC042hamXm29+yyv01VNWxQR+25pIkxpCnBxqjA=;
 b=kM4wHoCJP7GzrQCAQmsWFb8g0+GXQ+NASSj9dUtPIl9EPft0IAhmWqi7Ives1FWviW
 cSAb4rKmbTKKxm0m5JaSa8NRVYqJdLs4mJkrh9Jvvbdj5dZ9P6uLoEJZxkA3bxG8PCEm
 7tm5heZxFXPX3VCm3MIbTGoDFRzx0y/eiYdKujMd4IZ4MDjeBeJ2uVWZbf5419z0SoWd
 pENoltFiLVOpoY60FWWy1O0iyU83BTQc3ZAnU/47KYTdta5w3F+UUAfc3JgqnjkK0GlF
 5OXtlW6xNXdTvJyluKh9BwbPUFLEcDMlzhnNcIGmjIBs8td/hCVibfWgaDyqpq6ep6gY
 F8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mcgumC042hamXm29+yyv01VNWxQR+25pIkxpCnBxqjA=;
 b=mFXXaDJ3OPc+sQsoxeKS5AOwePZyQ3YHfdu5gMw/VfUySfCp8sgGvndGmMY+DEVZiW
 kDqT/zwsgeoG+zu0g74XbAA8HJ9UfQgImLBc8GozDEraUxvbBgeKL2ff1DfY7U4/nfdN
 mCsb4hHlBsO8JwI5Y9MyyKdNidD0EBIrlfnDvHy8kBOOQgefw7JBEA/pplEt0arbNMED
 YkDOwQSe8yzcx3B5BmyNuy1gHQGPAtiZDjH/IQKjFqU2Y7ggqn3EEMS9M63SNISV5Dwl
 KDkQFDACO+QCFx1DuXxs2KblCF4ZYYA3UIO7dg7RScvu0+rzP84Ge1Qi5S/XrK6cJ7dN
 Tl0Q==
X-Gm-Message-State: APjAAAViliCyii4TPwhKnOarCpldjA/+hNf4Lp6r1vWdfZNDKBvRXvgr
 I2ivTlWy8u5+fil9Mpy1M38rYISWArdq0ki6uys=
X-Google-Smtp-Source: APXvYqwv2OkVLF5eEKJG0Ns0rVUyUA9voZ8QnMQmXb8/qfIgPn9n2vj68B+adzYnJGsJxoujk1ntp3KsJm7MDBO1Iek=
X-Received: by 2002:ac8:5408:: with SMTP id b8mr1636912qtq.164.1571887843007; 
 Wed, 23 Oct 2019 20:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191021114017.26011-1-stefanha@redhat.com>
In-Reply-To: <20191021114017.26011-1-stefanha@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 24 Oct 2019 11:30:31 +0800
Message-ID: <CAONzpcYQZ2zL4AvdXD6vbMCsfg72213S8wORSoPiAfQ9vCxxZQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: notify virtqueue via host notifier when available
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 19:40, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Host notifiers are used in several cases:
> 1. Traditional ioeventfd where virtqueue notifications are handled in
>    the main loop thread.
> 2. IOThreads (aio_handle_output) where virtqueue notifications are
>    handled in an IOThread AioContext.
> 3. vhost where virtqueue notifications are handled by kernel vhost or
>    a vhost-user device backend.
>
> Most virtqueue notifications from the guest use the ioeventfd mechanism,
> but there are corner cases where QEMU code calls virtio_queue_notify().
> This currently honors the host notifier for the IOThreads
> aio_handle_output case, but not for the vhost case.  The result is that
> vhost does not receive virtqueue notifications from QEMU when
> virtio_queue_notify() is called.
>
> This patch extends virtio_queue_notify() to set the host notifier
> whenever it is enabled instead of calling the vq->(aio_)handle_output()
> function directly.
>
> This fixes the vhost case although it does add a trip through the
> eventfd for the traditional ioeventfd case.  I don't think it's worth
> adding a fast path for the traditional ioeventfd case because calling
> virtio_queue_notify() is rare when ioeventfd is enabled.
>
> Reported-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Felipe and Yongji: Only tested with "make check".  Please try
> vhost-user-scsi/blk and let us know if it fixes the issue.
>

I can see the vhost-user-blk issue is fixed by this patch after the
below patch applied:

diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 1dc834a..a32a439 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -46,6 +46,8 @@ static Property vhost_user_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };

>  include/hw/virtio/virtio-bus.h | 7 +++++++
>  hw/virtio/virtio.c             | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
> index 38c9399cd4..28ca51cb4c 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -139,6 +139,13 @@ static inline VirtIODevice *virtio_bus_get_device(VirtioBusState *bus)
>
>  /* Return whether the proxy allows ioeventfd.  */
>  bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus);
> +
> +/* Return whether ioeventfd has been started. */
> +static inline bool virtio_bus_ioeventfd_started(VirtioBusState *bus)
> +{
> +    return bus->ioeventfd_started;
> +}
> +
>  /* Start the ioeventfd. */
>  int virtio_bus_start_ioeventfd(VirtioBusState *bus);
>  /* Stop the ioeventfd. */
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 527df03bfd..abdcec00cd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1567,6 +1567,8 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
>
>  void virtio_queue_notify(VirtIODevice *vdev, int n)
>  {
> +    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> +    VirtioBusState *vbus = VIRTIO_BUS(qbus);
>      VirtQueue *vq = &vdev->vq[n];
>
>      if (unlikely(!vq->vring.desc || vdev->broken)) {
> @@ -1574,7 +1576,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
>      }
>
>      trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> -    if (vq->handle_aio_output) {
> +    if (virtio_bus_ioeventfd_started(vbus)) {

Need to check whether vq->host_notifier is valid or not here.
Otherwise, it could break the ctrl_vq in vhost_net device.

Thanks,
Yongji

