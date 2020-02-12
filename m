Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB0C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C18420714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/MikSCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C18420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rGr-0006zJ-8J
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1j1rGA-00061X-HX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1j1rG9-0004vK-A4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:36:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1j1rG9-0004uz-5p
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581511012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVeZHRsTKZC0u825vtqliPy0X+ycHafuEX0u/5yCXWc=;
 b=P/MikSCzGqcoysv9iDm+arA1H8txowAiNRACc6N1g64QCtGP2mPBglXOR1JAB2vPFKxGYQ
 YUBNGt4+jhpy0HfIrfaUONfuDeXEHwTfItI22f8Dd+qp/7LTsqucGlwKOSzPwhMAT5Rnd1
 SZQuMIBYvaCOZ5L8OZJwcA7ucQVzax4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-jSDNouKfOlCe4nxdjm7AsA-1; Wed, 12 Feb 2020 07:36:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17E0800D48;
 Wed, 12 Feb 2020 12:36:42 +0000 (UTC)
Received: from localhost (unknown [10.36.118.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8E6226FB6;
 Wed, 12 Feb 2020 12:36:38 +0000 (UTC)
Date: Wed, 12 Feb 2020 12:36:37 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
Message-ID: <20200212123637.GX3888@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <20200210221234.GH3888@redhat.com>
 <cc6e1e2e-d3a9-c498-354b-d382b5623ca0@redhat.com>
 <20200210225255.GJ3888@redhat.com> <20200212072729.GA22254@grep.be>
 <278d29cd-bc0d-19f0-c2a4-0191d16a677f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <278d29cd-bc0d-19f0-c2a4-0191d16a677f@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jSDNouKfOlCe4nxdjm7AsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Wouter Verhelst <w@uter.be>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On Wed, Feb 12, 2020 at 06:09:11AM -0600, Eric Blake wrote:
> On 2/12/20 1:27 AM, Wouter Verhelst wrote:
> >Hi,
> >
> >On Mon, Feb 10, 2020 at 10:52:55PM +0000, Richard W.M. Jones wrote:
> >>But anyway ... could a flag indicating that the whole image is sparse
> >>be useful, either as well as NBD_INIT_SPARSE or instead of it?  You
> >>could use it to avoid an initial disk trim, which is something that
> >>mke2fs does:
> >
> >Yeah, I think that could definitely be useful. I honestly can't see a
> >use for NBD_INIT_SPARSE as defined in this proposal; and I don't think
> >it's generally useful to have a feature if we can't think of a use case
> >for it (that creates added complexity for no benefit).
> >
> >If we can find a reasonable use case for NBD_INIT_SPARSE as defined in
> >this proposal, then just add a third bit (NBD_INIT_ALL_SPARSE or
> >something) that says "the whole image is sparse". Otherwise, I think we
> >should redefine NBD_INIT_SPARSE to say that.
>=20
> Okay, in v2, I will start with just two bits, NBD_INIT_SPARSE
> (entire image is sparse, nothing is allocated) and NBD_INIT_ZERO
> (entire image reads as zero), and save any future bits for later
> additions.  Do we think that 16 bits is sufficient for the amount of
> initial information likely to be exposed?

So as I understand the proposal, the 16 bit limit comes about because
we want a round 4 byte reply, 16 bits are used by NBD_INFO_INIT_STATE
and that leaves 16 bits feature bits.  Therefore the only way to go
from there is to have 32 feature bits but an awkward unaligned 6 byte
structure, or 48 feature bits (8 byte structure).

I guess given those constraints we can stick with 16 feature bits, and
if we ever needed more then we'd have to introduce NBD_INFO_INIT_STATE2.

The only thing I can think of which might be useful is a "fully
preallocated" bit which might be used as an indication that writes are
fast and are unlikely to fail with ENOSPC.

> Are we in agreement that
> my addition of an NBD_INFO_ response to NBD_OPT_GO is the best way
> to expose initial state bits?

Seems reasonable to me.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


