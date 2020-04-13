Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683CAC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A8F20678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnZgAn4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A8F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNwpA-0003Ew-5w
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jNwoU-0002oe-5B
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jNwoT-0008LT-0n
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:59:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jNwoS-0008LF-Tg
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586775576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaaqG3u6w+b9iGtCz932pTs9orEYuZZgJ38ADrwQ3po=;
 b=CnZgAn4d1O/VGOSeUnRHmB5SsWmT6fUQsw9DV7w3N2hmpk9ofr75uDysmx8ITtPpsP+fbp
 YyM49BAyW/5StoBV1jByPxYQyH72M+ypc44/gXSqI+DH/z/f2sEJOalzpHRvIfeozG191a
 UsAvDCcYlCabnYunxEsJwTFcKuL7R+A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-Vwo-b5hVMI-s3NDd-EqHsw-1; Mon, 13 Apr 2020 06:59:34 -0400
X-MC-Unique: Vwo-b5hVMI-s3NDd-EqHsw-1
Received: by mail-wr1-f69.google.com with SMTP id o12so3442258wra.14
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 03:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AQ+rq9smvDCKyN/SCkYYdsmgyiiPmd11lRQurDej5BI=;
 b=Flv06pxTpEhkfb6JedbYbJkXCl99iQaKaNSOO1IhA762yuaPK9NFpvx2xGgB+lwZ+N
 lGsmP5ktq1sfQMOA5SeCyDV90n9J2jeO3R0tDon0G8hTPlXYWi8+H7FkVHfOsHefYHG/
 woieXcpBc1dCpIbUwY0S3F3yOeCtXhpAW2bGjzW/KJmFQD4XRv8clQXSGK1e0/gmgi/k
 E/gK8HWno108ZIQkodipjxyOA53KemGLVav4000Aqtdu441rc9hCYdNNMQCozHFQJ1MH
 9LhpBjF7uuIL+XmwMp458GoONCrXiXiTfb2yquufnnBeUFLGwuyrsJCWTiAM70YJltBd
 73xA==
X-Gm-Message-State: AGi0PuZu8Qs+Ty/HrBTVsWYbOMilCnkDzYnsHv/Prq3oLFdcfkwTnjpw
 wx8CihHdgB2apGrmfbmWGMEy3//2VO6mIJIO77rKdk1z/2ZXc7WVPgqHCwO7LJGZ+s3U0+vY+tS
 +Sq5013sTo2tGBaA=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr10813165wmb.128.1586775572935; 
 Mon, 13 Apr 2020 03:59:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypL+xSA9Y3T9ToMunZM4fAW3iAdvjPUcbZ+9KA9pVNFhNOvorz44ZvnxnWc/50aErGPuHKUrww==
X-Received: by 2002:a1c:6455:: with SMTP id y82mr10813151wmb.128.1586775572756; 
 Mon, 13 Apr 2020 03:59:32 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
 by smtp.gmail.com with ESMTPSA id v16sm14133797wml.30.2020.04.13.03.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 03:59:31 -0700 (PDT)
Date: Mon, 13 Apr 2020 06:59:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 0/3] virtio, vhost-gpu: Release memory returned by
 malloc() with free()
Message-ID: <20200413065857-mutt-send-email-mst@kernel.org>
References: <20200323112943.12010-1-philmd@redhat.com>
 <20200323094104-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200323094104-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 09:41:20AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 23, 2020 at 12:29:40PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > Coverity reported a ALLOC_FREE_MISMATCH in vg_handle_cursor(),
> > because the memory returned by vu_queue_pop() is allocated with
> > malloc(). Fix it.
> >=20
> > Similar error occurs with virtio. Document and fix.
>=20
> I will queue this. Thanks!

So what are we doing with this patchset? Marc-Andr=E9 reported issues -
any plan to fix them up? Split up the patchset to 3 independent
patches?

> > Philippe Mathieu-Daud=E9 (3):
> >   vhost-user-gpu: Release memory returned by vu_queue_pop() with free()
> >   virtio: Document virtqueue_pop()
> >   virtio-gpu: Release memory returned by virtqueue_pop() with free()
> >=20
> >  include/hw/virtio/virtio.h              | 8 ++++++++
> >  contrib/vhost-user-gpu/vhost-user-gpu.c | 4 ++--
> >  contrib/vhost-user-gpu/virgl.c          | 2 +-
> >  hw/display/virtio-gpu-3d.c              | 2 +-
> >  hw/display/virtio-gpu.c                 | 8 ++++----
> >  5 files changed, 16 insertions(+), 8 deletions(-)
> >=20
> > --=20
> > 2.21.1


