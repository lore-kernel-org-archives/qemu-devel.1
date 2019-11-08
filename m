Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E88FFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 07:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2809420865
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 07:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exA5FOwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2809420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSyc2-0003T8-5o
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 02:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSybJ-00031n-BE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 02:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSybG-0000xS-Oo
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 02:22:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSybG-0000x8-Gy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 02:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573197749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/lLM9Z4Ow+LNPl/oIsVg/AjYSCnHzEPsAKYIkSK9z8=;
 b=exA5FOwZ+6dFj6HE16uS3RpccNWx2EE/oxoDxh97TEtHYwFal+bhvoo1C8oq7lOpzo9VVg
 13wxpaNm9+CGD1EisnV6YCrSkiP9etMpvY6jmZhGWhj5oHQ8S/JLEtBajrGIJHVwCETffQ
 j/uHA83BQ1OEEin85BU4KTp4z7w88X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-v1yQem93PpuTYIy_o1Hp-w-1; Fri, 08 Nov 2019 02:22:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF3791005500;
 Fri,  8 Nov 2019 07:22:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DBFC60850;
 Fri,  8 Nov 2019 07:22:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7414111AAA; Fri,  8 Nov 2019 08:22:10 +0100 (CET)
Date: Fri, 8 Nov 2019 08:22:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: guest / host buffer sharing ...
Message-ID: <20191108072210.ywyneaoc2y4slth6@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org>
 <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: v1yQem93PpuTYIy_o1Hp-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 qemu-devel <qemu-devel@nongnu.org>, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Adding a list of common properties to the spec certainly makes sense,
> > so everybody uses the same names.  Adding struct-ed properties for
> > common use cases might be useful too.
>=20
> Why not define VIRTIO devices for wayland and friends?

There is an out-of-tree implementation of that, so yes, that surely is
an option.

Wayland needs (a) shared buffers, mostly for gfx data, and (b) a stream
pipe as control channel.  Pretty much the same for X11, except that
shared buffers are optional because the X protocol can also squeeze all
display updates through the stream pipe.

So, if you want allow guests talk to the host display server you can run
the stream pipe over vsock.  But there is nothing for the shared
buffers ...

We could replicate vsock functionality elsewhere.  I think that happened
in the out-of-tree virtio-wayland implementation.  There also was some
discussion about adding streams to virtio-gpu, slightly pimped up so you
can easily pass around virtio-gpu resource references for buffer
sharing.  But given that getting vsock right isn't exactly trivial
(consider all the fairness issues when multiplexing multiple streams
over a virtqueue for example) I don't think this is a good plan.

cheers,
  Gerd


