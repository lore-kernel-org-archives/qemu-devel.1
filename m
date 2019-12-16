Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1CC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 10:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9CB20684
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 10:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTZYFkwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9CB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igo0d-0000ow-1g
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 05:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ignzz-0000NM-1k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 05:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ignzw-0007Dc-3G
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 05:53:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ignzv-0007DM-VU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 05:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576493587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbVg+bhAD4wlhRqRb8hee0Cqido6h5sSUwsmNsLBzik=;
 b=dTZYFkwSy+/qLnGLyJ0+vem6826w7qbabmpsQjuuaOdG8ybAlnTRMtkIv0VFMAIQBcsJLi
 nw0U8FrX2DpN9une0ESxqtWyoLMOl90fNLorLOirwiTHAut/bXDn0FBDRi7+aCCiX+MZWB
 h49ysKBVESMxonyg8FN/a2FQm6sOHWM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-ePTsfKwoO5KV3EqcCbDcJA-1; Mon, 16 Dec 2019 05:53:03 -0500
Received: by mail-qt1-f197.google.com with SMTP id d18so4386031qtp.16
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 02:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qfd907/JE7k0fUp/+dcE3TMKQNwpvsBf2pEldE51Zi0=;
 b=GydzkBbDtGDkJgr5AUPwImHJXOSgfP3vHoYHiy8djX6GZ6auetYmdGh9iHU5bo2F73
 UI/blZynanri8cKmaBrnaAZHyNls9Dc4uH9fp4m1RFeaRcf58w841wZMYlDqDsWCUiLl
 1r4i0sf+MIMMvzy6xkjGbM5VNYxkl4ez+SG5sfrKTwCX8GU6jGsjFSARRtBcwQAh/8yl
 9b7tGTp4hllH9xlRuSBsdkkXIr4mCycak0oEbvpfQ7GDtR6AVPPR9prg6nzpWlkUfZjV
 BXmzyGsluMqDF6LJxLHZPlnPSG7icphkHsGGueIx2WOPRYfgE22HaADiQPoE4RtjW+Tz
 DVLQ==
X-Gm-Message-State: APjAAAVz4GJcRsm9jRZUIBUivmqkVZP8TrYCDERVJORn4ljU6tR1STPg
 u2oOY8mSYIydK55FCFs93InjCGvGzXX8cH2EbSDYERlW97GdvESD1iDoBHIz7M6HNeB1tHMdytN
 hgpexo+KAhYYh1JE=
X-Received: by 2002:a0c:e84d:: with SMTP id l13mr25835033qvo.53.1576493583034; 
 Mon, 16 Dec 2019 02:53:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyg0Z5FRR5FFf+2hIiOs3rC38arqSLt+gY4ql2Oz2MMhUiDBovrNW2+H9x/XNreMj9U1cBz4A==
X-Received: by 2002:a0c:e84d:: with SMTP id l13mr25835025qvo.53.1576493582834; 
 Mon, 16 Dec 2019 02:53:02 -0800 (PST)
Received: from redhat.com (bzq-111-168-31-5.red.bezeqint.net. [31.168.111.5])
 by smtp.gmail.com with ESMTPSA id
 o17sm6520844qtq.93.2019.12.16.02.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 02:53:01 -0800 (PST)
Date: Mon, 16 Dec 2019 05:52:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: update queue size on guest write
Message-ID: <20191216055229-mutt-send-email-mst@kernel.org>
References: <20191213142358.345301-1-mst@redhat.com>
 <20191216085013.q7tgbesniil3nmbq@steredhat>
MIME-Version: 1.0
In-Reply-To: <20191216085013.q7tgbesniil3nmbq@steredhat>
X-MC-Unique: ePTsfKwoO5KV3EqcCbDcJA-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 09:50:13AM +0100, Stefano Garzarella wrote:
> On Fri, Dec 13, 2019 at 09:24:03AM -0500, Michael S. Tsirkin wrote:
> > Some guests read back queue size after writing it.
> > Update the size immediatly upon write otherwise
> > they get confused.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
>=20
> Just a question, should we do the same in virtio-mmio?
>=20
> Maybe doing virtio_queue_set_num() in any case (legacy and non-legacy)
> during VIRTIO_MMIO_QUEUE_NUM writing.
>=20
> Thanks,
> Stefano

I guess it makes sense ...

> >=20
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index c6b47a9c73..e5c759e19e 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1256,6 +1256,8 @@ static void virtio_pci_common_write(void *opaque,=
 hwaddr addr,
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_SIZE:
> >          proxy->vqs[vdev->queue_sel].num =3D val;
> > +        virtio_queue_set_num(vdev, vdev->queue_sel,
> > +                             proxy->vqs[vdev->queue_sel].num);
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_MSIX:
> >          msix_vector_unuse(&proxy->pci_dev,
> > --=20
> > MST
> >=20
> >=20
>=20
> --=20


