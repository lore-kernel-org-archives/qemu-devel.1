Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD46C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65DC20724
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XiSuRkdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65DC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRuTh-0005OQ-Qv
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 05:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRuSt-0004jX-SX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRuSr-0002Pb-1g
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:17:42 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:36922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jRuSq-0001qx-1s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:17:40 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id EB93F2E14BF;
 Fri, 24 Apr 2020 12:17:33 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 EsPqODlHlv-HXJivddQ; Fri, 24 Apr 2020 12:17:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587719853; bh=XU4fHCFtKtGmLcPf2XoPH/vVRDBJ0ZgW6CkboFo28lw=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=XiSuRkdPWUv6qY0ATsoLcpuMcTtunN9FBjDn0M3l7Me4g/taYszySa8uypmCgoW8U
 LL5NR5eyqkPkmhirJtSbyfd+jyO6bMxzM3zNShQjMziGi+jovVLG5XlgMo4c0jX3Hq
 ptbnihuvnksA9twomUqWHyMBN1/vLkbFxnPB5DrY=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7407::1:15])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 G5QcZMsm6w-HWXqfKF0; Fri, 24 Apr 2020 12:17:32 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Fri, 24 Apr 2020 12:17:31 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [RFC PATCH v1 5/7] vhost-user-blk: add mechanism to track the
 guest notifiers init state
Message-ID: <20200424091723.GA15344@dimastep-nix>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
 <4bd32763095d015bc83f1f11a871d3a8e7b36e01.1587667007.git.dimastep@yandex-team.ru>
 <20200422161750.GC31091@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422161750.GC31091@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:6b8:0:1619::183
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

On Wed, Apr 22, 2020 at 12:17:50PM -0400, Raphael Norwitz wrote:
> There are some problems with this patch. It doesn't apply cleanly.
> 
> Are you sure you’re developing on an up to date master branch?
> 
> On Thu, Apr 23, 2020 at 09:39:36PM +0300, Dima Stepanov wrote:
> > 
> > In case of the vhost-user devices the daemon can be killed at any
> > moment. Since QEMU supports the reconnet functionality the guest
> > notifiers should be reset and disabled after "disconnect" event. The
> > most issues were found if the "disconnect" event happened during vhost
> > device initialization step.
> > The disconnect event leads to the call of the vhost_dev_cleanup()
> > routine. Which memset to 0 a vhost device structure. Because of this, if
> > device was not started (dev.started == false) and the connection is
> > broken, then the set_guest_notifier method will produce assertion error.
> > Also connection can be broken after the dev.started field is set to
> > true.
> > A new notifiers_set field is added to the vhost_dev structure to track
> > the state of the guest notifiers during the initialization process.
> > 
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  hw/block/vhost-user-blk.c |  8 ++++----
> >  hw/virtio/vhost.c         | 11 +++++++++++
> >  include/hw/virtio/vhost.h |  1 +
> >  3 files changed, 16 insertions(+), 4 deletions(-)
> > 
> >  @@ -1417,6 +1422,8 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
> 
> I can’t find the function vhost_dev_drop_guest_notifiers() in
> /hw/virtio/vhost.c, or anywhere in the codebase.
> 
> Where does this code come from?

These wrapper functions were introduced in this patch set with the
previous patch:
  [RFC PATCH v1 4/7] vhost: introduce wrappers to set guest notifiers for
virtio device
The problem was found in the vhost-user-blk stack. But it seems to me
that it is the same for all vhost-user devices. That is why i've tried
to suggest solution which will resolve other vhost-user devices, too.
And this was the reason to add new wrappers.

> 
> >          virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
> >      }
> >      virtio_device_release_ioeventfd(vdev);
> > +
> > +    hdev->notifiers_set = false;
> >  }
> >  
> >  /*
> > @@ -1449,6 +1456,10 @@ int vhost_dev_drop_guest_notifiers(struct vhost_dev *hdev,
> >      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> >      int ret;
> >  
> > +    if (!hdev->notifiers_set) {
> > +        return 0;
> > +    }
> > +
> >      ret = k->set_guest_notifiers(qbus->parent, nvqs, false);
> >      if (ret < 0) {
> >          error_report("Error reset guest notifier: %d", -ret);
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 4d0d2e2..e3711a7 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -90,6 +90,7 @@ struct vhost_dev {
> >      QLIST_HEAD(, vhost_iommu) iommu_list;
> >      IOMMUNotifier n;
> >      const VhostDevConfigOps *config_ops;
> > +    bool notifiers_set;
> >  };
> >  
> >  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> > -- 
> > 2.7.4
> > 
> > 

