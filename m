Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6907CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315F02053B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ns4mlita"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315F02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBN8-00005x-83
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 06:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZBMJ-0007Dr-KS
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:45:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZBMI-0005vp-B5
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589453096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7pT5nTW7n2WcTR2f9gsD4VoEQG7ZR8xKGLdWojo7Bng=;
 b=Ns4mlitaZGDNp7fzlUHqY3gCN2qX7NlwqZPjU/w/OPR8L2Kd3yTzHnTPfg/eSqlCkA0i4O
 i3Yc79t2GhsLJwtracqVRyUI7KeWuLyVt9zQnSiuw02/ns7wLgZor95zfFApVHVO6TnMfN
 d2hudDxmP3WgnaV64Q7EtoVu1mHGWqA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-amJKmJ8uNl23W1Y8C06ngQ-1; Thu, 14 May 2020 06:44:54 -0400
X-MC-Unique: amJKmJ8uNl23W1Y8C06ngQ-1
Received: by mail-wm1-f71.google.com with SMTP id k17so3954826wmi.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 03:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7pT5nTW7n2WcTR2f9gsD4VoEQG7ZR8xKGLdWojo7Bng=;
 b=RU7iEnUBzvm6rjbk8k6fa0XFffeZW6ScvK4pvrz4cgr8/Wo+5d4jxFEhpA/anQ3wWb
 k573Z4LKYT6yBDn+1QnXE/Y2h7+1DzKx4oZgzssGLUXruWKPgON37YMF0f53+I3AQnJc
 C0kyU7Gv8+i2GQEDjnYa9dLzs76QmAZqjsxhaNRnGJM+YsfEWcREFKEgPtX1E3P10gSD
 oMznAPLYdyUuOQJ+N2Y96RFw0D3TK1hS3Bm0h16/PfXas33Hm/IoMJNq/oUqnKLIJSOh
 tliuLm7poDxfkY00g016S1nnaFUbY3S0fl2zIC5A619Kre0BQsFR21MgQUY9dKqAvvjz
 vnlQ==
X-Gm-Message-State: AGi0Puaofea/RLr9npIsfzAQOQnEkp9CyzPKnnmSir+IlYjiMYMKAhmf
 rKisKuB9/D3NCCgzqB52n44D9Lf1hHzJsLd59fxG8YZiyqQBemlXIJEH6ZK0xemnkUWBOkP1zKF
 JLKnfMygbZqdrwYY=
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr34648768wme.23.1589453092729; 
 Thu, 14 May 2020 03:44:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvf3nrnMw0Zfx03lS18D2hj2bQlLAHwGQFvAgZ2DSYqOJoawDxBuWdGMFJfzvxAAonT851cw==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr34648743wme.23.1589453092431; 
 Thu, 14 May 2020 03:44:52 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
 by smtp.gmail.com with ESMTPSA id t6sm15386884wma.4.2020.05.14.03.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 03:44:51 -0700 (PDT)
Date: Thu, 14 May 2020 06:44:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] vhost-user: add support for VHOST_USER_SET_STATUS
Message-ID: <20200514064306-mutt-send-email-mst@kernel.org>
References: <20200514073332.1434576-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514073332.1434576-1-maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: shahafs@mellanox.com, lulu@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, amorenoz@redhat.com, matan@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 14, 2020 at 09:33:32AM +0200, Maxime Coquelin wrote:
> It is usefull for the Vhost-user backend to know
> about about the Virtio device status updates,
> especially when the driver sets the DRIVER_OK bit.
> 
> With that information, no more need to do hazardous
> assumptions on when the driver is done with the
> device configuration.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> 
> This patch applies on top of Cindy's "vDPA support in qemu"
> series, which introduces the .vhost_set_state vhost-backend
> ops.
> 
>  docs/interop/vhost-user.rst | 12 ++++++++++++
>  hw/net/vhost_net.c          | 10 +++++-----
>  hw/virtio/vhost-user.c      | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 3b1b6602c7..f108de7458 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -815,6 +815,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
>    #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
> +  #define VHOST_USER_PROTOCOL_F_STATUS               15
>  
>  Master message types
>  --------------------
> @@ -1263,6 +1264,17 @@ Master message types
>  
>    The state.num field is currently reserved and must be set to 0.
>  
> +``VHOST_USER_SET_STATUS``
> +  :id: 36
> +  :equivalent ioctl: VHOST_VDPA_SET_STATUS
> +  :slave payload: N/A
> +  :master payload: ``u64``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
> +  successfully negotiated, this message is submitted by the master to
> +  notify the backend with updated device status as defined in the Virtio
> +  specification.
> +
>  Slave message types
>  -------------------
>  
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 463e333531..37f3156dbc 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -517,10 +517,10 @@ int vhost_set_state(NetClientState *nc, int state)
>  {
>      struct vhost_net *net = get_vhost_net(nc);
>      struct vhost_dev *hdev = &net->dev;
> -    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> -        if (hdev->vhost_ops->vhost_set_state) {
> -                return hdev->vhost_ops->vhost_set_state(hdev, state);
> -             }
> -        }
> +
> +    if (hdev->vhost_ops->vhost_set_state) {
> +        return hdev->vhost_ops->vhost_set_state(hdev, state);
> +    }
> +
>      return 0;
>  }
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ec21e8fbe8..b7e52d97fc 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -59,6 +59,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
>      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
>      VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
> +    VHOST_USER_PROTOCOL_F_STATUS = 15,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>  
> @@ -100,6 +101,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_INFLIGHT_FD = 32,
>      VHOST_USER_GPU_SET_SOCKET = 33,
>      VHOST_USER_RESET_DEVICE = 34,
> +    VHOST_USER_SET_STATUS = 36,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
> @@ -1886,6 +1888,38 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
>      return 0;
>  }
>  
> +static int vhost_user_set_state(struct vhost_dev *dev, int state)
> +{
> +    bool reply_supported = virtio_has_feature(dev->protocol_features,
> +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
> +
> +    VhostUserMsg msg = {
> +        .hdr.request = VHOST_USER_SET_STATUS,
> +        .hdr.flags = VHOST_USER_VERSION,
> +        .hdr.size = sizeof(msg.payload.u64),
> +        .payload.u64 = (uint64_t)state,
> +    };
> +
> +    if (!virtio_has_feature(dev->protocol_features,
> +                VHOST_USER_PROTOCOL_F_STATUS)) {
> +        return -1;
> +    }
> +
> +    if (reply_supported) {
> +        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        return -1;
> +    }
> +
> +    if (reply_supported) {
> +        return process_message_reply(dev, &msg);
> +    }

So since we are doing this anyway, let's give backend the
opportunity to validate features and fail FEATURES_OK?



> +
> +    return 0;
> +}
> +
>  bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
>  {
>      if (user->chr) {
> @@ -1947,4 +1981,5 @@ const VhostOps user_ops = {
>          .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
>          .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
>          .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
> +        .vhost_set_state = vhost_user_set_state,
>  };
> -- 
> 2.25.4


