Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C5C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F2E207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaGWHE04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F2E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqwxU-0003Lv-Gm
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 05:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iqwwt-0002vW-2z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iqwwq-0008R9-BD
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:27:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iqwwp-0008PK-Jz
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578911270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+tVSdsC32yKDhgDmvOZyHdoPIw+Sl0j/wcAR2A/T3k=;
 b=MaGWHE04V1u6SwRvYSesIH4iOXl339ZcCfw3AhU+FUW5cSWJv3KS/iG4otIFwVOLS/yzKT
 Ho/P6hqP0KiEcucmtNdfsRJacMjqN/ZfmaDzAZcqhlI2VubVRuPRwelY3LdZwM5KL1BQNs
 EK+OxCgunwm8b1Qqx+kQmp6+jovQ5A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-BYhjOATsMJ6BW02iDkgTEg-1; Mon, 13 Jan 2020 05:27:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65491800D55;
 Mon, 13 Jan 2020 10:27:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AAE35C1BB;
 Mon, 13 Jan 2020 10:27:38 +0000 (UTC)
Date: Mon, 13 Jan 2020 11:27:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
Message-ID: <20200113102737.GC5549@linux.fritz.box>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <003a01d5c6b3$df62afd0$9e280f70$@ru>
 <20200109120038.GD9504@linux.fritz.box>
 <87k15v1z71.fsf@dusky.pond.sub.org>
 <000f01d5c9f4$cfbc1230$6f343690$@ru>
 <20200113100648.GB5549@linux.fritz.box>
 <CAFEAcA8_snB=+i06Vna7t+E_5=ynPAr_KnLAABXrX5A=ntWOjg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8_snB=+i06Vna7t+E_5=ynPAr_KnLAABXrX5A=ntWOjg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BYhjOATsMJ6BW02iDkgTEg-1
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Ciro Santilli <ciro.santilli@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Thomas Dullien <thomas.dullien@googlemail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, maria.klimushenkova@ispras.ru,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Gerd Hoffmann <kraxel@redhat.com>,
 Pavel Dovgaluk <pavel.dovgaluk@ispras.ru>, Igor R <boost.lists@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.01.2020 um 11:14 hat Peter Maydell geschrieben:
> On Mon, 13 Jan 2020 at 10:07, Kevin Wolf <kwolf@redhat.com> wrote:
> > In MAINTAINERS, you are listed yourself as the maintainer for
> > record/replay. I wonder whether you shouldn't just be sending pull
> > requests after getting Acked-by or Reviewed-by from the maintainers of
> > other subsystems you touch.
>=20
> Ideally somebody else should be interested enough in record/replay
> to review patches. "I'm a subsystem maintainer and send pull
> requests" ideally shouldn't be something we give out just because
> patches aren't getting code review, though I know that it
> does sometimes degenerate into that...

I had the impression that he said he had collected (almost) all of the
necessary reviews, but nobody really seems to be interested to take the
series through their tree because no matter who you ask, the majority of
changes will always be for other subsystems.

And as record/replay is already listed as a separate subsystem in
MAINTAINERS, it seems to make sense to me that it also gets its own pull
requests rather than trying to get patches merged though the trees of
various subsystem maintainers who all aren't really responsible for it.

Kevin


