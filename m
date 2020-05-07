Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CAEC54E4B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFB42073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFB42073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhbr-0003lB-Sn
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWhak-00025h-Rg
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:33:38 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:57800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWhaj-0003GD-8f
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:33:38 -0400
Received: from player737.ha.ovh.net (unknown [10.108.57.178])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 74A1F8E007
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 16:33:33 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id BF8D88ADA921;
 Thu,  7 May 2020 14:33:31 +0000 (UTC)
Date: Thu, 7 May 2020 16:33:28 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Message-ID: <20200507163328.4736534d@bahia.lan>
In-Reply-To: <8590081.eFxiLWWr9E@silver>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <4216293.sUgoX00Q1d@silver> <20200506194910.615e8126@bahia.lan>
 <8590081.eFxiLWWr9E@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2034782608128317760
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkedtgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.73.241; envelope-from=groug@kaod.org;
 helo=10.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 10:33:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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

On Thu, 07 May 2020 13:37:30 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 6. Mai 2020 19:49:10 CEST Greg Kurz wrote:
> > > Ok, but why not both? Moving locks to worker thread and QemuMutex ->
> > > CoMutex?
> > Using CoMutex would be mandatory if we leave the locking where it sits
> > today, so that the main thread can switch to other coroutines instead
> > of blocking. We don't have the same requirement with the worker thread:
> > it just needs to do the actual readdir() and then it goes back to the
> > thread pool, waiting to be summoned again for some other work. 
> 
> Yes, I know.
> 
> > So I'd
> > rather use standard mutexes to keep things simple... why would you
> > want to use a CoMutex here ?
> 
> Like you said, it would not be mandatory, nor a big deal, the idea was just if 
> a lock takes longer than expected then a worker thread could already continue 
> with another task. I mean the amount of worker threads are limited they are 
> not growing on demand, are they?
> 

Yes, the pool is limited to a fixed number of 64 threads, but...

> I also haven't reviewed QEMU's lock implementations in very detail, but IIRC 
> CoMutexes are completely handled in user space, while QemuMutex uses regular 
> OS mutexes and hence might cost context switches. 
> 

... since the locking would only been exercised with an hypothetical
client doing stupid things, this is beginning to look like bike-shedding
to me. :)

> > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > index 9e046f7acb51..ac84ae804496 100644
> > > > --- a/hw/9pfs/9p.c
> > > > +++ b/hw/9pfs/9p.c
> > > > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> > > > 
> > > >      struct stat stbuf;
> > > >      off_t saved_dir_pos;
> > > > 
> > > > -    struct dirent *dent;
> > > > +    struct dirent dent;
> > > > 
> > > >      /* save the directory position */
> > > >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > > > 
> > > > @@ -2181,13 +2181,11 @@ static int coroutine_fn
> > > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, while (1) {
> > > > 
> > > >          v9fs_path_init(&path);
> > > > 
> > > > -        v9fs_readdir_lock(&fidp->fs.dir);
> > > > -
> > > 
> > > That's the deadlock fix, but ...
> > > 
> > > >          err = v9fs_co_readdir(pdu, fidp, &dent);
> > > > 
> > > > -        if (err || !dent) {
> > > > +        if (err <= 0) {
> > > > 
> > > >              break;
> > > >          
> > > >          }
> > > 
> > > ... even though this code simplification might make sense, I don't think
> > > it
> > > should be mixed with the deadlock fix together in one patch. They are not
> > 
> > I could possibly split this in two patches, one for returning a copy
> > and one for moving the locking around, but...
> > 
> > > related with each other, nor is the code simplification you are aiming
> > > trivial
> > ... this assertion is somewhat wrong: moving the locking to
> > v9fs_co_readdir() really requires it returns a copy.
> 
> Yeah, I am also not sure whether a split would make it more trivial enough in 
> this case to be worth the hassle. If you find an acceptable solution, good, if 
> not then leave it one patch.
> 

Another option would be to g_malloc() the dirent in v9fs_co_readdir() and
g_free() in the callers. This would cause less churn since we could keep
the same function signature.

> > > enough to justify squashing. The deadlock fix should make it through the
> > > stable branches, while the code simplification should not. So that's
> > > better
> > > off as a separate cleanup patch.
> > 
> > The issue has been there for such a long time without causing any
> > trouble. Not worth adding churn in stable for a bug that is impossible
> > to hit with a regular linux guest.
> 
> Who knows. There are also other clients out there. A potential deadlock is 
> still a serious issue after all.
> 

Well, I guess Cc: qemu-stable doesn't cost much and then I let other
people decide. I have enough in my plate with upstream.

> > > > @@ -32,13 +32,20 @@ int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu,
> > > > V9fsFidState *fidp, struct dirent *entry;
> > > > 
> > > >              errno = 0;
> > > > 
> > > > +
> > > > +            v9fs_readdir_lock(&fidp->fs.dir);
> > > > +
> > > > 
> > > >              entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > > >              if (!entry && errno) {
> > > >              
> > > >                  err = -errno;
> > > > 
> > > > +            } else if (entry) {
> > > > +                memcpy(dent, entry, sizeof(*dent));
> > > > +                err = 1;
> > > 
> > > I find using sizeof(*dent) a bit dangerous considering potential type
> > > changes in future. I would rather use sizeof(struct dirent). It is also
> > > more human friendly to read IMO.
> > 
> > Hmm... I believe it's the opposite actually: with sizeof(*dent), memcpy
> > will always copy the number of bytes that are expected to fit in *dent,
> > no matter the type.
> 
> Yes, but what you intend is to flat copy a structure, not pointers. So no 
> matter how the type is going to be changed you always actually wanted 
> (semantically)
> 
> 	copy(sizeof(struct dirent), nelements)
> 
> Now it is nelements=1, in future it might also be nelements>1, but what you 
> certainly don't ever want here is
> 
> 	copy(sizeof(void*), nelements)
> 
> > But yes, since memcpy() doesn't do any type checking for us, I think
> > I'll just turn this into:
> > 
> >                 *dent = *entry;
> 
> Ok
> 
> Best regards,
> Christian Schoenebeck
> 
> 


