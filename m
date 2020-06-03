Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2C5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E8620678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ncu+W89Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E8620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOe2-0007iy-V6
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgOdN-0006nz-UY
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:20:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgOdM-000273-FI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591172423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDFHsjF86DjcZRAltues3hs59ErfRbD4AIlBBJe4/fc=;
 b=Ncu+W89QL2PPw7ifGICeCPwxskENRkohSR6s10xGLlpQMb5kG14C1706vUsuHjgWz7zK8m
 ehq5f1Pm9sTDOEOjuro+GQ+HeWQwqjMTOYI+GHlSjmGTCLzxYu2ZmMuHty/rjeanzEDB2e
 n842eW+GucTveL0WM24C/sSyP6+FY9k=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-__WcpsNHMZi1mFjSsR9a_Q-1; Wed, 03 Jun 2020 04:20:21 -0400
X-MC-Unique: __WcpsNHMZi1mFjSsR9a_Q-1
Received: by mail-pg1-f200.google.com with SMTP id u76so1714986pgc.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 01:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hDFHsjF86DjcZRAltues3hs59ErfRbD4AIlBBJe4/fc=;
 b=s3aW8imF7xDeMdnY1e5ZtQno6vBq5/SzSum5uSQNX7ur6O1koGHAt1xtro/y0eGutN
 7T+CjHi5T96Yq8AQg0P9LIALIeFZSI3aUJveORKOEyrXzyWymA7BiYFhVFIPL7RwZXBE
 EPYNoDWsTZRhVdgEcKEed+QqqoxVqZWWDT6SMSbJK5QB/dNXgIO1KGdkae7d6J4XJr6w
 eA7zPT6uLb73objeNdGW4Oe/b+rFm0YhivrDbse4+WT0jT/l9Zh2moB24Tp+X1WhOZF9
 PU4e5ofCfEVRiyP9rhcJrrfcnIadWGz/ixdQ4dG5NalFnKz8VsNlLDVSSjr/O9IIff5v
 YKMg==
X-Gm-Message-State: AOAM533tHKp8+hbQq0b+lvTUfVsuP+rrB523x3dcsLwq9kunN0Y3Xg+Z
 NR//eE2RHLaBF9eOo6ryeM5uAZydqfQ1eKv2rRBX8Xuk0POHpNey4BvGMbrHuaX0dazZ5v29IH0
 wkj4POEDckegiVifeWQCbbzEa2eAlOJc=
X-Received: by 2002:a62:3545:: with SMTP id c66mr8438481pfa.223.1591172420924; 
 Wed, 03 Jun 2020 01:20:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziyNjflcpb7oJi+ba7CbO4LKu8G3sfcxVUoTDAgKPahHS62GjNe5Ic3HvObMi5uVo5zx9QuI0Z4nDIYqJy1cs=
X-Received: by 2002:a62:3545:: with SMTP id c66mr8438443pfa.223.1591172420674; 
 Wed, 03 Jun 2020 01:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-8-lulu@redhat.com>
 <97b9479d-96f2-bbfc-7908-ef56f16bacaf@redhat.com>
In-Reply-To: <97b9479d-96f2-bbfc-7908-ef56f16bacaf@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 3 Jun 2020 16:20:09 +0800
Message-ID: <CACLfguVKV+_YFNnoiW1PLhPU+dQhiJMzzn2gbEWdU_H88PP9HQ@mail.gmail.com>
Subject: Re: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 3, 2020 at 2:43 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/29 =E4=B8=8B=E5=8D=8810:06, Cindy Lu wrote:
> > From: Tiwei Bie<tiwei.bie@intel.com>
> >
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
> >    qemu-system-x86_64 -cpu host -enable-kvm \
> >      ......
> >    -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-v=
dpa0 \
> >    -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
> >
> > Co-Authored-By: Lingshan zhu<lingshan.zhu@intel.com>
> > Signed-off-by: Cindy Lu<lulu@redhat.com>
> > ---
>
>
> Btw, I don't see the how to connect the vhost_set/get_config() with the
> virtio_net_set/get_config().
>
Sure, I will add this part
> Thanks
>
>


