Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FFDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63422075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7xp9eVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63422075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKa8-0003Qm-Vd
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKZV-0002ep-9m
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:59:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKZU-0001oW-IE
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589965167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6el3VwidVQkMcQzAUY7i407EukSnYG3NaKZcpd7e38=;
 b=U7xp9eVNIZxfmnihnXr6geyGCWMLM5797doBw51Tlg4L4pRpqCw3tYVl/YXiFYy68o9Cor
 XwiPNlZj7Gv/iv6sbrtXCHgmMXJGnEvb+XwYYYADVeYEWUElBJYBtK6D0znl5cyf6Qsbt4
 EVLaAAegir7MavXiqpO53739cvl5Ffo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-y6jL0zsdNNmS14PoLWFSZA-1; Wed, 20 May 2020 04:59:26 -0400
X-MC-Unique: y6jL0zsdNNmS14PoLWFSZA-1
Received: by mail-wr1-f70.google.com with SMTP id 90so1105319wrg.23
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+6el3VwidVQkMcQzAUY7i407EukSnYG3NaKZcpd7e38=;
 b=jFFuaIRIYNRVOgXl4XNOKpaHF8A624tWEr6R3np1A1Rzher//XFigLNvlhAHg9gQD8
 9cc+5i9mYLrDtyL+bog7RUGkZujzSEb4j8EuUF7atotmD0OM5wEviGbmuiDZPlz74uJ5
 2Vbugz4s5r+ffEi+8qDstOGXlyQn1/jEUsfQM/Q9A5EBotYq44zSGbhv6Ij6bnHpe6p2
 rtz7gID1GiO/Kz0FfkJUZMaKE6VnPV9lSdNzkf5BDFVsOqphFiaXZVZU6F/VbgFQxt+S
 1ZKvqDH0JTkRlW/SLvgrXIOoA/1nef7mrFdbvrZA3r0KaRrbWk027G6hbAEURdkqnQ1q
 2lfQ==
X-Gm-Message-State: AOAM531ULkyaCpYKnnaVPJrrydzC+a0nKIoM9faKUPC1tl1/GFUlKE34
 CbMyRn6sf4LALhfqYDZVDxVb2DvTjFcgifS8mgLR1ABU5MlHh/elQUc8AWZTbKlbUjgKccwmybb
 V79jyMdhIqE6dzCk0yumhcdBrXqyisXo=
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr3134430wrw.17.1589965163134;
 Wed, 20 May 2020 01:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0f0kPOFlquIF1FU3e2FrWkKYXg5o5/npW6mGDdEW23EEwnvTaglVMhD+3ECDT8xQmW7lswvKnePFjEC8LQMI=
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr3134413wrw.17.1589965162934;
 Wed, 20 May 2020 01:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-3-rvkagan@yandex-team.ru>
 <ae8e02be-8cce-6b4d-dc12-4c2c70a8d1a0@redhat.com>
In-Reply-To: <ae8e02be-8cce-6b4d-dc12-4c2c70a8d1a0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 May 2020 10:59:11 +0200
Message-ID: <CAP+75-U0SsdBeK-6gzjrjeBN099FnM15_qU6JZ2Fy6H8aNA1uA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] block: consolidate blocksize properties
 consistency checks
To: Roman Kagan <rvkagan@yandex-team.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 10:57 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Roman,
>
> On 5/20/20 10:06 AM, Roman Kagan wrote:
> > Several block device properties related to blocksize configuration must
> > be in certain relationship WRT each other: physical block must be no
> > smaller than logical block; min_io_size, opt_io_size, and
> > discard_granularity must be a multiple of a logical block.
> >
> > To ensure these requirements are met, add corresponding consistency
> > checks to blkconf_blocksizes, adjusting its signature to communicate
> > possible error to the caller.  Also remove the now redundant consistenc=
y
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
> > @@ -87,7 +87,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, v=
oid *buf, hwaddr size,
> >   bool blkconf_geometry(BlockConf *conf, int *trans,
> >                         unsigned cyls_max, unsigned heads_max, unsigned=
 secs_max,
> >                         Error **errp);
> > -void blkconf_blocksizes(BlockConf *conf);
> > +bool blkconf_blocksizes(BlockConf *conf, Error **errp);

Maybe rename blkconf_validate_blocksizes()?

> >   bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
> >                                      bool resizable, Error **errp);
> >
[...]


