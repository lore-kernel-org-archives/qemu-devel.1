Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304E620720
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="lA1/Vi7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304E620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7Yf-0002Qs-0u
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kY7Pn-0007Aw-MH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:52:27 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:59863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kY7Pl-0004Gp-G5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=pjtbNfkJlxQuQ7OpuQZomAZ7pHysEqyWsSzXtd/Ju8U=; b=lA1/Vi7rcVwef4q9ovvJBC82Z6
 pVKAmXI3GuUwTtwLDPClmv8G9/6rC1r5+0LeW8H0KaVzPZsjrtrDEYO2RIT8lRDXEsgmYh3BU4twT
 QxsQEIoVdbf+12XbwHdjElWp2XslZaiyBBC8kyzDXBS/tmE4/i2bly4cN5T+Bbw47LttQcDqJwh+Q
 9RFaw8G+7yI5rJMF6ugDPnk2wIz9M0+vASXDKYGROZXmAfmN4tueipKfVRa5x5jbRWofK0QvoBAaZ
 TuvuvUCI9yl9aSqo9m6qpPTHXWSAEGi3lyGosjb86vWYOsFfp8CMr5+s8F0xoVqjy0X5uTqUXLR7z
 XH48Cz7w==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Greg Kurz <groug@kaod.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of
 4 bytes
Date: Thu, 29 Oct 2020 13:52:19 +0100
Message-ID: <5833982.jYnqBMCBrJ@silver>
In-Reply-To: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
References: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 08:52:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 29. Oktober 2020 09:25:41 CET Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the virtio device config space access is handled by the
> virtio_config_readX() and virtio_config_writeX() APIs. They perform
> a sanity check on the result of address plus size against the config
> space size before the access occurs.

Since I am not very familiar with the virtio implementation side, I hope
Michael would have a look at this patch.

But some comments from my side ...

> 
> For unaligned access, the last converted naturally aligned access
> will fail the sanity check on 9pfs. For example, with a mount_tag
> `p9fs`, if guest software tries to read the mount_tag via a 4 byte
> read at the mount_tag offset which is not 4 byte aligned, the read
> result will be `p9\377\377`, which is wrong.

Why 4? Shouldn't this rather consider worst case alignment?

> 
> This changes the size of device config space to be a multiple of 4
> bytes so that correct result can be returned in all circumstances.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>  hw/9pfs/virtio-9p-device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 14371a7..e6a1432 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -201,6 +201,7 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
>      V9fsVirtioState *v = VIRTIO_9P(dev);
>      V9fsState *s = &v->state;
>      FsDriverEntry *fse = get_fsdev_fsentry(s->fsconf.fsdev_id);
> +    size_t config_size;
>  
>      if (qtest_enabled() && fse) {
>          fse->export_flags |= V9FS_NO_PERF_WARN;
> @@ -211,7 +212,8 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
> -    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
> +    config_size = ROUND_UP(v->config_size, 4);
> +    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, config_size);
>      v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
>  }

Shouldn't this config_size correction rather be handled on virtio.c side
instead, i.e. in virtio_init()?

>  
> -- 
> 2.7.4

Best regards,
Christian Schoenebeck



