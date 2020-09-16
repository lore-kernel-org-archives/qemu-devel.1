Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44638C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710B72076C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L97ZTrMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710B72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIRwX-0003GW-A5
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIRvm-0002dv-A0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIRvk-0007LJ-9O
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600241558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGvPBEo4zD5NZfEA6gJvov6sfZ5lqOn4xnIjNdFaZbY=;
 b=L97ZTrMj46VpakskjbbokXI+rTa51yl0jwoIl4JG7w5HIGpbk54biz6Iw12cpCtGyiPlCV
 5AIvBHUMNyupDhFcsbGQQUeALo/kL6YNFGudSahnDZr+WCW7MGm1OnTu3wH/cUflEHcxcw
 gS2p4n8apBsElcX/UbjTwx5RCeXKRyY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-JlaMwr0SOUOLmO56b-1dNw-1; Wed, 16 Sep 2020 03:32:35 -0400
X-MC-Unique: JlaMwr0SOUOLmO56b-1dNw-1
Received: by mail-wr1-f71.google.com with SMTP id l9so2177985wrq.20
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 00:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CGvPBEo4zD5NZfEA6gJvov6sfZ5lqOn4xnIjNdFaZbY=;
 b=ZNE/+M2VdgV3oqxjqko6yIYLc+6Ll2T+d2HFwSLcXrjtRnKYvc1TyksKCdc0ya/OlF
 VzJD8/ZVLw+Rn4+BDZV3zIykWIYXwEMeu/envuXWIE0N0KupKL3OLeHqjZ7BKZC92pK5
 i27lWy9lS619Hu6HPMR6raRpkEsBK9BDzXHEXWY3QJGgtx33OgkpSTRZqc9tC0Va77/h
 Yi3+epNlcEMVQHs4eUzO/LlS/9c5awGqF3tNRNJjG2c1Etmss6x662NmsgwOH6ne/28Z
 ecdIp9E2rVxU9C+NpRkoUiNi6Dqri3uywD75y4uz8zL3bqizbOnHJD6xVfGfT/twRayY
 F/LQ==
X-Gm-Message-State: AOAM533cdF6Q4+P6/B7a7NA71aRlQvuQ73W9wZQiHoVD5+bRHLyEL6R/
 ChiKAAOnlv8ToD+IY6SuxWRUoK0gAx4f15shM/NWMNwCvZ5+YWwgLZnKM0SNjgFSQZY9/mGFPFL
 7lUBPWsEWbU6v7o0=
X-Received: by 2002:a1c:5641:: with SMTP id k62mr3368159wmb.13.1600241553442; 
 Wed, 16 Sep 2020 00:32:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtPaK6feqM8QTC5DflQPG1aMBoDRhSpLoWw8xaRYu4sb1ReEAjPZwG5J4qcvlwWLsvRtH2FQ==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr3368142wmb.13.1600241553195; 
 Wed, 16 Sep 2020 00:32:33 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id j14sm32587103wrr.66.2020.09.16.00.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 00:32:32 -0700 (PDT)
Date: Wed, 16 Sep 2020 09:32:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200916073230.tew74t5n3atgtsqa@steredhat>
References: <20200915130514.80989-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200915130514.80989-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Cc qemu-stable@nongnu.org

It was not my day... I forgot to cc stable.

Thanks,
Stefano

On Tue, Sep 15, 2020 at 03:05:14PM +0200, Stefano Garzarella wrote:
> Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
> on") added a check that returns an error if legacy support is on, but the
> device is not legacy.
> 
> Unfortunately some devices were wrongly declared legacy even if they
> were not (e.g vhost-vsock).
> 
> To avoid migration issues, we disable this error for machine types < 5.1,
> but we print a warning.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
>  - fixed Cornelia's e-mail address
> ---
>  include/hw/virtio/virtio.h |  1 +
>  hw/core/machine.c          |  1 +
>  hw/virtio/virtio.c         | 18 ++++++++++++++++--
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 807280451b..ed7cee348b 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -103,6 +103,7 @@ struct VirtIODevice
>      bool use_started;
>      bool started;
>      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
> +    bool disable_legacy_check;
>      VMChangeStateEntry *vmstate;
>      char *bus_name;
>      uint8_t device_endian;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ea26d61237..b686eab798 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -44,6 +44,7 @@ GlobalProperty hw_compat_5_0[] = {
>      { "vmport", "x-signal-unsupported-cmd", "off" },
>      { "vmport", "x-report-vmx-type", "off" },
>      { "vmport", "x-cmds-v2", "off" },
> +    { "virtio-device", "x-disable-legacy-check", "true" },
>  };
>  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
>  
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e983025217..30ccc43b8c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3287,6 +3287,8 @@ void virtio_init(VirtIODevice *vdev, const char *name,
>   */
>  bool virtio_legacy_allowed(VirtIODevice *vdev)
>  {
> +    bool ret = false;
> +
>      switch (vdev->device_id) {
>      case VIRTIO_ID_NET:
>      case VIRTIO_ID_BLOCK:
> @@ -3298,10 +3300,20 @@ bool virtio_legacy_allowed(VirtIODevice *vdev)
>      case VIRTIO_ID_9P:
>      case VIRTIO_ID_RPROC_SERIAL:
>      case VIRTIO_ID_CAIF:
> +        ret = true;
> +    }
> +
> +    /*
> +     * For backward compatibility, we allow legacy mode with old machine types
> +     * to get the migration working.
> +     */
> +    if (!ret && vdev->disable_legacy_check) {
> +        warn_report("device is modern-only, but for backward compatibility "
> +                    "legacy is allowed");
>          return true;
> -    default:
> -        return false;
>      }
> +
> +    return ret;
>  }
>  
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
> @@ -3713,6 +3725,8 @@ static Property virtio_properties[] = {
>      DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
>      DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
> +    DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
> +                     disable_legacy_check, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -- 
> 2.26.2
> 
> 


