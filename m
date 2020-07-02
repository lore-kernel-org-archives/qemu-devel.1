Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301B320748
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301B320748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1O4-0003Fp-DL
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jr1F1-00062K-4s
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:35:11 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:38426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jr1Ey-0007pV-3o
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:35:10 -0400
Received: from player159.ha.ovh.net (unknown [10.108.42.239])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9EAFD13A44C
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 17:35:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id C041C13FA18C9;
 Thu,  2 Jul 2020 15:35:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00316ba177e-06aa-47d0-9bb6-b75cb77efee5,75BF62B4CECF668C6CB40BD95E0165A1AD7DE050)
 smtp.auth=groug@kaod.org
Date: Thu, 2 Jul 2020 17:35:00 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Message-ID: <20200702173500.27f2b0a5@bahia.lan>
In-Reply-To: <1814766.vrYqd63b1M@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <3956126.q4pgddXim5@silver> <20200701171240.5374ebc1@bahia.lan>
 <1814766.vrYqd63b1M@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18349635211014150464
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeggdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.37.72; envelope-from=groug@kaod.org;
 helo=4.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:35:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Thu, 02 Jul 2020 13:43:11 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 1. Juli 2020 17:12:40 CEST Greg Kurz wrote:
> > On Wed, 01 Jul 2020 13:47:12 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Mittwoch, 1. Juli 2020 12:09:24 CEST Greg Kurz wrote:
> > > > No I'm talking about code that isn't changed by this series:
> > > >     if (initial_offset == 0) {
> > > >     
> > > >         v9fs_co_rewinddir(pdu, fidp);
> > > >     
> > > >     } else {
> > > >     
> > > >         v9fs_co_seekdir(pdu, fidp, initial_offset);
> > > >     
> > > >     }
> > > >     count = v9fs_do_readdir(pdu, fidp, max_count);
> > > > 
> > > > Leaving these outside the critical section seems to negate
> > > > your arguments... please clarify.
> > > 
> > > Yeah, I admit I have neglected this issue, as concurrent readdir requests
> > > with same FID always was some kind of theoretical issue. But yes, you are
> > > right,
> > It's perfectly fine to miss things, that's what reviews are made for :)
> > 
> > > that should be addressed by
> > > 
> > > 1. entirely removing the rewinddir/seekdir code here
> > > 
> > > 2. passing initial_offset to v9fs_do_readdir(), which in turn would
> > > 
> > >    pass it to readdir_many()
> > > 
> > > 3. readdir_many() would handle rewinddir/seekdir exclusively in its
> > > crticial> 
> > >    section.
> > 
> > Sounds good. v7 ?
> 
> Sure, that's not the problem, I can repost this handled appropriately of 
> course.
> 
> But would you please finalize your picture of this patch set first? I would 
> really (try) to finally nail this thing with the next version.
> 

I'll do my best.

> > > > There are indeed several issues with the current readdir:
> > > > 
> > > > 1) potential inconsistency on concurrent Treaddir requests
> > > > 
> > > > 2) excessive dispatching to worker threads
> > > > 
> > > > So we agreed that 1) should never happen with a regular linux
> > > > client (we could even dump the lock actually) but we want to
> > > > make it clear in the code anyway that actions on the directory
> > > > stream are serialized.
> > > 
> > > My point is you are trying to fix a merely thereotical issue on code
> > > that's
> > > conceptually, inherently wrong and dead end code at first place. Top half
> > > code
> > I'm not trying to fix anything. We already have locking in place to
> > deal with this theoretical issue and it interferes with your changes.
> > I don't care that much if a silly guest shoots itself in the foot
> > actually, so it'll be fine with me if you just dump the lock, as
> > long as it doesn't cause QEMU to hang or crash.
> 
> Ah ok, I got you as if you wanted to fix more details on the old readdir code, 
> which would be a clear blocker for this patch set to proceed. Good then.
> 
> > > should always be designed to be as thin as possible. The old readdir code
> > > though is the complete opposite.
> > 
> > It isn't readdir only, most requests span over multiple v9fs_co_*() calls...
> 
> Right, I know! And that's actually my root motivation to finally bring this 
> patch set forward, since I am very aware that this patch set is just a small 
> brick in the overall procecss of fixing similarly affected code portions. So 
> yes, that's my plan to fix them with upcoming patch sets, too.
> 
> Having said that, could we probably try to make future reviews a bit more 
> efficient at certain aspects? For instance it would help a lot if the patch 
> set was reviewed entirely, and not stopped at the very first issue spotted and 
> then suspended to ++version, as this creates large latencies in the overall 
> review process?
> 

