Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC7C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82D12077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zurj0UKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82D12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMNy-0001xx-PV
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ieMN4-000129-1e
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ieMN1-0001i0-QV
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:58:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ieMN1-0001hA-Mn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575910730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JePwOEVt3TnzkyoJhky2S96B6cJDlDhThQGEXl5o3mA=;
 b=Zurj0UKhCmP/X66RENNdGCfL706f1EqsNs3+5C8BC2Z88R6QCkpwmOLPjVkWFZKKPGGYZR
 a90i2YABo3wObx0EUOePyURCIRckk5ZjoR80zxQzZxlJeO+r7uSKajxC/F8vm4/LfOc638
 gcQxjpSxfz9mfo724Qn1wI4bSTs5cXg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Yiga0YrlMkaiyOVUbcpMoQ-1; Mon, 09 Dec 2019 11:58:49 -0500
Received: by mail-qk1-f199.google.com with SMTP id g28so10341323qkl.6
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 08:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eUdTzGeXWnBdK0KgUMpqwBh3oNRUdrkwhuERrmffIUw=;
 b=fg2v71mktfmTYESYSf3bQp+/9w0EuhjPUG1lhFqcvEjTmaUcm/U+6jrEVL6w30ORAQ
 Y/V4QxX8CitIozrTBslxqqg391VBjyRInWrfvHU07K88uNRBTpW3lLZk5hV2znNpjWa2
 l51xLHIPgeUq5FIao+toDVIiK+wItbBj5ElSjfroI/DZoAvWdSROn86A5xMKjHm5/MYO
 qbRhc/w65f8lfBBChsN3+hJ+803IxJsRvu2TpBT08Ev3ytn0jsEwGvRs//jHhGSzVKOp
 Q/FdE3imRA3MU2rsgnXaO2arS9jwDIVv5bdS08aPvLtteT7zyZJcZjsc6Tp4uzcmuiKh
 sg6w==
X-Gm-Message-State: APjAAAVjj5nBwgafmvDjSALNGgchEvkboIliLHN+4N4EA339AOzvPsoT
 nui7/c31u0EnTRam3CTwweIn9g3cfmTI9nkB2ahlmR8YZH0NcuDzlAhZZZEHyAHSh4vHGVi8X6l
 GxuJyUeGquZ04TCc=
X-Received: by 2002:aed:34a3:: with SMTP id x32mr25421316qtd.309.1575910728664; 
 Mon, 09 Dec 2019 08:58:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqFq+X3lvpBqHHmE1Hg75Q7EP+Cq70y3g/tYIfG8SKljrPWA1PR8xGNL/2NCSF0Zd5eUzDtQ==
X-Received: by 2002:aed:34a3:: with SMTP id x32mr25421298qtd.309.1575910728463; 
 Mon, 09 Dec 2019 08:58:48 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id l62sm29651qke.12.2019.12.09.08.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 08:58:47 -0800 (PST)
Date: Mon, 9 Dec 2019 11:58:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
Message-ID: <20191209115829-mutt-send-email-mst@kernel.org>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <20191209114042-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191209114042-mutt-send-email-mst@kernel.org>
X-MC-Unique: Yiga0YrlMkaiyOVUbcpMoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 11:43:20AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 04, 2019 at 03:31:54PM +0800, pannengyuan@huawei.com wrote:
> > From: Pan Nengyuan <pannengyuan@huawei.com>
> >=20
> > Devices tend to maintain vq pointers, allow deleting them trough a vq p=
ointer.
>=20
> You want to also mention something about clearing
> .used_elems to avoid chances of double free.
>=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>=20
>=20
> So let's just name the new one virtio_del_queue then,
> and drop the old one.

I tried but it seems like too much work.

>=20
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
 int queue_size,
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
> > @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int=
 queue_size,
> > =20
> >  void virtio_del_queue(VirtIODevice *vdev, int n);
> > =20
> > +void virtio_delete_queue(VirtQueue *vq);
> > +
> >  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >                      unsigned int len);
> >  void virtqueue_flush(VirtQueue *vq, unsigned int count);
> > --=20
> > 2.7.2.windows.1
> >=20


