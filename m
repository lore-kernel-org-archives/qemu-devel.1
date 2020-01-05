Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFDC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 11:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B7821582
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 11:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbfxBdD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B7821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io4Gt-0001Lg-R1
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 06:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io4GA-0000tJ-PW
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 06:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io4G7-00076E-U9
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 06:39:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58239
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io4G7-00075M-JB
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 06:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578224390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpo7oZnQ8wUF/7b+x4y6Uo6vUWjf043CMvMwOIeuqVg=;
 b=AbfxBdD9jeOEXLvBm2GATkTHXc14VoX64r7CaaE74YkVG78B+SiOpiFrwab16gBaHovkuT
 4BKUfkt4Ew9z95eOB6EAaehluhGsJUpqA6PV/fkVS4J/2aqL91dfoyXwYSU+i9Fp7jjDFa
 HEtx3W52FJHLWZa7hOy3NPNWiGVYBTQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-M02QGU_pPKmjO8scm_z43Q-1; Sun, 05 Jan 2020 06:39:48 -0500
Received: by mail-qt1-f199.google.com with SMTP id p12so32469889qtu.6
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 03:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=54zZY2PTnzqBkK+lCfpmXvmpIx5RY7I/Ase632NbK7Q=;
 b=qzet3L1+0LRgzKaBymfZJLT8q/h76OaVVU6MspIgZzUDtoLulhC5SxU49QRSXnEmAy
 ifF8Qh+Y+ZSFmVD6iGlKvzDmwGimQk7X3XNHTLIf3eHLh54CJMP9BruC4fKXbBvW3Tfv
 HokGMNHVRsmkae/xDyg6sJtUSu+B+PRfiKsUBCvX+unMIY2ujdKyOUYbMLnj9ozKFOgt
 kgTubi/gfaE4aL/zs9Ggy5ENatHTtUdicAdtzj5lHob23KxsR16V09GirVSHZBxdR78c
 h9VSbSjSQ90ZMYIkrNQIsoMbdn3Ctu3i7ox6QaqUPxEJsPknKFnfLRgdKfL7TLYzByBK
 p7zQ==
X-Gm-Message-State: APjAAAWoAUnKBN68RJHIK/BpD1ExK8eOkrs8rRYY7b431YnCY0DhFPyL
 CCdFI8x20W+2y9GgvJ5iyuSJ71hkQNyWKNVjMMOZF5g/c90glkOYTDG6D0l3j+5o5E2Wl5aArkd
 KpUA+wZW4Fd7X+os=
X-Received: by 2002:a05:620a:678:: with SMTP id
 a24mr4252367qkh.270.1578224387849; 
 Sun, 05 Jan 2020 03:39:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6mqzZMeKMrKMidjfsFqPztEH1oEwOAFUE3xbuAwwZtoyLRB4WET0GvBHHDLxlY0/j7KM4hQ==
X-Received: by 2002:a05:620a:678:: with SMTP id
 a24mr4252351qkh.270.1578224387586; 
 Sun, 05 Jan 2020 03:39:47 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id q73sm19092299qka.56.2020.01.05.03.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 03:39:46 -0800 (PST)
Date: Sun, 5 Jan 2020 06:39:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
Message-ID: <20200105063518-mutt-send-email-mst@kernel.org>
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
 <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
 <20200101184425-mutt-send-email-mst@kernel.org>
 <CAOEp5Oefmj5dM5auk1QpQ3F+CeJXQy+0aXJC1VNmUOj1KHp8aw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oefmj5dM5auk1QpQ3F+CeJXQy+0aXJC1VNmUOj1KHp8aw@mail.gmail.com>
X-MC-Unique: M02QGU_pPKmjO8scm_z43Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Yan Vugenfirer <yan@daynix.com>, pbonzini@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 02, 2020 at 09:09:04AM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Thu, Jan 2, 2020 at 1:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
>     On Thu, Dec 26, 2019 at 11:29:50AM +0200, Yuri Benditovich wrote:
>     > On Thu, Dec 26, 2019 at 10:58 AM Jason Wang <jasowang@redhat.com> w=
rote:
>     > >
>     > >
>     > > On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:
>     > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
>     > > > Fix leak of region reference that prevents complete
>     > > > device deletion on hot unplug.
>     > >
>     > >
>     > > More information is needed here, the bug said only q35 can meet t=
his
>     > > issue. What makes q35 different here?
>     > >
>     >
>     > I do not have any ready answer, I did not dig into it too much.
>     > Probably Michael Tsirkin or Paolo Bonzini can answer without diggin=
g.
>=20
>=20
>=20
>     > >
>     > > >
>     > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > > > ---
>     > > >=C2=A0 =C2=A0hw/virtio/virtio.c | 5 +++++
>     > > >=C2=A0 =C2=A01 file changed, 5 insertions(+)
>     > > >
>     > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>     > > > index 04716b5f6c..baadec8abc 100644
>     > > > --- a/hw/virtio/virtio.c
>     > > > +++ b/hw/virtio/virtio.c
>     > > > @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice *vdev=
, int
>     n)
>     > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev->vq[n].vring.num_default =3D 0;
>     > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev->vq[n].handle_output =3D NULL;
>     > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev->vq[n].handle_aio_output =3D NUL=
L;
>     > > > +=C2=A0 =C2=A0 /*
>     > > > +=C2=A0 =C2=A0 =C2=A0* with vring.num =3D 0 the queue will be i=
gnored
>     > > > +=C2=A0 =C2=A0 =C2=A0* in later loops of region cache reset
>     > > > +=C2=A0 =C2=A0 =C2=A0*/
>     > >
>     > >
>     > > I can't get the meaning of this comment.
>     > >
>     > > Thanks
>     > >
>     > >
>     > > > +=C2=A0 =C2=A0 virtio_virtqueue_reset_region_cache(&vdev->vq[n]=
);
>=20
>=20
>     Do we need to drop this from virtio_device_free_virtqueues then?
>=20
>=20
>=20
> Not mandatory. Repetitive=C2=A0 virtio_virtqueue_reset_region_cache=C2=A0=
does not do
> anything bad.
> Some of virtio devices do not do 'virtio_del_queue' at all. Currently=C2=
=A0
> virtio_device_free_virtqueues resets region cache for them.
> IMO, not calling 'virtio_del_queue' is a bug, but not in the scope of cur=
rent
> series, I'll take care of that later.

Maybe we should just del all queues in virtio_device_unrealize?
Will allow us to drop some logic tracking which vqs were created.


>=20
>     > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(vdev->vq[n].used_elems);
>     > > >=C2=A0 =C2=A0}
>     > > >
>     > >
>=20
>=20


