Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB6C2D0DE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 23:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694FE20848
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 23:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faJMLYZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694FE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imnlb-0007ZQ-II
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 18:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1imnky-000751-28
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 18:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1imnkw-0006PQ-GY
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 18:50:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1imnkw-0006Oe-Be
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 18:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577922625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdyatWB78Kdni7U2XhcZbG26fqRy+jGSBrd6UDRmbys=;
 b=faJMLYZi9+FLZxTNi2h7BXCIR8dc917GZEexU0IR+7mBj8IkxWDOokxJ/brc/nUEgiWMwK
 pTyOvbxcwwoZSbr1Or/+bA4qlvGuA9YtIIdahpdjGWi5lHYP2C53xtpFlUzG59wCuoXVSS
 +ztCjub7d+iEKfsAbZAQ28I1pRbZ5A0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-PLvdt3xvO926cvUbXx_Qpw-1; Wed, 01 Jan 2020 18:50:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so19280048wrm.17
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 15:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=I1CC66Ikw4YBtxWMbzBs/HTQQUwVWR0X5qsu0kq4BJE=;
 b=tcUBC8CmE+I0/dru06AlcbQzkhCEfDhvW+eMyR6c0wvvzOBJsVZfD4b8VTW5GmgIYr
 8RlEjg1B1XpnYhCgjnrfCDeQcIy6F/KX/S4mFRpMFR6m8kQKRzwhFj733Ru8mnpEvao3
 FbPm1PoFgVaSf3UjGT4Zkrhnru2sS4ve8bUzAyWntWEt7iMZts81UaXE4G7yl7OGTEMO
 +EjBXzeL9ubNfKgTgu5tCFFoCe4AFrJNrjtOSk+mGgeF2LYfXLVXGUosj2AHvoFBa8LE
 bQQDvJrkYuwlci2Ov3jTC9koURmSa7wm8bubumKvPZJaWLwiBGBcB++wNUNKeoTcSq8b
 U1sQ==
X-Gm-Message-State: APjAAAVvEDSpg3Sws2BLVUvWqmGt5cdwGv/lzhbV0cuzw01ubxQqTRDj
 D3SkVp1vlqDye27lTlKWlLNCD/n7X68TL33PPY5KoBEt806Js0ya5FAV4Ou/a6wjDH2BJpfCbj5
 aCVMB/R1x2rNQOAo=
X-Received: by 2002:a05:600c:2298:: with SMTP id
 24mr11581234wmf.65.1577922622673; 
 Wed, 01 Jan 2020 15:50:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiSTZm7L1CcJrPK/yGCgnDNgM1/5VYWXFZkHNx6hPUwPY1/e1ca5jUkdfZNJK1RdSTJx8tgw==
X-Received: by 2002:a05:600c:2298:: with SMTP id
 24mr11581217wmf.65.1577922622483; 
 Wed, 01 Jan 2020 15:50:22 -0800 (PST)
Received: from redhat.com (89.20.181.189.static.ef-service.nl. [89.20.181.189])
 by smtp.gmail.com with ESMTPSA id b137sm7028722wme.26.2020.01.01.15.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2020 15:50:21 -0800 (PST)
Date: Wed, 1 Jan 2020 18:50:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
Message-ID: <20200101184425-mutt-send-email-mst@kernel.org>
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
 <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
X-MC-Unique: PLvdt3xvO926cvUbXx_Qpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Yan Vugenfirer <yan@daynix.com>, pbonzini@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 26, 2019 at 11:29:50AM +0200, Yuri Benditovich wrote:
> On Thu, Dec 26, 2019 at 10:58 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> > > Fix leak of region reference that prevents complete
> > > device deletion on hot unplug.
> >
> >
> > More information is needed here, the bug said only q35 can meet this
> > issue. What makes q35 different here?
> >
>=20
> I do not have any ready answer, I did not dig into it too much.
> Probably Michael Tsirkin or Paolo Bonzini can answer without digging.



> >
> > >
> > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > ---
> > >   hw/virtio/virtio.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 04716b5f6c..baadec8abc 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice *vdev, int =
n)
> > >       vdev->vq[n].vring.num_default =3D 0;
> > >       vdev->vq[n].handle_output =3D NULL;
> > >       vdev->vq[n].handle_aio_output =3D NULL;
> > > +    /*
> > > +     * with vring.num =3D 0 the queue will be ignored
> > > +     * in later loops of region cache reset
> > > +     */
> >
> >
> > I can't get the meaning of this comment.
> >
> > Thanks
> >
> >
> > > +    virtio_virtqueue_reset_region_cache(&vdev->vq[n]);


Do we need to drop this from virtio_device_free_virtqueues then?

> > >       g_free(vdev->vq[n].used_elems);
> > >   }
> > >
> >


