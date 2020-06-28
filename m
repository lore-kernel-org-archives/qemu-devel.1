Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92E6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 01:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812B320768
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 01:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9nOAbCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812B320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpMFf-00058h-Nw
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 21:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpMEs-0004f2-GB
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 21:36:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpMEq-0001ZG-1B
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 21:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593308166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CvseV/TT1bgz1T3b/5QK1g4QkngIPrnsMGDdR1Y0tw=;
 b=g9nOAbCxFEoOZlMlXbi0mN6Jk1eZh/wUWq15R3zwEsj6w04bmFI/Kha2O0w4nUnbUFY4gH
 TK+I/sSt2WFDgy+Rosx1doIczuihA6cvtDO9dKZgXaHw6Ese0aqSBy6rbT0n6C8z2SGJ1s
 BAvd/qWMlJyLVtzuG6AE/8rMJXNH8Gw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-CFaaKrYeO8Kp1Yfq2QMC6g-1; Sat, 27 Jun 2020 21:36:02 -0400
X-MC-Unique: CFaaKrYeO8Kp1Yfq2QMC6g-1
Received: by mail-pg1-f198.google.com with SMTP id x184so9821527pgb.7
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 18:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7CvseV/TT1bgz1T3b/5QK1g4QkngIPrnsMGDdR1Y0tw=;
 b=h7WwVeBpPOtUWEOEt/cVasOdANMUXSyLct5PCnpWecy/6uxBuIS0JhVU4BLdIacF8b
 gYGVHYan+tQL/9XC+kx7wsXs7qD/fm4JEfAQkwYCnFlCAf5mLqHi1LrpfY077DWCnJxJ
 3zLq2nBtMGbsrbq7OMMz5xQBT6+CV84Pe+0Txa8mnKejXx5LeSX4QU/uQfSwdxXFYV1d
 w3LuqJqLc36vZqMENLOZjwhjXtlnomFWkIZ2k6PNOkt+7+OrhZijl2VMzWTRoOF1Pepw
 HgjD4cqGPYsFUGaZ2fEAJeDItY+EJJSOdbe7aULoy5b3XqydszPdK4hqibuOTXcwXmHz
 EK0Q==
X-Gm-Message-State: AOAM532is6Xtdv8xKbx790Dm10bQom3kHXr3yTrEm0U0wBVIqf4DP8Fa
 TQRnFeknJfc2KPq6/ASKYtKch87YIHGvgefzaOMPW4vOG1Gqvt0U2uDUzOCHvoRXgYPW9w1FCrN
 uugpzONB09B2Ngg4/we3DjgRsi+lB8fU=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr5297850pgk.203.1593308161231; 
 Sat, 27 Jun 2020 18:36:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBnKVn71vU15KU/VPpuqbUe3/1AtBvGd8RBw5Q7ewFuwyvwfxSRqRz1jSziOVUK9FuCbiqIbd7jF9XJgK6Gxs=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr5297821pgk.203.1593308160953; 
 Sat, 27 Jun 2020 18:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-10-lulu@redhat.com>
 <e712646c-c5d0-4e93-d368-4d1bb5351e60@redhat.com>
In-Reply-To: <e712646c-c5d0-4e93-d368-4d1bb5351e60@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 28 Jun 2020 09:35:49 +0800
Message-ID: <CACLfguVHproSFH2jykZBVaWWycHU5RGXJNRa-TTSjC017_8EUw@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] vhost-vdpa: introduce vhost-vdpa backend
To: Laurent Vivier <lvivier@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 21:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 8:37 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 22/06/2020 17:37, Cindy Lu wrote:
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific configuration
> > interface for setting up a vhost HW accelerator, this patch set introduces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> > qemu-system-x86_64 -cpu host -enable-kvm \
> >     ......
> >     -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
> >     -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \
> >
> > Signed-off-by: Lingshan zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  configure                         |  21 ++
> >  hw/net/vhost_net.c                |  19 +-
> >  hw/net/virtio-net.c               |  19 +-
> >  hw/virtio/Makefile.objs           |   1 +
> >  hw/virtio/vhost-backend.c         |  22 +-
> >  hw/virtio/vhost-vdpa.c            | 406 ++++++++++++++++++++++++++++++
> >  hw/virtio/vhost.c                 |  42 +++-
> >  include/hw/virtio/vhost-backend.h |   6 +-
> >  include/hw/virtio/vhost-vdpa.h    |  26 ++
> >  include/hw/virtio/vhost.h         |   6 +
> >  qemu-options.hx                   |  12 +
> >  11 files changed, 555 insertions(+), 25 deletions(-)
> >  create mode 100644 hw/virtio/vhost-vdpa.c
> >  create mode 100644 include/hw/virtio/vhost-vdpa.h
> >
> ...
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 660e9e8588..84e5b1a833 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -14,7 +14,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/main-loop.h"
> >  #include "standard-headers/linux/vhost_types.h"
> > -
> > +#include "hw/virtio/vhost-vdpa.h"
> >  #ifdef CONFIG_VHOST_KERNEL
> >  #include <linux/vhost.h>
> >  #include <sys/ioctl.h>
> > @@ -22,10 +22,19 @@
> >  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
> >                               void *arg)
> >  {
> > -    int fd = (uintptr_t) dev->opaque;
> > -
> > -    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_KERNEL);
> > +    int fd = -1;
>
> You don't need to initialize fd before the switch() because all cases
> will set a value to it or assert.
>
> > +    switch (dev->vhost_ops->backend_type) {
> > +    case VHOST_BACKEND_TYPE_KERNEL:
> > +        fd  = (uintptr_t)dev->opaque;
> > +        break;
> > +    case VHOST_BACKEND_TYPE_VDPA:
> > +        fd = ((struct vhost_vdpa *)dev->opaque)->device_fd;
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> >
> > +    assert(fd != -1);
>
> Perhaps this assert is not needed:
> Unitialized value will be catched by "default:", and there was no such
> kind of check on "(uintptr_t)dev->opaque" before.
>
sure, thanks will fix this
> Thanks,
> Laurent
>


