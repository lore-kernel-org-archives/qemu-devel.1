Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD7C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850B42137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GaHT8Zvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850B42137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5Se-00069G-Ja
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jU5Ry-0005dA-3Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jU5Rx-0003bl-7K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:25:45 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:44166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jU5Rs-0002nq-38; Thu, 30 Apr 2020 05:25:40 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5AB222E146F;
 Thu, 30 Apr 2020 12:25:32 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 qCMTu8ette-PUAWZ7Qk; Thu, 30 Apr 2020 12:25:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588238732; bh=Q1MXmzvPzaV3j0oC7jyuuGuF8mD/ViQ1mYgbA1ZKCo8=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=GaHT8ZvgBnzvfkrCIZ5XRZXCjikMtZ7DDv/wcmgd7tZgR7i86EfE+DsDXxGM/E0G1
 SHMts1nbusa1M9Rp6+WJWlDIHRCbABCHGKZ6cJloYP7xM+3ki/KojLEXsrKbPLswhu
 r1T/aGIHcLwdd3bJdPP+ZZAZcVZny47y+3olEVX8=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net
 [2a02:6b8:b080:9508::1:c])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 KyRWgMum2l-PUWOUEeL; Thu, 30 Apr 2020 12:25:30 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Thu, 30 Apr 2020 12:25:28 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3] block: make BlockConf.*_size properties 32-bit
Message-ID: <20200430092528.GC31415@rvkaganb>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin\"" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20200429091813.1469510-1-rvkagan@yandex-team.ru>
 <f80b44cf-5fe3-8e10-b928-b61f7940d3cf@redhat.com>
 <20200429121915.GA31415@rvkaganb>
 <caedf222-3fef-ad92-3b03-f28d8019b7f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caedf222-3fef-ad92-3b03-f28d8019b7f0@redhat.com>
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:6b8:0:1a2d::193
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
 "Michael S. Tsirkin\"" <mst@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 02:59:31PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/29/20 2:19 PM, Roman Kagan wrote:
