Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7B8C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 09:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD94B2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 09:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qak2G5po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD94B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieyHJ-0006UL-S0
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 04:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ieyGV-000650-6O
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ieyGR-0002Dy-Nu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:26:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ieyGR-0002AK-5I
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 04:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576056393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUEA3DTpeyiTMO4yFUvbCE27cpRyI0YDYGh3YmWkd7U=;
 b=Qak2G5podDRIDFHapDDYvx+n5oM+vcEbjD/XSqGiZ9qglKYsySbCt6LCAl9M2JIKJefJKW
 5c53QFggSGD4NukFF8TF8dLqCxL8xoaPss+sMZ2Syu5ao25mFRg2WTsKAi3S4PlcXal+80
 fVOIgW5H6Uxor0G/Vg4iHAbeqVLSnHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-DXrrFDgMP86Y1baJfLsJvg-1; Wed, 11 Dec 2019 04:26:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48198107ACFA;
 Wed, 11 Dec 2019 09:26:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B1695C1B5;
 Wed, 11 Dec 2019 09:26:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9C6C416E05; Wed, 11 Dec 2019 10:26:25 +0100 (CET)
Date: Wed, 11 Dec 2019 10:26:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: guest / host buffer sharing ...
Message-ID: <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: DXrrFDgMP86Y1baJfLsJvg-1
X-Mimecast-Spam-Score: 0
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

> None of the proposals directly address the use case of sharing host
> allocated buffers between devices, but I think they can be extended to
> support it. Host buffers can be identified by the following tuple:
> (transport type enum, transport specific device address, shmid,
> offset). I think this is sufficient even for host-allocated buffers
> that aren't visible to the guest (e.g. protected memory, vram), since
> they can still be given address space in some shared memory region,
> even if those addresses are actually inaccessible to the guest. At
> this point, the host buffer identifier can simply be passed in place
> of the guest ram scatterlist with either proposed buffer sharing
> mechanism.

> I think the main question here is whether or not the complexity of
> generic buffers and a buffer sharing device is worth it compared to
> the more implicit definition of buffers.

Here are two issues mixed up.  First is, whenever we'll go define a
buffer sharing device or not.  Second is how we are going to address
buffers.

I think defining (and addressing) buffers implicitly is a bad idea.
First the addressing is non-trivial, especially with the "transport
specific device address" in the tuple.  Second I think it is a bad idea
from the security point of view.  When explicitly exporting buffers it
is easy to restrict access to the actual exports.

Instead of using a dedicated buffer sharing device we can also use
virtio-gpu (or any other driver which supports dma-buf exports) to
manage buffers.  virtio-gpu would create an identifier when exporting a
buffer (dma-buf exports inside the guest), attach the identifier to the
dma-buf so other drivers importing the buffer can see and use it.  Maybe
add an ioctl to query, so guest userspace can query the identifier too.
Also send the identifier to the host so it can also be used on the host
side to lookup and access the buffer.

With no central instance (buffer sharing device) being there managing
the buffer identifiers I think using uuids as identifiers would be a
good idea, to avoid clashes.  Also good for security because it's pretty
much impossible to guess buffer identifiers then.

cheers,
  Gerd


