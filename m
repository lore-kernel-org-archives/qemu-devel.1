Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE89020671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH9dO+V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE89020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR2A-0006hJ-08
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbR1P-0005Eb-Ho
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:52:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38350
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbR1O-00019O-Rn
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589989962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFsEpvTxPW3ElWyQyYoRef9LUjtzesHVQu26J2kXqls=;
 b=DH9dO+V7xX8r25SgE8JtxEJLcxx37AZh2FzNOUDcnqnGVVb/n36/hcNCesrDXSuBTd0D1l
 ELuPaWZHky/P4Y99WArvl++ra6vb1O20h9tGYIZExmCMYZ41wivhndDGm27JrgykP1vti2
 cu9UgyQvKwlr9doI22kDu8Uc9fq4J3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-dHGOMePZO3KeaQaE-DbU9A-1; Wed, 20 May 2020 11:52:38 -0400
X-MC-Unique: dHGOMePZO3KeaQaE-DbU9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F64D19200C0;
 Wed, 20 May 2020 15:52:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E71610640E2;
 Wed, 20 May 2020 15:52:23 +0000 (UTC)
Date: Wed, 20 May 2020 17:52:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 2/3] block: consolidate blocksize properties
 consistency checks
Message-ID: <20200520155221.GF5192@linux.fritz.box>
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-3-rvkagan@yandex-team.ru>
 <ae8e02be-8cce-6b4d-dc12-4c2c70a8d1a0@redhat.com>
 <CAP+75-U0SsdBeK-6gzjrjeBN099FnM15_qU6JZ2Fy6H8aNA1uA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+75-U0SsdBeK-6gzjrjeBN099FnM15_qU6JZ2Fy6H8aNA1uA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Roman Kagan <rvkagan@yandex-team.ru>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.05.2020 um 10:59 hat Philippe Mathieu-Daudé geschrieben:
> On Wed, May 20, 2020 at 10:57 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
> >
> > Hi Roman,
> >
> > On 5/20/20 10:06 AM, Roman Kagan wrote:
> > > Several block device properties related to blocksize configuration must
> > > be in certain relationship WRT each other: physical block must be no
> > > smaller than logical block; min_io_size, opt_io_size, and
> > > discard_granularity must be a multiple of a logical block.
> > >
> > > To ensure these requirements are met, add corresponding consistency
> > > checks to blkconf_blocksizes, adjusting its signature to communicate
> > > possible error to the caller.  Also remove the now redundant consistency
> > > checks from the specific devices.
> > >
> > > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > > ---
> > > v4: new patch
> > >
> > >   include/hw/block/block.h   |  2 +-
> > >   hw/block/block.c           | 29 ++++++++++++++++++++++++++++-
> > >   hw/block/fdc.c             |  5 ++++-
> > >   hw/block/nvme.c            |  5 ++++-
> > >   hw/block/virtio-blk.c      |  7 +------
> > >   hw/ide/qdev.c              |  5 ++++-
> > >   hw/scsi/scsi-disk.c        | 10 +++-------
> > >   hw/usb/dev-storage.c       |  5 ++++-
> > >   tests/qemu-iotests/172.out |  2 +-
> > >   9 files changed, 50 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> > > index d7246f3862..784953a237 100644
> > > --- a/include/hw/block/block.h
> > > +++ b/include/hw/block/block.h
> > > @@ -87,7 +87,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
> > >   bool blkconf_geometry(BlockConf *conf, int *trans,
> > >                         unsigned cyls_max, unsigned heads_max, unsigned secs_max,
> > >                         Error **errp);
> > > -void blkconf_blocksizes(BlockConf *conf);
> > > +bool blkconf_blocksizes(BlockConf *conf, Error **errp);
> 
> Maybe rename blkconf_validate_blocksizes()?

It does more than validating. It also assigns defaults or guesses
settings from the host file.

Kevin


