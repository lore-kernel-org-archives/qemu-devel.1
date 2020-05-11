Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C89C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4C62075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fwu1MmCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4C62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4Tw-0007gw-Ab
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jY4TD-0006nN-QW; Mon, 11 May 2020 05:11:31 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:54924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jY4TA-0000eO-3D; Mon, 11 May 2020 05:11:29 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 042FB2E0141;
 Mon, 11 May 2020 12:11:23 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 8S0lqoiCHp-BJWardsD; Mon, 11 May 2020 12:11:22 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589188282; bh=7kweTz0B17gGKB30stljIlEMQyqdxeoPLtkTRxZQM4Y=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=fwu1MmCTqbzg4XVMRUVOYVeJMEngzukkqWKM0pr/mPbctY7TaYGYMUzM9wCRIxLSX
 UsoxRWJaOs2aELBl+6Fp0XYBAOgpOM/2emr8ZwVp+GfFzFycZUyx9uzR7IFF3v7k8N
 p+AoARMxzIEGEhkUPSG81eS6IGLCC+eTMy9jtEeo=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7214::1:7])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 8XfFjgzoVf-BIWmmYJk; Mon, 11 May 2020 12:11:18 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 11 May 2020 12:11:17 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/5] vhost: check vring address before calling unmap
Message-ID: <20200511091117.GB27319@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <2d4952df2cc246f7421b4b9023a581b22210fc41.1588252862.git.dimastep@yandex-team.ru>
 <4a03e4aa-3a21-d678-be98-13268343b674@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a03e4aa-3a21-d678-be98-13268343b674@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, arei.gonglei@huawei.com, raphael.norwitz@nutanix.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 11:05:58AM +0800, Jason Wang wrote:
> 
> On 2020/4/30 下午9:36, Dima Stepanov wrote:
> >Since disconnect can happen at any time during initialization not all
> >vring buffers (for instance used vring) can be intialized successfully.
> >If the buffer was not initialized then vhost_memory_unmap call will lead
> >to SIGSEGV. Add checks for the vring address value before calling unmap.
> >Also add assert() in the vhost_memory_unmap() routine.
> >
> >Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >---
> >  hw/virtio/vhost.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index ddbdc53..3ee50c4 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -314,6 +314,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
> >                                 hwaddr len, int is_write,
> >                                 hwaddr access_len)
> >  {
> >+    assert(buffer);
> >+
> >      if (!vhost_dev_has_iommu(dev)) {
> >          cpu_physical_memory_unmap(buffer, len, is_write, access_len);
> >      }
> >@@ -1132,12 +1134,25 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
> >                                                  vhost_vq_index);
> >      }
> >-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
> >-                       1, virtio_queue_get_used_size(vdev, idx));
> >-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
> >-                       0, virtio_queue_get_avail_size(vdev, idx));
> >-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
> >-                       0, virtio_queue_get_desc_size(vdev, idx));
> >+    /*
> >+     * Since the vhost-user disconnect can happen during initialization
> >+     * check if vring was initialized, before making unmap.
> >+     */
> >+    if (vq->used) {
> >+        vhost_memory_unmap(dev, vq->used,
> >+                           virtio_queue_get_used_size(vdev, idx),
> >+                           1, virtio_queue_get_used_size(vdev, idx));
> >+    }
> >+    if (vq->avail) {
> >+        vhost_memory_unmap(dev, vq->avail,
> >+                           virtio_queue_get_avail_size(vdev, idx),
> >+                           0, virtio_queue_get_avail_size(vdev, idx));
> >+    }
> >+    if (vq->desc) {
> >+        vhost_memory_unmap(dev, vq->desc,
> >+                           virtio_queue_get_desc_size(vdev, idx),
> >+                           0, virtio_queue_get_desc_size(vdev, idx));
> >+    }
> 
> 
> Any reason not checking hdev->started instead? vhost_dev_start() will set it
> to true if virtqueues were correctly mapped.
> 
> Thanks
Well i see it a little bit different:
 - vhost_dev_start() sets hdev->started to true before starting
   virtqueues
 - vhost_virtqueue_start() maps all the memory
If we hit the vhost disconnect at the start of the
vhost_virtqueue_start(), for instance for this call:
  r = dev->vhost_ops->vhost_set_vring_base(dev, &state);
Then we will call vhost_user_blk_disconnect:
  vhost_user_blk_disconnect()->
    vhost_user_blk_stop()->
      vhost_dev_stop()->
        vhost_virtqueue_stop()
As a result we will come in this routine with the hdev->started still
set to true, but if used/avail/desc fields still uninitialized and set
to 0.

> 
> 
> >  }
> >  static void vhost_eventfd_add(MemoryListener *listener,
> 

