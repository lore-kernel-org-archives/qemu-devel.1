Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD551C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F45B206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XyddKv/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F45B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQC8-0004Ub-On
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jrQB5-0003uR-R2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:12:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:53123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jrQB3-0007OB-Aj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ohZDw3bJkitu6+J48VAUrgc8f3zLT8Z79n3TuL+exog=; b=XyddKv/EklVrfH3PKGgFmL4g0c
 E4JCX9kfPtAgsiD7tgMdAOabsAkELGEMlY4TWNX/e8XNHLBqOeKceZm4RSr8UkxTQrBCpFKZBy7Lu
 q+RhXM2uU7MnnX6DtOOqn4ykhrOhqQfUM7xCGs+scVZLpGY0E+DdsSamv8XiW22smVgVZj1TEHpdR
 xyQykqC9AYfnWeWiUwGZG7yj9he1ndJxPudf1R+mvTwg4OT8AV0Yx28GvutJW/dCItqn7n0wSJyy6
 VCFWwowJTVq/LSnblGxeumU0En4XzDKrCyMUxSi10VEv+p2qkiWn+hf3oh0+hzBvDRSebhH8KsMPh
 I+j7rUSPEDNlILL4gWx53AB1Dj3AlTe6tIOKtSVw0+fLmKTvtPau5e6MDYwYNulBzMqEijkQWsCOG
 JOyzK2QAK8C37Md/xlrnUvVx66+kajiy0BxI44DTktC5b6UAPZSU9VSxBiDJZv21+/GgqKHVZcQHT
 PQ4iVIN+5lA5u2DzbtkC+LyX6eUHX7el3WNn2ndi+rp3tKUpiz2nXmRkWeupRK9kjOHw/zis9lpa0
 vbiYGZ3DeTpB9u1Ibu8550W1WzJLwlhkon+Ggeh3Qyw/WhFOoEuxtYc03+fIwscOK4uzaQ1uuMBjS
 8/grKf7Rf6MVJa+IAuPNeSQvHB/75d2WRNWrHaQe8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Date: Fri, 03 Jul 2020 20:12:40 +0200
Message-ID: <3725173.XoidOMcW12@silver>
In-Reply-To: <20200703175315.61461738@bahia.lan>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <5261112.usFQB0EGfy@silver> <20200703175315.61461738@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 14:12:42
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

On Freitag, 3. Juli 2020 17:53:15 CEST Greg Kurz wrote:
> > > I don't remember questioning the overall concept behind these changes
> > > because it looks reasonable enough (even if I would appreciate to be
> > > able to verify them with a working reproducer).
> > 
> > What exactly do you mean here with working reproducer?
> 
> Some test program to be run in a real guest that gets improved performance
> with this patch set for example.

Mhm, for now the benchmark patches already provided should be proof enough 
that this optimization will bring significant improvements in the end.

Like mentioned on a side note; to actually feel the difference with a real 
Linux client, a kernel patch is also required for the guest. But I definitely 
don't start dealing with LKML before the ground is laid on QEMU side (i.e. 
this patch set is merged on master).

> > I don't say don't care about code style, details et al., but caring a bit
> > less on reviews would not hurt, so to say. A bit of (invisible) tolerance
> > avoids friction and stagnancy.
> 
> No, this friction and stagnancy is essentially the result of not sharing
> the same agenda and different tastes also.

That summary is a bit too simple, and you know that. But okay, let's leave it 
that way.

> > rather block for something between <1ms .. 8ms, i.e. fs driver completes
> > before it would be able to actually see a flush request.
> > 
> > But to make it also clear: it would not bite with the new design either.
> > If
> > someone really would see a necessity to abort readdir requests, that would
> > be possible without huge changes.
> 
> Tflush requests are handled in the top-half exclusively by design, ie.
> they rely on the worker thread handling the targeted request to yield
> control back to the main I/O thread. Since this doesn't happen anymore
> with your patches, I'm not sure how you be able to abort a _many readdir_
> request once it's been fired into a worker thread.
> 
> A possible solution could be to break down a Treaddir into multiple
> _many readdirs_ jobs, and have a knob or some logic to control the
> latency ratio.

Too complicated, there is no need to break it down into subtasks or something. 
It can be handled with a simple abort condition in readdir_many()'s loop. But 
that's not an issue for now to discuss the details.

