Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE563C55186
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49E620735
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbGmT8Rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49E620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRBdN-0001c3-QT
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 05:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jRBcY-0001BX-1t
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jRBcX-0004wD-5Z
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:24:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37874
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jRBcW-0004si-Oj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587547479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUPMkbQ0OptCrAr+ymxvAuRq58l4LHWtQKqnFvAGpas=;
 b=SbGmT8RzM8HCMLNKZkYGqsPv68zJXYiVvm/2BCemVF1GS7ltPiGpR5KDEON+plDt48a4Hb
 aHIg2Z3OBw0AnSTHR491Vn8Jum9jSNWe2iUQKH99PZHf5DAxFXPW2ik3RhgRQSrs+luHfn
 xzTIRfnI7rFYIz6YmMz4TY7ePrPq/Hc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-1RyL-923MO6kM0Vqv2Ms6A-1; Wed, 22 Apr 2020 05:24:37 -0400
X-MC-Unique: 1RyL-923MO6kM0Vqv2Ms6A-1
Received: by mail-pg1-f197.google.com with SMTP id f14so1174361pgj.15
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 02:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4OMfVuyhsYUJ6YCyDq9+9QJOIpNohNvXtLt68FyL1zc=;
 b=ivPocaYPgkQ/mpbjZdkZwRTlEMqRzEHfCke5rbro6hNPYd3VasQq/3X+ZUN6+R/EVk
 sYkFiPa7nNDrTqWMpMuZATIRqccYqQIvPQUEGUSjhiuTqY/aQmHK4vjtqa/TaKdrPrQ1
 oV5jTcb1VbOsrAYDwrzz/C4yOi8shpB/A5/lv3RDIEP6viHleJlO77DjzL0520CKHLBO
 rruGpDPSFYKrUZvztG3e4ZXy67VKfpFN+9Oig9w+87j0GDdLl4KBi/Rou+fkCxLbfebo
 FxcuY8TFf7A5csmfbZ1VlIJc6dUzzeJVieQMsZAEcxS3qSvPitnqJJZA10iRY1PLzVzI
 oTUA==
X-Gm-Message-State: AGi0PuYfrU2gPvYiVrlAAm2F3tRL3qcoy+atoNkGZCvBIvMm6fVZwRYq
 jdKqSiHT+cpILLdr2nqw6JhCPOjvep4lMdorvu5EFehMWGo+WZRqYGRT4Nr+ILGA3HXLLKCxCvj
 4WGZeRpMCw26x5uhd/9RtA1wpQgRUkfs=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr26735306pgb.203.1587547476550; 
 Wed, 22 Apr 2020 02:24:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypL10TNRuua3qCc2db79DlLIo0/YmxANUfUr9f4NsijlaJLfy/ugq4YhvZ/byCAbAkak8IGP2jYP2Vrcemc04as=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr26735268pgb.203.1587547476318; 
 Wed, 22 Apr 2020 02:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-4-lulu@redhat.com>
 <4e1cc5db-0578-4c6b-afce-da6aebcf24c6@redhat.com>
In-Reply-To: <4e1cc5db-0578-4c6b-afce-da6aebcf24c6@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 22 Apr 2020 17:24:25 +0800
Message-ID: <CACLfguWSEcfsZPWr1Y3co1ncpZ1Y4C9Jzje2vmGE_G552aeSag@mail.gmail.com>
Subject: Re: [RFC v1 3/4] vhost-vdpa: implement vhost-vdpa backend
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:04:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 11:54 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 20/04/2020 11:32, Cindy Lu wrote:
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific configurat=
ion
> > interface for setting up a vhost HW accelerator, this patch set introdu=
ces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> >   qemu-system-x86_64 -cpu host -enable-kvm \
> >     ......
> >   -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-vd=
pa0 \
> >   -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
> >
> > Author: Tiwei Bie
>
> Use "git commit --author" to set that.
Thanks, I will fix this

> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/vhost_net.c                |  43 ++++
> >  hw/net/virtio-net.c               |   9 +
> >  hw/virtio/Makefile.objs           |   2 +-
> >  hw/virtio/vhost-backend.c         |   3 +
> >  hw/virtio/vhost-vdpa.c            | 379 ++++++++++++++++++++++++++++++
> >  hw/virtio/vhost.c                 |   5 +
> >  include/hw/virtio/vhost-backend.h |   6 +-
> >  include/hw/virtio/vhost-vdpa.h    |  14 ++
> >  8 files changed, 459 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/virtio/vhost-vdpa.c
> >  create mode 100644 include/hw/virtio/vhost-vdpa.h
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 4096d64aaf..0d13fda2fc 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> ...
> > @@ -434,6 +462,10 @@ VHostNetState *get_vhost_net(NetClientState *nc)
> >          assert(vhost_net);
> >          break;
> >  #endif
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        vhost_net =3D vhost_vdpa_get_vhost_net(nc);
> > +        assert(vhost_net);
> > +        break;
>
> This should be inside a "#ifdef".
>
Thanks Laurent, I will add a new macro for vDPA

> Thanks,
> Laurent
>


