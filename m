Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228C8C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7381021775
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnRPf5rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7381021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY1zZ-0007DB-C8
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 03:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kY1x8-0005me-L3
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kY1x5-0001Ag-GJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603954943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LCiOkbrK+4ryCpKLa/LqV2l45XFLIjZnvH/1qu+hY0=;
 b=gnRPf5rpHWKNLjyvabElPn6MeSQBqt0xbI2iDMlfyr7I7POKTpcXctvYRG5Tf38qjDwGbC
 j6ui0AIsyL9a5CHeRAKkhOo7U1EAQHX4QV9ReqXjrSKNjIq3CBI1JKktoKHPGuZx9b2SE1
 dZdTVKrR944q1UNxcklp1T5ik9WopQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-GZfNoBqrN7GQIBSCeA8CfQ-1; Thu, 29 Oct 2020 03:02:20 -0400
X-MC-Unique: GZfNoBqrN7GQIBSCeA8CfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 929B81009E39;
 Thu, 29 Oct 2020 07:02:19 +0000 (UTC)
Received: from [10.72.12.209] (ovpn-12-209.pek2.redhat.com [10.72.12.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE74C6EF6A;
 Thu, 29 Oct 2020 07:02:08 +0000 (UTC)
Subject: Re: [PATCH v2] virtio: skip guest index check on device load
To: Felipe Franciosi <felipe@nutanix.com>, qemu-devel@nongnu.org
References: <20201028134643.110698-1-felipe@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ca52cfce-0d89-3a13-ac75-400230462a9c@redhat.com>
Date: Thu, 29 Oct 2020 15:02:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028134643.110698-1-felipe@nutanix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/28 下午9:47, Felipe Franciosi wrote:
> QEMU must be careful when loading device state off migration streams to
> prevent a malicious source from exploiting the emulator. Overdoing these
> checks has the side effect of allowing a guest to "pin itself" in cloud
> environments by messing with state which is entirely in its control.
>
> Similarly to what f3081539 achieved in usb_device_post_load(), this
> commit removes such a check from virtio_load(). Worth noting, the result
> of a load without this check is the same as if a guest enables a VQ with
> invalid indexes to begin with. That is, the virtual device is set in a
> broken state (by the datapath handler) and must be reset.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
> v2: Keep the check around for logging.
>
>   hw/virtio/virtio.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 6f8f865aff..ceb58fda6c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -17,6 +17,7 @@
>   #include "trace.h"
>   #include "exec/address-spaces.h"
>   #include "qemu/error-report.h"
> +#include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "hw/virtio/virtio.h"
> @@ -3160,12 +3161,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>               nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
>               /* Check it isn't doing strange things with descriptor numbers. */
>               if (nheads > vdev->vq[i].vring.num) {
> -                error_report("VQ %d size 0x%x Guest index 0x%x "
> -                             "inconsistent with Host index 0x%x: delta 0x%x",
> -                             i, vdev->vq[i].vring.num,
> -                             vring_avail_idx(&vdev->vq[i]),
> -                             vdev->vq[i].last_avail_idx, nheads);
> -                return -1;
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "VQ %d size 0x%x Guest index 0x%x "
> +                              "inconsistent with Host index 0x%x: delta 0x%x",
> +                              i, vdev->vq[i].vring.num,
> +                              vring_avail_idx(&vdev->vq[i]),
> +                              vdev->vq[i].last_avail_idx, nheads);
>               }
>               vdev->vq[i].used_idx = vring_used_idx(&vdev->vq[i]);
>               vdev->vq[i].shadow_avail_idx = vring_avail_idx(&vdev->vq[i]);


Acked-by: Jason Wang <jasowang@redhat.com>



