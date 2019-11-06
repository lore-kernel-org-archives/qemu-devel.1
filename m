Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB5C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 06:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C99206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 06:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVAM2QUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C99206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSElO-0004gT-Jm
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 01:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSEkC-00040o-0Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSEk9-0001Ce-0a
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:24:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSEk8-0001B4-LS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573021475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVHuDeKp/JxkWn+leUSttm6AS7WtVdk/IpNuvOqG84Y=;
 b=VVAM2QUm+o5rN1jdMi3mu6WMo9rdMZpqt34o7fxFxgGKV3zXos0Ndg2ypixK3eYCZOy4rh
 Os+7my5S8cTnF8GH22U+WH1t4fupPmRqnNXx1hwpVpQcRif+rjoUPCTAcMfnuJ0u71J+mj
 0VJqsa92v8RzKWVRSpMsBTDea7hN5pA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-G0Ceot-oMl2pUt67I-20Dw-1; Wed, 06 Nov 2019 01:24:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F028017DE;
 Wed,  6 Nov 2019 06:24:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 125F11001B00;
 Wed,  6 Nov 2019 06:24:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4021611AAA; Wed,  6 Nov 2019 07:24:28 +0100 (CET)
Date: Wed, 6 Nov 2019 07:24:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: guest / host buffer sharing ...
Message-ID: <20191106062428.4ammt22igf5d6zve@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <7255d3ca5f10bbf14b1a3fcb6ac34a19@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <7255d3ca5f10bbf14b1a3fcb6ac34a19@hostfission.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: G0Ceot-oMl2pUt67I-20Dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Alex Lau <alexlau@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org,
 qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > (1) The virtio device
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Has a single virtio queue, so the guest can send commands to register
> > and unregister buffers.  Buffers are allocated in guest ram.  Each
> > buffer
> > has a list of memory ranges for the data.  Each buffer also has some
> > properties to carry metadata, some fixed (id, size, application), but
> > also allow free form (name =3D value, framebuffers would have
> > width/height/stride/format for example).
> >=20
>=20
> Perfect, however since it's to be a generic device there also needs to be=
 a
> method in the guest to identify which device is the one the application i=
s
> interested in without opening the device.

This is what the application buffer property is supposed to handle, i.e.
you'll have a single device, all applications share it and the property
tells which buffer belongs to which application.

> The device should also support a reset feature allowing the guest to
> notify the host application that all buffers have become invalid such as
> on abnormal termination of the guest application that is using the device=
.

The guest driver should cleanup properly (i.e. unregister all buffers)
when an application terminates of course, no matter what the reason is
(crash, exit without unregistering buffers, ...).  Doable without a full
device reset.

Independent from that a full reset will be supported of course, it is a
standard virtio feature.

> Conversely, qemu on unix socket disconnect should notify the guest of thi=
s
> event also, allowing each end to properly syncronize.

I was thinking more about a simple guest-side publishing of buffers,
without a backchannel.  If more coordination is needed you can use
vsocks for that for example.

> > (3) The qemu host implementation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > qemu (likewise other vmms) can use the udmabuf driver to create
> > host-side dma-bufs for the buffers.  The dma-bufs can be passed to
> > anyone interested, inside and outside qemu.  We'll need some protocol
> > for communication between qemu and external users interested in those
> > buffers, to receive dma-bufs (via unix file descriptor passing) and
> > update notifications.

Using vhost for the host-side implementation should be possible too.

> > Dispatching updates could be done based on the
> > application property, which could be "virtio-vdec" or "wayland-proxy"
> > for example.
>=20
> I don't know enough about udmabuf to really comment on this except to ask
> a question. Would this make guest to guest transfers without an
> intermediate buffer possible?

Yes.

cheers,
  Gerd


