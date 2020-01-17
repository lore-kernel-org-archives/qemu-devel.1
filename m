Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170CC33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6D22072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NroQSwnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6D22072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS1l-0004As-NT
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1isRuj-0006UF-Bs
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1isRui-0007SC-2u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:43:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1isRuh-0007Rc-VJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579268631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQ27qtdSLnctcp86p3J3CfLOCOUqmqOh+XZLSSfyyhU=;
 b=NroQSwnWBEAzt2Ic7jhXHVKvBawYEy6+pBtNzQG9r68lCj8CNhGbzif8+YBVg5dXiQ1jYt
 LepPo4duGbOUC0Hegt2D/9Xw3DD+kZ1tfgNwqh/1MNGYEHLQM+88ZprcPE9zTboVc7KHkJ
 HJb/GM7dlDdA1CyDqI59D6BSaJwRItw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-0O-5FZS3MPmeKRYBYdSgyQ-1; Fri, 17 Jan 2020 08:43:48 -0500
Received: by mail-qt1-f199.google.com with SMTP id k27so15883818qtu.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yiz/0Yu5NB5bF4aCasqNPtEYa/c/w4kZyJEv8MhIzyY=;
 b=LpoNt0Rb2PienGKfBXDoPa9fQgHwynDzFl2B0BuIwwLG1FYwhMdzi3sBnLvnQb3RSD
 54OvFe6cEExNI2xQeimSgwS84KwFQ59MDWba6VLEFReyYMmyaGr6JqNBzvEkYikcm2Tj
 aqsBG3IyNIeqdadvG3q39/Z5erlmSLLBHUIwJd8zmC+qMBERcEidMoNiOsANV5F7dnta
 FDHw71driz4DfeDGYcioMucawAPPYAm+2dvDmYOZ+GY5RJeNtDUhVPbxaJKAsWbttoIq
 G08uHzvvOQQxe1NJzP4EX5jWGTcZ5cXBUd5rwQumXtoFb3950l8zPa8o64Umw5bfDgud
 oYcQ==
X-Gm-Message-State: APjAAAXpez5asOdepvha0dqcG7r3xy8tB4nJSN9/2JBycgNSypiCF0ZR
 nXhD8R4KDg/NUa9I/cwwHkeCNUkghVXyxYqJU9XSnlcFVhFGoCQ8axLvEy40UmnJtBjQ/ysgcW8
 a1ai0TBjZThqLTxY=
X-Received: by 2002:ac8:514c:: with SMTP id h12mr2609393qtn.332.1579268627735; 
 Fri, 17 Jan 2020 05:43:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqztJw7OYoLZyQ3SPPw/uBfN/DVQYV6sVMcn7xqLAjhvxZY4Adx+GApNU0ndU97CPF2qw/n7Gw==
X-Received: by 2002:ac8:514c:: with SMTP id h12mr2609385qtn.332.1579268627482; 
 Fri, 17 Jan 2020 05:43:47 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
 by smtp.gmail.com with ESMTPSA id 201sm11919306qkf.10.2020.01.17.05.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 05:43:46 -0800 (PST)
Date: Fri, 17 Jan 2020 08:43:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 1/2] virtio-9p-device: fix memleak in
 virtio_9p_device_unrealize
Message-ID: <20200117084322-mutt-send-email-mst@kernel.org>
References: <20200117060927.51996-1-pannengyuan@huawei.com>
 <20200117060927.51996-2-pannengyuan@huawei.com>
 <7781044.dIsAdKOGtE@silver>
MIME-Version: 1.0
In-Reply-To: <7781044.dIsAdKOGtE@silver>
X-MC-Unique: 0O-5FZS3MPmeKRYBYdSgyQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>,
 pannengyuan@huawei.com, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 01:52:53PM +0100, Christian Schoenebeck wrote:
> On Freitag, 17. Januar 2020 07:09:26 CET pannengyuan@huawei.com wrote:
> > From: Pan Nengyuan <pannengyuan@huawei.com>
> >=20
> > v->vq forgot to cleanup in virtio_9p_device_unrealize, the memory leak
> > stack is as follow:
> >=20
> > Direct leak of 14336 byte(s) in 2 object(s) allocated from:
> >   #0 0x7f819ae43970 (/lib64/libasan.so.5+0xef970)  ??:?
> >   #1 0x7f819872f49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
> >   #2 0x55a3a58da624 (./x86_64-softmmu/qemu-system-x86_64+0x2c14624)=20
> > /mnt/sdb/qemu/hw/virtio/virtio.c:2327 #3 0x55a3a571bac7
> > (./x86_64-softmmu/qemu-system-x86_64+0x2a55ac7)=20
> > /mnt/sdb/qemu/hw/9pfs/virtio-9p-device.c:209 #4 0x55a3a58e7bc6
> > (./x86_64-softmmu/qemu-system-x86_64+0x2c21bc6)=20
> > /mnt/sdb/qemu/hw/virtio/virtio.c:3504 #5 0x55a3a5ebfb37
> > (./x86_64-softmmu/qemu-system-x86_64+0x31f9b37)=20
> > /mnt/sdb/qemu/hw/core/qdev.c:876
> >=20
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>=20
> Maybe you could add this patch to your revised PR Greg?

I'm testing all the related virtio changes and they will be
in my next PR.

> > ---
> > Changes V2 to V1:
> > - use old function virtio_del_queue to make it easier for stable branch
> > to merge (suggested by Christian Schoenebeck)
> > ---
> >  hw/9pfs/virtio-9p-device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index b5a7c03f26..910dc5045e 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -215,6 +215,7 @@ static void virtio_9p_device_unrealize(DeviceState =
*dev,
> > Error **errp) V9fsVirtioState *v =3D VIRTIO_9P(dev);
> >      V9fsState *s =3D &v->state;
> >=20
> > +    virtio_del_queue(vdev, 0);
> >      virtio_cleanup(vdev);
> >      v9fs_device_unrealize_common(s, errp);
> >  }
>=20
>=20
>=20


