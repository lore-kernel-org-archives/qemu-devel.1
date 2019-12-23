Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B6C2D0D0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 14:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9F32075B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 14:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrlqDnWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9F32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijOfb-0003WS-St
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 09:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijOez-00031r-AP
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijOev-0005mz-Vh
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:26:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijOev-0005lH-G9
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577111166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzZmCYOc60AewkYgJ8WP25v2hGoTsqscwQU7Mnr4nQU=;
 b=DrlqDnWVKHVYLefpll2slduBC2wQtcdHNYZ9BP5WEtWmFU63U9aAel3Pf0/bBiK9To37rg
 lH90dqhnfefxE5tIIZK5aVPlHNfm2yRSrxvptmxYFYJ46Aus9hOuMu1B5GgfwCN+gP4sVR
 k2HWI1SgW6amysfI+xN7vq7huFYJdT0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-gkdgRgIjM92_paz94RggQA-1; Mon, 23 Dec 2019 09:26:04 -0500
Received: by mail-qk1-f199.google.com with SMTP id 24so11193884qka.16
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 06:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g5SC4PAXtTFqDYjydk+T8aSBBLbIGGeJPr+xT+NRa+M=;
 b=gntmz0mTfhYJeQwajUcjg4cpCzG/JeK05xlmO1FDIjHxh9JlXeVsl+COUvZFwinYRB
 RUO1UrLA3e+XueLn11pbMYd0mvN/xW/5+b8vJ2+osmH66vnCNVj42HvPe8jmHm7MlDGP
 WkkymPHzonEbfY2+pLkzRhaGtuzoBVUM61c33gAWLIZ6NFsiXWRmZS6JNE/w+GaZai4P
 JWklGJ/UvuRuZNzL1Ebo6C4TEsTEhKGDaetScDXvefJqUUEZ232ok1ksor90V3BHIN5T
 EH7LKLHOxTjhqBDFUh0DGyNSZEAQV47N9I+T+FIZazoyk59G7FwyB6HsG+N612j48W9i
 DeaA==
X-Gm-Message-State: APjAAAWLVjVzmCrzE0AohfjDk20oLCK0xjH5G02Rre5jmrS4jMEcHyOH
 MqIwn6pP8itX/qJQWz+MnZb8+pZP26pdSze49lchHk4v9GbQVqCXL2RBNrjTvvrwgvz6mow9Znz
 BqQ2iuoFTi4nmubk=
X-Received: by 2002:ac8:7158:: with SMTP id h24mr22829890qtp.63.1577111164453; 
 Mon, 23 Dec 2019 06:26:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyuG8F0M8LJqMMSCAPreAKxHOItavSmu1U7VnbXMK6AluYlspDhfV4VWwzUjuX70piSSNaYg==
X-Received: by 2002:ac8:7158:: with SMTP id h24mr22829862qtp.63.1577111164193; 
 Mon, 23 Dec 2019 06:26:04 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 e3sm4872820qtj.30.2019.12.23.06.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 06:26:03 -0800 (PST)
Date: Mon, 23 Dec 2019 09:25:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio: add the queue number check
Message-ID: <20191223092508-mutt-send-email-mst@kernel.org>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
X-MC-Unique: gkdgRgIjM92_paz94RggQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 23, 2019 at 12:02:18PM +0100, Paolo Bonzini wrote:
> On 23/12/19 10:18, Yang Zhong wrote:
> >   In this time, the queue number in the front-end block driver is 2, bu=
t
> >   the queue number in qemu side is still 4. So the guest virtio_blk
> >   driver will failed to create vq with backend.
>=20
> Where?
>=20
> >   There is no "set back"
> >   mechnism for block driver to inform backend this new queue number.
> >   So, i added this check in qemu side.
>=20
> Perhaps the guest kernel should still create the virtqueues, and just
> not use them.  In any case, now that you have explained it, it is
> certainly a guest bug.
>=20
> Paolo


Paolo do you understand where the bug is?
E.g. I see this in vhost user block:

    /* Kick right away to begin processing requests already in vring */
    for (i =3D 0; i < s->dev.nvqs; i++) {
        VirtQueue *kick_vq =3D virtio_get_queue(vdev, i);

        if (!virtio_queue_get_desc_addr(vdev, i)) {
            continue;
        }
        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
    }

which is an (admittedly hacky) want to skip VQs which
were not configured by guest ....


