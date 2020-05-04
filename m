Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C557C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9A9206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9A9206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXGb-0001e1-Bq
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jVXFQ-0000c9-V0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:18:50 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:46560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jVXFO-0003FA-Gj
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:18:48 -0400
Received: from player772.ha.ovh.net (unknown [10.108.54.141])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 39128233FC7
 for <qemu-devel@nongnu.org>; Mon,  4 May 2020 11:18:42 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 638CF120C4FB0;
 Mon,  4 May 2020 09:18:41 +0000 (UTC)
Date: Mon, 4 May 2020 11:18:34 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 3/5] 9pfs: add new function v9fs_co_readdir_many()
Message-ID: <20200504111834.117c98d9@bahia.lan>
In-Reply-To: <5819799.mbObChnQ2B@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <5059845.6LZZmIoT5M@silver> <20200430153049.12488a1d@bahia.lan>
 <5819799.mbObChnQ2B@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15992845230435965248
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.104.253; envelope-from=groug@kaod.org;
 helo=12.mo4.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:18:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 01 May 2020 16:04:41 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 30. April 2020 15:30:49 CEST Greg Kurz wrote:
> > > > I agree that a client that issues concurrent readdir requests on the
> > > > same fid is probably asking for troubles, but this permitted by the
> > > > spec. Whether we should detect such conditions and warn or even fail
> > > > is discussion for another thread.
> > > > 
> > > > The locking is only needed to avoid concurrent accesses to the dirent
> > > > structure returned by readdir(), otherwise we could return partially
> > > > overwritten file names to the client. It must be done for each
> > > > individual
> > > > call to readdir(), but certainly not for multiple calls.
> > > 
> > > Yeah, that would resolve this issue more appropriately for 9p2000.L, since
> > > Treaddir specifies an offset, but for 9p2000.u the result of a concurrent
> > > read on a directory (9p2000.u) would still be undefined.
> > 
> > The bad client behavior you want to tackle has nothing to do with
> > the locking itself. Since all the code in 9p.c runs serialized in
> > the context of the QEMU main loop, concurrent readdir requests could
> > easily be detected up-front with a simple flag in the fid structure.
> 
> Well, it's fine with me. I don't really see an issue here right now. But that 
> all the code was serialized is not fully true. Most of the 9p.c code is still 
> heavily dispatching between main thread and worker threads back and forth. And 
> for that reason the order of request processing might change quite arbitrarily 
> in between. Just keep that in mind.
> 

Just to make things clear. The code in 9p.c is ALWAYS exclusively run by
the main thread. Only the code called under v9fs_co_run_in_worker() is
dispatched on worker threads. So, yes the order of individual backend
operations may change, but the start of a new client request is necessarily
serialized with the completion of pending ones, which is the only thing
we care for actually.

