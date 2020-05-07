Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F78EC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5110820643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5110820643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjVa-0002sS-C1
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWjUy-0002TY-9x
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:35:48 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:53142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWjUw-0003l9-4r
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:35:48 -0400
Received: from player761.ha.ovh.net (unknown [10.108.42.167])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4847920EAB0
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 18:35:42 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id 9CA061224844D;
 Thu,  7 May 2020 16:35:40 +0000 (UTC)
Date: Thu, 7 May 2020 18:35:36 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Message-ID: <20200507183536.1714287f@bahia.lan>
In-Reply-To: <3839530.O0e2CIhMhP@silver>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <8590081.eFxiLWWr9E@silver> <20200507163328.4736534d@bahia.lan>
 <3839530.O0e2CIhMhP@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4097431238336026944
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkedtgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.76.65; envelope-from=groug@kaod.org;
 helo=2.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 12:35:42
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

On Thu, 07 May 2020 17:03:46 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 7. Mai 2020 16:33:28 CEST Greg Kurz wrote:
> > > I also haven't reviewed QEMU's lock implementations in very detail, but
> > > IIRC CoMutexes are completely handled in user space, while QemuMutex uses
> > > regular OS mutexes and hence might cost context switches.
> > 
> > ... since the locking would only been exercised with an hypothetical
> > client doing stupid things, this is beginning to look like bike-shedding
> > to me. :)
> 
> Aha, keep that in mind when you're doing your next review. ;-)
> 

Fair enough. :)

> No seriously, like I said, I don't really care too much about Mutex vs. 
> CoMutex in you patch here. It was actually more about wide-picture thinking, 
> i.e. other places of (co)mutexes being used or other potential changes that 
> would make this or other uses more relevant one day.
> 

Then I agree with you that it would be better to use CoMutex if we were
experiencing thread pool exhaustion indeed.

> > > > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > > > index 9e046f7acb51..ac84ae804496 100644
> > > > > > --- a/hw/9pfs/9p.c
> > > > > > +++ b/hw/9pfs/9p.c
> > > > > > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > > > > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> > > > > > 
> > > > > >      struct stat stbuf;
> > > > > >      off_t saved_dir_pos;
> > > > > > 
> > > > > > -    struct dirent *dent;
> > > > > > +    struct dirent dent;
> > > > > > 
> > > > > >      /* save the directory position */
> > > > > >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > > > > > 
> > > > > > @@ -2181,13 +2181,11 @@ static int coroutine_fn
> > > > > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, while (1) {
> > > > > > 
> > > > > >          v9fs_path_init(&path);
> > > > > > 
> > > > > > -        v9fs_readdir_lock(&fidp->fs.dir);
> > > > > > -
> > > > > 
> > > > > That's the deadlock fix, but ...
> > > > > 
> > > > > >          err = v9fs_co_readdir(pdu, fidp, &dent);
> > > > > > 
> > > > > > -        if (err || !dent) {
> > > > > > +        if (err <= 0) {
> > > > > > 
> > > > > >              break;
> > > > > >          
> > > > > >          }
> > > > > 
> > > > > ... even though this code simplification might make sense, I don't
> > > > > think
> > > > > it
> > > > > should be mixed with the deadlock fix together in one patch. They are
> > > > > not
> > > > 
> > > > I could possibly split this in two patches, one for returning a copy
> > > > and one for moving the locking around, but...
> > > > 
> > > > > related with each other, nor is the code simplification you are aiming
> > > > > trivial
> > > > 
> > > > ... this assertion is somewhat wrong: moving the locking to
> > > > v9fs_co_readdir() really requires it returns a copy.
> > > 
> > > Yeah, I am also not sure whether a split would make it more trivial enough
> > > in this case to be worth the hassle. If you find an acceptable solution,
> > > good, if not then leave it one patch.
> > 
> > Another option would be to g_malloc() the dirent in v9fs_co_readdir() and
> > g_free() in the callers. This would cause less churn since we could keep
> > the same function signature.
> 
> I was actually just going to suggest the same. So yes, looks like a less 
> invasive change to me.
> 

I'll just do that then :)

> Best regards,
> Christian Schoenebeck
> 
> 


