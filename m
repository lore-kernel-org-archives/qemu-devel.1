Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23733C35250
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 07:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E161E20733
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 07:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1VTu770"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E161E20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0hLx-0000iR-Vx
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 02:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j0hLI-0000EN-80
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 02:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j0hLF-0005Mt-LG
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 02:49:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j0hLF-0005HB-9y
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 02:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581234560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGaF0tV0BJ0+NvSYlHAFoFJNQjtLdNbrd/EkPHQsIHk=;
 b=d1VTu770oCxFRR6BJMpRuucLIOMi+THec6TdnPQGIZWu7cytJrh/yAUbtAmPKQ+2A2zCj7
 a+elYjbsuw+GOkGRJEz2iIHSossDj3NrRQi1hrODzOkT/WWjepNxn5CIVBT4+SfMT9XtJo
 PC08R2++MVp2f4Ca3WLgNOFHCr3bjK8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-Gtc4AdVJOqWUjULJ0CYpag-1; Sun, 09 Feb 2020 02:49:16 -0500
Received: by mail-qk1-f199.google.com with SMTP id y6so2541685qki.13
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 23:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PVmN1YUoVFUlADWAK0P0uJ/vuhRwYwRZUwiYuM6b9/4=;
 b=m72E6vDRgyrTdfhSm0eaVz4ySA/KI5H6e1usiWn64SEK264wM1qHjQOjQckU2HgH+s
 GVY5li7XuN/MPPuWdl09VfOc2Ag8IGJZs3nV+o7ysOxcZ0YHDUTgAGD2fEyRo6vkCt5R
 j2NHw71yoHvS2SnFEnKI2ASN1hnXaOmzFZ8Zdr7ge+avRslpxGu+WZEXOTLTzG5B6WQ9
 2NY9sioIGsI7CbccEDHZPu/SR3IiUm/86axs5O1VetN5AKzXjEcppalHVNxnUug3aSBH
 j5op0XV9BV5YHWXr63jFgUzVNlYBgF89CoCriwi+CGAEN1TFlSu58lz1bx69CU5HxIMm
 yKYA==
X-Gm-Message-State: APjAAAWCZ5knTu1jn/rLyWX2zxWxmZdGrvpKfwegWI9Q9zkWnpRKJqkM
 wiu3I/NhUGLUeQtPynriRd/izJ5cm7GLrW8RfGycOlzybxQvBZzZGu5OgY/bcVu++xHGl39yBYM
 pG4Qdr1ahHKbnY4g=
X-Received: by 2002:ae9:e115:: with SMTP id g21mr5747410qkm.187.1581234556404; 
 Sat, 08 Feb 2020 23:49:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTbRfoV9CeYgj15idM1vs8U3sFvl7F7DFNlN3JewiXFKuVI3Woz7X7ksqP35fpUnQ7EpjTHA==
X-Received: by 2002:ae9:e115:: with SMTP id g21mr5747389qkm.187.1581234556050; 
 Sat, 08 Feb 2020 23:49:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id x22sm4173676qtq.30.2020.02.08.23.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 23:49:14 -0800 (PST)
Date: Sun, 9 Feb 2020 02:49:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
Message-ID: <20200209024650-mutt-send-email-mst@kernel.org>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
 <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
 <20200205111905.GE58062@stefanha-x1.localdomain>
 <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
X-MC-Unique: Gtc4AdVJOqWUjULJ0CYpag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 11:48:05AM +0300, Denis Plotnikov wrote:
>=20
>=20
> On 05.02.2020 14:19, Stefan Hajnoczi wrote:
> > On Tue, Feb 04, 2020 at 12:59:04PM +0300, Denis Plotnikov wrote:
> > >=20
> > > On 30.01.2020 17:58, Stefan Hajnoczi wrote:
> > > > On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
> > > > > The goal is to reduce the amount of requests issued by a guest on
> > > > > 1M reads/writes. This rises the performance up to 4% on that kind=
 of
