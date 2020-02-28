Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3EBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC19620732
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVfIob68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC19620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7dYU-0005Pe-RK
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j7dXl-0004v8-Gw
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j7dXj-00070t-Jd
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:10:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j7dXj-0006zB-Ev
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582888254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWQKtSW8qeCOC8ta5ZF4rzwmzx7MFgGROqOWw3Caoik=;
 b=EVfIob682H7c1LDmSweY+x4WZEFpXjulejMGqkswTyiSp/cH1F2pI/3KZp174BLnClwr+S
 t8tX6Q0Bg3UgS+jbdxgAAwKyiAkBhbgbLsT2+5CvpFcUYUwHofYmGbzjQf9AJH2vWy4zCR
 7n+gagGmvwFnemQaiD5d8pmi2Zkq39I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-8QHyUWR-NDOLUp-7jPtm6g-1; Fri, 28 Feb 2020 06:10:51 -0500
X-MC-Unique: 8QHyUWR-NDOLUp-7jPtm6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9AA8017DF;
 Fri, 28 Feb 2020 11:10:49 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5954826FD9;
 Fri, 28 Feb 2020 11:10:48 +0000 (UTC)
Date: Fri, 28 Feb 2020 12:10:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Ring <stefanrin@gmail.com>
Subject: Re: Strange data corruption issue with gluster (libgfapi) and ZFS
Message-ID: <20200228111046.GC5274@linux.fritz.box>
References: <CAAxjCEzHQz4cG_8m7S6=CwCBoN5daQs+KVyuU5GL5Tq3Bky1NA@mail.gmail.com>
 <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
 <CAAxjCEwv61e87ZUz-jueL9AkzaNbY3pRoFmf2dah-p9W8nosWA@mail.gmail.com>
 <CAAxjCEx__TsY75b0iecG1a_wUO2MF2UMVP50nFHQi2Ouyu0znw@mail.gmail.com>
 <CAAxjCExb8GKP0Y8hwEbv=DETfu1dG3++umYV0n8vX6kxuJW3pQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAxjCExb8GKP0Y8hwEbv=DETfu1dG3++umYV0n8vX6kxuJW3pQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: integration@gluster.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.02.2020 um 23:25 hat Stefan Ring geschrieben:
> On Thu, Feb 27, 2020 at 10:12 PM Stefan Ring <stefanrin@gmail.com> wrote:
> > Victory! I have a reproducer in the form of a plain C libgfapi client.
> >
> > However, I have not been able to trigger corruption by just executing
> > the simple pattern in an artificial way. Currently, I need to feed my
> > reproducer 2 GB of data that I streamed out of the qemu block driver.
> > I get two possible end states out of my reproducer: The correct one or
> > a corrupted one, where 48 KB are zeroed out. It takes no more than 10
> > runs to get each of them at least once. The corrupted end state is
> > exactly the same that I got from the real qemu process from where I
> > obtained the streamed trace. This gives me a lot of confidence in the
> > soundness of my reproducer.
> >
> > More details will follow.
>=20
> Ok, so the exact sequence of activity around the corruption is this:
>=20
> 8700 and so on are the sequential request numbers. All of these
> requests are writes. Blocks are 512 bytes.
>=20
> 8700
>   grows the file to a certain size (2134144 blocks)
>=20
> <8700 retires, nothing in flight>
>=20
> 8701
>   writes 55 blocks inside currently allocated file range, close to the
> end (7 blocks short)
>=20
> 8702
>   writes 54 blocks from the end of 8701, growing the file by 47 blocks
>=20
> <8702 retires, 8701 remains in flight>
>=20
> 8703
>   writes from the end of 8702, growing the file by 81 blocks
>=20
> <8703 retires, 8701 remains in flight>
>=20
> 8704
>   writes 1623 blocks also from the end of 8702, growing the file by 1542 =
blocks
>=20
> <8701 retires>
> <8704 retires>
>=20
> The exact range covered by 8703 ends up zeroed out.
>=20
> If 8701 retires earlier (before 8702 is issued), everything is fine.

This sounds almost like two other bugs we got fixed recently (in the
QEMU file-posix driver and in the XFS kernel driver) where two write
extending the file size were in flight in parallel, but if the shorter
one completed last, instead extending the file, it would end up
truncating it.

I'm not sure, though, why 8701 would try to change the file size because
it's entirely inside the already allocated file range. But maybe adding
the current file size at the start and completion of each request to
your debug output could give us more data points?

Kevin