Review of 9pfs is a best effort thing... I usually stop reviewing when I'm fed
up or when all the time I could reasonably invest is elapsed. Breaking down
the series in smaller patches is the usual improvement for that.

> And likewise it would also help if review is prioritized on relevant behaviour 
> aspects (concept, design) first before arguing about code style details like 
> variable names or other details invisible to users.
> 

I don't remember questioning the overall concept behind these changes
because it looks reasonable enough (even if I would appreciate to be
able to verify them with a working reproducer).

Even if it is invisible to the users, coding style or how a series is
broken down in patches is important for developers.

> And finally: compromises. As man power on 9p is very limited, it would make 
> sense to limit patch sets at a certain extent and agree to postpone certain 
> non-critical issues to subsequent patches (or sets of), otherwise a patch set 
> will grow and grow and it will take ages to get forward.
> 

FWIW this patchset was more than 10 patches and now it is only 5 :)

The good news is that you'll soon be able to merge things by yourself.
I'll help you when I can but I won't be the gating factor anymore.

Hurrah !

> > > > 2) basically means moving some logic from the frontend to the
> > > > backend, ie. called from v9fs_co_run_in_worker(). This implies
> > > > that a very long request (ie. one that would span on many calls
> > > > to readdir()) cannot be interrupted by the client anymore, as
> > > > opposed to what we have now BTW.
> > 
> > ... most likely to allow clients to interrupt a long request with a
> > Tflush. Have you considered this aspect in your changes ?
> 
> In this particular patch set, no, as for readdir this should not be an issue 
> in practice for anybody. After this patch set is applied, even on huge 
> directories, the fs driver's duration for readdir would barely be measurable. 
> In fact the server's latency would always be much higher, yet.
> 

Reproducer ? Numbers ? ;)

> But also for the upcoming, planned patch sets (i.e. other request types): That 
> would be an example where I would ask you to lower you expectations a bit and 
> that we could agree to postpone such an aspect to a subsequent, separate patch 
> (or set of).
> 
> > > 3) Complexity of old readdir code is so much bigger compared to the new
> > > one
> > > 
> > >    such that probability of additional issues is also significantly
> > >    higher.
> > > > 
> > > > I tend to think that addressing both issues in one "rush" is
> > > > as much "error prone".
> > > 
> > > No it's not. The optimized readdir implementation is quantifyable,
> > > significantly less complex than the old implementation (i.e. significantly
> > > smaller amount of branches and error pathes, determenistic clear
> > > separation of thread's task assignments which includes much smaller
> > > amount of thread hops). Less complexity and increased determinism
> > > consequently means reduced chance of misbehaviours. So that's not a
> > > subjective, but rather a quantifyable, proven statement.
> > > 
> > > You can't switch from the old (wrong) concept to the new concept without
> > > some minimum amount of changes, which yes are not small, but I don't see
> > > any way to make the change set smaller without yet introducing new
> > > negative side effects.
> > > 
> > > I am now using words that I heard from your side before: please be
> > > realistic. Currently man power on 9p code is extremely limited to put it
> > > mildly. Yes, we could spend time on fixing this (theoretical) issue on
> > > the old readdir could. But what would it buy? Due to the limited man
> > > power we can only move forward with compromises; in this case you are
> > > fighting for code that's DOA. The only thing that you achieve by still
> > > sticking to the old readdir code is you are preventing that we move
> > > forward at all. Remember: I originally sent this patch almost 7 months
> > > ago.
> > > 
> > > > > Also: it does not make sense to move locking on this series from fs
> > > > > driver
> > > > > back to main I/O thread. Atomicity must retain on driver side, not on
> > > > > top
> > > > > half.
> > > > 
> > > > Then the whole seekdir/rewinddir/telldir/readdir sequence should
> > > > be called with a single v9fs_co_run_in_worker() invocation, in
> > > > which case the locking could just be something like:
> > > > 
> > > > int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
> > > > 
> > > >                                       struct V9fsDirEnt **entries,
> > > >                                       int32_t maxsize, bool dostat)
> > > > 
> > > > {
> > > > 
> > > >     int err = 0;
> > > >     
> > > >     if (v9fs_request_cancelled(pdu)) {
> > > >     
> > > >         return -EINTR;
> > > >     
> > > >     }
> > > >     
> > > >     v9fs_readdir_lock(&fidp->fs.dir);
> > > >     
> > > >     v9fs_co_run_in_worker({
> > > >     
> > > >         err = do_readdir_many(pdu, fidp, entries, maxsize, dostat);
> > > >     
> > > >     });
> > > >     
> > > >     v9fs_readdir_unlock(&fidp->fs.dir);
> > > >     return err;
> > > > 
> > > > }
> > > 
> > > That's exactly what should be prevented. The lock must be on driver thread
> > > side, not on main thread side. The goal is to reduce the time slice of
> > > individual locks. If the lock is on main thread, the time slice of a lock
> > > (even on huge directories with thousands of entries) is multiple factors
> > > larger than if the lock is on driver thread side. So that's not just few
> > > percent or so, it is huge.
> > 
> > Sorry I don't get it...  In a contention-less situation, which is the
> > case we really care for, qemu_co_mutex_lock() has no overhead.
> 
> Yes, it only kicks in if there is concurrency.
> 