> > > > > disk access pattern.
> > > > >=20
> > > > > The maximum chunk size to be used for the guest disk accessing is
> > > > > limited with seg_max parameter, which represents the max amount o=
f
> > > > > pices in the scatter-geather list in one guest disk request.
> > > > >=20
> > > > > Since seg_max is virqueue_size dependent, increasing the virtqueu=
e
> > > > > size increases seg_max, which, in turn, increases the maximum siz=
e
> > > > > of data to be read/write from guest disk.
> > > > >=20
> > > > > More details in the original problem statment:
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.ht=
ml
> > > > >=20
> > > > > Suggested-by: Denis V. Lunev <den@openvz.org>
> > > > > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > > > ---
> > > > >    hw/core/machine.c          | 3 +++
> > > > >    include/hw/virtio/virtio.h | 2 +-
> > > > >    2 files changed, 4 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index 3e288bfceb..8bc401d8b7 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -28,6 +28,9 @@
> > > > >    #include "hw/mem/nvdimm.h"
> > > > >    GlobalProperty hw_compat_4_2[] =3D {
> > > > > +    { "virtio-blk-device", "queue-size", "128"},
> > > > > +    { "virtio-scsi-device", "virtqueue_size", "128"},
> > > > > +    { "vhost-blk-device", "virtqueue_size", "128"},
> > > > vhost-blk-device?!  Who has this?  It's not in qemu.git so please o=
mit
> > > > this line. ;-)
> > > So in this case the line:
> > >=20
> > > { "vhost-blk-device", "seg_max_adjust", "off"},
> > >=20
> > > introduced by my patch:
> > >=20
> > > commit 1bf8a989a566b2ba41c197004ec2a02562a766a4
> > > Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > Date:=A0=A0 Fri Dec 20 17:09:04 2019 +0300
> > >=20
> > >  =A0=A0=A0 virtio: make seg_max virtqueue size dependent
> > >=20
> > > is also wrong. It should be:
> > >=20
> > > { "vhost-scsi-device", "seg_max_adjust", "off"},
> > >=20
> > > Am I right?
> > It's just called "vhost-scsi":
> >=20
> > include/hw/virtio/vhost-scsi.h:#define TYPE_VHOST_SCSI "vhost-scsi"
> >=20
> > > > On the other hand, do you want to do this for the vhost-user-blk,
> > > > vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?  Th=
ose
> > > > devices would benefit from better performance too.
> After thinking about that for a while, I think we shouldn't extend queue
> sizes for vhost-user-blk, vhost-user-scsi and vhost-scsi.
> This is because increasing the queue sizes seems to be just useless for
> them: the all thing is about increasing the queue sizes for increasing
> seg_max (it limits the max block query size from the guest). For
> virtio-blk-device and virtio-scsi-device it makes sense, since they have
> seg-max-adjust property which, if true, sets seg_max to virtqueue_size-2.
> vhost-scsi also have this property but it seems the property just doesn't
> affect anything (remove it?).
> Also vhost-user-blk, vhost-user-scsi and vhost-scsi don't do any seg_max
> settings. If I understand correctly, their backends are ment to be
> responsible for doing that.

The queue size is set by qemu IIRC.

> So, what about changing the queue sizes just for virtio-blk-device and
> virtio-scsi-device?


Hmm that would break ability to migrate between userspace and vhost
backends, would it not?


> Denis
>=20
> > > It seems to be so. We also have the test checking those settings:
> > > tests/acceptance/virtio_seg_max_adjust.py
> > > For now it checks virtio-scsi-pci and virtio-blk-pci.
> > > I'm going to extend it for the virtqueue size checking.
> > > If I change vhost-user-blk, vhost-user-scsi and vhost-scsi it's worth
> > > to check those devices too. But I don't know how to form a command li=
ne
> > > for that 3 devices since they should involve some third party compone=
nts as
> > > backends (kernel modules, DPDK, etc.) and they seems to be not availa=
ble in
> > > the
> > > qemu git.
> > > Is there any way to do it with some qit.qemu available stubs or somet=
hing
> > > else?
> > > If so, could you please point out the proper way to do it?
> > qemu.git has contrib/vhost-user-blk/ and contrib/vhost-user-scsi/ if
> > you need to test those vhost-user devices without external dependencies=
.
> >=20
> > Stefan


