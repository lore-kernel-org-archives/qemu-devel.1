Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F285C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EA7206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EA7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJyw-0006PG-H5
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yang.zhong@intel.com>) id 1ijJy8-0005xY-DM
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1ijJy6-0006d6-0X
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:25:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:40508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1ijJy5-0006EZ-NU
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:25:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 01:25:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; d="scan'208";a="249429950"
Received: from yangzhon-virtual.bj.intel.com (HELO localhost) ([10.238.145.50])
 by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2019 01:25:30 -0800
Date: Mon, 23 Dec 2019 17:18:56 +0800
From: Yang Zhong <yang.zhong@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio: add the queue number check
Message-ID: <20191223091856.GA8433@yangzhon-Virtual>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: yang.zhong@intel.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 23, 2019 at 09:44:46AM +0100, Paolo Bonzini wrote:
> On 23/12/19 09:28, Yang Zhong wrote:
> > In the guest kernel driver, like virtio_blk.c and virtio_scsi.c,
> > there are some definitions like below:
> > 
> > num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs)
> > 
> > If the queue number is bigger than vcpu number, the VM will be
> > stuck in the guest driver because the qemu and guest driver have
> > different queue number. So, this check can avoid this issues.
> 
> Can you explain how the bug happens? This would be an issue in the
> kernel driver, QEMU shouldn't care about how the kernel driver chooses
> to steer requests to virtqueues.
> 
  Paolo, Merry Christmas!

  This issue is easy to reproduce, when i enabled multiple queue with SPDK,
  and if the num-queues > cpu number in the qemu command, the guest kernel
  will stuck there and after guest kernel do "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
  , the guest kernel will crash.

  My qemu command:
  ./qemu-system-x86_64 \
    -machine q35,accel=kvm \
    -cpu host -m 1024,maxmem=20G,slots=2 -smp 2 \
    -chardev socket,id=char0,path=/var/tmp/vhost.1 \
    -device vhost-user-blk-pci,chardev=char0,num-queues=4,bootindex=2,config-wce=true \
    ......

  My debug patch as below:
  diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
  index 7ffd719d89de..b0a2fb503c00 100644
  --- a/drivers/block/virtio_blk.c
  +++ b/drivers/block/virtio_blk.c
  @@ -511,11 +511,12 @@ static int init_vq(struct virtio_blk *vblk)
          err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
                                     struct virtio_blk_config, num_queues,
                                     &num_vqs);
  +printk("---0------blk_probe and init_vq, the num_queues=%d---\n", num_vqs);
        if (err)
                num_vqs = 1;
  -
  +printk("---1------blk_probe and init_vq, the num_queues=%d---\n", num_vqs);
        num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
  -
  +printk("---2------blk_probe and init_vq, the num_queues=%d---\n", num_vqs);
        vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);

  The debug log:
  [    0.225780] Linux agpgart interface v0.103
  [    0.226908] loop: module loaded
  [    0.227079] ---0------blk_probe and init_vq, the num_queues=4---
  [    0.227192] ---1------blk_probe and init_vq, the num_queues=4---
  [    0.227260] ---2------blk_probe and init_vq, the num_queues=2---
  [    0.227813] virtio_blk virtio1: [vda] 1048576 512-byte logical blocks (537 MB/512 MiB)

  In this time, the queue number in the front-end block driver is 2, but
  the queue number in qemu side is still 4. So the guest virtio_blk
  driver will failed to create vq with backend. There is no "set back"
  mechnism for block driver to inform backend this new queue number.
  So, i added this check in qemu side.

  Since the current virtio-blk and vhost-user-blk device always
  defaultly use 1 queue, it's hard to find this issue.

  I checked the guest kernel driver, virtio-scsi and virtio-blk all
  have same check in their driver probe:

  num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
 
  It's possible the guest driver has different queue number with qemu
  side.

  I also want to fix this issue from guest driver side, but currently there 
  is no better solution to fix this issue.

  By the way, i did not try scsi with this corner case, and only check
  driver and qemu code to find same issue. thanks! 

  Yang

> Paolo
> 
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  hw/block/vhost-user-blk.c | 11 +++++++++++
> >  hw/block/virtio-blk.c     | 11 ++++++++++-
> >  hw/scsi/virtio-scsi.c     | 12 ++++++++++++
> >  3 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 63da9bb619..250e72abe4 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -23,6 +23,8 @@
> >  #include "qom/object.h"
> >  #include "hw/qdev-core.h"
> >  #include "hw/qdev-properties.h"
> > +#include "qemu/option.h"
> > +#include "qemu/config-file.h"
> >  #include "hw/virtio/vhost.h"
> >  #include "hw/virtio/vhost-user-blk.h"
> >  #include "hw/virtio/virtio.h"
> > @@ -391,6 +393,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> >      Error *err = NULL;
> > +    unsigned cpus;
> >      int i, ret;
> >  
> >      if (!s->chardev.chr) {
> > @@ -403,6 +406,14 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> >          return;
> >      }
> >  
> > +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
> > +                               "cpus", 0);
> > +    if (s->num_queues > cpus ) {
> > +        error_setg(errp, "vhost-user-blk: the queue number should be equal "
> > +                "or less than vcpu number");
> > +        return;
> > +    }
> > +
> >      if (!s->queue_size) {
> >          error_setg(errp, "vhost-user-blk: queue size must be non-zero");
> >          return;
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index d62e6377c2..b2f4d01148 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -18,6 +18,8 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/main-loop.h"
> >  #include "trace.h"
> > +#include "qemu/option.h"
> > +#include "qemu/config-file.h"
> >  #include "hw/block/block.h"
> >  #include "hw/qdev-properties.h"
> >  #include "sysemu/blockdev.h"
> > @@ -1119,7 +1121,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
> >      VirtIOBlock *s = VIRTIO_BLK(dev);
> >      VirtIOBlkConf *conf = &s->conf;
> >      Error *err = NULL;
> > -    unsigned i;
> > +    unsigned i,cpus;
> >  
> >      if (!conf->conf.blk) {
> >          error_setg(errp, "drive property not set");
> > @@ -1133,6 +1135,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
> >          error_setg(errp, "num-queues property must be larger than 0");
> >          return;
> >      }
> > +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
> > +                               "cpus", 0);
> > +    if (conf->num_queues > cpus ) {
> > +        error_setg(errp, "virtio-blk: the queue number should be equal "
> > +                "or less than vcpu number");
> > +        return;
> > +    }
> >      if (!is_power_of_2(conf->queue_size) ||
> >          conf->queue_size > VIRTQUEUE_MAX_SIZE) {
> >          error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index e8b2b64d09..8e3e44f6b9 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -21,6 +21,8 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/iov.h"
> >  #include "qemu/module.h"
> > +#include "qemu/option.h"
> > +#include "qemu/config-file.h"
> >  #include "sysemu/block-backend.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/scsi/scsi.h"
> > @@ -880,6 +882,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >      VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(dev);
> > +    unsigned cpus;
> >      int i;
> >  
> >      virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
> > @@ -893,6 +896,15 @@ void virtio_scsi_common_realize(DeviceState *dev,
> >          virtio_cleanup(vdev);
> >          return;
> >      }
> > +
> > +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
> > +                               "cpus", 0);
> > +    if (s->conf.num_queues > cpus ) {
> > +        error_setg(errp, "virtio-scsi: the queue number should be equal "
> > +                "or less than vcpu number");
> > +        return;
> > +    }
> > +
> >      s->cmd_vqs = g_new0(VirtQueue *, s->conf.num_queues);
> >      s->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
> >      s->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
> > 

