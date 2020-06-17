Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE06C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8D921707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUGRyNfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8D921707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcMu-0003P5-2E
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcLr-0002pY-UX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:59:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcLp-0001Dc-53
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592416792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOyTAkVRj+O9O8epirNOSrk0N1hiwslmvzq2ZgtwDeo=;
 b=QUGRyNfFn5RZc/pmdoW/UyEmn8mUgOCPHLGb7m6NJR4S10l2EW4N3oDbFu/ZIvxsD8wuxm
 x969asvdxZn5dzQTTwK5wPw4m5GUHtbxfpMjnLVYgWu0d8q/gNzU4v2Ypb/2sAlPWjroWn
 TY3dAHCWRmz9TOeW2QVMIkb5Lj3pfAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-7Z7rg9BhOgyUDiuYdTNuSw-1; Wed, 17 Jun 2020 13:59:48 -0400
X-MC-Unique: 7Z7rg9BhOgyUDiuYdTNuSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C6411800D42;
 Wed, 17 Jun 2020 17:59:47 +0000 (UTC)
Received: from work-vm (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 862B419931;
 Wed, 17 Jun 2020 17:59:39 +0000 (UTC)
Date: Wed, 17 Jun 2020 18:59:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 18/21] virtio-mem: Migration sanity checks
Message-ID: <20200617175936.GL2776@work-vm>
References: <20200610115419.51688-1-david@redhat.com>
 <20200610115419.51688-19-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610115419.51688-19-david@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> We want to make sure that certain properties don't change during
> migration, especially to catch user errors in a nice way. Let's migrate
> a temporary structure and validate that the properties didn't change.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yep OK, but some comment below

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/virtio/virtio-mem.c | 69 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 2df33f9125..450b8dc49d 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -519,12 +519,81 @@ static int virtio_mem_post_load(void *opaque, int version_id)
>      return virtio_mem_restore_unplugged(VIRTIO_MEM(opaque));
>  }
>  
> +typedef struct VirtIOMEMMigSanityChecks {
> +    VirtIOMEM *parent;
> +    uint64_t addr;
> +    uint64_t region_size;
> +    uint64_t block_size;
> +    uint32_t node;
> +} VirtIOMEMMigSanityChecks;
> +
> +static int virtio_mem_mig_sanity_checks_pre_save(void *opaque)
> +{
> +    VirtIOMEMMigSanityChecks *tmp = opaque;
> +    VirtIOMEM *vmem = tmp->parent;
> +
> +    tmp->addr = vmem->addr;
> +    tmp->region_size = memory_region_size(&vmem->memdev->mr);
> +    tmp->block_size = vmem->block_size;
> +    tmp->node = vmem->node;
> +    return 0;
> +}
> +
> +static int virtio_mem_mig_sanity_checks_post_load(void *opaque, int version_id)
> +{
> +    VirtIOMEMMigSanityChecks *tmp = opaque;
> +    VirtIOMEM *vmem = tmp->parent;
> +    const uint64_t new_region_size = memory_region_size(&vmem->memdev->mr);
> +
> +    if (tmp->addr != vmem->addr) {
> +        error_report("Property '%s' changed from 0x%" PRIx64 " to 0x%" PRIx64,
> +                     VIRTIO_MEM_ADDR_PROP, tmp->addr, vmem->addr);
> +        return -EINVAL;
> +    }

It seems weird that you do 'Property ...' and then the string; although
you only do it for 3 out of 4.
I was going to ask you to include the device name here, but I'm guessing
when it fails the outer migration code will print a 'Failed loading
device.....'  so at least you know what it is.
I would want it to be obvious when I see a 'region size changed' that I
knew it was my virtio-mem device that was screwy.

Dave

> +    /*
> +     * Note: Preparation for resizeable memory regions. The maximum size
> +     * of the memory region must not change during migration.
> +     */
> +    if (tmp->region_size != new_region_size) {
> +        error_report("region size changed from 0x%" PRIx64 " to 0x%" PRIx64,
> +                     tmp->region_size, new_region_size);
> +        return -EINVAL;
> +    }
> +    if (tmp->block_size != vmem->block_size) {
> +        error_report("Property '%s' changed from 0x%" PRIx64 " to 0x%" PRIx64,
> +                     VIRTIO_MEM_BLOCK_SIZE_PROP, tmp->block_size,
> +                     vmem->block_size);
> +        return -EINVAL;
> +    }
> +    if (tmp->node != vmem->node) {
> +        error_report("Property '%s' changed from %" PRIu32 " to %" PRIu32,
> +                     VIRTIO_MEM_NODE_PROP, tmp->node, vmem->node);
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_mem_sanity_checks = {
> +    .name = "virtio-mem-device/sanity-checks",
> +    .pre_save = virtio_mem_mig_sanity_checks_pre_save,
> +    .post_load = virtio_mem_mig_sanity_checks_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(addr, VirtIOMEMMigSanityChecks),
> +        VMSTATE_UINT64(region_size, VirtIOMEMMigSanityChecks),
> +        VMSTATE_UINT64(block_size, VirtIOMEMMigSanityChecks),
> +        VMSTATE_UINT32(node, VirtIOMEMMigSanityChecks),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static const VMStateDescription vmstate_virtio_mem_device = {
>      .name = "virtio-mem-device",
>      .minimum_version_id = 1,
>      .version_id = 1,
>      .post_load = virtio_mem_post_load,
>      .fields = (VMStateField[]) {
> +        VMSTATE_WITH_TMP(VirtIOMEM, VirtIOMEMMigSanityChecks,
> +                         vmstate_virtio_mem_sanity_checks),
>          VMSTATE_UINT64(usable_region_size, VirtIOMEM),
>          VMSTATE_UINT64(size, VirtIOMEM),
>          VMSTATE_UINT64(requested_size, VirtIOMEM),
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


