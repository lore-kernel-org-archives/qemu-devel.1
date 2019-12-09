Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF9C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345C02077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fs9e/cxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345C02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLRJ-0002Gg-4e
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ieLQa-0001rL-JM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ieLQY-0000e3-Ub
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:58:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ieLQY-0000dC-Lm
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575907105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeCKi3OANFZh+M9+VH6dXr2zzHnOEiTrrXC1+WE2lA8=;
 b=fs9e/cxdOI5VoqUC6SD6dS2He2pTLCdquYNNakAaMzSRv/n0C30iItrBPld8NXm0nd8gww
 g+CWMfXki9cMceZ9tTWI4LFFKiDSgYbIhsw1U4i3riakA1y/9qBaNFmu2mC1xqwvCT3ckh
 jmNbGp6v4qRKCUIyAuWhaKtJPFONhaw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-nyTn5ny_MR6Flo4t4s6-9Q-1; Mon, 09 Dec 2019 10:58:24 -0500
Received: by mail-qt1-f199.google.com with SMTP id r9so11418966qtc.4
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F+X0nHYMFoTwafdTqEWVef9Ov+czW/2wF42F7NktdmQ=;
 b=Q8uiZMF2O8+7eI+NzP5bwq6rnUhbIf1fbBiCvfvXbd2l0eWmBO2qu8DNtabsVor0Zb
 ahaVHznmrMzadbO3SUvZfsx1c5hsRQ9pPf0DmZIVx5deK18szH9vNn6V9jVlYZqkDovK
 PdfZgukg3dSoMgDyUMAnAyS+kc7Vj9kXqCAYxF0DR5Fj/5bb9Mr4LkhVCcfm4W29hRGh
 3WGVous6lBjqA2+HkGLJZ6S+C36Q0fxE6hcFdbbPAoMgTFug6vk/NWDQOapke/bJBubC
 58dvjAL7+snqNYIDtsoVqDrOLAOPGPygRoMtCuUup89u1TTAfeWXeKnlL+KCJlrhIBSA
 CAIQ==
X-Gm-Message-State: APjAAAULZgx1yB+1GHgxlbHJDrRRGo/JIzFqwPimADTLa4Sz+gyHHDJa
 hbMo9ypt9zLesQs2n9qXzBV/D6VngG3W/0MoxXTmaMD5FjVXrhZSC6dQ00UFU4eSLF3uIWM1MYT
 zd11rk4GIKcBBgrg=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr12841073qtj.117.1575907103645; 
 Mon, 09 Dec 2019 07:58:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjBEB1QPRKHqvi1IlN7azt7h5x6o0o9Dr3SBZfU93C9LFSvy57nKV/Gk4cC7rN8LdXtvfzFw==
X-Received: by 2002:ac8:140c:: with SMTP id k12mr12841057qtj.117.1575907103401; 
 Mon, 09 Dec 2019 07:58:23 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id o81sm2613310qke.33.2019.12.09.07.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 07:58:22 -0800 (PST)
Date: Mon, 9 Dec 2019 10:58:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
Message-ID: <20191209105101-mutt-send-email-mst@kernel.org>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <606337023.38890965.1575448387620.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
In-Reply-To: <606337023.38890965.1575448387620.JavaMail.zimbra@redhat.com>
X-MC-Unique: nyTn5ny_MR6Flo4t4s6-9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: liyiting@huawei.com, kuhn chenqun <kuhn.chenqun@huawei.com>,
 pannengyuan@huawei.com, qemu-devel@nongnu.org,
 zhang zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 03:33:07AM -0500, Pankaj Gupta wrote:
>=20
> > From: Pan Nengyuan <pannengyuan@huawei.com>
> >=20
> > Devices tend to maintain vq pointers, allow deleting them trough a vq
> > pointer.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> > ---
> > Changes v2 to v1:
> > - add a new function virtio_delete_queue to cleanup vq through a vq poi=
nter
> > ---
> >  hw/virtio/virtio.c         | 16 +++++++++++-----
> >  include/hw/virtio/virtio.h |  2 ++
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 04716b5..6de3cfd 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev,=
 int
> > queue_size,
> >      return &vdev->vq[i];
> >  }
> > =20
> > +void virtio_delete_queue(VirtQueue *vq)
> > +{
> > +    vq->vring.num =3D 0;
> > +    vq->vring.num_default =3D 0;
> > +    vq->handle_output =3D NULL;
> > +    vq->handle_aio_output =3D NULL;
> > +    g_free(vq->used_elems);
> > +    vq->used_elems =3D NULL;
> > +}
> > +
> >  void virtio_del_queue(VirtIODevice *vdev, int n)
> >  {
> >      if (n < 0 || n >=3D VIRTIO_QUEUE_MAX) {
> >          abort();
> >      }
> > =20
> > -    vdev->vq[n].vring.num =3D 0;
> > -    vdev->vq[n].vring.num_default =3D 0;
> > -    vdev->vq[n].handle_output =3D NULL;
> > -    vdev->vq[n].handle_aio_output =3D NULL;
> > -    g_free(vdev->vq[n].used_elems);
> > +    virtio_delete_queue(&vdev->vq[n]);
> >  }
> > =20
> >  static void virtio_set_isr(VirtIODevice *vdev, int value)
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index c32a815..e18756d 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int
> > queue_size,
> > =20
> >  void virtio_del_queue(VirtIODevice *vdev, int n);
> > =20
> > +void virtio_delete_queue(VirtQueue *vq);
> > +
> >  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >                      unsigned int len);
> >  void virtqueue_flush(VirtQueue *vq, unsigned int count);
> > --
> > 2.7.2.windows.1
> >=20
> >=20
> Overall it ooks good to me.
>=20
> Just one point: e.g in virtio_rng: "virtio_rng_device_unrealize" function
> We are doing :     virtio_del_queue(vdev, 0);

Yea. Let's just bite the bullet and convert all callers.
Not so many of them.

> One can directly call "virtio_delete_queue". It can become confusing
> to call multiple functions for same purpose. Instead, Can we make=20
> "virtio_delete_queue" static inline?

We can't really.


> Other than that:
> Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
>=20
> >=20
> >=20


