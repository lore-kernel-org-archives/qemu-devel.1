Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632D22075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKB9pRnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632D22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKXz-0000kj-Ke
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKXH-0008KK-D2
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:57:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKXF-0001Hw-WF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589965027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Q+r+uSD6XxHwyY47fFMsWDIRMSq4JY6RGiALLBke4w=;
 b=FKB9pRnwmwj1Fc490oQHTYk4zWKzlw1d6+GNFXzOhOtDjWL8fhWdu9mq+YV5mpE28rz4sZ
 f2pt939l5xlJ8Mi7WbmdMJcgU1e9FsJ3sgj8NEioDDPfrhkd0pyefftvzIk7IiOl9m8aou
 u1KuWegwmrgyXjPThIqazeagwQEqUW0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-m88WOLDmPUi3ayg4OTy5jQ-1; Wed, 20 May 2020 04:57:04 -0400
X-MC-Unique: m88WOLDmPUi3ayg4OTy5jQ-1
Received: by mail-wm1-f69.google.com with SMTP id l26so654391wmh.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Q+r+uSD6XxHwyY47fFMsWDIRMSq4JY6RGiALLBke4w=;
 b=oD6j8+yjKQiW7SuzSc9oDgQ997/5gQYkZww/Pj4172AQ3exZmsNqywgZz7aAyqoQ8I
 MVx7Dk9k5GH3qpeYpsvEhceA7/WcT8b0zkKlJmlMjcqd9nrO5rzfHQmzC/RWZXD6nCbf
 3wjOq2hvtMDmkpl9krg7Z8nc83O4Vc5K5757UtQ7przXM5bwf2AFi8r/lY7nEQQnXaMG
 aH++9eNzNqzWLymc8m5hf+0aqOjEDVtVv/Cp0DR7+N/d5N0iP0jU7RECAxVEr4KWhVSB
 jqKoYiQ/coXONhdP8795D92meqPUJU8fvFRUYDdVC+RduMSlE7btnbJRX/XsMNknwK6E
 hwBw==
X-Gm-Message-State: AOAM530dxSi76twPCNomc3EuPETLJgM/9gHf9FilVxdh26uLTNR8tTp/
 kf6vpH8c5fau21O8ThSsv9hxuQfL978bJo+ND/gjZOj+IbtMPP40TZyxIXUQUozHrME1xcg/xpH
 5PHkD97UG8u11UjQ=
X-Received: by 2002:a7b:c306:: with SMTP id k6mr3572686wmj.40.1589965022191;
 Wed, 20 May 2020 01:57:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyhUOUX6Hw2F7xtHpfbjs8bfNLuWub9z+Z1DxoxXGe0VYelAUrTpaE43fOxfg+xIz0h3Hj4w==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr3572651wmj.40.1589965021847;
 Wed, 20 May 2020 01:57:01 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g6sm2069726wrp.75.2020.05.20.01.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 01:57:01 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] block: consolidate blocksize properties
 consistency checks
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-3-rvkagan@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae8e02be-8cce-6b4d-dc12-4c2c70a8d1a0@redhat.com>
Date: Wed, 20 May 2020 10:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520080657.29080-3-rvkagan@yandex-team.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Roman,

