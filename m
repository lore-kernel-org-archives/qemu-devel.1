Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B55C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D662A206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuA5B2az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D662A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEpl-0004KQ-02
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZEj9-0000t0-8c
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:20:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZEj8-0005Bo-1Z
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n3ReUXe3/N3pAU6Mq1dwHEVnxl+HPk1CckhRDj7qnWM=;
 b=XuA5B2azB59KPpoBVYGUFx2OU76rsK1rz0tvRHcBZAy767keq4GgTb3WoAbJa+/ybF/0hq
 FzHgkxQ+ShC41KaejAq+82GN5y90hd3H7eIlVio1rFLShT7xqlGhj+eRbjKQGlNIftJwbp
 K8FHfmOlm9C9rJlQVMmpkDmZGvfsYKE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-CYNDu_hNMGq95hZjMlVVUQ-1; Thu, 14 May 2020 10:20:40 -0400
X-MC-Unique: CYNDu_hNMGq95hZjMlVVUQ-1
Received: by mail-wm1-f71.google.com with SMTP id h6so13576479wmi.7
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n3ReUXe3/N3pAU6Mq1dwHEVnxl+HPk1CckhRDj7qnWM=;
 b=htD+OUIApsge1OFjTe8YDeqqTv957F62S+Na6dVhPzR6DGuDBHxH39AWFyLSMFDUpY
 zatahlYYTlQC9YSljWa/vDO+mcM2bbpnbsEix5r90p4j7rszhOMFYDrs/jNGpVTAAsUi
 xoyy6mrS1+/tWdPSXNJ5oI3KWAZHZHELYpM/HBAs548+IGOaDpVM7oymL1wjlE2U1y4v
 o4lc8ZhHcfOxOIJFFPuRuwhV+ocsNdfYC5aMqEl5ujuHSAEg/AleATvgm+SICgE8sVDC
 6ugrEDv4CD+0YOJK1Y3ZPm5Z2eowtqddfZ2ooxTjLCF34+qgYq7A1UIi/vg7d3uIrWd+
 UsgQ==
X-Gm-Message-State: AOAM5315KdN6amXSI+X8QEFo0Q7Oz0ZvCABeJFsVy3B2Ov0xMD17pnUu
 vHWoukWRtWAunbaJy7lfO3hQbt4HyzkVaLQb+0abxSQtmoNARvvQoyWuuBSmRBn4OxDiy38ufK4
 GVja0u/5kIrWvGGI=
X-Received: by 2002:adf:d0c6:: with SMTP id z6mr6151915wrh.219.1589466037131; 
 Thu, 14 May 2020 07:20:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfoI3gGJcekACwjbFV2EStazbw5ynhUr9hX2B0UIAIItO5xPUxmdz1F9qM7HNFTxHlvQoE7A==
X-Received: by 2002:adf:d0c6:: with SMTP id z6mr6151895wrh.219.1589466036846; 
 Thu, 14 May 2020 07:20:36 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
 by smtp.gmail.com with ESMTPSA id x24sm4462565wrd.51.2020.05.14.07.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:20:36 -0700 (PDT)
Date: Thu, 14 May 2020 10:20:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] vhost-user: add support for VHOST_USER_SET_STATUS
Message-ID: <20200514101732-mutt-send-email-mst@kernel.org>
References: <20200514073332.1434576-1-maxime.coquelin@redhat.com>
 <20200514064306-mutt-send-email-mst@kernel.org>
 <f6d6d746-813a-d3b8-1876-450f8e35d9a8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f6d6d746-813a-d3b8-1876-450f8e35d9a8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On Thu, May 14, 2020 at 04:12:32PM +0200, Maxime Coquelin wrote:
