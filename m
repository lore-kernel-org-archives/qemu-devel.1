Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 03:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BF320775
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 03:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyENDFhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BF320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiVAU-0003yq-EI
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 23:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jiV9q-0003Zt-6q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 23:42:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jiV9o-0004TY-7y
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 23:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591674154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FgRUpS2Tz9NE/dgNJNWnd1cxmo7js9w9R91mbzP4gNI=;
 b=ZyENDFhyzqNEDbSJTZ+J0LAoKVUEnxI1BBIkn4/DUzs7xB3s3pxzp9PSN9As8kR+Uc/YAS
 MVmyCC0NjZW7JbRfmZGquW5Rk6JbAyZIj59Makjcx2mNAviU0EEo7FFbJaxgo/D9g4Y0lE
 NleShzflCWUkVXPlhNGkeTOrmq8SG6w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Ki9FTdYVNUa2uIE8HExr0A-1; Mon, 08 Jun 2020 23:42:25 -0400
X-MC-Unique: Ki9FTdYVNUa2uIE8HExr0A-1
Received: by mail-pf1-f200.google.com with SMTP id b186so15073777pfg.10
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 20:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FgRUpS2Tz9NE/dgNJNWnd1cxmo7js9w9R91mbzP4gNI=;
 b=nH+yi4Dn5FrzqnI+AP1hM68dVfQW5hziL/2HRwhaabjQ5Z8R4rVGimA5CoatWhxAAf
 69w9Ql1DHRTraXyuQJ4sDFVDYBRlV70v9mfZa3MVT8DaAj+9ktg8mdzYxrd69LsNXHe7
 pWPIZ4ZRHgjVNr9hnZtj0V2T73STc5pcCrPvp7dHJ6TfZGSVrUav0gNokwGHVXamUwoE
 Q3jjwwXT/Aslzmt7oHiqsJ1r9J93VMsvLMlJcvTK/iKpbbMMsJrosG7B/TE4cXZFu3Hx
 CLrMYUOn0pAGzqOWFp1qfE4xDPj4GRLgrqJAvT7svnKlMd78TryaFHbpoFirbN1/+fMh
 9QDQ==
X-Gm-Message-State: AOAM531Wy/VrdU1g2rL85Sp+8yH1HcjISRckG+kqEwvJwsJGZzsC5vEW
 Ayjj3Fg9ijEYvTM02Urvg0CNmaBpPg5uuDiXvwGajUsJmpGoUvTiPBtFse1/tIo1uSwCx6pxzhE
 5ISHgyiApX44k6T5ZwSw+X6gGX46U3d8=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr23309825pgk.203.1591674144814; 
 Mon, 08 Jun 2020 20:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Zyc3HBxq36EYb7g9grldBkx6s1N/NZ8YOp6bYc0e5NzXmzgdrW8WGfp+mz9TSPEc4aHJkcHwUkiyJ3rBe7g=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr23309794pgk.203.1591674144474; 
 Mon, 08 Jun 2020 20:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-8-lulu@redhat.com>
 <202b7a79-8d27-cdd8-7c72-5016b53c538d@redhat.com>
In-Reply-To: <202b7a79-8d27-cdd8-7c72-5016b53c538d@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jun 2020 11:42:13 +0800
Message-ID: <CACLfguXH2gHNqfLfov_V02c4dYHgWH7hEepc32DGe6tRLu7khg@mail.gmail.com>
Subject: Re: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, hanand@xilinx.com,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 9, 2020 at 4:14 AM Eric Blake <eblake@redhat.com> wrote:
>
> On 5/29/20 9:06 AM, Cindy Lu wrote:
> > From: Tiwei Bie <tiwei.bie@intel.com>
>
> The original author is Tiwei Bie...
>
> >
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific configuration
> > interface for setting up a vhost HW accelerator, this patch set introduces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> >    qemu-system-x86_64 -cpu host -enable-kvm \
> >      ......
> >    -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
> >    -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \
> >
> > Co-Authored-By: Lingshan zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
>
> ...but there is no S-o-b here.  Also, Co-Authored-By is an unusual tag;
> it's just as easy to spell it Signed-off-by even for co-authors.
>
> [Pardon my delicacy in wording my response; I unfortunately lack enough
> cultural context to know a preferred name or even gender-correct
> pronouns for referring to the authors in shorthand]
>
Thanks Eric for pointing that out :-), I will fix this soon.

Thanks
Cindy

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>