> > On Wed, Apr 29, 2020 at 11:41:04AM +0200, Philippe Mathieu-Daudé wrote:
> > > Cc'ing virtio-blk and scsi maintainers.
> > > 
> > > On 4/29/20 11:18 AM, Roman Kagan wrote:
> > > > Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
> > > > 32-bit for logical_block_size, physical_block_size, and min_io_size.
> > > > However, the properties in BlockConf are defined as uint16_t limiting
> > > > the values to 32768.
> > > > 
> > > > This appears unnecessary tight, and we've seen bigger block sizes handy
> > > > at times.
> > > > 
> > > > Make them 32 bit instead and lift the limitation up to 2 MiB which
> > > > appears to be good enough for everybody, and matches the qcow2 cluster
> > > > size limit.
> > > > 
> > > > As the values can now be fairly big and awkward to type, make the
> > > > property setter accept common size suffixes (k, m).
> > > > 
> > > > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > > > ---
> > > > v2 -> v3:
> > > > - mention qcow2 cluster size limit in the log and comment [Eric]
> > > > 
> > > > v1 -> v2:
> > > > - cap the property at 2 MiB [Eric]
> > > > - accept size suffixes
> > > > 
> > > >    include/hw/block/block.h     |  8 ++++----
> > > >    include/hw/qdev-properties.h |  2 +-
> > > >    hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
> > > >    3 files changed, 29 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> > > > index d7246f3862..9dd6bba56a 100644
> > > > --- a/include/hw/block/block.h
> > > > +++ b/include/hw/block/block.h
> > > > @@ -18,9 +18,9 @@
> > > >    typedef struct BlockConf {
> > > >        BlockBackend *blk;
> > > > -    uint16_t physical_block_size;
> > > > -    uint16_t logical_block_size;
> > > > -    uint16_t min_io_size;
> > > > +    uint32_t physical_block_size;
> > > > +    uint32_t logical_block_size;
> > > > +    uint32_t min_io_size;
> > > >        uint32_t opt_io_size;
> > > >        int32_t bootindex;
> > > >        uint32_t discard_granularity;
> > > > @@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
> > > >                              _conf.logical_block_size),                    \
> > > >        DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
> > > >                              _conf.physical_block_size),                   \
> > > > -    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
> > > > +    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),    \
> > > >        DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
> > > >        DEFINE_PROP_UINT32("discard_granularity", _state,                   \
> > > >                           _conf.discard_granularity, -1),                  \
> > > > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> > > > index f161604fb6..f9e0f8c041 100644
> > > > --- a/include/hw/qdev-properties.h
> > > > +++ b/include/hw/qdev-properties.h
> > > > @@ -197,7 +197,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
> > > >    #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
> > > >        DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
> > > >    #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> > > > -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> > > > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
> > > >    #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
> > > >        DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
> > > >    #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> > > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > > > index 2047114fca..e673f3c43f 100644
> > > > --- a/hw/core/qdev-properties.c
> > > > +++ b/hw/core/qdev-properties.c
> > > > @@ -14,6 +14,7 @@
> > > >    #include "qapi/visitor.h"
> > > >    #include "chardev/char.h"
> > > >    #include "qemu/uuid.h"
> > > > +#include "qemu/units.h"
> > > >    void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
> > > >                                      Error **errp)
> > > > @@ -729,30 +730,42 @@ const PropertyInfo qdev_prop_pci_devfn = {
> > > >    /* --- blocksize --- */
> > > > +/* lower limit is sector size */
> > > > +#define MIN_BLOCK_SIZE          512
> > > > +#define MIN_BLOCK_SIZE_STR      "512 B"
> > > > +/*
> > > > + * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
> > > > + * matches qcow2 cluster size limit
> > > > + */
> > > > +#define MAX_BLOCK_SIZE          (2 * MiB)
> > > > +#define MAX_BLOCK_SIZE_STR      "2 MiB"
> > > > +
> > > >    static void set_blocksize(Object *obj, Visitor *v, const char *name,
> > > >                              void *opaque, Error **errp)
> > > >    {
> > > >        DeviceState *dev = DEVICE(obj);
> > > >        Property *prop = opaque;
> > > > -    uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
> > > > +    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> > > > +    uint64_t value;
> > > >        Error *local_err = NULL;
> > > > -    const int64_t min = 512;
> > > > -    const int64_t max = 32768;
> > > >        if (dev->realized) {
> > > >            qdev_prop_set_after_realize(dev, name, errp);
> > > >            return;
> > > >        }
> > > > -    visit_type_uint16(v, name, &value, &local_err);
> > > > +    visit_type_size(v, name, &value, &local_err);
> > > >        if (local_err) {
> > > >            error_propagate(errp, local_err);
> > > >            return;
> > > >        }
> > > >        /* value of 0 means "unset" */
> > > > -    if (value && (value < min || value > max)) {
> > > > -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
> > > > -                   dev->id ? : "", name, (int64_t)value, min, max);
> > > > +    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
> > > > +        error_setg(errp,
> > > > +                   "Property %s.%s doesn't take value %" PRIu64
> > > > +                   " (minimum: " MIN_BLOCK_SIZE_STR
> > > > +                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
> > > > +                   dev->id ? : "", name, value);
> > > >            return;
> > > >        }
> > > > @@ -768,9 +781,10 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
> > > >    }
> > > >    const PropertyInfo qdev_prop_blocksize = {
> > > > -    .name  = "uint16",
> > > > -    .description = "A power of two between 512 and 32768",
> > > > -    .get   = get_uint16,
> > > > +    .name  = "size",
> > > > +    .description = "A power of two between " MIN_BLOCK_SIZE_STR
> > > > +                   " and " MAX_BLOCK_SIZE_STR,
> > > > +    .get   = get_uint32,
> > > >        .set   = set_blocksize,
> > > >        .set_default_value = set_default_value_uint,
> > > >    };
> > > > 
> > > 
> > > 1/ Don't you need to update SCSIBlockLimits too?
> > 
> > I guess you mean SCSIBlockLimits.min_io_size which is the only uint16_t
> > field there, do you?
> 
> Yes.
> 
> > 
> > > 2/ It seems hw/block/virtio-blk.c can get underflow now.
> > 
> > Both SCSIBlockLimits.min_io_size and virtio_blk_config.min_io_size are
> > expressed in logical blocks so there appears to be no problem here.
> > 
> > > Maybe you miss this change:
> > > 
> > > -- >8 --
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -917,7 +917,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev,
> > > uint8_t *config)
> > >                    s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 -
> > > 2);
> > >       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
> > >       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
> > > -    virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
> > > +    virtio_stl_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
> > 
> > The width of this field in the device's config space is defined in the
> > spec and can't be changed.
> > 
> > Nor is there any need due to this patch.
> 
> OK, thanks :)

May I count this as an r-b? :)

Thanks,
Roman.