> 
> 
> 
> On 5/14/20 12:44 PM, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2020 at 09:33:32AM +0200, Maxime Coquelin wrote:
> >> It is usefull for the Vhost-user backend to know
> >> about about the Virtio device status updates,
> >> especially when the driver sets the DRIVER_OK bit.
> >>
> >> With that information, no more need to do hazardous
> >> assumptions on when the driver is done with the
> >> device configuration.
> >>
> >> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >> ---
> >>
> >> This patch applies on top of Cindy's "vDPA support in qemu"
> >> series, which introduces the .vhost_set_state vhost-backend
> >> ops.
> >>
> >>  docs/interop/vhost-user.rst | 12 ++++++++++++
> >>  hw/net/vhost_net.c          | 10 +++++-----
> >>  hw/virtio/vhost-user.c      | 35 +++++++++++++++++++++++++++++++++++
> >>  3 files changed, 52 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >> index 3b1b6602c7..f108de7458 100644
> >> --- a/docs/interop/vhost-user.rst
> >> +++ b/docs/interop/vhost-user.rst
> >> @@ -815,6 +815,7 @@ Protocol features
> >>    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
> >>    #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
> >>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
> >> +  #define VHOST_USER_PROTOCOL_F_STATUS               15
> >>  
> >>  Master message types
> >>  --------------------
> >> @@ -1263,6 +1264,17 @@ Master message types
> >>  
> >>    The state.num field is currently reserved and must be set to 0.
> >>  
> >> +``VHOST_USER_SET_STATUS``
> >> +  :id: 36
> >> +  :equivalent ioctl: VHOST_VDPA_SET_STATUS
> >> +  :slave payload: N/A
> >> +  :master payload: ``u64``
> >> +
> >> +  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
> >> +  successfully negotiated, this message is submitted by the master to
> >> +  notify the backend with updated device status as defined in the Virtio
> >> +  specification.
> >> +
> >>  Slave message types
> >>  -------------------
> >>  
> >> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> >> index 463e333531..37f3156dbc 100644
> >> --- a/hw/net/vhost_net.c
> >> +++ b/hw/net/vhost_net.c
> >> @@ -517,10 +517,10 @@ int vhost_set_state(NetClientState *nc, int state)
> >>  {
> >>      struct vhost_net *net = get_vhost_net(nc);
> >>      struct vhost_dev *hdev = &net->dev;
> >> -    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> >> -        if (hdev->vhost_ops->vhost_set_state) {
> >> -                return hdev->vhost_ops->vhost_set_state(hdev, state);
> >> -             }
> >> -        }
> >> +
> >> +    if (hdev->vhost_ops->vhost_set_state) {
> >> +        return hdev->vhost_ops->vhost_set_state(hdev, state);
> >> +    }
> >> +
> >>      return 0;
> >>  }
> >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> index ec21e8fbe8..b7e52d97fc 100644
> >> --- a/hw/virtio/vhost-user.c
> >> +++ b/hw/virtio/vhost-user.c
> >> @@ -59,6 +59,7 @@ enum VhostUserProtocolFeature {
> >>      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
> >>      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
> >>      VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
> >> +    VHOST_USER_PROTOCOL_F_STATUS = 15,
> >>      VHOST_USER_PROTOCOL_F_MAX
> >>  };
> >>  
> >> @@ -100,6 +101,7 @@ typedef enum VhostUserRequest {
> >>      VHOST_USER_SET_INFLIGHT_FD = 32,
> >>      VHOST_USER_GPU_SET_SOCKET = 33,
> >>      VHOST_USER_RESET_DEVICE = 34,
> >> +    VHOST_USER_SET_STATUS = 36,
> >>      VHOST_USER_MAX
> >>  } VhostUserRequest;
> >>  
> >> @@ -1886,6 +1888,38 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
> >>      return 0;
> >>  }
> >>  
> >> +static int vhost_user_set_state(struct vhost_dev *dev, int state)
> >> +{
> >> +    bool reply_supported = virtio_has_feature(dev->protocol_features,
> >> +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
> >> +
> >> +    VhostUserMsg msg = {
> >> +        .hdr.request = VHOST_USER_SET_STATUS,
> >> +        .hdr.flags = VHOST_USER_VERSION,
> >> +        .hdr.size = sizeof(msg.payload.u64),
> >> +        .payload.u64 = (uint64_t)state,
> >> +    };
> >> +
> >> +    if (!virtio_has_feature(dev->protocol_features,
> >> +                VHOST_USER_PROTOCOL_F_STATUS)) {
> >> +        return -1;
> >> +    }
> >> +
> >> +    if (reply_supported) {
> >> +        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> >> +    }
> >> +
> >> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> >> +        return -1;
> >> +    }
> >> +
> >> +    if (reply_supported) {
> >> +        return process_message_reply(dev, &msg);
> >> +    }
> > 
> > So since we are doing this anyway, let's give backend the opportunity
> > to validate features and fail FEATURES_OK?
> 
> Just to be sure I understand, the feature negotiation happens,
> then when the backend receives FEATURES_OK, it uses the REPLY_ACK
> protocol feature to NACK?

Or ack but clear FEATURES_OK in the response.

> 
> In DPDK backend, we already check the feature set by SET_FEATURES are
> supported by the backend.

But that assumes all possible combinations of features in the bitmap
always work. That might not be the case.

> If it is not the case, either the master did
> set NEED_REPLY flag and error would be reported to the master, or the
> NEED_REPLY flag isn't set in the message and the backend disconnects.
> 
> Looking at Qemu side, it does not seem to set the NEED_REPLY flag on
> SET_FEATURES, so basically the backend close the sockets if it happened.

That is not the best ay to handle that imho.

> 
> I wonder whether it would be better for Qemu to set the NEED_REPLY flag
> on SET_FEATURES, so that when the backend is running and VHOST_F_LOG_ALL
> feature bit is set, we are the sure the master starts the live-migration
> only once the SET_FEATURES is fully handled on backend side.
> 
> What do you think?

features are set before backend is started so there's nothing to
migrate really.

> 
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
> >>  {
> >>      if (user->chr) {
> >> @@ -1947,4 +1981,5 @@ const VhostOps user_ops = {
> >>          .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
> >>          .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
> >>          .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
> >> +        .vhost_set_state = vhost_user_set_state,
> >>  };
> >> -- 
> >> 2.25.4
> > 


