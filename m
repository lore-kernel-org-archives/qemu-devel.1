Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9F6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ABA2087D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abkLQqNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ABA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITRl-0006s0-0v
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kITQw-00060i-R0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kITQu-0002zT-IH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600247335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wbkAh16LTqbWTqdhsGvyV/tlBLCoQLY3QMWob8WvcY=;
 b=abkLQqNZx4VTqfr9TOocN5sVoK8X4DqIdcUrZlURnx3Yth5eVQngOObO8i03i2tdOodx7U
 q2WurBsuwzgPIzeNv29uhcN2FLOe9rQ6yGG0KOHG5gnFf2T+kZq2xK56j2xZ+LWNg59kWx
 gbdBApiSWf2YVDbrsvEy8DPNh43adFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-OW6joycaPG-CBXxSk778hg-1; Wed, 16 Sep 2020 05:08:53 -0400
X-MC-Unique: OW6joycaPG-CBXxSk778hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7917ADC00;
 Wed, 16 Sep 2020 09:08:52 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54DC3614F5;
 Wed, 16 Sep 2020 09:08:51 +0000 (UTC)
Date: Wed, 16 Sep 2020 11:08:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200916110848.47395807.cohuck@redhat.com>
In-Reply-To: <20200915130514.80989-1-sgarzare@redhat.com>
References: <20200915130514.80989-1-sgarzare@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 15:05:14 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

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

Hm... not sure if we actually should add a new device property for
that. Maybe we can use a flag in the base machine type instead?

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

I don't think we should warn in the function that returns whether
legacy is allowed or not. Future code might want to call this function
for other purposes, and returning true with a warning is not that
useful for code that wants to find out whether legacy is supported for
a type in principle.

So even though it is more work, I think we should move this warning to
the code that is actively trying to fence off misconfigured devices.

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


