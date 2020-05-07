Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF3BC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC6C20870
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="w3eC0WFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC6C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWer2-0005LR-VN
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWeqN-0004vs-8v
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:37:35 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:48615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWeqL-0002rW-92
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=lIfmfWTKLqD5YaQ/UlSuVe2aA9aYB4r68ilvMvbu5cE=; b=w3eC0WFLw+uvPQS2A5g46XJhbW
 IvRd/O0F/J0NrCOp+RyvQgedSDcmsackCTqqfI0VVkGHAUFx0M7gRMfIEKPF1ZpWWEY/NbHdIuLiD
 h2g5iAH/fa5r2WVs9j6GZ1sDZosDJzr/cbtZLs2bUQphb/7QtqrNTX7UAZ8P0ruE7neE9JwwsY6LS
 GaHoNhZz/NoSGgXHn/HrZjA76etUWRuJG3x/OzQ1OUh6vkfVoEYyFblxkGnGA5aURiOft32F0dmkS
 q5VZiaro+jZ4vBWuvzFZ4HQrd9YD1Z6Y4YBnvfqtN+E2Hm0TEdf1u4U+WloSydIUVgu7+Ek+SdlY0
 reSn6wGWXMJwhm/AMiNP4OXJnWzCBb7bmxip0yDCAmANXV8AamQCk77W4ON46ffaz6i8E0amLVdD8
 3lnDdrWcxKHZxlZu9xxTLl+unIjgWWAuFDdcZoJTmfGifP0nX4iQYik/NmrKUMd6G2jaE4kn3awxf
 oRClmqdiR2yx1fLALEaDol2LwI8+Zo/INwYStkJtUU2BsPQB+/vD81id7xQ77tD1z6LdzQGsVMoEM
 sn3mhgeuUFNsNlBbmMXvSwD6kEes1WlVzofjM0VavAQ0ZYOjFyGLZK6u05Eex1Xbs6qtgztrBdhjd
 PThiXjgKx17/BM1IFs7W/eyuSsC7Z89vjEKovHPyE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Date: Thu, 07 May 2020 13:37:30 +0200
Message-ID: <8590081.eFxiLWWr9E@silver>
In-Reply-To: <20200506194910.615e8126@bahia.lan>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <4216293.sUgoX00Q1d@silver> <20200506194910.615e8126@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 07:37:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 6. Mai 2020 19:49:10 CEST Greg Kurz wrote:
> > Ok, but why not both? Moving locks to worker thread and QemuMutex ->
> > CoMutex?
> Using CoMutex would be mandatory if we leave the locking where it sits
> today, so that the main thread can switch to other coroutines instead
> of blocking. We don't have the same requirement with the worker thread:
> it just needs to do the actual readdir() and then it goes back to the
> thread pool, waiting to be summoned again for some other work. 

Yes, I know.

> So I'd
> rather use standard mutexes to keep things simple... why would you
> want to use a CoMutex here ?

Like you said, it would not be mandatory, nor a big deal, the idea was just if 
a lock takes longer than expected then a worker thread could already continue 
with another task. I mean the amount of worker threads are limited they are 
not growing on demand, are they?

I also haven't reviewed QEMU's lock implementations in very detail, but IIRC 
CoMutexes are completely handled in user space, while QemuMutex uses regular 
OS mutexes and hence might cost context switches. 

> > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > index 9e046f7acb51..ac84ae804496 100644
> > > --- a/hw/9pfs/9p.c
> > > +++ b/hw/9pfs/9p.c
> > > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> > > 
> > >      struct stat stbuf;
> > >      off_t saved_dir_pos;
> > > 
> > > -    struct dirent *dent;
> > > +    struct dirent dent;
> > > 
> > >      /* save the directory position */
> > >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > > 
> > > @@ -2181,13 +2181,11 @@ static int coroutine_fn
> > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, while (1) {
> > > 
> > >          v9fs_path_init(&path);
> > > 
> > > -        v9fs_readdir_lock(&fidp->fs.dir);
> > > -
> > 
> > That's the deadlock fix, but ...
> > 
> > >          err = v9fs_co_readdir(pdu, fidp, &dent);
> > > 
> > > -        if (err || !dent) {
> > > +        if (err <= 0) {
> > > 
> > >              break;
> > >          
> > >          }
> > 
> > ... even though this code simplification might make sense, I don't think
> > it
> > should be mixed with the deadlock fix together in one patch. They are not
> 
> I could possibly split this in two patches, one for returning a copy
> and one for moving the locking around, but...
> 
> > related with each other, nor is the code simplification you are aiming
> > trivial
> ... this assertion is somewhat wrong: moving the locking to
> v9fs_co_readdir() really requires it returns a copy.

Yeah, I am also not sure whether a split would make it more trivial enough in 
this case to be worth the hassle. If you find an acceptable solution, good, if 
not then leave it one patch.

> > enough to justify squashing. The deadlock fix should make it through the
> > stable branches, while the code simplification should not. So that's
> > better
> > off as a separate cleanup patch.
> 
> The issue has been there for such a long time without causing any
> trouble. Not worth adding churn in stable for a bug that is impossible
> to hit with a regular linux guest.

Who knows. There are also other clients out there. A potential deadlock is 
still a serious issue after all.

> > > @@ -32,13 +32,20 @@ int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu,
> > > V9fsFidState *fidp, struct dirent *entry;
> > > 
> > >              errno = 0;
> > > 
> > > +
> > > +            v9fs_readdir_lock(&fidp->fs.dir);
> > > +
> > > 
> > >              entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > >              if (!entry && errno) {
> > >              
> > >                  err = -errno;
> > > 
> > > +            } else if (entry) {
> > > +                memcpy(dent, entry, sizeof(*dent));
> > > +                err = 1;
> > 
> > I find using sizeof(*dent) a bit dangerous considering potential type
> > changes in future. I would rather use sizeof(struct dirent). It is also
> > more human friendly to read IMO.
> 
> Hmm... I believe it's the opposite actually: with sizeof(*dent), memcpy
> will always copy the number of bytes that are expected to fit in *dent,
> no matter the type.

Yes, but what you intend is to flat copy a structure, not pointers. So no 
matter how the type is going to be changed you always actually wanted 
(semantically)

	copy(sizeof(struct dirent), nelements)

Now it is nelements=1, in future it might also be nelements>1, but what you 
certainly don't ever want here is

	copy(sizeof(void*), nelements)

> But yes, since memcpy() doesn't do any type checking for us, I think
> I'll just turn this into:
> 
>                 *dent = *entry;

Ok

Best regards,
Christian Schoenebeck



