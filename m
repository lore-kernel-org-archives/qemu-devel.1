Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA6C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E04D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkPI81Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E04D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1SrA-0004x0-BX
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1SqD-0004Q1-BN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1SqA-0000ju-F1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:32:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1SqA-0000ip-Ay
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581417145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GV8BSyE1Q2kwnEIApBOR1TRiLxDHd8NI/b2nsQlLVxA=;
 b=XkPI81Pbq9/eRmLUvj54izYarrxTQJcf7tRKjIZmNNaoCXdEan+XIoP7opL8XMwdAlt4fv
 OfHFTTnReCYxyElOUcQmz+AYODtCsniJEUNNU7eXgjr7BBeAbD5aiYSztYD3eb7FiPPIos
 OusZublOkNzv0CSAfWRjs8e+E5wx9Yo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-jhnM-ZZnPSSq5liOVR9naQ-1; Tue, 11 Feb 2020 05:32:21 -0500
Received: by mail-qv1-f69.google.com with SMTP id dc2so6868013qvb.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 02:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/LI3vofty+gyeG1XAW/PjNbmafjFWY3ljlIajvKyC0w=;
 b=CGOlgNcwLfB3bz+ilGB4uicqzlNdvUd6vFJ7G2CqHfMpzgRRqu2X6U1bnzKwThVrKd
 eKhg0EmBATHuWaiWmSINj9k0uRVvKLpMWLgWLtkhvSSlFXYVI0S2brjloPIXnUChp8GD
 egzucYN0lna2NIMQo3yRClX/f7L7tv9j6RKheDuEunM+ENP959haXHrvR/tyXh224M5u
 MSPgm4v/ZaurXrE/rk9syYFqKCnTtk7yHiF14ADODShuQxKah2pBBQVZHavxKp4u+0WC
 +97mZca+krSAhJuExRPpLPQeE0O4CaDGwPe7p+9+60BSvcbdk+JdZQiiPi2A4avMJFDF
 uHKQ==
X-Gm-Message-State: APjAAAULo+kd24LhKvPIQUVbEAs/ViGKcBRGjMvfdNpupUO4lasDwND8
 GGKpea537/CkCS2vzYtrz/s+x+KG4GPZzbQ5OVUGvEFVJCJZIf5uC2rkSTC7T/qzuDW4+ZT5s/j
 LcwjAVS7iSCDqUaU=
X-Received: by 2002:a05:620a:1589:: with SMTP id
 d9mr1909335qkk.411.1581417140830; 
 Tue, 11 Feb 2020 02:32:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgPmtPa/VLM/cwPHGbevnmgWWEIM2ywrAjXVdK2F6WBbFq/1sPLYhfkzNtHkbA6LjASi78kQ==
X-Received: by 2002:a05:620a:1589:: with SMTP id
 d9mr1909314qkk.411.1581417140523; 
 Tue, 11 Feb 2020 02:32:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id 16sm1777436qkm.93.2020.02.11.02.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 02:32:19 -0800 (PST)
Date: Tue, 11 Feb 2020 05:32:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
Message-ID: <20200211052534-mutt-send-email-mst@kernel.org>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
 <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
 <20200205111905.GE58062@stefanha-x1.localdomain>
 <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
 <20200209024650-mutt-send-email-mst@kernel.org>
 <0e9663a0-85fe-2d8f-abc7-e30f686ae0be@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <0e9663a0-85fe-2d8f-abc7-e30f686ae0be@virtuozzo.com>
X-MC-Unique: jhnM-ZZnPSSq5liOVR9naQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Mon, Feb 10, 2020 at 06:34:15PM +0300, Denis Plotnikov wrote:
>=20
>=20
> On 09.02.2020 10:49, Michael S. Tsirkin wrote:
> > On Fri, Feb 07, 2020 at 11:48:05AM +0300, Denis Plotnikov wrote:
> > >=20
> > > On 05.02.2020 14:19, Stefan Hajnoczi wrote:
> > > > On Tue, Feb 04, 2020 at 12:59:04PM +0300, Denis Plotnikov wrote:
> > > > > On 30.01.2020 17:58, Stefan Hajnoczi wrote:
> > > > > > On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote=
:
> > > > > > > The goal is to reduce the amount of requests issued by a gues=
t on
> > > > > > > 1M reads/writes. This rises the performance up to 4% on that =
kind of
> > > > > > > disk access pattern.
> > > > > > >=20
> > > > > > > The maximum chunk size to be used for the guest disk accessin=
g is
> > > > > > > limited with seg_max parameter, which represents the max amou=
nt of
> > > > > > > pices in the scatter-geather list in one guest disk request.
> > > > > > >=20
> > > > > > > Since seg_max is virqueue_size dependent, increasing the virt=
queue
> > > > > > > size increases seg_max, which, in turn, increases the maximum=
 size
