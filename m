Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D6C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D0220809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVe2QFSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D0220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJxxK-0006FU-Ji
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 07:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJxvr-0005hy-Ci
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJxvo-0001Em-OW
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600602899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWs8JMXyQyengKmRa2cl8VskO8imxtU7jki5DIiur3w=;
 b=TVe2QFSIJdb1ohRIkKgAYhp1LSXnJnLkBd92C0hqayDInayjLylv9FF8UE9RN5jrJ14Pmk
 C2B0wo7WrLzqqs83xZN+ZiHRYIRUzcSzjmVcuCSaZ2FOXIYcdMtB7+nZupDiEYa9H/DjqV
 5sLKU6TeyKt8ee0ugF6VjmRFXCJW3t8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-4d36K8t6MBmSQbDH-mCgOQ-1; Sun, 20 Sep 2020 07:54:54 -0400
X-MC-Unique: 4d36K8t6MBmSQbDH-mCgOQ-1
Received: by mail-wr1-f71.google.com with SMTP id y3so4511280wrl.21
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 04:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aWs8JMXyQyengKmRa2cl8VskO8imxtU7jki5DIiur3w=;
 b=qa/8ks9eGIDpaQTrAyMCIOWwKjwROwrvkXCHsSMWODTL+UjRMQ6/2zvbIIazJKvPv9
 +awoZ7rIsRtWYATNJHFLuoyBgAsgWu2Xedx5OeRZPOALkDl6AjX44mL++3enCz8tWxAN
 ZnAw5j+/EDjvk1EE23d6D6gmlqY/gP6ZIg9yXIgozPTfIr0icMVTZ3zDhMMf3XFO5tsT
 Iy8EURCyO257XrSCfjXws7236V1JP5kLVoGbksl87zUlnW9qB9y8wfVI/yKa9wzC1r8c
 nJHZy7W5ULnbKP9qU27tUedHmrxqe5B9S1FFEnWetPxOlRHgnfbQXDyP9EzsIwT6qejU
 m0kg==
X-Gm-Message-State: AOAM533jYzX622qQaoDyu9HMg9Cwrwe5FEMwYO5XFpHExHhBe6asflh0
 82q/IrB2BFbJwpyAS2GhE5ZP6TrlzbW7zE9K9gp5D9d7N+4U3M8ezrdw9OHuZV6CXXtQrbQGqQy
 hOSk6GFosx6kql6Q=
X-Received: by 2002:a1c:6607:: with SMTP id a7mr24719979wmc.142.1600602892929; 
 Sun, 20 Sep 2020 04:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYZilzpSmXoWxzDORfC7movIrfyEymXrjWErWrN+t/HHi9U21dnPCEbz60+UoQOsWvQScwAQ==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr24719971wmc.142.1600602892695; 
 Sun, 20 Sep 2020 04:54:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:458b:b280:cf0:4acf?
 ([2001:b07:6468:f312:458b:b280:cf0:4acf])
 by smtp.gmail.com with ESMTPSA id a20sm13848349wmm.40.2020.09.20.04.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 04:54:51 -0700 (PDT)
Subject: Re: [PATCH] virtio: update MemoryRegionCaches when guest set bad
 features
To: Li Qiang <liq3ea@163.com>, mst@redhat.com
References: <20200919082706.6703-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bef7a8fa-d156-4ee1-0019-29b095a36c35@redhat.com>
Date: Sun, 20 Sep 2020 13:54:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919082706.6703-1-liq3ea@163.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 07:54:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/20 10:27, Li Qiang wrote:
> Current the 'virtio_set_features' only update the 'MemorRegionCaches'
> when the 'virtio_set_features_nocheck' return '0' which means it is
> not bad features. However the guest can still trigger the access of the
> used vring after set bad features. In this situation it will cause assert
> failure in 'ADDRESS_SPACE_ST_CACHED'.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890333
> Fixes: db812c4073c7 ("virtio: update MemoryRegionCaches when guest negotiates features")
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/virtio/virtio.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e983025217..4441ae5ed4 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2963,17 +2963,16 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>          return -EINVAL;
>      }
>      ret = virtio_set_features_nocheck(vdev, val);
> -    if (!ret) {
> -        if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> -            /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> -            int i;
> -            for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> -                if (vdev->vq[i].vring.num != 0) {
> -                    virtio_init_region_cache(vdev, i);
> -                }
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> +        int i;
> +        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> +            if (vdev->vq[i].vring.num != 0) {
> +                virtio_init_region_cache(vdev, i);
>              }
>          }
> -
> +    }
> +    if (!ret) {
>          if (!virtio_device_started(vdev, vdev->status) &&
>              !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>              vdev->start_on_kick = true;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


