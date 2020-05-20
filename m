Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE95C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A4120823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="qP+lGWpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbWct-0007lU-Vf
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbWbu-0007Dx-Vl; Wed, 20 May 2020 17:50:47 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:57504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbWbr-0003rf-MX; Wed, 20 May 2020 17:50:45 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9E0D72E15FD;
 Thu, 21 May 2020 00:50:37 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net
 (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Re5UCFfqPn-oY2OFLmO; Thu, 21 May 2020 00:50:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590011437; bh=m9GEZkurVaCJLwzGrUVqA0aEgzP8g3I7gWdk8d7nKkE=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=qP+lGWpRX3oCq0DKJzlWNmy/L87kRRkftlhjApCu2pWiONIyUq9X9g0nMLbiYyh9b
 Gk8l7C8PzqHPl/TbEVTVqGFoBDRKoOJPkquN/63xGtfxxNU8T0fvX6skm14d39/CtJ
 KM9LQaxrI25nnne4Jt/EZadHCM6XFVy1QEE3AMAk=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:407::1:16])
 by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 M63wWBdcdM-oYXWcPGW; Thu, 21 May 2020 00:50:34 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Thu, 21 May 2020 00:50:33 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 3/3] block: make BlockConf.*_size properties 32-bit
Message-ID: <20200520215033.GE104207@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-4-rvkagan@yandex-team.ru>
 <20200520155444.GG5192@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520155444.GG5192@linux.fritz.box>
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 05:54:44PM +0200, Kevin Wolf wrote:
> Am 20.05.2020 um 10:06 hat Roman Kagan geschrieben:
> > Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
> > 32-bit for logical_block_size, physical_block_size, and min_io_size.
> > However, the properties in BlockConf are defined as uint16_t limiting
> > the values to 32768.
> > 
> > This appears unnecessary tight, and we've seen bigger block sizes handy
> > at times.
> > 
> > Make them 32 bit instead and lift the limitation up to 2 MiB which
> > appears to be good enough for everybody, and matches the qcow2 cluster
> > size limit.
> > 
> > As the values can now be fairly big and awkward to type, make the
> > property setter accept common size suffixes (k, m).
> > 
> > Also as the devices which use min_io_size (virtio-blk and scsi) pass its
> > value to the guest in units of logical blocks in a 16bit field, to
> > prevent its silent truncation add a corresponding check to
> > blkconf_blocksizes.
> > 
> > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > ---
> > v3 -> v4:
> > - check min_io_size against truncation [Kevin]
> > 
> > v2 -> v3:
> > - mention qcow2 cluster size limit in the log and comment [Eric]
> > 
> > v1 -> v2:
> > - cap the property at 2 MiB [Eric]
> > - accept size suffixes
> > 
> >  include/hw/block/block.h     |  8 ++++----
> >  include/hw/qdev-properties.h |  2 +-
> >  hw/block/block.c             | 11 +++++++++++
> >  hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
> >  4 files changed, 40 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> > index 784953a237..2fa09aa0b1 100644
> > --- a/include/hw/block/block.h
> > +++ b/include/hw/block/block.h
> > @@ -18,9 +18,9 @@
> >  
> >  typedef struct BlockConf {
> >      BlockBackend *blk;
> > -    uint16_t physical_block_size;
> > -    uint16_t logical_block_size;
> > -    uint16_t min_io_size;
> > +    uint32_t physical_block_size;
> > +    uint32_t logical_block_size;
> > +    uint32_t min_io_size;
> >      uint32_t opt_io_size;
> >      int32_t bootindex;
> >      uint32_t discard_granularity;
> > @@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
> >                            _conf.logical_block_size),                    \
> >      DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
> >                            _conf.physical_block_size),                   \
> > -    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
> > +    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),    \
> >      DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
> >      DEFINE_PROP_UINT32("discard_granularity", _state,                   \
> >                         _conf.discard_granularity, -1),                  \
> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> > index f161604fb6..f9e0f8c041 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -197,7 +197,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
> >  #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
> >  #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> > -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
> >  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
> >      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
> >  #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> > diff --git a/hw/block/block.c b/hw/block/block.c
> > index 5f8ebff59c..cd95e7e38f 100644
> > --- a/hw/block/block.c
> > +++ b/hw/block/block.c
> > @@ -96,6 +96,17 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
> >          return false;
> >      }
> >  
> > +    /*
> > +     * all devices which support min_io_size (scsi and virtio-blk) expose it to
> > +     * the guest as a uint16_t in units of logical blocks
> > +     */
> > +    if ((conf->min_io_size / conf->logical_block_size) > UINT16_MAX) {
> > +        error_setg(errp,
> > +                   "min_io_size must be no more than " stringify(UINT16_MAX)
> > +                   " of logical_block_size");
> 
> I'm not a native speaker, but "no more than 65536 of
> logical_block_size" sounds odd to me.

Neither am I but I agree with the feeling.

> Maybe "65536 times the logical_block_size"?

Sounds better indeed, will do in the respin.
Or perhaps "no more than 65536 logical blocks"?

Thanks,
Roman.

> 
> > +        return false;
> > +    }
> > +
> >      if (conf->opt_io_size % conf->logical_block_size) {
> >          error_setg(errp,
> >                     "opt_io_size must be a multple of logical_block_size");
> 
> Kevin
> 

