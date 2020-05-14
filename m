Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72004C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288D420657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KH6wA6bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288D420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFUA-0008U5-5y
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZFA8-000271-1c
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:48:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZFA6-0003gX-LW
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589467717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imtP1xe7M/PDqZTnyzKNtYEVsK1ctI2D/xE0IoyipfU=;
 b=KH6wA6bbKaS1a3fk8yHk1H1797hNxsSEF35wwSh7Lfjza2IzzBG8bInChaEoNPfvAwEynQ
 aMUCahyYKeIbHzX8zI9ruDE2HbkaKFSitNkyN2YFMyzAwlyPUmTV0dMwmZebyWMTcgy43+
 Tlm4K+1Ri2WoQJV2ZFZxHDvFRtrEIms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-slrPq8U-OEufVkHGkSCVxg-1; Thu, 14 May 2020 10:48:36 -0400
X-MC-Unique: slrPq8U-OEufVkHGkSCVxg-1
Received: by mail-wm1-f69.google.com with SMTP id t23so3993833wmi.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=imtP1xe7M/PDqZTnyzKNtYEVsK1ctI2D/xE0IoyipfU=;
 b=NwHIvqWQIu5ic1r1/gCFAxPlXQCmQq/nz9K3oB/2KKao9wpcQ4Vs/26NPq84vFjLNP
 sWwQj6yVRIV19U2HyZLhoHcZduBbpi/7BmSHLEtU7nPZRiESoHHj346gfsUxgqbD8qxg
 Wwry5QNzQ8Y0+w37yeeacUciTlHvFoWi8/q2mL/FK06K0r+RKKxSMCdPZ1Bt8RVM99Ij
 jyri4rhy05Y1YtFc62gNKLjkXTGxlcA07VntXNdBAEub5yO4HJLhRcze7zZtwvC3evi4
 vNBWX2HSC+wvjNtb8rh76wlL9ls9iSP0Qz17JkAtS+in+zf6HnNC83oy+r1aKp6qwvQP
 OHCQ==
X-Gm-Message-State: AOAM533e6y/25iSE3Zu7CkQ9FTsadADy/P/iwM0aYp2RibGVfMtbCraa
 +1vsCDhrJL6HXqgMkTgUZnP/Df8MJIZyTyqmvcqI7vi6UOS9mu7Qm4nrQtLb1lxOQMzN8B8tDk7
 1Y0kCBLP5pKaVwAQ=
X-Received: by 2002:adf:f512:: with SMTP id q18mr6301836wro.38.1589467714537; 
 Thu, 14 May 2020 07:48:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7pcoFIEEtwpC0CLEwQyShMThHMJmrqRBG72uvE/j8+N02OMarGRZee+Vj7ATx9g56MwZpRQ==
X-Received: by 2002:adf:f512:: with SMTP id q18mr6301807wro.38.1589467714222; 
 Thu, 14 May 2020 07:48:34 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
 by smtp.gmail.com with ESMTPSA id l19sm40956159wmj.14.2020.05.14.07.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:48:33 -0700 (PDT)
Date: Thu, 14 May 2020 10:48:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] vhost-user: add support for VHOST_USER_SET_STATUS
Message-ID: <20200514104455-mutt-send-email-mst@kernel.org>
References: <20200514073332.1434576-1-maxime.coquelin@redhat.com>
 <33dae8af-a7ee-e005-f8d5-2b4a038b8211@redhat.com>
 <670d4623-fba9-dba6-8eea-2f1c16f2ad4b@redhat.com>
 <20200514064721-mutt-send-email-mst@kernel.org>
 <b915c324-2e07-9149-e527-2be8087f8b06@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b915c324-2e07-9149-e527-2be8087f8b06@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: shahafs@mellanox.com, lulu@redhat.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, amorenoz@redhat.com, matan@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 14, 2020 at 04:39:26PM +0200, Maxime Coquelin wrote:
