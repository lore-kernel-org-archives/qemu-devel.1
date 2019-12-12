Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D809C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386EB214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlMsy8ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386EB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifKzE-0004cy-CK
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 04:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ifKyV-00045G-Vu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ifKyS-00028Z-2x
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:41:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ifKyR-00022Z-PW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576143689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usv4R7S50UJPk7WQfmZAdI21qFA/J1ewRjSGJhHashk=;
 b=DlMsy8ugEElVYkUsqjADj6RgLjitQdGH4JdaAl1BenRgTcaH01SKxHmXKFPdR3HAKUHKo0
 ck/7fvLSIX64xSUHgLqWWvzVzE/6Dv3SKU/6ZxMd/b/09n8b6pAN/ZoVrlm4huYAwfFHkV
 aqPgPbFNHJ+xOyKu/z2aAU0mXxLdUw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-L3UJtB9uPhey8emPuGSlQA-1; Thu, 12 Dec 2019 04:41:25 -0500
X-MC-Unique: L3UJtB9uPhey8emPuGSlQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100A0104ED2A;
 Thu, 12 Dec 2019 09:41:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A49819C69;
 Thu, 12 Dec 2019 09:41:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3A5D316E19; Thu, 12 Dec 2019 10:41:21 +0100 (CET)
Date: Thu, 12 Dec 2019 10:41:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Message-ID: <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
References: <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
 <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Zach Reizner <zachr@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>,
 Alex Lau <alexlau@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > First the addressing is non-trivial, especially with the "transport
> > specific device address" in the tuple.
> 
> There is complexity here, but I think it would also be present in the
> buffer sharing device case. With a buffer sharing device, the same
> identifying information would need to be provided from the exporting
> driver to the buffer sharing driver, so the buffer sharing device
> would be able to identify the right device in the vmm.

No.  The idea is that the buffer sharing device will allocate and manage
the buffers (including identifiers), i.e. it will only export buffers,
never import.

> > Second I think it is a bad idea
> > from the security point of view.  When explicitly exporting buffers it
> > is easy to restrict access to the actual exports.
> 
> Restricting access to actual exports could perhaps help catch bugs.
> However, I don't think it provides any security guarantees, since the
> guest can always just export every buffer before using it.

Probably not on the guest/host boundary.

It's important for security inside the guest though.  You don't want
process A being able to access process B private resources via buffer
sharing support, by guessing implicit buffer identifiers.

With explicit buffer exports that opportunity doesn't exist in the first
place.  Anything not exported can't be accessed via buffer sharing,
period.  And to access the exported buffers you need to know the uuid,
which in turn allows the guest implement any access restrictions it
wants.

> > Instead of using a dedicated buffer sharing device we can also use
> > virtio-gpu (or any other driver which supports dma-buf exports) to
> > manage buffers.
> 
> I don't think adding generic buffer management to virtio-gpu (or any
> specific device type) is a good idea,

There isn't much to add btw.  virtio-gpu has buffer management, buffers
are called "resources" in virtio-gpu terminology.  You can already
export them as dma-bufs (just landed in 5.5-rc1) and import them into
other drivers.

Without buffer sharing support the driver importing a virtio-gpu dma-buf
can send the buffer scatter list to the host.  So both virtio-gpu and
the other device would actually access the same guest pages, but they
are not aware that the buffer is shared between devices.

With buffer sharing virtio-gpu would attach a uuid to the dma-buf, and
the importing driver can send the uuid (instead of the scatter list) to
the host.  So the device can simply lookup the buffer on the host side
and use it directly.  Another advantage is that this enables some more
use cases like sharing buffers between devices which are not backed by
guest ram.

> since that device would then
> become a requirement for buffer sharing between unrelated devices.

No.  When we drop the buffer sharing device idea (which is quite
likely), then any device can create buffers.  If virtio-gpu is involved
anyway, for example because you want show the images from the
virtio-camera device on the virtio-gpu display, it makes sense to use
virtio-gpu of course.  But any other device can create and export
buffers in a similar way.  Without a buffer sharing device there is no
central instance managing the buffers.  A virtio-video spec (video
encoder/decoder) is in discussion at the moment, it will probably get
resource management simliar to virtio-gpu for the video frames, and it
will be able to export/import those buffers (probably not in the first
revision, but it is on the radar).

> > With no central instance (buffer sharing device) being there managing
> > the buffer identifiers I think using uuids as identifiers would be a
> > good idea, to avoid clashes.  Also good for security because it's pretty
> > much impossible to guess buffer identifiers then.
> 
> Using uuids to identify buffers would work. The fact that it provides
> a single way to refer to both guest and host allocated buffers is
> nice. And it could also directly apply to sharing resources other than
> buffers (e.g. fences). Although unless we're positing that there are
> different levels of trust within the guest, I don't think uuids really
> provides much security.

Well, security-wise you want have buffer identifiers which can't be
easily guessed.  And guessing uuid is pretty much impossible due to
the namespace being huge.

> If we're talking about uuids, they could also be used to simplify my
> proposed implicit addressing scheme. Each device could be assigned a
> uuid, which would simplify the shared resource identifier to
> (device-uuid, shmid, offset).

See above for the security aspects of implicit vs. explicit buffer
identifiers.

cheers,
  Gerd


