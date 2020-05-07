Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00485C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC98320659
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjyOLfjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC98320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWj1K-0007aj-VB
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jWiyt-00045i-6W
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:02:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jWiyq-0003sQ-Fa
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588867354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBwa7V3c5laGSzlhFEVk3gSOupBGcgpGYoMz2T21NtM=;
 b=XjyOLfjCj5nzqBZp1e9+W3lsg8GivAyhJVhC8S3pAL3W0JsU52kGWHopF2te4P1B23670p
 655sKDAi6ECPo3j6KurCZkU6t8YqtBNtLGJlbM1wPw5Rbchb/vGjx7jI1ybcqulPRkI+q9
 3UZ+5muaOpUT6PSnhCjt1L9U8lwzdH8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-rRKeVe2XNwiWgshrtjm2pA-1; Thu, 07 May 2020 12:02:32 -0400
X-MC-Unique: rRKeVe2XNwiWgshrtjm2pA-1
Received: by mail-pf1-f199.google.com with SMTP id y16so6023665pfe.16
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 09:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4wVEwJb2NUfoxXRGJ2Xb2+qOoW/XCm/5XFuvinXQDeg=;
 b=DRiNU+eB1QZ+/joyxpLQ+L1kLEwngbg6FugLqseUjZDD6uAsVSdFQqX9oDWTKZ+77l
 7DqYDJyqIVfVk3Ztj615GdisZydSTv9Focq4DqpwEeFsDrc/WGajYwdqSvMnsXkiQB9m
 odArN8nNOuhaCLYpNmoZqzupZdI/nJ86qsDB8cofYf+rTFTEbxteKDICSIMNIDJU2qJD
 jkUQVGKpl3AU7lwQZ9NPQxmYad7kFJzfYJrDkBsevLm2+iGWnAYg4N/wNKx9ObulGZHb
 JeVoT71IbGUBqp3XbjoiOtpdEvr4BBkk0aoZR5WV0K9Te/5Kdtd9iMRAvxTc0ieA7+eB
 pk6g==
X-Gm-Message-State: AGi0PubXU758O3//jCBREabIoZbTy0z1xB5piBWAWfY9g5Cavr4cPASs
 jKuFwhiOvngQjdtOoItS18fztNpvu5BVqdrymGQWU+kNz8Ihq5n8qLoUJWeRiye19oGGxMKQntl
 9SQ/T+EbvPu7iluzBoLTDX9qRMZvVj08=
X-Received: by 2002:a17:90a:cb86:: with SMTP id
 a6mr810801pju.127.1588867351305; 
 Thu, 07 May 2020 09:02:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypLMvolKoVVenIxvb6E4pMk+9LTgUd9wV5wdWe38c69enU38bmjvNf4JADo9h7k3SDSaHFOZf7TDPAa1oXhk0Vc=
X-Received: by 2002:a17:90a:cb86:: with SMTP id
 a6mr810741pju.127.1588867350863; 
 Thu, 07 May 2020 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-4-lulu@redhat.com>
 <9eedb51e-0a78-c1f5-d391-366259a0e71a@redhat.com>
In-Reply-To: <9eedb51e-0a78-c1f5-d391-366259a0e71a@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 8 May 2020 00:02:19 +0800
Message-ID: <CACLfguUFAtuwC7v6JrMEc6e6_6kUBHALLS-K9-47mzw3qnCXCg@mail.gmail.com>
Subject: Re: [RFC v1 3/4] vhost-vdpa: implement vhost-vdpa backend
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 rob.miller@broadcom.com, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 7, 2020 at 11:30 PM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 4/20/20 11:32 AM, Cindy Lu wrote:
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> > index 6f6670783f..d81bd9885f 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -17,7 +17,8 @@ typedef enum VhostBackendType {
> >      VHOST_BACKEND_TYPE_NONE =3D 0,
> >      VHOST_BACKEND_TYPE_KERNEL =3D 1,
> >      VHOST_BACKEND_TYPE_USER =3D 2,
> > -    VHOST_BACKEND_TYPE_MAX =3D 3,
> > +    VHOST_BACKEND_TYPE_VDPA =3D 3,
> > +    VHOST_BACKEND_TYPE_MAX =3D 4,
> >  } VhostBackendType;
> >
> >  typedef enum VhostSetConfigType {
> > @@ -112,6 +113,7 @@ typedef int (*vhost_get_inflight_fd_op)(struct vhos=
t_dev *dev,
> >  typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
> >                                          struct vhost_inflight *infligh=
t);
> >
> > +typedef int (*vhost_set_state_op)(struct vhost_dev *dev, int state);
>
> I think state should be of type uint8_t.
>
ok, I will change this to uint8_t


