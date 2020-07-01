Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73303C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335992073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Q4IgmkeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335992073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbDb-0002PW-G4
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jqbCw-00020u-Ey
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:47:18 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:37643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jqbCt-0002Do-Vh
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Q2G7BoUgNRQMR3AeaS1do1Ry44yW/70zOUIlvVDxS+M=; b=Q4IgmkeXNgfskuKZ+FbxNd8Az7
 v67elN0jobGHE93GS8UlinwLwEry42v6Z/JM0vjzCUvnQcItyfociD6y7oPerdwT2NIGXsI0hAxXs
 siYCq9LjtQmqVjR8A1dHBrsT4eBp7o2RDs+i7lt62U+KAtdtCMzUI8Nq9m5fvOQCH22proVULOoCv
 8Oo9+65LdwKkeEqoGJH5A7+Fy/+9oZI2YNVpk3NLjRzgnKLedB0tCdvG2LF2edSHR2w8nzZJoQ9tV
 3gTXXIw2VcfLSBEh6ChAT2l2ZeXo4rlg+tV8oNH3dKfZEsQ/eGO0jQmWJ8U1WaokJS+alGSMCr9bn
 j0ipxNY0nP/j9dLB0YHsQQQllHSKq7b8On0FJaoQQqTyYzgq13UC6uiObB8ev6GtS6zMVyhlTVXIA
 KV1wPSNWUjFzl+K/1sxdjMfVseXA3NtUDfmaQyzO6T/yMnVEUv7uIdpTWKBLgYCFOZg6u8hl9Y9qN
 YfjEqpAWHA8h0j8iE/EaFiTRPuhleUthZahwq+k5AbmLsGmhH0emSI3V4BfHgKefw4H0SiCjsM5ik
 Ztcuzxz3yhFdBQlgmpo2qrZoEomOdTvVcNgS9erblhvK/ovOB/DeT8Gc/4hQUvPDa6Wlm1F6wenrZ
 bw5DKSNi5DGyq2JE+0s/56QVAHtoaAijWa8mQUnZA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Date: Wed, 01 Jul 2020 13:47:12 +0200
Message-ID: <3956126.q4pgddXim5@silver>
In-Reply-To: <20200701120924.617532a3@bahia.lan>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <4716485.3Xd2u1jlTO@silver> <20200701120924.617532a3@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 07:47:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 1. Juli 2020 12:09:24 CEST Greg Kurz wrote:
> No I'm talking about code that isn't changed by this series:
> 
>     if (initial_offset == 0) {
>         v9fs_co_rewinddir(pdu, fidp);
>     } else {
>         v9fs_co_seekdir(pdu, fidp, initial_offset);
>     }
>     count = v9fs_do_readdir(pdu, fidp, max_count);
> 
> Leaving these outside the critical section seems to negate
> your arguments... please clarify.

Yeah, I admit I have neglected this issue, as concurrent readdir requests with 
same FID always was some kind of theoretical issue. But yes, you are right, 
that should be addressed by 

1. entirely removing the rewinddir/seekdir code here

2. passing initial_offset to v9fs_do_readdir(), which in turn would
   pass it to readdir_many()

3. readdir_many() would handle rewinddir/seekdir exclusively in its crticial
   section.

> There are indeed several issues with the current readdir:
> 
> 1) potential inconsistency on concurrent Treaddir requests
> 
> 2) excessive dispatching to worker threads
> 
> So we agreed that 1) should never happen with a regular linux
> client (we could even dump the lock actually) but we want to
> make it clear in the code anyway that actions on the directory
> stream are serialized.

My point is you are trying to fix a merely thereotical issue on code that's 
conceptually, inherently wrong and dead end code at first place. Top half code 
should always be designed to be as thin as possible. The old readdir code 
though is the complete opposite.

> 2) basically means moving some logic from the frontend to the
> backend, ie. called from v9fs_co_run_in_worker(). This implies
> that a very long request (ie. one that would span on many calls
> to readdir()) cannot be interrupted by the client anymore, as
> opposed to what we have now BTW.

3) Complexity of old readdir code is so much bigger compared to the new one
   such that probability of additional issues is also significantly higher.

> I tend to think that addressing both issues in one "rush" is
> as much "error prone".

No it's not. The optimized readdir implementation is quantifyable, 
significantly less complex than the old implementation (i.e. significantly 
smaller amount of branches and error pathes, determenistic clear separation of 
thread's task assignments which includes much smaller amount of thread hops). 
Less complexity and increased determinism consequently means reduced chance of 
misbehaviours. So that's not a subjective, but rather a quantifyable, proven 
statement.

You can't switch from the old (wrong) concept to the new concept without some 
minimum amount of changes, which yes are not small, but I don't see any way to 
make the change set smaller without yet introducing new negative side effects.

I am now using words that I heard from your side before: please be realistic. 
Currently man power on 9p code is extremely limited to put it mildly. Yes, we 
could spend time on fixing this (theoretical) issue on the old readdir could. 
But what would it buy? Due to the limited man power we can only move forward 
with compromises; in this case you are fighting for code that's DOA. The only 
thing that you achieve by still sticking to the old readdir code is you are 
preventing that we move forward at all. Remember: I originally sent this patch 
almost 7 months ago.

> > Also: it does not make sense to move locking on this series from fs driver
> > back to main I/O thread. Atomicity must retain on driver side, not on top
> > half.
> 
> Then the whole seekdir/rewinddir/telldir/readdir sequence should
> be called with a single v9fs_co_run_in_worker() invocation, in
> which case the locking could just be something like:
> 
> int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
>                                       struct V9fsDirEnt **entries,
>                                       int32_t maxsize, bool dostat)
> {
>     int err = 0;
> 
>     if (v9fs_request_cancelled(pdu)) {
>         return -EINTR;
>     }
> 
>     v9fs_readdir_lock(&fidp->fs.dir);
> 
>     v9fs_co_run_in_worker({
>         err = do_readdir_many(pdu, fidp, entries, maxsize, dostat);
>     });
> 
>     v9fs_readdir_unlock(&fidp->fs.dir);
>     return err;
> }

That's exactly what should be prevented. The lock must be on driver thread 
side, not on main thread side. The goal is to reduce the time slice of 
individual locks. If the lock is on main thread, the time slice of a lock 
(even on huge directories with thousands of entries) is multiple factors 
larger than if the lock is on driver thread side. So that's not just few 
percent or so, it is huge.

> This would technically leave the locking in the main I/O thread,
> but it isn't conceptually different from locking at the beginning
> of do_readdir_lock() and unlocking before returning. My concern
> is that I don't know how coroutine mutexes behave with multiple
> worker threads...

Well, your Mutex -> CoMutex change was intended to fix a deadlock with the old 
readdir implementation. That deadlock could not happen with the new readdir 
implementation, which suggests that it probably makes sense to revert this 
change (i.e. CoMutex -> Mutex) for this new implementation.

Best regards,
Christian Schoenebeck



