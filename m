Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7856FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2616820823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gWTeUCYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbWKi-0007rB-97
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbWJ8-0006rr-2t; Wed, 20 May 2020 17:31:22 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:49578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbWJ4-0008IJ-7z; Wed, 20 May 2020 17:31:20 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 8F6B72E151E;
 Thu, 21 May 2020 00:31:11 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 TSEkOTNcFG-V8Y4lRVf; Thu, 21 May 2020 00:31:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590010271; bh=NBPIvnZz5aGFL7oA8FakgPOwfnGQXOBEp5S4g48DhkQ=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=gWTeUCYz9tuzmwQF4ppS4/gLxp80BGVdUgZE/yDGtdaHaTyh4y+s1+moLf4btGXi6
 cY+cGLE65DIG4QwVoBlRjOh9RedjTe/wyIRrwFf4jMrsTJg/I4bJZ5q/v1EfGQXcPR
 2/sfCblnEH5U5KM/vGdiYLEyPVlGbn9GVgCfFNLo=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:407::1:16])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 mCcPUIRPyD-V7XuTUji; Thu, 21 May 2020 00:31:08 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Thu, 21 May 2020 00:31:06 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 2/3] block: consolidate blocksize properties
 consistency checks
Message-ID: <20200520213106.GC104207@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-3-rvkagan@yandex-team.ru>
 <ae8e02be-8cce-6b4d-dc12-4c2c70a8d1a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae8e02be-8cce-6b4d-dc12-4c2c70a8d1a0@redhat.com>
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 10:57:00AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/20/20 10:06 AM, Roman Kagan wrote:
> > Several block device properties related to blocksize configuration must
> > be in certain relationship WRT each other: physical block must be no
> > smaller than logical block; min_io_size, opt_io_size, and
> > discard_granularity must be a multiple of a logical block.
> > 
> > To ensure these requirements are met, add corresponding consistency
> > checks to blkconf_blocksizes, adjusting its signature to communicate
> > possible error to the caller.  Also remove the now redundant consistency
> > checks from the specific devices.
> > 
> > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > ---
> > v4: new patch
> > 
> >   include/hw/block/block.h   |  2 +-
> >   hw/block/block.c           | 29 ++++++++++++++++++++++++++++-
> >   hw/block/fdc.c             |  5 ++++-
> >   hw/block/nvme.c            |  5 ++++-
> >   hw/block/virtio-blk.c      |  7 +------
> >   hw/ide/qdev.c              |  5 ++++-
> >   hw/scsi/scsi-disk.c        | 10 +++-------
> >   hw/usb/dev-storage.c       |  5 ++++-
> >   tests/qemu-iotests/172.out |  2 +-
> >   9 files changed, 50 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> > index d7246f3862..784953a237 100644
> > --- a/include/hw/block/block.h
> > +++ b/include/hw/block/block.h
> > @@ -87,7 +87,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
> >   bool blkconf_geometry(BlockConf *conf, int *trans,
> >                         unsigned cyls_max, unsigned heads_max, unsigned secs_max,
> >                         Error **errp);
> > -void blkconf_blocksizes(BlockConf *conf);
> > +bool blkconf_blocksizes(BlockConf *conf, Error **errp);
> >   bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
> >                                      bool resizable, Error **errp);
> > diff --git a/hw/block/block.c b/hw/block/block.c
> > index bf56c7612b..5f8ebff59c 100644
> > --- a/hw/block/block.c
> > +++ b/hw/block/block.c
> > @@ -61,7 +61,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
> >       return true;
> >   }
> > -void blkconf_blocksizes(BlockConf *conf)
> > +bool blkconf_blocksizes(BlockConf *conf, Error **errp)
> >   {
> >       BlockBackend *blk = conf->blk;
> >       BlockSizes blocksizes;
> > @@ -83,6 +83,33 @@ void blkconf_blocksizes(BlockConf *conf)
> >               conf->logical_block_size = BDRV_SECTOR_SIZE;
> >           }
> >       }
> > +
> > +    if (conf->logical_block_size > conf->physical_block_size) {
> > +        error_setg(errp,
> > +                   "logical_block_size > physical_block_size not supported");
> 
> "not supported" or "invalid"?
> 
> > +        return false;
> > +    }
> > +
> > +    if (conf->min_io_size % conf->logical_block_size) {
> 
> It seems the block code usually do:
> 
>        if (!QEMU_IS_ALIGNED(conf->min_io_size, conf->logical_block_size)) {
> 
> > +        error_setg(errp,
> > +                   "min_io_size must be a multple of logical_block_size");
> 
> Typo "multple" -> "multiple".
> 
> > +        return false;
> > +    }
> > +
> > +    if (conf->opt_io_size % conf->logical_block_size) {
> > +        error_setg(errp,
> > +                   "opt_io_size must be a multple of logical_block_size");
> 
> Ditto.
> 
> > +        return false;
> > +    }
> > +
> > +    if (conf->discard_granularity != -1 &&
> > +        conf->discard_granularity % conf->logical_block_size) {
> > +        error_setg(errp, "discard_granularity must be "
> > +                   "a multple of logical_block_size");
> 
> Again.
> 
> > +        return false;
> > +    }
> > +
> > +    return true;
> 
> Usually we return true for error, isn't it?

I just followed the convention of all other functions with error
handling in this file.

> >   }
> >   bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
> > diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> > index c5fb9d6ece..8eda572ef4 100644
> > --- a/hw/block/fdc.c
> > +++ b/hw/block/fdc.c
> > @@ -554,7 +554,10 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
> >           read_only = !blk_bs(dev->conf.blk) || blk_is_read_only(dev->conf.blk);
> >       }
> > -    blkconf_blocksizes(&dev->conf);
> > +    if (!blkconf_blocksizes(&dev->conf, errp)) {
> > +        return;
> > +    }
> > +
> >       if (dev->conf.logical_block_size != 512 ||
> >           dev->conf.physical_block_size != 512)
> >       {
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 2f3100e56c..672650e162 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1390,7 +1390,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >           host_memory_backend_set_mapped(n->pmrdev, true);
> >       }
> > -    blkconf_blocksizes(&n->conf);
> > +    if (!blkconf_blocksizes(&n->conf, errp)) {
> > +        return;
> > +    }
> > +
> >       if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
> >                                          false, errp)) {
> >           return;
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 413083e62f..4ffdb130be 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1162,12 +1162,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
> >           return;
> >       }
> > -    blkconf_blocksizes(&conf->conf);
> > -
> > -    if (conf->conf.logical_block_size >
> > -        conf->conf.physical_block_size) {
> > -        error_setg(errp,
> > -                   "logical_block_size > physical_block_size not supported");
> 
> Ah, "not supported" comes from here, OK.

Indeed :)

