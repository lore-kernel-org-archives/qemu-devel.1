Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A16C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 03:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258042222F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 03:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXuh4iCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258042222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR5bj-0006x5-Vt
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 23:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kR5ap-0006WD-R6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 23:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kR5am-0000VD-9L
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 23:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602300643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1pCyZjtc2qf9iS4pWX6gwsUk4RkRB6FNdPp55ajmlU=;
 b=WXuh4iCnAMXI/FrzS7k2iENisXNDN9DgBfuU3EYFHGYYZ1QhwTOSzvFRu1juKrTMXYwIVm
 ZVl8yTBR+gSUydturmbcWPlPE1FPiN1a+r7M19GTBlwdHlWq5YCxvX5eJ1trgx9MW0Cdj/
 yxT7MftE+UfTP3rITe6enkisIICg7rM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-jLRnYhqTM2SxzE0pmmmm0Q-1; Fri, 09 Oct 2020 23:30:38 -0400
X-MC-Unique: jLRnYhqTM2SxzE0pmmmm0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6373802B77;
 Sat, 10 Oct 2020 03:30:36 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F07B5C1BB;
 Sat, 10 Oct 2020 03:30:31 +0000 (UTC)
Subject: Re: [PATCH] vhost: Don't special case vq->used_phys in
 vhost_get_log_size()
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160208823418.29027.15172801181796272300.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <30e455d0-ac84-0be4-f1bb-5b7a98b1b66b@redhat.com>
Date: Sat, 10 Oct 2020 11:30:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160208823418.29027.15172801181796272300.stgit@bahia.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 21:43:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/8 上午12:30, Greg Kurz wrote:
> The first loop in vhost_get_log_size() computes the size of the dirty log
> bitmap so that it allows to track changes in the entire guest memory, in
> terms of GPA.
>
> When not using a vIOMMU, the address of the vring's used structure,
> vq->used_phys, is a GPA. It is thus already covered by the first loop.
>
> When using a vIOMMU, vq->used_phys is a GIOVA that will be translated
> to an HVA when the vhost backend needs to update the used structure. It
> will log the corresponding GPAs into the bitmap but it certainly won't
> log the GIOVA.
>
> So in any case, vq->used_phys shouldn't be explicitly used to size the
> bitmap. Drop the second loop.
>
> This fixes a crash of the source when migrating a guest using in-kernel
> vhost-net and iommu_platform=on on POWER, because DMA regions are put
> over 0x800000000000000ULL. The resulting insanely huge log size causes
> g_malloc0() to abort.
>
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879349
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>
> This supersedes "vhost: Ignore vrings in dirty log when using a vIOMMU"
>
> http://patchwork.ozlabs.org/project/qemu-devel/patch/160105498386.68108.2145229309875282336.stgit@bahia.lan/
> ---
>   hw/virtio/vhost.c |   10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 011951625442..c02b658b597f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -172,16 +172,6 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
>                                          reg->memory_size);
>           log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
>       }
> -    for (i = 0; i < dev->nvqs; ++i) {
> -        struct vhost_virtqueue *vq = dev->vqs + i;
> -
> -        if (!vq->used_phys && !vq->used_size) {
> -            continue;
> -        }
> -
> -        uint64_t last = vq->used_phys + vq->used_size - 1;
> -        log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> -    }
>       return log_size;
>   }
>   


Acked-by: Jason Wang <jasowang@redhat.com>



>