> > > > > +
> > > > > +    /* save the directory position */
> > > > > +    saved_dir_pos = s->ops->telldir(&s->ctx, &fidp->fs);
> > > > > +    if (saved_dir_pos < 0) {
> > > > > +        err = saved_dir_pos;
> > > > > +        goto out;
> > > > > +    }
> > > > > +
> > > > > +    while (true) {
> > > > > +        /* get directory entry from fs driver */
> > > > > +        err = do_readdir(pdu, fidp, &dent);
> > > > > +        if (err || !dent) {
> > > > > +            break;
> > > > > +        }
> > > > > +
> > > > > +        /*
> > > > > +         * stop this loop as soon as it would exceed the allowed
> > > > > maximum
> > > > > +         * response message size for the directory entries collected
> > > > > so
> > > > > far, +         * because anything beyond that size would need to be
> > > > > discarded by +         * 9p controller (main thread / top half) anyway
> > > > > +         */
> > > > > +        v9fs_string_init(&name);
> > > > > +        v9fs_string_sprintf(&name, "%s", dent->d_name);
> > > > > +        len = v9fs_readdir_response_size(&name);
> > > > > +        v9fs_string_free(&name);
> > > > > +        if (size + len > maxsize) {
> > > > > +            /* this is not an error case actually */
> > > > > +            break;
> > > > > +        }
> > > > > +
> > > > > +        /* append next node to result chain */
> > > > > +        if (!e) {
> > > > > +            *entries = e = g_malloc0(sizeof(V9fsDirEnt));
> > > > > +        } else {
> > > > > +            e = e->next = g_malloc0(sizeof(V9fsDirEnt));
> > > > > +        }
> > > > > +        e->dent = g_malloc0(sizeof(struct dirent));
> > > > 
> > > > So we're allocating a bunch of stuff here...
> > > > 
> > > > > +        memcpy(e->dent, dent, sizeof(struct dirent));
> > > > > +
> > > > > +        /* perform a full stat() for directory entry if requested by
> > > > > caller */ +        if (dostat) {
> > > > > +            err = s->ops->name_to_path(
> > > > > +                &s->ctx, &fidp->path, dent->d_name, &path
> > > > > +            );
> > > > > +            if (err < 0) {
> > > > > 
> > > > >                  err = -errno;
> > > > > 
> > > > > -            } else {
> > > > > -                *dent = entry;
> > > > > -                err = 0;
> > > > > +                break;
> > > > 
> > > > ... but we're erroring out there and it seems that we're leaking
> > > > all the entries that have been allocated so far.
> > > 
> > > No, they are not leaking actually.
> > > 
> > > You are right that they are not deallocated in do_readdir_many(), but
> > > that's intentional: in the new implementation of v9fs_do_readdir() you
> > > see that v9fs_free_dirents(entries) is *always* called at the very end of
> > > the function, no matter if success or any error. That's one of the
> > > measures to simplify overall code as much as possible.
> > 
> > Hmm... I still don't quite like the idea of having an erroring function
> > asking for extra cleanup. I suggest you come up with an idem-potent version
> > of v9fs_free_dirents(), move it to codir.c (I also prefer locality of calls
> > to g_malloc and g_free in the same unit), make it extern and call it
> > both on the error path of v9fs_co_readdir_many() and in v9fs_do_readdir().
> 
> I understand your position of course, but I still won't find that to be a good 
> move.
> 
> My veto here has a reason: your requested change would prevent an application 
> that I had in mind for future purpose actually: Allowing "greedy" fetching 

Are you telling that this series has some kind of hidden agenda related to
a possible future change ?!?

> directory entries, that is returning all successful read entries while some of 
> the entries might have been errored for some reason. Think about a directory 
> where one entry is another device which errors for some reason, then a user 
> probably still would want to see the other entries at least. I know that 

Hrm... if dostat is such a weak requirement that callers might want to
simply ignore the missing stat, then readdir_many() shouldn't error out
in the first place.

> purpose would still need some minor adjustments, but no changes to the current 
> structure of this function actually.
> 
> But to also make this clear: there is no "extra" cleanup right now. 
> v9fs_free_dirents(entries) is *always* called by caller, no matter if success, 
> error, allocated list or NULL. It couldn't be more simple. A user of this 
> function must call v9fs_free_dirents(entries) at a certain point anyway.
> 
> If you have a bad feeling about it, I can make it more clear by an API doc 
> comment on v9fs_co_readdir_many() if you want, like e.g. "You @b MUST @ ALWAYS 
> call v9fs_free_dirents() after using this function, both on success or 
> error.".
> 

No, I just cannot ack the case of a function that returns partially valid
data and an error at the same time. Doesn't look sane to me.

> > > I think you mean the case when there's an error inside the if (dostat) {}
> > > block: The comments on struct V9fsDirEnt already suggest that the "st"
> > > member is optional and may be NULL. So if there's an error inside if
> > > (dostat) {} then caller still has a valid "dent" field at least and it's
> > > up to caller whether or not it's a problem for its purpose that "st" is
> > > empty. For that reason I would not move the block forward.
> > 
> > Hrm... the comment is:
> > 
> >     /*
> >      * optional (may be NULL): A full stat of each directory entry is just
> >      * done if explicitly told to fs driver.
> >      */
> > 
> > I don't read that it is optional for the fs driver to populate "st"
> > if this was required by the caller.
> 
> Well, if you find that ambigious, I could add an additional sentence "It might 
> also be NULL if stat failed.".
> 
> > Also, looking at the next patch
> > I see that the condition for calling stat() is V9FS_REMAP_INODES and
> > the code explicitly requires "st" to be available in this case.
> 
> Yes, but there is also an if (!st) { ... } in the subsequent patch already. So 
> I don't see an issue here.
> 
> Changing the order in readdir_many() would prevent future applications of that 
> function that I described. Or let's say, order would need to be reverted back 
> again later on.
> 
> Best regards,
> Christian Schoenebeck
> 
> 


