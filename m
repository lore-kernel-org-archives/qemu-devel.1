Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D7C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF342073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="omcygCyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF342073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isR8x-0001U8-S0
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isR7W-00005f-6W
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isR7S-0003TI-KM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:53:02 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:57027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1isR7S-0003S7-89
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=WWAxBM0HwRtqtr8gFAXHwZg5jhKzLmk9kV/zFBlG+Xw=; b=omcygCyxUWTkBDJUS4eSlndNEa
 9xWKLpylRlrftaaG5MbvJcO/LjL2ZmHpcXI04jYEN+gaLXm/60+LJ1IF50hTbEcvSArgRgBC2c1Lv
 e2cRs4dlJmc4sP0ECpj1OnehZjJNpT2suZdd45YOIaDxD74V+ioNYdsz315tEYALH+4DUWxpo5KbL
 ZhMP2OFp1RGLcsE3pqcpqcClFVFj9gIV3yaojGQ/ApvZaGZLTVyQUGQDJu/ZjaVwDQmLj/6O4GGGh
 7p5okwc2hNUXC5WDhmofjiRFpex8oTFeWZngAuOiM0SMwHo1Qw159ik8f4ERpj7w9xE5/8avNlPcs
 KBDjJYjF1kRCK0AqJLk8firKKUnzrD6UBPrQ3Crp0J9v9VmP/qZBDw2VPZULwY+md+FKRI+fPKyFA
 mKOINrpNOwbMo3ued/qXbGHspJd+3HylK3vTqMvZyzVe3dceDY+je/odUuo+/IglUyqE3KGTOJdl4
 2yjJTeE+KioWLAuA013cWbxaHHXPeY3AGZcsnb5Rrd9NXRIPNKxP8xOfYZQSZIY4zi/eEEu9vdVYh
 C2rq16BAjrB2Mz5oe9YciRh7EOuNtE6az0WnITyJ6Aib54O+lwnFmwmLJk4ihMGumaNv2zG++ECYt
 /SJYWfoxq5+chDwrG9ZuGeSCteiw/zpNgVP0Ugong=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: pannengyuan@huawei.com, mst@redhat.com, groug@kaod.org,
 Euler Robot <euler.robot@huawei.com>, zhang.zhanghailiang@huawei.com
Subject: Re: [PATCH v2 1/2] virtio-9p-device: fix memleak in
 virtio_9p_device_unrealize
Date: Fri, 17 Jan 2020 13:52:53 +0100
Message-ID: <7781044.dIsAdKOGtE@silver>
In-Reply-To: <20200117060927.51996-2-pannengyuan@huawei.com>
References: <20200117060927.51996-1-pannengyuan@huawei.com>
 <20200117060927.51996-2-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 17. Januar 2020 07:09:26 CET pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> v->vq forgot to cleanup in virtio_9p_device_unrealize, the memory leak
> stack is as follow:
> 
> Direct leak of 14336 byte(s) in 2 object(s) allocated from:
>   #0 0x7f819ae43970 (/lib64/libasan.so.5+0xef970)  ??:?
>   #1 0x7f819872f49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
>   #2 0x55a3a58da624 (./x86_64-softmmu/qemu-system-x86_64+0x2c14624) 
> /mnt/sdb/qemu/hw/virtio/virtio.c:2327 #3 0x55a3a571bac7
> (./x86_64-softmmu/qemu-system-x86_64+0x2a55ac7) 
> /mnt/sdb/qemu/hw/9pfs/virtio-9p-device.c:209 #4 0x55a3a58e7bc6
> (./x86_64-softmmu/qemu-system-x86_64+0x2c21bc6) 
> /mnt/sdb/qemu/hw/virtio/virtio.c:3504 #5 0x55a3a5ebfb37
> (./x86_64-softmmu/qemu-system-x86_64+0x31f9b37) 
> /mnt/sdb/qemu/hw/core/qdev.c:876
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Maybe you could add this patch to your revised PR Greg?

> ---
> Changes V2 to V1:
> - use old function virtio_del_queue to make it easier for stable branch
> to merge (suggested by Christian Schoenebeck)
> ---
>  hw/9pfs/virtio-9p-device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index b5a7c03f26..910dc5045e 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -215,6 +215,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev,
> Error **errp) V9fsVirtioState *v = VIRTIO_9P(dev);
>      V9fsState *s = &v->state;
> 
> +    virtio_del_queue(vdev, 0);
>      virtio_cleanup(vdev);
>      v9fs_device_unrealize_common(s, errp);
>  }