> 
> 
> On 5/14/20 12:51 PM, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2020 at 12:14:32PM +0200, Maxime Coquelin wrote:
> >>
> >>
> >> On 5/14/20 9:53 AM, Jason Wang wrote:
> >>>
> >>> On 2020/5/14 下午3:33, Maxime Coquelin wrote:
> >>>> It is usefull for the Vhost-user backend to know
> >>>> about about the Virtio device status updates,
> >>>> especially when the driver sets the DRIVER_OK bit.
> >>>>
> >>>> With that information, no more need to do hazardous
> >>>> assumptions on when the driver is done with the
> >>>> device configuration.
> >>>>
> >>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >>>> ---
> >>>>
> >>>> This patch applies on top of Cindy's "vDPA support in qemu"
> >>>> series, which introduces the .vhost_set_state vhost-backend
> >>>> ops.
> >>>>
> >>>>   docs/interop/vhost-user.rst | 12 ++++++++++++
> >>>>   hw/net/vhost_net.c          | 10 +++++-----
> >>>>   hw/virtio/vhost-user.c      | 35 +++++++++++++++++++++++++++++++++++
> >>>>   3 files changed, 52 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >>>> index 3b1b6602c7..f108de7458 100644
> >>>> --- a/docs/interop/vhost-user.rst
> >>>> +++ b/docs/interop/vhost-user.rst
> >>>> @@ -815,6 +815,7 @@ Protocol features
> >>>>     #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
> >>>>     #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
> >>>>     #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
> >>>> +  #define VHOST_USER_PROTOCOL_F_STATUS               15
> >>>>     Master message types
> >>>>   --------------------
> >>>> @@ -1263,6 +1264,17 @@ Master message types
> >>>>       The state.num field is currently reserved and must be set to 0.
> >>>>   +``VHOST_USER_SET_STATUS``
> >>>> +  :id: 36
> >>>> +  :equivalent ioctl: VHOST_VDPA_SET_STATUS
> >>>> +  :slave payload: N/A
> >>>> +  :master payload: ``u64``
> >>>> +
> >>>> +  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
> >>>> +  successfully negotiated, this message is submitted by the master to
> >>>> +  notify the backend with updated device status as defined in the Virtio
> >>>> +  specification.
> >>>> +
> >>>>   Slave message types
> >>>>   -------------------
> >>>>   diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> >>>> index 463e333531..37f3156dbc 100644
> >>>> --- a/hw/net/vhost_net.c
> >>>> +++ b/hw/net/vhost_net.c
> >>>> @@ -517,10 +517,10 @@ int vhost_set_state(NetClientState *nc, int state)
> >>>>   {
> >>>>       struct vhost_net *net = get_vhost_net(nc);
> >>>>       struct vhost_dev *hdev = &net->dev;
> >>>> -    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> >>>> -        if (hdev->vhost_ops->vhost_set_state) {
> >>>> -                return hdev->vhost_ops->vhost_set_state(hdev, state);
> >>>> -             }
> >>>> -        }
> >>>> +
> >>>> +    if (hdev->vhost_ops->vhost_set_state) {
> >>>> +        return hdev->vhost_ops->vhost_set_state(hdev, state);
> >>>> +    }
> >>>> +
> >>>>       return 0;
> >>>>   }
> >>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >>>> index ec21e8fbe8..b7e52d97fc 100644
> >>>> --- a/hw/virtio/vhost-user.c
> >>>> +++ b/hw/virtio/vhost-user.c
> >>>> @@ -59,6 +59,7 @@ enum VhostUserProtocolFeature {
> >>>>       VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
> >>>>       VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
> >>>>       VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
> >>>> +    VHOST_USER_PROTOCOL_F_STATUS = 15,
> >>>>       VHOST_USER_PROTOCOL_F_MAX
> >>>>   };
> >>>>   @@ -100,6 +101,7 @@ typedef enum VhostUserRequest {
> >>>>       VHOST_USER_SET_INFLIGHT_FD = 32,
> >>>>       VHOST_USER_GPU_SET_SOCKET = 33,
> >>>>       VHOST_USER_RESET_DEVICE = 34,
> >>>> +    VHOST_USER_SET_STATUS = 36,
> >>>>       VHOST_USER_MAX
> >>>>   } VhostUserRequest;
> >>>>   @@ -1886,6 +1888,38 @@ static int vhost_user_set_inflight_fd(struct
> >>>> vhost_dev *dev,
> >>>>       return 0;
> >>>>   }
> >>>>   +static int vhost_user_set_state(struct vhost_dev *dev, int state)
> >>>> +{
> >>>> +    bool reply_supported = virtio_has_feature(dev->protocol_features,
> >>>> +                                             
> >>>> VHOST_USER_PROTOCOL_F_REPLY_ACK);
> >>>> +
> >>>> +    VhostUserMsg msg = {
> >>>> +        .hdr.request = VHOST_USER_SET_STATUS,
> >>>> +        .hdr.flags = VHOST_USER_VERSION,
> >>>> +        .hdr.size = sizeof(msg.payload.u64),
> >>>> +        .payload.u64 = (uint64_t)state,
> >>>> +    };
> >>>> +
> >>>> +    if (!virtio_has_feature(dev->protocol_features,
> >>>> +                VHOST_USER_PROTOCOL_F_STATUS)) {
> >>>> +        return -1;
> >>>> +    }
> >>>> +
> >>>> +    if (reply_supported) {
> >>>> +        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> >>>> +    }
> >>>> +
> >>>> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> >>>> +        return -1;
> >>>> +    }
> >>>> +
> >>>> +    if (reply_supported) {
> >>>> +        return process_message_reply(dev, &msg);
> >>>> +    }
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>
> >>>
> >>> Interesting, I wonder how vm stop will be handled in this case.
> >>
> >> For now, my DPDK series only use DRIVER_OK to help determine when the
> >> driver is done with the initialization. For VM stop, it still relies on
> >> GET_VRING_BASE.
> > 
> > Sounds like a good fit.
> > GET_VRING_BASE is transparent to guest, as is vmstop.
> > This is more for driver 
> > 
> > 
> >>
> >> GET_VRING_BASE arrives before DRIVER_OK bit is cleared is the tests I've
> >> done (logs from backend side):
> > 
> > 
> > One problem is with legacy guests, for these you can't rely
> > on DRIVER_OK, they often kick before that, and sometimes
> > expect buffers to be used too (e.g. for scsi).
> 
> Ok, I remember this case now.
> Any idea on how the backend would detect such legacy guests?

