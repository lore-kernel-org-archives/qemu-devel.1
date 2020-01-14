Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE95DC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEA524679
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="xCoIucWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEA524679
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ9M-0002nI-N3
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1irJ8H-0001eD-BE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1irJ8D-0001YF-R0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:09:09 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:46097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1irJ8D-0001XS-AH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XoZ2Bi8Y0Yqwodn8o2cYyHv/SJWl3/61lC3OFas4Ca4=; b=xCoIucWloQDd/ry9qYoTALuE+Q
 2lUqpNH62QqabHZixRynBKImqkLeeWbj6lOfcyiEvjnTHkSQX3q9axwfY1/vjGupbpnFEjZkMaMf+
 NfAYSSwXVEzpsbkxGMzXHaDqNyALRNepnxjmTcB8Rwi8+/IAY8TDki0lEbiOxM+LqoZG8BzPwlfqy
 GDf5QQN/FBjdRcDIPkv+gYgz+Ra763kJP97LxuxZ78hzVW89DNyWF5V8JOFudRMS5Kek7iExoYaYu
 hKXK4y+1/i1ZdSrmYZcR8fiWTgHSf3qV/jDSE2udj1oLHZym1Nc8/PTtrJd3NUDZ8M/vzOZ4J+86Y
 /0ZJUyzu5/UwEIocFHQMHusEp8dxbiKRiwpUvU77ddHWVlOZ8Gv3NJralZHF2mzAY4+sXQ2MeCISF
 eEe6TzYOxspc/1zrVfAWhIBiTSZSGFTzBA6SZnAGo5N3rI3a9TOIPXRt7LwNfEwA4mcyVAUuw+328
 QiGf1Zf+ybL0ypk6B1egxT+MuozBCKza/X/xbcD/1SoSDPCyKKiFxnp557p0cJkn4ZAaaHU+o10uN
 NMD8IA38HYvV1tSd98egFVsbjL8kbkaeRq6N2QpiB+K5nTyj+1eT7uckH97MBT0zAlFXK23vW5Hxx
 iq/aMgK3Stn5ZPr4KG5u4pGdvIA0PEgjJ6DW9l7+g=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: pannengyuan@huawei.com, mst@redhat.com, groug@kaod.org,
 Euler Robot <euler.robot@huawei.com>, zhang.zhanghailiang@huawei.com
Subject: Re: [PATCH] virtio-9p-device: fix memleak in
 virtio_9p_device_unrealize
Date: Tue, 14 Jan 2020 11:08:59 +0100
Message-ID: <56394079.B7N9aGhjP3@silver>
In-Reply-To: <20200114074020.54696-1-pannengyuan@huawei.com>
References: <20200114074020.54696-1-pannengyuan@huawei.com>
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

On Dienstag, 14. Januar 2020 08:40:20 CET pannengyuan@huawei.com wrote:
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
> ---
>  hw/9pfs/virtio-9p-device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index b5a7c03f26..b146387ae2 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -215,6 +215,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev,
> Error **errp) V9fsVirtioState *v = VIRTIO_9P(dev);
>      V9fsState *s = &v->state;
> 
> +    virtio_delete_queue(v->vq);
>      virtio_cleanup(vdev);
>      v9fs_device_unrealize_common(s, errp);
>  }

Looks like you are using an old interface. The new one is

	void virtio_del_queue(VirtIODevice *vdev, int n);

Best regards,
Christian Schoenebeck



