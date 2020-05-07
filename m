Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0787C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC8220708
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC8220708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgs5-0001ZQ-MQ
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWgno-0003dc-7O
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:43:04 -0400
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:49852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWgnl-0005PH-U7
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:43:03 -0400
Received: from player735.ha.ovh.net (unknown [10.108.42.170])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 65B02162DE5
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 15:42:59 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id CC22A11E6F9BE;
 Thu,  7 May 2020 13:42:57 +0000 (UTC)
Date: Thu, 7 May 2020 15:42:53 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Message-ID: <20200507154253.26715a19@bahia.lan>
In-Reply-To: <3205025.KiTILEyK6o@silver>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <3204505.kZXhZKLjgj@silver> <20200506195415.4cc48810@bahia.lan>
 <3205025.KiTILEyK6o@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1180787529036568896
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkedtgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.35.227; envelope-from=groug@kaod.org;
 helo=17.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 09:42:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 07 May 2020 13:46:50 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 6. Mai 2020 19:54:15 CEST Greg Kurz wrote:
> > On Wed, 06 May 2020 15:36:16 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Mittwoch, 6. Mai 2020 15:05:23 CEST Christian Schoenebeck wrote:
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
> > > 
> > > One more: since this dirent structure is now on the stack, it should
> > > better be initialized for safety reasons.
> > 
> > I don't think so, for two reasons:
> > - I can't think of an initializer that would make sense for a dirent
> 
> The same as it would (implied - usually, e.g. with gmalloc0()) if you were 
> allocating it on heap: by initializing it with all zeroes, e.g. just:
> 
> 	struct dirent dent = {};
> 

Ok, so you have a zeroed dent, which is likely just as wrong as
any other arbitrary value... I just agree that if we have some
bug that prevents v9fs_co_readdir() to fill the dentry, this
would prevent arbitrary host data to leak to the guest.

> > - if a future change introduces a branch where dent could be used
> >   uninitialized, I'd rather give a chance to the compiler to bark
> 
> The compiler would reliably bark on using it unitialized if you were about to 
> access it directly within the same function. But that's not the case here. 

Hmm... that's the case with the current code base:

v9fs_do_readdir_with_stat:

        err = v9fs_co_readdir(pdu, fidp, &dent);
        if (err <= 0) {
            break;
        }
        err = v9fs_co_name_to_path(pdu, &fidp->path, dent.d_name, &path);
                                                     ^^^^

v9fs_do_readdir:

        err = v9fs_co_readdir(pdu, fidp, &dent);
        if (err <= 0) {
            break;
        }
        v9fs_string_init(&name);
        v9fs_string_sprintf(&name, "%s", dent.d_name);
                                         ^^^^

> dirent is passed by reference to a function which will be altering it. Such 
> stacked relations usually require more sophisticated diagnostics, like e.g. 
> exeuting the LLVM sanitizer.
> 

We also do Coverity runs on a regular basis.

> Best regards,
> Christian Schoenebeck
> 
> 


