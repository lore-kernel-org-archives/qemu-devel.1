Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7876F207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V31SYRYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7876F207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jebiX-0002oU-KK
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jebhv-0001sp-7S
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:53:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jebht-0006uy-GD
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590746020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBbcRVFEfSxughTklZo44hT/qdDRmX6G0cum4Aww9eQ=;
 b=V31SYRYB+IKCCsOr8DFt+iQ9dOkMDn9oczKRCnTmSoYJBe3PYWwYDHCQS5ByV7YvGPs2Cj
 Bk4Z9z18MbzLBnrPsZm2IajMTe7+LPGUUIp3BweywGDJZt+XsxXH1T4jzk+yUfLEp0D4PF
 WVcs1Q5eB33Hy30RJDlRyipLewg+yCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-hXw6j1zUO6qJWRJ1JtaZ6A-1; Fri, 29 May 2020 05:53:38 -0400
X-MC-Unique: hXw6j1zUO6qJWRJ1JtaZ6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3FFABFC7;
 Fri, 29 May 2020 09:53:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC8F110013D4;
 Fri, 29 May 2020 09:53:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BDC6113864A; Fri, 29 May 2020 11:53:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Kagan <rvkagan@yandex-team.ru>
Subject: Re: [PATCH v8 2/8] block: consolidate blocksize properties
 consistency checks
References: <20200528225516.1676602-1-rvkagan@yandex-team.ru>
 <20200528225516.1676602-3-rvkagan@yandex-team.ru>
Date: Fri, 29 May 2020 11:53:26 +0200
In-Reply-To: <20200528225516.1676602-3-rvkagan@yandex-team.ru> (Roman Kagan's
 message of "Fri, 29 May 2020 01:55:10 +0300")
Message-ID: <87r1v3m5ih.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Anthony Perard <anthony.perard@citrix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 xen-devel@lists.xenproject.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Roman Kagan <rvkagan@yandex-team.ru> writes:

> Several block device properties related to blocksize configuration must
> be in certain relationship WRT each other: physical block must be no
> smaller than logical block; min_io_size, opt_io_size, and
> discard_granularity must be a multiple of a logical block.
>
> To ensure these requirements are met, add corresponding consistency
> checks to blkconf_blocksizes, adjusting its signature to communicate
> possible error to the caller.  Also remove the now redundant consistency
> checks from the specific devices.
>
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Paul Durrant <paul@xen.org>
> ---
>  include/hw/block/block.h   |  2 +-
>  hw/block/block.c           | 30 +++++++++++++++++++++++++++++-
>  hw/block/fdc.c             |  5 ++++-
>  hw/block/nvme.c            |  5 ++++-
>  hw/block/swim.c            |  5 ++++-
>  hw/block/virtio-blk.c      |  7 +------
>  hw/block/xen-block.c       |  6 +-----
>  hw/ide/qdev.c              |  5 ++++-
>  hw/scsi/scsi-disk.c        | 12 +++++-------
>  hw/usb/dev-storage.c       |  5 ++++-
>  tests/qemu-iotests/172.out |  2 +-
>  11 files changed, 58 insertions(+), 26 deletions(-)
>
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index d7246f3862..784953a237 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -87,7 +87,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>  bool blkconf_geometry(BlockConf *conf, int *trans,
>                        unsigned cyls_max, unsigned heads_max, unsigned secs_max,
>                        Error **errp);
> -void blkconf_blocksizes(BlockConf *conf);
> +bool blkconf_blocksizes(BlockConf *conf, Error **errp);
>  bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>                                     bool resizable, Error **errp);
>  
> diff --git a/hw/block/block.c b/hw/block/block.c
> index bf56c7612b..b22207c921 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -61,7 +61,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>      return true;
>  }
>  
> -void blkconf_blocksizes(BlockConf *conf)
> +bool blkconf_blocksizes(BlockConf *conf, Error **errp)
>  {
>      BlockBackend *blk = conf->blk;
>      BlockSizes blocksizes;
> @@ -83,6 +83,34 @@ void blkconf_blocksizes(BlockConf *conf)
>              conf->logical_block_size = BDRV_SECTOR_SIZE;
>          }
>      }
> +
> +    if (conf->logical_block_size > conf->physical_block_size) {
> +        error_setg(errp,
> +                   "logical_block_size > physical_block_size not supported");
> +        return false;
> +    }

Pardon me if this has been answered already for prior revisions: do we
really support physical block sizes that are not a multiple of the
logical block size?