> > > > > > > Then the whole seekdir/rewinddir/telldir/readdir sequence should
> > > > > > > be called with a single v9fs_co_run_in_worker() invocation, in
> > > > > > > which case the locking could just be something like:
> > > > > > > 
> > > > > > > int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState
> > > > > > > *fidp,
> > > > > > > 
> > > > > > >                                       struct V9fsDirEnt
> > > > > > >                                       **entries,
> > > > > > >                                       int32_t maxsize, bool
> > > > > > >                                       dostat)
> > > > > > > 
> > > > > > > {
> > > > > > > 
> > > > > > >     int err = 0;
> > > > > > >     
> > > > > > >     if (v9fs_request_cancelled(pdu)) {
> > > > > > >     
> > > > > > >         return -EINTR;
> > > > > > >     
> > > > > > >     }
> > > > > > >     
> > > > > > >     v9fs_readdir_lock(&fidp->fs.dir);
> > > > > > >     
> > > > > > >     v9fs_co_run_in_worker({
> > > > > > >     
> > > > > > >         err = do_readdir_many(pdu, fidp, entries, maxsize,
> > > > > > >         dostat);
> > > > > > >     
> > > > > > >     });
> > > > > > >     
> > > > > > >     v9fs_readdir_unlock(&fidp->fs.dir);
> > > > > > >     return err;
> > > > > > > 
> > > > > > > }
> > > > > > 
> > > > > > That's exactly what should be prevented. The lock must be on
> > > > > > driver
> > > > > > thread
> > > > > > side, not on main thread side. The goal is to reduce the time
> > > > > > slice of
> > > > > > individual locks. If the lock is on main thread, the time slice of
> > > > > > a
> > > > > > lock
> > > > > > (even on huge directories with thousands of entries) is multiple
> > > > > > factors
> > > > > > larger than if the lock is on driver thread side. So that's not
> > > > > > just
> > > > > > few
> > > > > > percent or so, it is huge.
> > > > > 
> > > > > Sorry I don't get it...  In a contention-less situation, which is
> > > > > the
> > > > > case we really care for, qemu_co_mutex_lock() has no overhead.
> > > > 
> > > > Yes, it only kicks in if there is concurrency.
> > > 
> > > And we don't care to preserve performance for silly clients, do we ?
> > 
> > We don't necessarily need to preserve performance for them, that's right.
> > But it is already handled appropriately for them, so destroying it (i.e.
> > slowing them down) only makes sense if there is a good reason for that.
> 
> Ending up with a mix of two different kind of mutexes for 9p2000.L and .u is
> a good enough reason for me.

Correct behaviour always has precedence before code aesthetics, but we already 
agreed to remove the lock entirely anyway, so let's move on.

> > > > > > > This would technically leave the locking in the main I/O thread,
> > > > > > > but it isn't conceptually different from locking at the
> > > > > > > beginning
> > > > > > > of do_readdir_lock() and unlocking before returning. My concern
> > > > > > > is that I don't know how coroutine mutexes behave with multiple
> > > > > > > worker threads...
> > > > > > 
> > > > > > Well, your Mutex -> CoMutex change was intended to fix a deadlock
> > > > > > with
> > > > > > the
> > > > > > old readdir implementation. That deadlock could not happen with
> > > > > > the
> > > > > > new
> > > > > > readdir implementation, which suggests that it probably makes
> > > > > > sense to
> > > > > > revert this change (i.e. CoMutex -> Mutex) for this new
> > > > > > implementation.
> > > > > 
> > > > > No we can't because it is also used with 9p2000.u, that you said you
> > > > > don't want to fix.
> > > > 
> > > > Yes and no, I did not say I don't want to fix readdir for 9p2000.u at
> > > > all.
> > > > What I said was I want to prioritize and concentrate on the most
> > > > relevant
> > > > issues first. 9p2000.L is the most commonly used protocol variant, so
> > > > I
> > > > would like to fix the most severe (e.g. performance) issues for
> > > > 9p2000.L
> > > > first before spending time on 9p2000.u which is AFAICS barely used in
> > > > comparison, which I personally don't use at all, and which I am hence
> > > > not
> > > > testing in the same degree and cannot serve with the same quality as
> > > > 9p2000.L right now.
> > > > 
> > > > Plus if there are really users caring for 9p2000.u, I can gladly
> > > > assist
> > > > them to address these issues for 9p2000.u as well, provided that they
> > > > help at least with testing the required 9p2000.u changes.
> > > 
> > > I would personally do the opposite... again ;)
> > > 
> > > Like you say we essentially care for 9p2000.L and we only do limited
> > > support for 9p2000.u. If we have a change that we really want for
> > > 9p2000.L but it has an impact on 9p2000.u because of shared code,
> > > it is fine to do the changes anyway, including changes to the 9p2000.u
> > > specific code. Very basic testing of 9p2000.u (mount/ls or find/umount)
> > > or maybe running pjd-fstest is enough IMHO. If we break someone's setup
> > > and he complains, then we can ask him to test a fix before we merge it.
> > 
> > Well, so you want to handle the relevant 9p2000.u readdir optimizations by
> > yourself, and you would send it as follow-up patch set (after this set is
> > through), including test cases?
> 
> Ah it wasn't my point. I was just saying that any valuable change for
> 9p2000.L prevails and if you have to change some common code (eg.
> locking) that could impact the 9p2000.u experience, you can do it
> anyway, even if you only do smoke testing with 9p2000.u.

Ah I see, so you would. But you don't. ;-)

And yes, I could. But I won't either, for the following reasons:

1. I would have to write readdir test cases for 9p2000.u as well, because the 
   9p2000.L tests are incompatible. -> My time

2. I have to change the 9p2000.u server code -> My time

3. This patch grows substantially, by both lines and amount of patches -> My
   time and probably +10 versions more of this patch series.

4. I would have to do at least some basic testing of 9p2000.u behaviour
   -> My time

All these things would bring me +x months farther away from reaching my actual 
goal: making 9p useable by Linux clients. So no, I don't waste time on 
9p2000.u optimizations before I see somebody actually caring for 9p2000.u 
efficiency.

Best regards,
Christian Schoenebeck



