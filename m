Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79B7C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC1B24656
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC1B24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iffgD-0002su-Iv
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 02:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ifffS-0002Qy-3B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ifffQ-0000PH-07
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:47:17 -0500
Received: from [192.146.154.1] (port=54921 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ifffP-0000LM-NU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:47:15 -0500
Received: from raphael-norwitz.user.nutanix.com
 (raphael-norwitz.dev.nutanix.com [10.41.25.241])
 by mcp01.nutanix.com (Postfix) with ESMTP id EE42E1007E2A;
 Fri, 13 Dec 2019 07:47:13 +0000 (UTC)
Date: Thu, 12 Dec 2019 23:47:13 -0800
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] vhost-user: add VHOST_USER_RESET_DEVICE to reset
 devices
Message-ID: <20191213074713.GA40566@raphael-norwitz.user.nutanix.com>
References: <1572385083-5254-1-git-send-email-raphael.norwitz@nutanix.com>
 <1572385083-5254-2-git-send-email-raphael.norwitz@nutanix.com>
 <20191106063525-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106063525-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
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

On Wed, Nov 06, 2019 at 06:36:01AM -0500, Michael S. Tsirkin wrote:
> 
> On Tue, Oct 29, 2019 at 05:38:02PM -0400, Raphael Norwitz wrote:
> > Add a VHOST_USER_RESET_DEVICE message which will reset the vhost user
> > backend. Disabling all rings, and resetting all internal state, ready
> > for the backend to be reinitialized.
> > 
> > A backend has to report it supports this features with the
> > VHOST_USER_PROTOCOL_F_RESET_DEVICE protocol feature bit. If it does
> > so, the new message is used instead of sending a RESET_OWNER which has
> > had inconsistent implementations.
> > 
> > Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
> > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Ping on this. 

> 
> Looks ok, pls ping me after the release to apply this.
> > ---
> >  docs/interop/vhost-user.rst | 15 +++++++++++++++
> >  hw/virtio/vhost-user.c      |  8 +++++++-
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 7827b71..d213d4a 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -785,6 +785,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
> >    #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
> >    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
> > +  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
> >  
> >  Master message types
> >  --------------------
> > @@ -1190,6 +1191,20 @@ Master message types
> >    ancillary data. The GPU protocol is used to inform the master of
> >    rendering state and updates. See vhost-user-gpu.rst for details.
> >  
> > +``VHOST_USER_RESET_DEVICE``
> > +  :id: 34
> > +  :equivalent ioctl: N/A
> > +  :master payload: N/A
> > +  :slave payload: N/A
> > +
> > +  Ask the vhost user backend to disable all rings and reset all
> > +  internal device state to the initial state, ready to be
> > +  reinitialized. The backend retains ownership of the device
> > +  throughout the reset operation.
> > +
> > +  Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
> > +  feature is set by the backend.
> > +
> >  Slave message types
> >  -------------------
> >  
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 02a9b25..d27a10f 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -58,6 +58,7 @@ enum VhostUserProtocolFeature {
> >      VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
> >      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
> >      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
> > +    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> >  
> > @@ -98,6 +99,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_GET_INFLIGHT_FD = 31,
> >      VHOST_USER_SET_INFLIGHT_FD = 32,
> >      VHOST_USER_GPU_SET_SOCKET = 33,
> > +    VHOST_USER_RESET_DEVICE = 34,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >  
> > @@ -890,10 +892,14 @@ static int vhost_user_set_owner(struct vhost_dev *dev)
> >  static int vhost_user_reset_device(struct vhost_dev *dev)
> >  {
> >      VhostUserMsg msg = {
> > -        .hdr.request = VHOST_USER_RESET_OWNER,
> >          .hdr.flags = VHOST_USER_VERSION,
> >      };
> >  
> > +    msg.hdr.request = virtio_has_feature(dev->protocol_features,
> > +                                         VHOST_USER_PROTOCOL_F_RESET_DEVICE)
> > +        ? VHOST_USER_RESET_DEVICE
> > +        : VHOST_USER_RESET_OWNER;
> > +
> >      if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> >          return -1;
> >      }
> > -- 
> > 1.8.3.1
> 
> 