And we don't care to preserve performance for silly clients, do we ?

> > > > This would technically leave the locking in the main I/O thread,
> > > > but it isn't conceptually different from locking at the beginning
> > > > of do_readdir_lock() and unlocking before returning. My concern
> > > > is that I don't know how coroutine mutexes behave with multiple
> > > > worker threads...
> > > 
> > > Well, your Mutex -> CoMutex change was intended to fix a deadlock with the
> > > old readdir implementation. That deadlock could not happen with the new
> > > readdir implementation, which suggests that it probably makes sense to
> > > revert this change (i.e. CoMutex -> Mutex) for this new implementation.
> > 
> > No we can't because it is also used with 9p2000.u, that you said you
> > don't want to fix.
> 
> Yes and no, I did not say I don't want to fix readdir for 9p2000.u at all. 
> What I said was I want to prioritize and concentrate on the most relevant 
> issues first. 9p2000.L is the most commonly used protocol variant, so I would 
> like to fix the most severe (e.g. performance) issues for 9p2000.L first 
> before spending time on 9p2000.u which is AFAICS barely used in comparison, 
> which I personally don't use at all, and which I am hence not testing in the 
> same degree and cannot serve with the same quality as 9p2000.L right now.
> 
> Plus if there are really users caring for 9p2000.u, I can gladly assist them 
> to address these issues for 9p2000.u as well, provided that they help at least 
> with testing the required 9p2000.u changes.
> 

I would personally do the opposite... again ;)

Like you say we essentially care for 9p2000.L and we only do limited
support for 9p2000.u. If we have a change that we really want for
9p2000.L but it has an impact on 9p2000.u because of shared code,
it is fine to do the changes anyway, including changes to the 9p2000.u
specific code. Very basic testing of 9p2000.u (mount/ls or find/umount)
or maybe running pjd-fstest is enough IMHO. If we break someone's setup
and he complains, then we can ask him to test a fix before we merge it.

> Back to the actual topic: so what do we do about the mutex then? CoMutex for 
> 9p2000.u and Mutex for 9p2000.L? I know you find that ugly, but it would just 
> be a transitional measure.
> 

That would ruin my day...

More seriously, the recent fix for a deadlock condition that was present
for years proves that nobody seems to be using silly clients with QEMU.
So I think we should just dump the lock and add a one-time warning in
the top level handlers when we detect a duplicate readdir request on
the same fid. This should be a very simple patch (I can take care of
it right away).

> Best regards,
> Christian Schoenebeck
> 
> 

Cheers,

--
Greg

