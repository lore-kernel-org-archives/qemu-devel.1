Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C5C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F452082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oag0HISo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F452082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVJm-0001QF-Ew
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyV7Q-000666-QQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyV7P-0006kD-I3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:22:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyV7P-0006js-Du
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580710919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1B59ZsEJHms8mzYTUA33yrPCpqBMIJNHgz4KTsCY2Uo=;
 b=Oag0HISoNcQkbwTCpdVe+BKRZgu41435tQ6WJU5l+XMqzTEebZ2BkMJjDZQ3ofzC1LkQ/7
 IyRRtVf8hVyyyurgiXn84gTJT+cKLGndHxbuuEFYL8R4HvaM35V81G+CSKmjKMIrvr2XUN
 eIgxwkabOvRvb/SvzNpl8fOzvTbzV00=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-5uUokbglPz6yCXd7vU5rWA-1; Mon, 03 Feb 2020 01:21:56 -0500
Received: by mail-wm1-f71.google.com with SMTP id a10so3599762wme.9
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 22:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WGiOq0fdlGtLaJ/32CQvw8kNehgUQTCjasHybqpc8rA=;
 b=ggXW47r1XWC4fTblfBmPDv+r0m1C0DS8QDh8spobV5jA/k+StORWmjOdEYqNiMtLdh
 VTZXoD/wcoJLloi4B1dAIDxGxMnIPxksEtq4t27NbPxUyoJyk7MpOGY6zGBRL/s0KLpY
 nET4tUI93h1DDuwRkxFXxWpTsuMNrP9Ddp0iwIINKaE0njFsq+NTwkLgFzPwHTu5Qm00
 iNDmjL4ysxnZIW/1nzOluOSA76j32lLo7hLovA4c22Hej2/K6bLeeoiaWi20Q665LFKt
 rVI5QlfBcgkZ08ety6VPXZKpdWbCi3xqTLzCGcs0SR+zoXLn2vco56luoB/vdkbb/ric
 tChA==
X-Gm-Message-State: APjAAAXBbqnuwPs9rUr+yvmSpk74ea5k5J9cikJTYfPv+qu3TKzYxrwi
 THORDDl0ku1QqPtoT5rKeEOkTkHuHg7aFjYZOsMuFvEYvRxua2065d65r/5rADH7IGZVZBWoOFR
 Tc3l21JbzwbyIxvU=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr26428642wmh.35.1580710915576; 
 Sun, 02 Feb 2020 22:21:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyucL+FRQppQXgLqg8xdmhU2r05i3VvAOouDpimLUjAJfWJt28odCSMNjbFQrmiPOFp1vSchA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr26428622wmh.35.1580710915333; 
 Sun, 02 Feb 2020 22:21:55 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id l29sm487694wrb.64.2020.02.02.22.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 22:21:54 -0800 (PST)
Date: Mon, 3 Feb 2020 01:21:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio: add the queue number check
Message-ID: <20200203011552-mutt-send-email-mst@kernel.org>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
 <20191223092508-mutt-send-email-mst@kernel.org>
 <187f02d9-1677-d232-a44a-ed7b1e5f6ee5@redhat.com>
 <20200103150145.GA24552@yangzhon-Virtual>
 <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
 <20200110061051.GA1626@yangzhon-Virtual>
 <be72c787-50f8-4b63-59bc-d9ac802541b6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <be72c787-50f8-4b63-59bc-d9ac802541b6@redhat.com>
X-MC-Unique: 5uUokbglPz6yCXd7vU5rWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 05:22:47PM +0100, Paolo Bonzini wrote:
> I have just found this email... sorry for the delay.
>=20
> On 10/01/20 07:10, Yang Zhong wrote:
> >> No. If virtio-blk works, the bug is in vhost-user-blk; if virtio-blk n=
eeds
> >> no check in cpu count, vhost-user-blk also doesn't.
> >>
> >> You need to check first if the bug is in QEMU or the vhost-user-blk se=
rver.
> >
> >   (1). Seabios issue
> >   In init_virtio_blk() function, which set VIRTIO_CONFIG_S_DRIVER_OK
> >   status to qemu vhost-user-blk device.
> >=20
> >   // the related code
> >   ......
> >   status |=3D VIRTIO_CONFIG_S_DRIVER_OK;
> >   vp_set_status(&vdrive->vp, status);
> >   ......
> >=20
> >   I think there is no need for seabios to set VIRTIO_CONFIG_S_DRIVER_OK
> >   status to qemu vhost-user-blk device.
>=20
> It does so because it cannot know how it will be used.  It could be used
> by the guest boot loader to load a kernel, for example.  SeaBIOS sets
> DRIVER_OK because it has loaded a driver for the disk; that's exactly
> what DRIVER_OK signals.

Right. More specifically DRIVER_OK means driver finished setup and is
going to add buffers and process used ones, so device should start
looking at queues.

>=20
> >     In fact, this time vhost_user_blk_start almost do nothing because
> >     the real guest virtio-blk driver still not started yet. This time,
> >     there is only one vq can be used(this vq should be inited in seabio=
s).
> >=20
> >     When the guest virtio-blk driver really start and complet the
> >     probe(), the guest virtio-blk driver will set
> >     VIRTIO_CONFIG_S_DRIVER_OK to vhost-user-blk device again. This
> >     time, this driver will allocate RIGHT queue num according to
> >     MIN(vcpu, num_vqs).
>=20
> Doesn't it first reset the status to 0?
>=20
> >     (2). DPDK issue
> >      DPDK does not know the real queue number used by guest virtio-blk
> >      driver and it only know the queue number from vhost-user-blk
> >      commond line. Once the guest virtio-blk driver change the queue
> >      number according to MIN(vcpu, num_vqs), DPDK still use previous
> >      queue number and it think virtio is never ready by
> >      virtio_is_ready() function.
>=20
> What is virtio_is_ready()?  The virtio device should not wait for all
> the queues to be set.  A device is ready when it sets DRIVER_OK, and
> that's it.

Or - if we want to support legacy guests, and due to a bunch of legacy
guest bugs - if a legacy guest kicked a queue before setting DRIVER_OK.

> >      or DPDK can get the real queue number by checking if the vring.des=
c
> >      is NON-NULL.
>=20
> Note that there is no requirement that the driver initializes a
> consecutive number of virtqueues.  It is acceptable for it to initialize
> virtqueues 0, 1 and 57.  It seems like the bug is in DPDK, possibly more
> than one...
>=20
> Paolo
>=20
> >      By the way, vhost SCSI device has the same issue with
> >      vhost-user-blk device.=20
> >=20
> >      Yang
> >=20
> >> Paolo
> >=20