> > > > > > > of data to be read/write from guest disk.
> > > > > > >=20
> > > > > > > More details in the original problem statment:
> > > > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg0372=
1.html
> > > > > > >=20
> > > > > > > Suggested-by: Denis V. Lunev <den@openvz.org>
> > > > > > > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > > > > > ---
> > > > > > >     hw/core/machine.c          | 3 +++
> > > > > > >     include/hw/virtio/virtio.h | 2 +-
> > > > > > >     2 files changed, 4 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > > > index 3e288bfceb..8bc401d8b7 100644
> > > > > > > --- a/hw/core/machine.c
> > > > > > > +++ b/hw/core/machine.c
> > > > > > > @@ -28,6 +28,9 @@
> > > > > > >     #include "hw/mem/nvdimm.h"
> > > > > > >     GlobalProperty hw_compat_4_2[] =3D {
> > > > > > > +    { "virtio-blk-device", "queue-size", "128"},
> > > > > > > +    { "virtio-scsi-device", "virtqueue_size", "128"},
> > > > > > > +    { "vhost-blk-device", "virtqueue_size", "128"},
> > > > > > vhost-blk-device?!  Who has this?  It's not in qemu.git so plea=
se omit
> > > > > > this line. ;-)
> > > > > So in this case the line:
> > > > >=20
> > > > > { "vhost-blk-device", "seg_max_adjust", "off"},
> > > > >=20
> > > > > introduced by my patch:
> > > > >=20
> > > > > commit 1bf8a989a566b2ba41c197004ec2a02562a766a4
> > > > > Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > > > Date:=A0=A0 Fri Dec 20 17:09:04 2019 +0300
> > > > >=20
> > > > >   =A0=A0=A0 virtio: make seg_max virtqueue size dependent
> > > > >=20
> > > > > is also wrong. It should be:
> > > > >=20
> > > > > { "vhost-scsi-device", "seg_max_adjust", "off"},
> > > > >=20
> > > > > Am I right?
> > > > It's just called "vhost-scsi":
> > > >=20
> > > > include/hw/virtio/vhost-scsi.h:#define TYPE_VHOST_SCSI "vhost-scsi"
> > > >=20
> > > > > > On the other hand, do you want to do this for the vhost-user-bl=
k,
> > > > > > vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?=
  Those
> > > > > > devices would benefit from better performance too.
> > > After thinking about that for a while, I think we shouldn't extend qu=
eue
> > > sizes for vhost-user-blk, vhost-user-scsi and vhost-scsi.
> > > This is because increasing the queue sizes seems to be just useless f=
or
> > > them: the all thing is about increasing the queue sizes for increasin=
g
> > > seg_max (it limits the max block query size from the guest). For
> > > virtio-blk-device and virtio-scsi-device it makes sense, since they h=
ave
> > > seg-max-adjust property which, if true, sets seg_max to virtqueue_siz=
e-2.
> > > vhost-scsi also have this property but it seems the property just doe=
sn't
> > > affect anything (remove it?).
> > > Also vhost-user-blk, vhost-user-scsi and vhost-scsi don't do any seg_=
max
> > > settings. If I understand correctly, their backends are ment to be
> > > responsible for doing that.
> > The queue size is set by qemu IIRC.
> >=20
> > > So, what about changing the queue sizes just for virtio-blk-device an=
d
> > > virtio-scsi-device?
> >=20
> > Hmm that would break ability to migrate between userspace and vhost
> > backends, would it not?
> I'm not sure I've understood what you meant.
> Just for the record, I was going to change virtqueue-size for
> virtio-blk-device and virtio-scsi-device



If virtqueue size is different between virtio-blk-device and
vhost-user-blk then one can not migrate the former to the later.

> since they can adjust seg_max to
> the specified queue size and I don't want to touch vhost-s and vhost-user=
-s
> since they don't have adjustable seg_max for now.
>=20
> Denis



If I just grep seg_max_adjust I see them for vhost devices too.
Is that code ineffective somehow? What's it doing then?

> >=20
> >=20
> > > Denis
> > >=20
> > > > > It seems to be so. We also have the test checking those settings:
> > > > > tests/acceptance/virtio_seg_max_adjust.py
> > > > > For now it checks virtio-scsi-pci and virtio-blk-pci.
> > > > > I'm going to extend it for the virtqueue size checking.
> > > > > If I change vhost-user-blk, vhost-user-scsi and vhost-scsi it's w=
orth
> > > > > to check those devices too. But I don't know how to form a comman=
d line
> > > > > for that 3 devices since they should involve some third party com=
ponents as
> > > > > backends (kernel modules, DPDK, etc.) and they seems to be not av=
ailable in
> > > > > the
> > > > > qemu git.
> > > > > Is there any way to do it with some qit.qemu available stubs or s=
omething
> > > > > else?
> > > > > If so, could you please point out the proper way to do it?
> > > > qemu.git has contrib/vhost-user-blk/ and contrib/vhost-user-scsi/ i=
f
> > > > you need to test those vhost-user devices without external dependen=
cies.
> > > >=20
> > > > Stefan


