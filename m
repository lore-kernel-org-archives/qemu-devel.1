Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF54C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F402084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WicLDXb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F402084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXLZ-0001iG-Ip
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdXKU-0000lK-Fn; Tue, 26 May 2020 07:01:06 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:43522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdXKP-0003zi-O5; Tue, 26 May 2020 07:01:04 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C35D62E150E;
 Tue, 26 May 2020 14:00:56 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 JMcopHcGl9-0rYGgmg8; Tue, 26 May 2020 14:00:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590490856; bh=WdFz9z0QiFAQnIibXowXTLX1vGBDItjyMrIkdL5lb/c=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=WicLDXb2Tc+uhJoArk5HRbwm8SMI9PoblZTYXSWl0G1etzXU5mJ9VfeHWu2HFXlhg
 7WmQ+QbM7l/wqFzipwzEHbA9iFl4mVkAL62WnBH8L///O/sdiuKaYZmdV3dxbCvL9w
 yZM/J7oO/3uNRirAecrtXyarkCDK5PlNdqoFd9g4=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net
 [2a02:6b8:b080:8909::1:0])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 knwNKeuyGy-0rXqVWTF; Tue, 26 May 2020 14:00:53 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Tue, 26 May 2020 14:00:52 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 0/5] block: widen and check consistency of
 size-related BlockConf properties
Message-ID: <20200526110052.GA6355@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20200526081740.256236-1-rvkagan@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526081740.256236-1-rvkagan@yandex-team.ru>
Received-SPF: pass client-ip=5.45.199.163; envelope-from=rvkagan@yandex-team.ru;
 helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 07:00:57
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please ignore the series, I forgot xen-block device.

Roman.

On Tue, May 26, 2020 at 11:17:35AM +0300, Roman Kagan wrote:
> BlockConf includes several properties counted in bytes.
> 
> Enhance their handling in a some aspects, specifically
> 
> - accept common size suffixes (k, m)
> - perform consistency checks on the values, to prevent their silent
>   truncation and rounding
> - lift the upper limit on physical_block_size and logical_block_size
> 
> Also fix the accessor for opt_io_size in virtio-blk to make it match the size
> of the field.
> 
> History:
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
> Roman Kagan (5):
>   virtio-blk: store opt_io_size with correct size
>   block: consolidate blocksize properties consistency checks
>   qdev-properties: blocksize: use same limits in code and description
>   block: make size-related BlockConf properties accept size suffixes
>   block: lift blocksize property limit to 2 MiB
> 
>  include/hw/block/block.h     |  18 +-
>  include/hw/qdev-properties.h |   2 +-
>  hw/block/block.c             |  64 ++++-
>  hw/block/fdc.c               |   5 +-
>  hw/block/nvme.c              |   5 +-
>  hw/block/virtio-blk.c        |   9 +-
>  hw/core/qdev-properties.c    | 109 +++----
>  hw/ide/qdev.c                |   5 +-
>  hw/scsi/scsi-disk.c          |  12 +-
>  hw/usb/dev-storage.c         |   5 +-
>  tests/qemu-iotests/172.out   | 532 +++++++++++++++++------------------
>  11 files changed, 423 insertions(+), 343 deletions(-)
> 
> -- 
> 2.26.2
> 
> 

