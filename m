Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7CC2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831B722525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIFodqIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831B722525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuHb-0001Vh-J5
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amit@kernel.org>) id 1icuFr-0000b7-MW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amit@kernel.org>) id 1icuFp-0003pY-IW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:45:27 -0500
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1]:59174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amit@kernel.org>) id 1icuFn-0003du-3m
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GCat5FVA0VuTMCZQTN7B7ZGHIXbyEOoF09HIBMrwKN4=; b=RIFodqIoWLPG1cF+I3WrDbLVBw
 49rg5v/MpalrnLGVkPQQvcItuKillVvEQabt87ulLhjmWCABZ6V8HNrP51vQypR/BdCEDYTxq4KEa
 fiDtExusDbGuQlW/jar5IE1+NiXepjNCNaVGGjDGkgc3GvCTVjrhfq3SyyuJ2uYKfSqhsgBg/nwtj
 T7+y0PBV+5+I8gkXR+4u80YrVX9nP3T4x4h/PGg6yRtDp8mcyPHWApBlp7mQSqlFUc1gCUQiIPrnC
 1023Ao+BX6s54MTb4rignvf3P3LzW1l3xI8IVRGHKli8OvgHvWRU3uFVFmuxnmxu9tzmiZ6zXCK+i
 i/rIaRzQ==;
Received: from [54.239.6.185] (helo=u0c626add9cce5a.ant.amazon.com)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icuFZ-0000kB-IX; Thu, 05 Dec 2019 16:45:10 +0000
Message-ID: <1eaf11e84a6c1cbfbacebe2ae4361925142c1ab6.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
From: Amit Shah <amit@kernel.org>
To: pannengyuan@huawei.com, mst@redhat.com
Date: Thu, 05 Dec 2019 17:45:06 +0100
In-Reply-To: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:8b0:10b:1231::1
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-12-04 at 15:31 +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>

Shouldn't this be From: mst?

I didn't find a ref to the original patch to confirm if you had to
adapt it in any way, though.

> Devices tend to maintain vq pointers, allow deleting them trough a vq
> pointer.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - add a new function virtio_delete_queue to cleanup vq through a vq
> pointer
> ---
>  hw/virtio/virtio.c         | 16 +++++++++++-----
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5..6de3cfd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice
> *vdev, int queue_size,
>      return &vdev->vq[i];
>  }
>  
> +void virtio_delete_queue(VirtQueue *vq)
> +{
> +    vq->vring.num = 0;
> +    vq->vring.num_default = 0;
> +    vq->handle_output = NULL;
> +    vq->handle_aio_output = NULL;
> +    g_free(vq->used_elems);
> +    vq->used_elems = NULL;
> +}
> +
>  void virtio_del_queue(VirtIODevice *vdev, int n)
>  {
>      if (n < 0 || n >= VIRTIO_QUEUE_MAX) {
>          abort();
>      }
>  
> -    vdev->vq[n].vring.num = 0;
> -    vdev->vq[n].vring.num_default = 0;
> -    vdev->vq[n].handle_output = NULL;
> -    vdev->vq[n].handle_aio_output = NULL;
> -    g_free(vdev->vq[n].used_elems);
> +    virtio_delete_queue(&vdev->vq[n]);
>  }
>  
>  static void virtio_set_isr(VirtIODevice *vdev, int value)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c32a815..e18756d 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev,
> int queue_size,
>  
>  void virtio_del_queue(VirtIODevice *vdev, int n);
>  
> +void virtio_delete_queue(VirtQueue *vq);
> +
>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                      unsigned int len);
>  void virtqueue_flush(VirtQueue *vq, unsigned int count);


