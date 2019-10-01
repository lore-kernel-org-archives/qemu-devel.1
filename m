Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,WEIRD_QUOTING
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809A8C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2F2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A2F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFL9V-0000yD-UK
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFKYR-0006Rm-6N
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFKYP-0001rC-9s
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFKYL-0001pA-4J; Tue, 01 Oct 2019 11:59:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53F3820F2;
 Tue,  1 Oct 2019 15:59:04 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED66060C63;
 Tue,  1 Oct 2019 15:59:00 +0000 (UTC)
Date: Tue, 1 Oct 2019 17:58:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191001155859.GE4688@linux.fritz.box>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <f84745dc-68df-c10a-a91b-a28498e54870@virtuozzo.com>
 <20191001095416.GC4688@linux.fritz.box>
 <c051fd5c-31be-c98b-8155-70fe1b6c1283@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c051fd5c-31be-c98b-8155-70fe1b6c1283@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 01 Oct 2019 15:59:04 +0000 (UTC)
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
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.10.2019 um 17:09 hat John Snow geschrieben:
> 
> 
> On 10/1/19 5:54 AM, Kevin Wolf wrote:
> > Am 01.10.2019 um 10:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 01.10.2019 3:09, John Snow wrote:
> >>> Hi folks, I identified a problem with the migration code that Red Hat QE
> >>> found and thought you'd like to see it:
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=1652424#c20
> >>>
> >>> Very, very briefly: drive-mirror inserts a filter node that changes what
> >>> bdrv_get_device_or_node_name() returns, which causes a migration problem.
> >>>
> >>>
> >>> Ignorant question #1: Can we multi-parent the filter node and
> >>> source-node? It looks like at the moment both consider their only parent
> >>> to be the block-job and don't have a link back to their parents otherwise.
> >>>
> >>>
> >>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
> >>> ultimately what we want is to be able to find the "addressable" name for
> >>> the node the bitmap is attached to, which would be the name of the first
> >>> ancestor node that isn't a filter. (OR, the name of the block-backend
> >>> above that node.)
> >>
> >>
> >> Better would be to migrate by node-name only.. But am I right that
> >> node-names are different on source and destination? Or this situation
> >> changed?
> > 
> > Traditionally, I think migration assumes that frontends (guest devices)
> > must match exactly, but backends may and usually will differ.
> > 
> > Of course, dirty bitmaps are a backend feature that isn't really related
> > to guest devices, so this doesn't really work out any more in your case.
> > BlockBackend names are unusable for this purpose (especially as we're
> > moving towards anonymous BlockBackends everywhere), which I guess
> > essentially means node-name is the only option left.
> > 
> 
> The problem as I see it involves API stability.
> 
> We allow block-dirty-bitmap-add against e.g. "drive1" through the
> block-backend name (the name of the "drive" as the user sees it.)
> 
> Of course, once you start mirror, you aren't able to access that bitmap
> through that namepair anymore -- the "address" of the bitmap has "changed"!
> 
> (In actual fact, the bitmap always had two addresses; and simply we lost
> an alias -- but it's the one that the user likely used to create the
> bitmap, so that's bad.)

So if I understand correctly, the problem is that without a filter, in
some setups we get a usable BlockBackend name like "drive1", but when a
filter is added, we return the node-name instead which is
auto-generated and will be different on the destination.

Looking at the ChildRole documentation:

    /* Returns a name that is supposedly more useful for human users than the
     * node name for identifying the node in question (in particular, a BB
     * name), or NULL if the parent can't provide a better name. */
    const char *(*get_name)(BdrvChild *child);

I'd argue that a BlockBackend name is more useful for a human user even
across filter, so I'd support a .get_name implementation for a filter
child role (which Max wanted to introduce anyway for his filter series).

Of course, if you have a function that is made to return a convenient
text for human users, and you use it for a stable ABI like the migration
stream, this is an idea that would certainly have caused an entertaining
Linus rant in the good old kernel times.

> > Is bitmap migration something that must be enabled explicitly or does
> > it happen automatically? If it's explicit, then making an additional
> > requirement (matching node-names) shouldn't be a problem.
> 
> This means that bitmap migration becomes a blockdev-only feature.

I meant this more as the preferred way for the future rather than the
only thing supported.

But Peter has actually mentioned that for libvirt it will be
blockdev-only anyway. So do we even have a good reason to invest much
for the non-blockdev case?

Maybe making it blockdev-only is actually pretty reasonable.

> Serious question: do we have plans to formally deprecate things like
> -drive and mandate a blockdev workflow, or otherwise work to unify the
> actual graph that gets created between the two methods?

It's high on my wishlist, though we can't before libvirt uses blockdev.

Maybe something to talk about at KVM Forum?

> >>> A simple way to do this might be a "child_unfiltered" BdrvChild role
> >>> that simply bypasses the filter that was inserted and serves no real
> >>> purpose other than to allow the child to have a parent link and find who
> >>> it's """real""" parent is.
> >>>
> >>> Because of flushing, reopen, sync, drain &c &c &c I'm not sure how
> >>> feasible this quick idea might be, though.
> >>>
> >>>
> >>> - Corollary fix #1: call error_setg if the bitmap node name that's about
> >>> to go over the wire is an autogenerated node: this is never correct!
> >>>
> >>> (Why not? because the target is incapable of matching the node-name
> >>> because they are randomly generated AND you cannot specify node-names
> >>> with # prefixes as they are especially reserved!
> >>>
> >>> (This raises a related problem: if you explicitly add bitmaps to nodes
> >>> with autogenerated names, you will be unable to migrate them.))
> >>>
> >>
> >> In other words, we need a well defined way to match nodes on source and destination,
> >> keeping in mind filters, to migrate bitmaps correctly.
> >>
> 
> Yes, exactly.
> 
> >> Hm, did you thought about bitmaps in filters? It's not a problem to create bitmap in
> >> mirror-top filter during mirror job:)
> >>
> >> Or what about bitmaps in Quorum children? Or what about bitmap in qcow2 file child bs?
> >>
> >> If node-names are different on source and destination, what is the same? Top blk name
> >> and bdrv-children names (I recently saw Max's idea to check node "path" in iotest).
> > 
> > blk_name has to be assumed to be "". The BdrvChild path changes when
> > filters are inserted (and inserting filters on the destination that
> > aren't present on the source, or vice versa, sounds like something that
> > should just work).
> > 
> > So both parts of this are not great ways for addressing nodes.
> > 
> >> So, actually node is migration-addressable, if path <blk-name>/root[/child-name] to the
> >> defines this node directly (we must not have children with same name for some node in
> >> the path).
> >>
> >> And I think it's a correct way to define node in migration stream - by path.
> > 
> > I'm afraid node-name is the only thing that could possibly work reliably
> > for identifying nodes.
> > 
> > Kevin
> > 
> 
> It sounds like you are saying that bitmaps must become a blockdev-only
> feature.

More like we can't rely on BlockBackend names in a blockdev setup.
BlockBackend names can work in a purely traditional setup if we make
some effort to find the block backend even with filters in bettwen, but
they aren't universal even then. And node-names work in the blockdev
case, but they aren't universal either.

But as I said above, you made me wonder whether making it a
blockdev-only feature wouldn't actually be a good idea.

> I'm not sure if I have arrived at that conclusion yet, but it's at least
> inarguable that with blockdev it's a lot simpler to guarantee correctness.
> 
> However, we still have -cdrom and -hda and -drive and any number of
> sugars that I think we aren't committed to getting rid of yet... (or ever?)

-hda and -cdrom currently have hard-coded BlockBackend names. I don't
see what would stop us from changing this to hard-coded node names.

-drive is something that we probably need to remove in its current form
and introduce something new that is both user-friendly and powerful.
Actually, we should probably add the replacement first. :-)

Kevin