> 
> > +    if (!blkconf_blocksizes(&conf->conf, errp)) {
> >           return;
> >       }
> > diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> > index 06b11583f5..b4821b2403 100644
> > --- a/hw/ide/qdev.c
> > +++ b/hw/ide/qdev.c
> > @@ -187,7 +187,10 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
> >           return;
> >       }
> > -    blkconf_blocksizes(&dev->conf);
> > +    if (!blkconf_blocksizes(&dev->conf, errp)) {
> > +        return;
> > +    }
> > +
> >       if (dev->conf.logical_block_size != 512) {
> >           error_setg(errp, "logical_block_size must be 512 for IDE");
> >           return;
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index 387503e11b..06c8f1ba92 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -2346,12 +2346,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
> >           return;
> >       }
> > -    blkconf_blocksizes(&s->qdev.conf);
> > -
> > -    if (s->qdev.conf.logical_block_size >
> > -        s->qdev.conf.physical_block_size) {
> > -        error_setg(errp,
> > -                   "logical_block_size > physical_block_size not supported");
> > +    if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
> >           return;
> >       }
> > @@ -2436,7 +2431,8 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
> >       if (s->qdev.conf.blk) {
> >           ctx = blk_get_aio_context(s->qdev.conf.blk);
> >           aio_context_acquire(ctx);
> > -        blkconf_blocksizes(&s->qdev.conf);
> > +        /* ignore errors, blocksizes will be revalidated in scsi_realize */
> > +        blkconf_blocksizes(&s->qdev.conf, NULL);
> 
> Hmm, why not bail out ASAP on error?

You're probably right, it'll be cleaner this way.

Thanks,
Roman.

> 
> Good cleanup otherwise.
> 
> >       }
> >       s->qdev.blocksize = s->qdev.conf.logical_block_size;
> >       s->qdev.type = TYPE_DISK;
> > diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> > index 4eba47538d..de461f37bd 100644
> > --- a/hw/usb/dev-storage.c
> > +++ b/hw/usb/dev-storage.c
> > @@ -599,7 +599,10 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
> >           return;
> >       }
> > -    blkconf_blocksizes(&s->conf);
> > +    if (!blkconf_blocksizes(&s->conf, errp)) {
> > +        return;
> > +    }
> > +
> >       if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
> >                                          errp)) {
> >           return;
> > diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
> > index 7abbe82427..59cc70aebb 100644
> > --- a/tests/qemu-iotests/172.out
> > +++ b/tests/qemu-iotests/172.out
> > @@ -1204,7 +1204,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
> >                   drive-type = "144"
> >   Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=4096
> > -QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: Physical and logical block size must be 512 for floppy
> > +QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: logical_block_size > physical_block_size not supported
> >   Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physical_block_size=1024
> >   QEMU_PROG: -device floppy,drive=none0,physical_block_size=1024: Physical and logical block size must be 512 for floppy
> > 
> 