> +
> +    if (!QEMU_IS_ALIGNED(conf->min_io_size, conf->logical_block_size)) {
> +        error_setg(errp,
> +                   "min_io_size must be a multiple of logical_block_size");
> +        return false;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(conf->opt_io_size, conf->logical_block_size)) {
> +        error_setg(errp,
> +                   "opt_io_size must be a multiple of logical_block_size");
> +        return false;
> +    }
> +
> +    if (conf->discard_granularity != -1 &&
> +        !QEMU_IS_ALIGNED(conf->discard_granularity,
> +                         conf->logical_block_size)) {
> +        error_setg(errp, "discard_granularity must be "
> +                   "a multiple of logical_block_size");
> +        return false;
> +    }
> +
> +    return true;
>  }
>  
>  bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index c5fb9d6ece..8eda572ef4 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -554,7 +554,10 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
>          read_only = !blk_bs(dev->conf.blk) || blk_is_read_only(dev->conf.blk);
>      }
>  
> -    blkconf_blocksizes(&dev->conf);
> +    if (!blkconf_blocksizes(&dev->conf, errp)) {
> +        return;
> +    }
> +
>      if (dev->conf.logical_block_size != 512 ||
>          dev->conf.physical_block_size != 512)
>      {
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 2f3100e56c..672650e162 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1390,7 +1390,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          host_memory_backend_set_mapped(n->pmrdev, true);
>      }
>  
> -    blkconf_blocksizes(&n->conf);
> +    if (!blkconf_blocksizes(&n->conf, errp)) {
> +        return;
> +    }
> +
>      if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
>                                         false, errp)) {
>          return;
> diff --git a/hw/block/swim.c b/hw/block/swim.c
> index 8f124782f4..74f56e8f46 100644
> --- a/hw/block/swim.c
> +++ b/hw/block/swim.c
> @@ -189,7 +189,10 @@ static void swim_drive_realize(DeviceState *qdev, Error **errp)
>          assert(ret == 0);
>      }
>  
> -    blkconf_blocksizes(&dev->conf);
> +    if (!blkconf_blocksizes(&dev->conf, errp)) {
> +        return;
> +    }
> +
>      if (dev->conf.logical_block_size != 512 ||
>          dev->conf.physical_block_size != 512)
>      {
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 413083e62f..4ffdb130be 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1162,12 +1162,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    blkconf_blocksizes(&conf->conf);
> -
> -    if (conf->conf.logical_block_size >
> -        conf->conf.physical_block_size) {
> -        error_setg(errp,
> -                   "logical_block_size > physical_block_size not supported");
> +    if (!blkconf_blocksizes(&conf->conf, errp)) {
>          return;
>      }
>  
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 570489d6d9..e17fec50e1 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -239,11 +239,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
>          return;
>      }
>  
> -    blkconf_blocksizes(conf);
> -
> -    if (conf->logical_block_size > conf->physical_block_size) {
> -        error_setg(
> -            errp, "logical_block_size > physical_block_size not supported");
> +    if (!blkconf_blocksizes(conf, errp)) {
>          return;
>      }
>  
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 06b11583f5..b4821b2403 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -187,7 +187,10 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
>          return;
>      }
>  
> -    blkconf_blocksizes(&dev->conf);
> +    if (!blkconf_blocksizes(&dev->conf, errp)) {
> +        return;
> +    }
> +
>      if (dev->conf.logical_block_size != 512) {
>          error_setg(errp, "logical_block_size must be 512 for IDE");
>          return;
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 387503e11b..8ce68a9dd6 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2346,12 +2346,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
>          return;
>      }
>  
> -    blkconf_blocksizes(&s->qdev.conf);
> -
> -    if (s->qdev.conf.logical_block_size >
> -        s->qdev.conf.physical_block_size) {
> -        error_setg(errp,
> -                   "logical_block_size > physical_block_size not supported");
> +    if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
>          return;
>      }
>  
> @@ -2436,7 +2431,9 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
>      if (s->qdev.conf.blk) {
>          ctx = blk_get_aio_context(s->qdev.conf.blk);
>          aio_context_acquire(ctx);
> -        blkconf_blocksizes(&s->qdev.conf);
> +        if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
> +            goto out;
> +        }
>      }
>      s->qdev.blocksize = s->qdev.conf.logical_block_size;
>      s->qdev.type = TYPE_DISK;
> @@ -2444,6 +2441,7 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
>          s->product = g_strdup("QEMU HARDDISK");
>      }
>      scsi_realize(&s->qdev, errp);
> +out:
>      if (ctx) {
>          aio_context_release(ctx);
>      }
> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> index 4eba47538d..de461f37bd 100644
> --- a/hw/usb/dev-storage.c
> +++ b/hw/usb/dev-storage.c
> @@ -599,7 +599,10 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
>          return;
>      }
>  
> -    blkconf_blocksizes(&s->conf);
> +    if (!blkconf_blocksizes(&s->conf, errp)) {
> +        return;
> +    }
> +
>      if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
>                                         errp)) {
>          return;
> diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
> index 7abbe82427..59cc70aebb 100644
> --- a/tests/qemu-iotests/172.out
> +++ b/tests/qemu-iotests/172.out
> @@ -1204,7 +1204,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
>                  drive-type = "144"
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=4096
> -QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: Physical and logical block size must be 512 for floppy
> +QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: logical_block_size > physical_block_size not supported
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physical_block_size=1024
>  QEMU_PROG: -device floppy,drive=none0,physical_block_size=1024: Physical and logical block size must be 512 for floppy

This no longer exercises floppy_drive_realize()'s check of
logical_block_size:

    if (dev->conf.logical_block_size != 512 ||
        dev->conf.physical_block_size != 512)
    {
        error_setg(errp, "Physical and logical block size must "
                   "be 512 for floppy");
        return;
    }

Please update the test.


