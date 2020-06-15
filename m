Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B3AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 18:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05482080D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 18:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BHcdKOqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05482080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jktWp-0001Zb-9p
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 14:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jktUG-0006JI-7D; Mon, 15 Jun 2020 14:05:36 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:38948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jktUB-0008Sk-Kx; Mon, 15 Jun 2020 14:05:34 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id C5F052E15A6;
 Mon, 15 Jun 2020 21:05:24 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net
 (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 8QHNbBaHmb-5Ka82GjA; Mon, 15 Jun 2020 21:05:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1592244324; bh=xm8NBmAShTjxBdIzgaGbM6kRTaHHnu7nJyv1yfP8QzY=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=BHcdKOqAaezM8nX/rmBd0yekLRkAj+47CQsQxYB0wqLsWLGkthbXhHfsARxR2sj0P
 4nmSEqFRZUyPh1sXc4UB/1o3rFb1JpzDf5rrfikhWJZmUa9K0eMwSFmsJWKzsMz6gb
 /wgUm7AR4BKH362TaEutyxPN/vyz4svjz5Wb1I5k=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7317::1:4])
 by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 JsFWVHDsbr-5JlqCpJO; Mon, 15 Jun 2020 21:05:20 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Mon, 15 Jun 2020 21:05:18 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 0/8] block: enhance handling of size-related BlockConf
 properties
Message-ID: <20200615180518.GA4032@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
References: <20200528225516.1676602-1-rvkagan@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528225516.1676602-1-rvkagan@yandex-team.ru>
Received-SPF: pass client-ip=77.88.29.217; envelope-from=rvkagan@yandex-team.ru;
 helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 14:05:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 xen-devel@lists.xenproject.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 01:55:08AM +0300, Roman Kagan wrote:
> BlockConf includes several properties counted in bytes.
> 
> Enhance their handling in some aspects, specifically
> 
> - accept common size suffixes (k, m)
> - perform consistency checks on the values
> - lift the upper limit on physical_block_size and logical_block_size
> 
> Also fix the accessor for opt_io_size in virtio-blk to make it consistent with
> the size of the field.
> 
> History:
> v7 -> v8:
> - replace stringify with %u in error messages [Eric]
> - fix wording in logs [Eric]
> 
> v6 -> v7:
> - avoid overflow in min_io_size check [Eric]
> - try again to perform the art form in patch splitting [Eric]
> 
> v5 -> v6:
> - fix forgotten xen-block and swim
> - add prop_size32 instead of going with 64bit
> 
> v4 -> v5:
> - re-split the patches [Philippe]
> - fix/reword error messages [Philippe, Kevin]
> - do early return on failed consistency check [Philippe]
> - use QEMU_IS_ALIGNED instead of open coding [Philippe]
> - make all BlockConf size props support suffixes
> - expand the log for virtio-blk opt_io_size [Michael]
> 
> v3 -> v4:
> - add patch to fix opt_io_size width in virtio-blk
> - add patch to perform consistency checks [Kevin]
> - check min_io_size against truncation [Kevin]
> 
> v2 -> v3:
> - mention qcow2 cluster size limit in the log and comment [Eric]
> 
> v1 -> v2:
> - cap the property at 2 MiB [Eric]
> - accept size suffixes
> 
> Roman Kagan (8):
>   virtio-blk: store opt_io_size with correct size
>   block: consolidate blocksize properties consistency checks
>   qdev-properties: blocksize: use same limits in code and description
>   qdev-properties: add size32 property type
>   qdev-properties: make blocksize accept size suffixes
>   block: make BlockConf size props 32bit and accept size suffixes
>   qdev-properties: add getter for size32 and blocksize
>   block: lift blocksize property limit to 2 MiB
> 
>  include/hw/block/block.h     |  14 +-
>  include/hw/qdev-properties.h |   5 +-
>  hw/block/block.c             |  40 ++-
>  hw/block/fdc.c               |   5 +-
>  hw/block/nvme.c              |   5 +-
>  hw/block/swim.c              |   5 +-
>  hw/block/virtio-blk.c        |   9 +-
>  hw/block/xen-block.c         |   6 +-
>  hw/core/qdev-properties.c    |  85 +++++-
>  hw/ide/qdev.c                |   5 +-
>  hw/scsi/scsi-disk.c          |  12 +-
>  hw/usb/dev-storage.c         |   5 +-
>  tests/qemu-iotests/172.out   | 532 +++++++++++++++++------------------
>  13 files changed, 419 insertions(+), 309 deletions(-)

Ping?