On 5/20/20 10:06 AM, Roman Kagan wrote:
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
> ---
> v4: new patch
> 
>   include/hw/block/block.h   |  2 +-
>   hw/block/block.c           | 29 ++++++++++++++++++++++++++++-
>   hw/block/fdc.c             |  5 ++++-
>   hw/block/nvme.c            |  5 ++++-
>   hw/block/virtio-blk.c      |  7 +------
>   hw/ide/qdev.c              |  5 ++++-
>   hw/scsi/scsi-disk.c        | 10 +++-------
>   hw/usb/dev-storage.c       |  5 ++++-
>   tests/qemu-iotests/172.out |  2 +-
>   9 files changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index d7246f3862..784953a237 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -87,7 +87,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>   bool blkconf_geometry(BlockConf *conf, int *trans,
>                         unsigned cyls_max, unsigned heads_max, unsigned secs_max,
>                         Error **errp);
> -void blkconf_blocksizes(BlockConf *conf);
> +bool blkconf_blocksizes(BlockConf *conf, Error **errp);
>   bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>                                      bool resizable, Error **errp);
>   
> diff --git a/hw/block/block.c b/hw/block/block.c
> index bf56c7612b..5f8ebff59c 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -61,7 +61,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>       return true;
>   }
>   
> -void blkconf_blocksizes(BlockConf *conf)
> +bool blkconf_blocksizes(BlockConf *conf, Error **errp)
>   {
>       BlockBackend *blk = conf->blk;
>       BlockSizes blocksizes;
> @@ -83,6 +83,33 @@ void blkconf_blocksizes(BlockConf *conf)
>               conf->logical_block_size = BDRV_SECTOR_SIZE;
>           }
>       }
> +
> +    if (conf->logical_block_size > conf->physical_block_size) {
> +        error_setg(errp,
> +                   "logical_block_size > physical_block_size not supported");

"not supported" or "invalid"?

> +        return false;
> +    }
> +
> +    if (conf->min_io_size % conf->logical_block_size) {

It seems the block code usually do:

        if (!QEMU_IS_ALIGNED(conf->min_io_size, conf->logical_block_size)) {

> +        error_setg(errp,
> +                   "min_io_size must be a multple of logical_block_size");

Typo "multple" -> "multiple".

> +        return false;
> +    }
> +
> +    if (conf->opt_io_size % conf->logical_block_size) {
> +        error_setg(errp,
> +                   "opt_io_size must be a multple of logical_block_size");

Ditto.

> +        return false;
> +    }
> +
> +    if (conf->discard_granularity != -1 &&
> +        conf->discard_granularity % conf->logical_block_size) {
> +        error_setg(errp, "discard_granularity must be "
> +                   "a multple of logical_block_size");

Again.

> +        return false;
> +    }
> +
> +    return true;

Usually we return true for error, isn't it?

>   }
>   
>   bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index c5fb9d6ece..8eda572ef4 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -554,7 +554,10 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
>           read_only = !blk_bs(dev->conf.blk) || blk_is_read_only(dev->conf.blk);
>       }
>   
> -    blkconf_blocksizes(&dev->conf);
> +    if (!blkconf_blocksizes(&dev->conf, errp)) {
> +        return;
> +    }
> +
>       if (dev->conf.logical_block_size != 512 ||
>           dev->conf.physical_block_size != 512)
>       {
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 2f3100e56c..672650e162 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1390,7 +1390,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>           host_memory_backend_set_mapped(n->pmrdev, true);
>       }
>   
> -    blkconf_blocksizes(&n->conf);
> +    if (!blkconf_blocksizes(&n->conf, errp)) {
> +        return;
> +    }
> +
>       if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
>                                          false, errp)) {
>           return;
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 413083e62f..4ffdb130be 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1162,12 +1162,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    blkconf_blocksizes(&conf->conf);
> -
> -    if (conf->conf.logical_block_size >
> -        conf->conf.physical_block_size) {
> -        error_setg(errp,
> -                   "logical_block_size > physical_block_size not supported");

Ah, "not supported" comes from here, OK.

> +    if (!blkconf_blocksizes(&conf->conf, errp)) {
>           return;
>       }
>   
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 06b11583f5..b4821b2403 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -187,7 +187,10 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
>           return;
>       }
>   
> -    blkconf_blocksizes(&dev->conf);
> +    if (!blkconf_blocksizes(&dev->conf, errp)) {
> +        return;
> +    }
> +
>       if (dev->conf.logical_block_size != 512) {
>           error_setg(errp, "logical_block_size must be 512 for IDE");
>           return;
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 387503e11b..06c8f1ba92 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2346,12 +2346,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
>           return;
>       }
>   
> -    blkconf_blocksizes(&s->qdev.conf);
> -
> -    if (s->qdev.conf.logical_block_size >
> -        s->qdev.conf.physical_block_size) {
> -        error_setg(errp,
> -                   "logical_block_size > physical_block_size not supported");
> +    if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
>           return;
>       }
>   
> @@ -2436,7 +2431,8 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
>       if (s->qdev.conf.blk) {
>           ctx = blk_get_aio_context(s->qdev.conf.blk);
>           aio_context_acquire(ctx);
> -        blkconf_blocksizes(&s->qdev.conf);
> +        /* ignore errors, blocksizes will be revalidated in scsi_realize */
> +        blkconf_blocksizes(&s->qdev.conf, NULL);

Hmm, why not bail out ASAP on error?

Good cleanup otherwise.

>       }
>       s->qdev.blocksize = s->qdev.conf.logical_block_size;
>       s->qdev.type = TYPE_DISK;
> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> index 4eba47538d..de461f37bd 100644
> --- a/hw/usb/dev-storage.c
> +++ b/hw/usb/dev-storage.c
> @@ -599,7 +599,10 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
>           return;
>       }
>   
> -    blkconf_blocksizes(&s->conf);
> +    if (!blkconf_blocksizes(&s->conf, errp)) {
> +        return;
> +    }
> +
>       if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
>                                          errp)) {
>           return;
> diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
> index 7abbe82427..59cc70aebb 100644
> --- a/tests/qemu-iotests/172.out
> +++ b/tests/qemu-iotests/172.out
> @@ -1204,7 +1204,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
>                   drive-type = "144"
>   
>   Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=4096
> -QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: Physical and logical block size must be 512 for floppy
> +QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: logical_block_size > physical_block_size not supported
>   
>   Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physical_block_size=1024
>   QEMU_PROG: -device floppy,drive=none0,physical_block_size=1024: Physical and logical block size must be 512 for floppy
> 


