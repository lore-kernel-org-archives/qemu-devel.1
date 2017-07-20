Received: from eggs.gnu.org ([2001:4830:134:3::10]:59872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dY8I6-0001WJ-Ke
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dY8I2-0004r1-OB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:02:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dY8I2-0004qS-2w
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:02:38 -0400
Date: Thu, 20 Jul 2017 11:02:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170720100232.GA2456@work-vm>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, KONRAD Frederic <frederic.konrad@adacore.com>, Juan Quintela <quintela@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 17 July 2017 at 19:58, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Edgar E. Iglesias (edgar.iglesias@gmail.com) wrote:
> >> Is there a way we can prevent migration of the RAMBlock?
> >
> > Not yet, I think we'd have to:
> >    a) Add a flag to the RAMBlock
> >    b) Set it/clear it on registration
> >    c) Have a RAMBLOCK_FOREACH_MIGRATABLE macro
> >    d) Replace all of the RAMBLOCK_FOREACH (and the couple of hand coded
> >    cases) with the RAMBLOCK_FOREACH_MIGRATABLE
> >    e) Worry about the corner cases!
> >
> > I've got a few worries about what happens when the kernel tries to
> > do dirty yncing - I'm not sure if we have to change anything on that
> > interface to skip those RAMBlocks.
> 
> OK, so what should we do for 2.10 ?
> 
> We could:
>  * implement the changes you suggest above, and mark only
>    vmstate_register_ram'd blocks as migratable
>    (would probably need to fix some places which buggily
>    don't call vmstate_register_ram)
>  * implement the changes above, but special case mmio-interface
>    so only its ramblock is marked unmigratable

I think either of these is too late for 2.10 - I don't fancy prodding
about in all of the migration RAM loops at this stage.

>  * postpone the changes above until 2.11, and for 2.10 register
>    a migration-blocker in mmio-interface so that we at least
>    give the user a useful error rather than having it fail
>    obscurely on vmload (and release note this)

I think that's best, especially because I've just thought of another nasty.
If I understand the way mmio-interface is working, you're dynamically
changing the RAMBlock list while the guest is running.
And while we are using QLIST_FOREACH_RCU I'm not convinced we're
actually safe against dynamic modification of that list.

> (Or something else?)
> 
> I do think we definitely need to fix this for 2.11 at latest.

OK, I can do a-e OK, I'm more worried now about that dynamic
modification I just thought of.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