It's mostly safe to assume that it's only the case for pre-1.0 since 1.0
spec says you must not.  A small window after 1.0 has the bug too but I
think it's safe to just ask that these guests are fixed.


> If I'm not mistaken, we discussed the idea to poll on the kick to detect
> the rings are ready to be processed. But the problem is that Qemu writes
> a kick at eventfd creation time:
> 
> vhost_user_backend_start():
> -> vhost_dev_enable_notifiers()
> 	->virtio_bus_set_host_notifier()
> 		->event_notifier_init(, 1); //1 means active
> ->vhost_dev_start();
> 
> We could change the behavior in Qemu, but the backend won't know if
> Qemu has the fix or not, so won't know if it can rely on the kick.

eventfd counts kicks. So you can read the counter and check whether
there was another kick or not. The difficulty is around migration, we
should migrate the "ring kicked" state but we don't. We really should
just fix that, it's an old bug affecting not just vhost-user but
vhost too.


> >>
> >> VHOST_CONFIG: read message VHOST_USER_GET_VRING_BASE
> >>
> >> destroy port /tmp/vhost-user1, did: 0
> >> VHOST_CONFIG: vring base idx:0 file:41
> >> VHOST_CONFIG: read message VHOST_USER_GET_VRING_BASE
> >> VHOST_CONFIG: vring base idx:1 file:0
> >> VHOST_CONFIG: read message VHOST_USER_SET_STATUS
> >> VHOST_CONFIG: New device status(0x0000000b):
> >> 	-ACKNOWLEDGE: 1
> >> 	-DRIVER: 1
> >> 	-FEATURES_OK: 1
> >> 	-DRIVER_OK: 0
> >> 	-DEVICE_NEED_RESET: 0
> >> 	-FAILED: 0
> >>
> >>> In the case of vDPA kernel, we probable don't want to mirror the virtio
> >>> device status to vdpa device status directly.
> >>
> >> In vDPA DPDK, we don't mirror the Virtio device status either. It could
> >> make sense to do that, but would require some API changes.
> >>
> >>> Since qemu may stop
> >>> vhost-vdpa device through e.g resting vdpa device, but in the mean time,
> >>> guest should not detect such condition in virtio device status.
> >>
> >>
> >>
> >>> So in the new version of vDPA support, we probably need to do:
> >>>
> >>> static int vhost_vdpa_set_state(struct vhost_dev *dev, bool started)
> >>> {
> >>>     if (started) {
> >>>         uint8_t status = 0;
> >>>
> >>>         vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> >>>         vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
> >>>
> >>>         return !(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >>>     } else {
> >>>         vhost_vdpa_reset_device(dev);
> >>>         vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> >>>                                    VIRTIO_CONFIG_S_DRIVER);
> >>>         return 0;
> >>>     }
> >>> }
> >>
> >> IIUC, you have another copy of the status register not matching 1:1 what
> >> the guest sets/sees.
> >>
> >> Is vhost_vdpa_add_status() sending VHOST_VDPA_SET_STATUS to the backend?
> >>
> >> And why reading back the status from the backend? Just to confirm the
> >> change is taken into account?
> > 
> > Making sure features have been acked makes sense IMHO.
> > 
> > 
> >>> And vhost_set_state() will be called from vhost_dev_start()/stop().
> >>>
> >>> Does this work for vhost-user as well?
> >>
> >> IIUC what you did above, I think it would work. And we won't need
> >> GET_STATUS request, but just rely on the REPLY_ACK.
> > 
> > Right. Need to document that though.
> 
> Ok, will do in v2.
> 
> Thanks,
> Maxime
> 
> > 
> >>
> >> Thanks,
> >> Maxime
> >>
> >>> Thanks
> >>>
> >>>
> >>>> +
> >>>>   bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error
> >>>> **errp)
> >>>>   {
> >>>>       if (user->chr) {
> >>>> @@ -1947,4 +1981,5 @@ const VhostOps user_ops = {
> >>>>           .vhost_backend_mem_section_filter =
> >>>> vhost_user_mem_section_filter,
> >>>>           .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
> >>>>           .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
> >>>> +        .vhost_set_state = vhost_user_set_state,
> >>>>   };
> > 


