Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7A920663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7A920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeSB-0003Tu-P4
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqePw-0008LN-RQ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:12:57 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:36020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqePt-0002V2-8X
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:12:56 -0400
Received: from player735.ha.ovh.net (unknown [10.108.54.97])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7E97A170EFF
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 17:12:43 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id C1A9213B6C05E;
 Wed,  1 Jul 2020 15:12:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004db2b9b28-9dc7-4b8c-a928-d03fdaffba43,EF6FC975B06A46128E02C0B478BB3EF643A8B18B)
 smtp.auth=groug@kaod.org
Date: Wed, 1 Jul 2020 17:12:40 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Message-ID: <20200701171240.5374ebc1@bahia.lan>
In-Reply-To: <3956126.q4pgddXim5@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <4716485.3Xd2u1jlTO@silver> <20200701120924.617532a3@bahia.lan>
 <3956126.q4pgddXim5@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12099764826496014656
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.250.45; envelope-from=groug@kaod.org;
 helo=2.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 11:12:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Wed, 01 Jul 2020 13:47:12 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 1. Juli 2020 12:09:24 CEST Greg Kurz wrote:
> > No I'm talking about code that isn't changed by this series:
> > 
> >     if (initial_offset == 0) {
> >         v9fs_co_rewinddir(pdu, fidp);
> >     } else {
> >         v9fs_co_seekdir(pdu, fidp, initial_offset);
> >     }
> >     count = v9fs_do_readdir(pdu, fidp, max_count);
> > 
> > Leaving these outside the critical section seems to negate
> > your arguments... please clarify.
> 
> Yeah, I admit I have neglected this issue, as concurrent readdir requests with 
> same FID always was some kind of theoretical issue. But yes, you are right, 

It's perfectly fine to miss things, that's what reviews are made for :)

> that should be addressed by 
> 
> 1. entirely removing the rewinddir/seekdir code here
> 
> 2. passing initial_offset to v9fs_do_readdir(), which in turn would
>    pass it to readdir_many()
> 
> 3. readdir_many() would handle rewinddir/seekdir exclusively in its crticial
>    section.
> 

Sounds good. v7 ?

> > There are indeed several issues with the current readdir:
> > 
> > 1) potential inconsistency on concurrent Treaddir requests
> > 
> > 2) excessive dispatching to worker threads
> > 
> > So we agreed that 1) should never happen with a regular linux
> > client (we could even dump the lock actually) but we want to
> > make it clear in the code anyway that actions on the directory
> > stream are serialized.
> 
> My point is you are trying to fix a merely thereotical issue on code that's 
> conceptually, inherently wrong and dead end code at first place. Top half code 

I'm not trying to fix anything. We already have locking in place to
deal with this theoretical issue and it interferes with your changes.
I don't care that much if a silly guest shoots itself in the foot
actually, so it'll be fine with me if you just dump the lock, as
long as it doesn't cause QEMU to hang or crash.

> should always be designed to be as thin as possible. The old readdir code 
> though is the complete opposite.
> 

It isn't readdir only, most requests span over multiple v9fs_co_*() calls...

> > 2) basically means moving some logic from the frontend to the
> > backend, ie. called from v9fs_co_run_in_worker(). This implies
> > that a very long request (ie. one that would span on many calls
> > to readdir()) cannot be interrupted by the client anymore, as
> > opposed to what we have now BTW.
> 

... most likely to allow clients to interrupt a long request with a
Tflush. Have you considered this aspect in your changes ?

> 3) Complexity of old readdir code is so much bigger compared to the new one
>    such that probability of additional issues is also significantly higher.
> 
> > I tend to think that addressing both issues in one "rush" is
> > as much "error prone".
> 
> No it's not. The optimized readdir implementation is quantifyable, 
> significantly less complex than the old implementation (i.e. significantly 
> smaller amount of branches and error pathes, determenistic clear separation of 
> thread's task assignments which includes much smaller amount of thread hops). 
> Less complexity and increased determinism consequently means reduced chance of 
> misbehaviours. So that's not a subjective, but rather a quantifyable, proven 
> statement.
> 
> You can't switch from the old (wrong) concept to the new concept without some 
> minimum amount of changes, which yes are not small, but I don't see any way to 
> make the change set smaller without yet introducing new negative side effects.
> 
> I am now using words that I heard from your side before: please be realistic. 
> Currently man power on 9p code is extremely limited to put it mildly. Yes, we 
> could spend time on fixing this (theoretical) issue on the old readdir could. 
> But what would it buy? Due to the limited man power we can only move forward 
> with compromises; in this case you are fighting for code that's DOA. The only 
> thing that you achieve by still sticking to the old readdir code is you are 
> preventing that we move forward at all. Remember: I originally sent this patch 
> almost 7 months ago.
> 
> > > Also: it does not make sense to move locking on this series from fs driver
> > > back to main I/O thread. Atomicity must retain on driver side, not on top
> > > half.
> > 
> > Then the whole seekdir/rewinddir/telldir/readdir sequence should
> > be called with a single v9fs_co_run_in_worker() invocation, in
> > which case the locking could just be something like:
> > 
> > int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
> >                                       struct V9fsDirEnt **entries,
> >                                       int32_t maxsize, bool dostat)
> > {
> >     int err = 0;
> > 
> >     if (v9fs_request_cancelled(pdu)) {
> >         return -EINTR;
> >     }
> > 
> >     v9fs_readdir_lock(&fidp->fs.dir);
> > 
> >     v9fs_co_run_in_worker({
> >         err = do_readdir_many(pdu, fidp, entries, maxsize, dostat);
> >     });
> > 
> >     v9fs_readdir_unlock(&fidp->fs.dir);
> >     return err;
> > }
> 
> That's exactly what should be prevented. The lock must be on driver thread 
> side, not on main thread side. The goal is to reduce the time slice of 
> individual locks. If the lock is on main thread, the time slice of a lock 
> (even on huge directories with thousands of entries) is multiple factors 
> larger than if the lock is on driver thread side. So that's not just few 
> percent or so, it is huge.
> 

Sorry I don't get it...  In a contention-less situation, which is the
case we really care for, qemu_co_mutex_lock() has no overhead.

> > This would technically leave the locking in the main I/O thread,
> > but it isn't conceptually different from locking at the beginning
> > of do_readdir_lock() and unlocking before returning. My concern
> > is that I don't know how coroutine mutexes behave with multiple
> > worker threads...
> 
> Well, your Mutex -> CoMutex change was intended to fix a deadlock with the old 
> readdir implementation. That deadlock could not happen with the new readdir 
> implementation, which suggests that it probably makes sense to revert this 
> change (i.e. CoMutex -> Mutex) for this new implementation.
> 

No we can't because it is also used with 9p2000.u, that you said you
don't want to fix.

> Best regards,
> Christian Schoenebeck
> 
> 

Cheers,

--
Greg

