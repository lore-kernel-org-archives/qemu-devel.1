Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E92C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8246D21473
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="uvOfEzkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8246D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWi4f-0006Nw-NT
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWi41-0005wC-IX
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:03:53 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:42465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWi3y-0002E8-Uq
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=iP0RGBvPoay+trKQiGnDpvLtBayayU6OVv7FRnNz49k=; b=uvOfEzkcxMETkEWQStLSx6jyOf
 UyRK8OWalNBgSaE93Vpo6q1S6+OU39nai2EzUnLls2eKSLzy1U/4vruq7MtONGn3yoWvw+mvwnG+w
 TIqotTzj/kTy6LxBCRgwt3jb4KnKE43MOzxNg/oFnUL+xad1slcySSTNhWdkl2Tsl4RpHiDB1OzIO
 BEnh2zsaCKXdL1HFVF2Ac/kelklFZYVu5hDBPguYnTX/76T13g5B3x+7NuYVIDxVqJOS5NcEJ5R9B
 UFvPsSSs2jnwv6nVu73yWO6ETeF4tgGDaZ0MUvlJzaaMoN9yYf9+9ULQ2RRgxl1ieqxD9rrzW9iyp
 ckZXChi6onXR3QHq3ebWLleFDgIJh3aF2GNyRKwjU9SdxitKe7P4Qc8Ph9fmMDMLEncVKYszU8z67
 5HOlWmbiJeI7RmuNckO9Uc00NNUwLZATqDF2NDh80TI3Z3ROnzxETwRxuQbHX3zNBdHGEEyrCDdHG
 8AlimrunwzME0TGLPT2t0WnEvVYBl879FosnAtNRMioGwXhNg89HOuorM/YZOWscn67oI+xgNuz0G
 1nCqcrMaf8hLykeAECrFHuD8/0kCb+tLRRvRW56ti1WFoCIjocZZwTcSEel/tckmPtSvW1txWWC3b
 OI6fw1VEVOaZle5hQVKwEhFy97rg0tJNf8DptJGl8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Date: Thu, 07 May 2020 17:03:46 +0200
Message-ID: <3839530.O0e2CIhMhP@silver>
In-Reply-To: <20200507163328.4736534d@bahia.lan>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <8590081.eFxiLWWr9E@silver> <20200507163328.4736534d@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 11:03:47
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

On Donnerstag, 7. Mai 2020 16:33:28 CEST Greg Kurz wrote:
> > I also haven't reviewed QEMU's lock implementations in very detail, but
> > IIRC CoMutexes are completely handled in user space, while QemuMutex uses
> > regular OS mutexes and hence might cost context switches.
> 
> ... since the locking would only been exercised with an hypothetical
> client doing stupid things, this is beginning to look like bike-shedding
> to me. :)

Aha, keep that in mind when you're doing your next review. ;-)

No seriously, like I said, I don't really care too much about Mutex vs. 
CoMutex in you patch here. It was actually more about wide-picture thinking, 
i.e. other places of (co)mutexes being used or other potential changes that 
would make this or other uses more relevant one day.

> > > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > > index 9e046f7acb51..ac84ae804496 100644
> > > > > --- a/hw/9pfs/9p.c
> > > > > +++ b/hw/9pfs/9p.c
> > > > > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > > > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> > > > > 
> > > > >      struct stat stbuf;
> > > > >      off_t saved_dir_pos;
> > > > > 
> > > > > -    struct dirent *dent;
> > > > > +    struct dirent dent;
> > > > > 
> > > > >      /* save the directory position */
> > > > >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > > > > 
> > > > > @@ -2181,13 +2181,11 @@ static int coroutine_fn
> > > > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, while (1) {
> > > > > 
> > > > >          v9fs_path_init(&path);
> > > > > 
> > > > > -        v9fs_readdir_lock(&fidp->fs.dir);
> > > > > -
> > > > 
> > > > That's the deadlock fix, but ...
> > > > 
> > > > >          err = v9fs_co_readdir(pdu, fidp, &dent);
> > > > > 
> > > > > -        if (err || !dent) {
> > > > > +        if (err <= 0) {
> > > > > 
> > > > >              break;
> > > > >          
> > > > >          }
> > > > 
> > > > ... even though this code simplification might make sense, I don't
> > > > think
> > > > it
> > > > should be mixed with the deadlock fix together in one patch. They are
> > > > not
> > > 
> > > I could possibly split this in two patches, one for returning a copy
> > > and one for moving the locking around, but...
> > > 
> > > > related with each other, nor is the code simplification you are aiming
> > > > trivial
> > > 
> > > ... this assertion is somewhat wrong: moving the locking to
> > > v9fs_co_readdir() really requires it returns a copy.
> > 
> > Yeah, I am also not sure whether a split would make it more trivial enough
> > in this case to be worth the hassle. If you find an acceptable solution,
> > good, if not then leave it one patch.
> 
> Another option would be to g_malloc() the dirent in v9fs_co_readdir() and
> g_free() in the callers. This would cause less churn since we could keep
> the same function signature.

I was actually just going to suggest the same. So yes, looks like a less 
invasive change to me.

Best regards,
Christian Schoenebeck



