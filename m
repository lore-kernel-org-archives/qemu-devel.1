Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289B8207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ZEkI2dbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289B8207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbW9Z-0007Is-Ad
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbW0I-0007qG-0o; Wed, 20 May 2020 17:11:54 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbW0E-0003aq-E0; Wed, 20 May 2020 17:11:52 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E36702E151E;
 Thu, 21 May 2020 00:11:45 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 0FwMMYy3KN-Bc2C3Bko; Thu, 21 May 2020 00:11:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590009105; bh=ZJ/2xnlvxbB7KkkvonhfKBWzdwXe0KVo1aYpQRPc4/Y=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=ZEkI2dbCXMlYww1i+eMRjUjbxSV5BkQe3Ob8KupbyGM0kH8iCHXI37SPF4QhO2OT3
 kMvHRk2KxKVkY9/ocPRjGroxTIivFB0t0gMmHGaBNC/ZuUOE0ciEp6Xnk5HXaQv9l3
 RQF/bjutvMP15F41KVVoKkF+gxTNADCf6yGvgyLA=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:407::1:16])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 T6LJedDmC5-BcX4GqZq; Thu, 21 May 2020 00:11:38 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Thu, 21 May 2020 00:11:36 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 1/3] virtio-blk: store opt_io_size with correct size
Message-ID: <20200520211136.GB104207@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-2-rvkagan@yandex-team.ru>
 <20200520064125-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520064125-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=5.45.199.163; envelope-from=rvkagan@yandex-team.ru;
 helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 17:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 06:44:44AM -0400, Michael S. Tsirkin wrote:
> On Wed, May 20, 2020 at 11:06:55AM +0300, Roman Kagan wrote:
> > The width of opt_io_size in virtio_blk_topology is 32bit.
> > 
> > Use the appropriate accessor to store it.
> > 
> > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> 
> 
> Thanks for the patch!
> Could you add a bit of analysis - when does this cause
> bugs? I'm guessing on BE systems with legacy virtio, right?

I guess so too.  It was found just by eye inspection, trying to figure
out the potential truncation of opt_io_size in virtio-blk and why it's
different from scsi.  I don't have any analysis to add :(

> Also, should we convert virtio_stw_p and friends to get the
> pointer to the correct value type, as opposed to void *?

I dunno.  I guess they were designed to be used with untyped buffers and
modeled after virtio_{st,ld}*_phys.  The same question applies to the
underlying {st,ld}_{b,l}e_p.

> This will catch bugs like this ...

I'll try and see if this change doesn't cause too much churn / pain.
But I suggest to decouple it from the simple patch at hand.

Thanks,
Roman.

> > ---
> > v4: new patch
> > 
> >  hw/block/virtio-blk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index f5f6fc925e..413083e62f 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -918,7 +918,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
> >      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
> >      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
> >      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
> > -    virtio_stw_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_size);
> > +    virtio_stl_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_size);
> >      blkcfg.geometry.heads = conf->heads;
> >      /*
> >       * We must ensure that the block device capacity is a multiple of
> > -- 
> > 2.26.2
> 

