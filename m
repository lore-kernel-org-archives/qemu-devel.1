Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFAEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A4E20823
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5r3XOlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A4E20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2vh-0001cd-8g
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb2v8-00016C-9f
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:08:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb2v5-0000eF-Os
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589897314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0T7lddR9O1Ws9vMaltFThQxGXSZm71705Dl+BpBRBg=;
 b=c5r3XOlr5PE7Y1XUKt0ssvlszK6LwrxLAAumKq4MT9qc+Na6TjiSrCDuulLTVs+3y3VrCh
 oyo/ReY2xmEfsjfJ5vl3evCsaNwM07jB/ogbbdHuy7lLKryeTYhLFTs3DWgBZmLbqAEYvh
 IYXLAepJzVcpU3jYsQ7Ny6vab28uuHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-qs_FumUaO5ym015efKlaTA-1; Tue, 19 May 2020 10:08:31 -0400
X-MC-Unique: qs_FumUaO5ym015efKlaTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 306F01005510;
 Tue, 19 May 2020 14:08:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79FE26155F;
 Tue, 19 May 2020 14:08:28 +0000 (UTC)
Date: Tue, 19 May 2020 16:08:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Roman Kagan <rvkagan@yandex-team.ru>
Subject: Re: [PATCH v3] block: make BlockConf.*_size properties 32-bit
Message-ID: <20200519140826.GM7652@linux.fritz.box>
References: <20200429091813.1469510-1-rvkagan@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200429091813.1469510-1-rvkagan@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.04.2020 um 11:18 hat Roman Kagan geschrieben:
> Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
> 32-bit for logical_block_size, physical_block_size, and min_io_size.
> However, the properties in BlockConf are defined as uint16_t limiting
> the values to 32768.
> 
> This appears unnecessary tight, and we've seen bigger block sizes handy
> at times.
> 
> Make them 32 bit instead and lift the limitation up to 2 MiB which
> appears to be good enough for everybody, and matches the qcow2 cluster
> size limit.
> 
> As the values can now be fairly big and awkward to type, make the
> property setter accept common size suffixes (k, m).
> 
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> v2 -> v3:
> - mention qcow2 cluster size limit in the log and comment [Eric]
> 
> v1 -> v2:
> - cap the property at 2 MiB [Eric]
> - accept size suffixes
> 
>  include/hw/block/block.h     |  8 ++++----
>  include/hw/qdev-properties.h |  2 +-
>  hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
>  3 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index d7246f3862..9dd6bba56a 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -18,9 +18,9 @@
>  
>  typedef struct BlockConf {
>      BlockBackend *blk;
> -    uint16_t physical_block_size;
> -    uint16_t logical_block_size;
> -    uint16_t min_io_size;
> +    uint32_t physical_block_size;
> +    uint32_t logical_block_size;
> +    uint32_t min_io_size;
>      uint32_t opt_io_size;
>      int32_t bootindex;
>      uint32_t discard_granularity;
> @@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
>                            _conf.logical_block_size),                    \
>      DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
>                            _conf.physical_block_size),                   \
> -    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
> +    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),    \

This one doesn't go through set_blocksize(), so does the 2 MB
limitation actually not apply to min_io_size?

Let's go back to the line that Philippe already quoted:

    virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);

This means that we'll get silent 16 bit truncation of the size specified
by the user. This is the new bug. In addition, like before, we also
silently round down to the next multiple of the logical block size.

Of course, opt_io_size already has the same problems. I wonder whether
both should be converted to DEFINE_PROP_BLOCKSIZE. In either case, I
think virtio_blk_device_realize() must check that both values are
plausible; even if we use a block size property, it still needs to
verify that they are a multiple of the block size.

The same thing is true of hw/scsi/scsi-disk.c.

All other devices with DEFINE_BLOCK_PROPERTIES accept a value, but
silently ignore it, so nothing changes for them (though it's also not
the perfect state).

>      DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
>      DEFINE_PROP_UINT32("discard_granularity", _state,                   \
>                         _conf.discard_granularity, -1),                  \
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index f161604fb6..f9e0f8c041 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -197,7 +197,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>  #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
>  #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)

The 2 MB limit means that we won't get 16 bit truncation for anything
that is stored in sectors (512 * 64k = 32M).

As far as I can see, all devices can deal with this change then.

>  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
>  #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 2047114fca..e673f3c43f 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -14,6 +14,7 @@
>  #include "qapi/visitor.h"
>  #include "chardev/char.h"
>  #include "qemu/uuid.h"
> +#include "qemu/units.h"
>  
>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                    Error **errp)
> @@ -729,30 +730,42 @@ const PropertyInfo qdev_prop_pci_devfn = {
>  
>  /* --- blocksize --- */
>  
> +/* lower limit is sector size */
> +#define MIN_BLOCK_SIZE          512
> +#define MIN_BLOCK_SIZE_STR      "512 B"
> +/*
> + * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
> + * matches qcow2 cluster size limit
> + */
> +#define MAX_BLOCK_SIZE          (2 * MiB)
> +#define MAX_BLOCK_SIZE_STR      "2 MiB"
> +
>  static void set_blocksize(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>  {
>      DeviceState *dev = DEVICE(obj);
>      Property *prop = opaque;
> -    uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint64_t value;
>      Error *local_err = NULL;
> -    const int64_t min = 512;
> -    const int64_t max = 32768;
>  
>      if (dev->realized) {
>          qdev_prop_set_after_realize(dev, name, errp);
>          return;
>      }
>  
> -    visit_type_uint16(v, name, &value, &local_err);
> +    visit_type_size(v, name, &value, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>      /* value of 0 means "unset" */
> -    if (value && (value < min || value > max)) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
> -                   dev->id ? : "", name, (int64_t)value, min, max);
> +    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
> +        error_setg(errp,
> +                   "Property %s.%s doesn't take value %" PRIu64
> +                   " (minimum: " MIN_BLOCK_SIZE_STR
> +                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
> +                   dev->id ? : "", name, value);
>          return;
>      }
>  
> @@ -768,9 +781,10 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
>  }
>  
>  const PropertyInfo qdev_prop_blocksize = {
> -    .name  = "uint16",
> -    .description = "A power of two between 512 and 32768",
> -    .get   = get_uint16,
> +    .name  = "size",
> +    .description = "A power of two between " MIN_BLOCK_SIZE_STR
> +                   " and " MAX_BLOCK_SIZE_STR,
> +    .get   = get_uint32,
>      .set   = set_blocksize,
>      .set_default_value = set_default_value_uint,
>  };

This part looks good to me, too.

So I think we just need some additional checks for min_io_size (and
potentially opt_io_size while you're at it). Maybe that could be a
separate patch before this one.

Kevin


