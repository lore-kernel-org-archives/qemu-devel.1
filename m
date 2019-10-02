Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A06C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7BE2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7BE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFcaF-0005H9-FU
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFcY3-0003dM-7P
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFcY1-0003kw-TU
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:11:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFcXz-0003hI-2z; Wed, 02 Oct 2019 07:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51C57315C02C;
 Wed,  2 Oct 2019 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94A4019C7F;
 Wed,  2 Oct 2019 11:11:48 +0000 (UTC)
Date: Wed, 2 Oct 2019 13:11:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191002111147.GB5819@localhost.localdomain>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
 <20191002104600.GC6129@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002104600.GC6129@angien.pipo.sk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 02 Oct 2019 11:11:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.10.2019 um 12:46 hat Peter Krempa geschrieben:
> On Tue, Oct 01, 2019 at 12:07:54 -0400, John Snow wrote:
> > 
> > 
> > On 10/1/19 11:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > 01.10.2019 17:10, John Snow wrote:
> > >>
> > >>
> > >> On 10/1/19 10:00 AM, Vladimir Sementsov-Ogievskiy wrote:
> > >>>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
> > >>>> ultimately what we want is to be able to find the "addressable" name for
> > >>>> the node the bitmap is attached to, which would be the name of the first
> > >>>> ancestor node that isn't a filter. (OR, the name of the block-backend
> > >>>> above that node.)
> > >>> Not the name of ancestor node, it will break mapping: it must be name of the
> > >>> node itself or name of parent (may be through several filters) block-backend
> > >>>
> > >>
> > >> Ah, you are right of course -- because block-backends are the only
> > >> "nodes" for which we actually descend the graph and add the bitmap to
> > >> its child.
> > >>
> > >> So the real back-resolution mechanism is:
> > >>
> > 
> > Amendment:
> >    - If our local node-name N is well-formed, use this.
> 
> I'd like to re-iterate that the necessity to keep node names same on
> both sides of migration is unexpected, undocumented and in some cases
> impossible.

I think the (implicitly made) requirement is not that all node-names are
kept the same, but only the node-names of those nodes for which
migration transfers some state.

It seems to me that bitmap migration is the first case of putting
something in the migration stream that isn't related to a frontend, but
to the backend, so the usual device hierarchy to address information
doesn't work here. And it seems the implications of this weren't really
considered sufficiently, resulting in the design problem we're
discussing now.

What we need to transfer is dirty bitmaps, which can be attached to any
node in the block graph. If we accept that the way to transfer this is
the migration stream, we need a way to tell which bitmap belongs to
which node. Matching node-name is the obvious answer, just like a
matching device tree hierarchy is used for frontends.

If we don't want to use the migration stream for backends, we would need
to find another way to transfer the bitmaps. I would welcome removing
backend data from the migration stream, but if this includes
non-persistent bitmaps, I don't see what the alternative could be.

> If you want to mandate that they must be kept the same please document
> it and also note the following:
> 
> - during migrations the storage layout may change e.g. a backing chain
>   may become flattened, thus keeping node names stable beyond the top
>   layer is impossible

You don't want to transfer bitmaps of nodes that you're going to drop.
I'm not an expert for these bitmaps, but I think this just means you
would have to disable any bitmaps on the backing files to be dropped on
the source host before you migrate.

> - in some cases (readonly image in a cdrom not present on destination,
>   thus not relevant here probably) it may even become impossible to
>   create any node thus keeping the top node may be impossible

Same thing, you don't want to transfer a bitmap for a node that
disappears.

> - it should be documented when and why this happens and how management
>   tools are supposed to do it
> 
> - please let me know what's actually expected, since libvirt
>   didn't enable blockdev yet we can fix any unexpected expectations
> 
> - Document it so that the expectations don't change after this.

Yes, we need a good and ideally future-proof rule of which node-names
need to stay the same. Currently it's only bitmaps, but might we get
another feature later where we want to transfer more backend data?

> - Ideally node names will not be bound to anything and freely
>   changeable. If necessary we can provide a map to qemu during migration
>   which is probably less painful and more straightforward than keeping
>   them in sync somehow ...

A map feels painful for the average user (and for the QEMU
implementation), even if it looks convenient for libvirt. If anything,
I'd make it optional and default to 1:1 mappings for anything that isn't
explicitly mapped.

Kevin