> >   Since the current virtio-blk and vhost-user-blk device always
> >   defaultly use 1 queue, it's hard to find this issue.
> >=20
> >   I checked the guest kernel driver, virtio-scsi and virtio-blk all
> >   have same check in their driver probe:
> >=20
> >   num_vqs =3D min_t(unsigned int, nr_cpu_ids, num_vqs);
> > =20
> >   It's possible the guest driver has different queue number with qemu
> >   side.
> >=20
> >   I also want to fix this issue from guest driver side, but currently t=
here=20
> >   is no better solution to fix this issue.
> >=20
> >   By the way, i did not try scsi with this corner case, and only check
> >   driver and qemu code to find same issue. thanks!=20
> >=20
> >   Yang
> >=20
> >> Paolo
> >>
> >>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> >>> ---
> >>>  hw/block/vhost-user-blk.c | 11 +++++++++++
> >>>  hw/block/virtio-blk.c     | 11 ++++++++++-
> >>>  hw/scsi/virtio-scsi.c     | 12 ++++++++++++
> >>>  3 files changed, 33 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> >>> index 63da9bb619..250e72abe4 100644
> >>> --- a/hw/block/vhost-user-blk.c
> >>> +++ b/hw/block/vhost-user-blk.c
> >>> @@ -23,6 +23,8 @@
> >>>  #include "qom/object.h"
> >>>  #include "hw/qdev-core.h"
> >>>  #include "hw/qdev-properties.h"
> >>> +#include "qemu/option.h"
> >>> +#include "qemu/config-file.h"
> >>>  #include "hw/virtio/vhost.h"
> >>>  #include "hw/virtio/vhost-user-blk.h"
> >>>  #include "hw/virtio/virtio.h"
> >>> @@ -391,6 +393,7 @@ static void vhost_user_blk_device_realize(DeviceS=
tate *dev, Error **errp)
> >>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >>>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> >>>      Error *err =3D NULL;
> >>> +    unsigned cpus;
> >>>      int i, ret;
> >>> =20
> >>>      if (!s->chardev.chr) {
> >>> @@ -403,6 +406,14 @@ static void vhost_user_blk_device_realize(Device=
State *dev, Error **errp)
> >>>          return;
> >>>      }
> >>> =20
> >>> +    cpus =3D qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-=
opts"), NULL),
> >>> +                               "cpus", 0);
> >>> +    if (s->num_queues > cpus ) {
> >>> +        error_setg(errp, "vhost-user-blk: the queue number should be=
 equal "
> >>> +                "or less than vcpu number");
> >>> +        return;
> >>> +    }
> >>> +
> >>>      if (!s->queue_size) {
> >>>          error_setg(errp, "vhost-user-blk: queue size must be non-zer=
o");
> >>>          return;
> >>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> >>> index d62e6377c2..b2f4d01148 100644
> >>> --- a/hw/block/virtio-blk.c
> >>> +++ b/hw/block/virtio-blk.c
> >>> @@ -18,6 +18,8 @@
> >>>  #include "qemu/error-report.h"
> >>>  #include "qemu/main-loop.h"
> >>>  #include "trace.h"
> >>> +#include "qemu/option.h"
> >>> +#include "qemu/config-file.h"
> >>>  #include "hw/block/block.h"
> >>>  #include "hw/qdev-properties.h"
> >>>  #include "sysemu/blockdev.h"
> >>> @@ -1119,7 +1121,7 @@ static void virtio_blk_device_realize(DeviceSta=
te *dev, Error **errp)
> >>>      VirtIOBlock *s =3D VIRTIO_BLK(dev);
> >>>      VirtIOBlkConf *conf =3D &s->conf;
> >>>      Error *err =3D NULL;
> >>> -    unsigned i;
> >>> +    unsigned i,cpus;
> >>> =20
> >>>      if (!conf->conf.blk) {
> >>>          error_setg(errp, "drive property not set");
> >>> @@ -1133,6 +1135,13 @@ static void virtio_blk_device_realize(DeviceSt=
ate *dev, Error **errp)
> >>>          error_setg(errp, "num-queues property must be larger than 0"=
);
> >>>          return;
> >>>      }
> >>> +    cpus =3D qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-=
opts"), NULL),
> >>> +                               "cpus", 0);
> >>> +    if (conf->num_queues > cpus ) {
> >>> +        error_setg(errp, "virtio-blk: the queue number should be equ=
al "
> >>> +                "or less than vcpu number");
> >>> +        return;
> >>> +    }
> >>>      if (!is_power_of_2(conf->queue_size) ||
> >>>          conf->queue_size > VIRTQUEUE_MAX_SIZE) {
> >>>          error_setg(errp, "invalid queue-size property (%" PRIu16 "),=
 "
> >>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> >>> index e8b2b64d09..8e3e44f6b9 100644
> >>> --- a/hw/scsi/virtio-scsi.c
> >>> +++ b/hw/scsi/virtio-scsi.c
> >>> @@ -21,6 +21,8 @@
> >>>  #include "qemu/error-report.h"
> >>>  #include "qemu/iov.h"
> >>>  #include "qemu/module.h"
> >>> +#include "qemu/option.h"
> >>> +#include "qemu/config-file.h"
> >>>  #include "sysemu/block-backend.h"
> >>>  #include "hw/qdev-properties.h"
> >>>  #include "hw/scsi/scsi.h"
> >>> @@ -880,6 +882,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
> >>>  {
> >>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >>>      VirtIOSCSICommon *s =3D VIRTIO_SCSI_COMMON(dev);
> >>> +    unsigned cpus;
> >>>      int i;
> >>> =20
> >>>      virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
> >>> @@ -893,6 +896,15 @@ void virtio_scsi_common_realize(DeviceState *dev=
,
> >>>          virtio_cleanup(vdev);
> >>>          return;
> >>>      }
> >>> +
> >>> +    cpus =3D qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-=
opts"), NULL),
> >>> +                               "cpus", 0);
> >>> +    if (s->conf.num_queues > cpus ) {
> >>> +        error_setg(errp, "virtio-scsi: the queue number should be eq=
ual "
> >>> +                "or less than vcpu number");
> >>> +        return;
> >>> +    }
> >>> +
> >>>      s->cmd_vqs =3D g_new0(VirtQueue *, s->conf.num_queues);
> >>>      s->sense_size =3D VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
> >>>      s->cdb_size =3D VIRTIO_SCSI_CDB_DEFAULT_SIZE;
> >>>
> >=20


