Received: from eggs.gnu.org ([2001:4830:134:3::10]:60715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYVDN-0002f7-83
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYVDJ-00053c-7J
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dYVDI-00053M-U6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:31:17 -0400
Date: Fri, 21 Jul 2017 11:31:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170721103110.GD2133@work-vm>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
	<20170720100232.GA2456@work-vm>
	<408f467d-08dc-bb3e-0bfc-9825ca07107c@adacore.com>
	<20170721091337.GA2133@work-vm>
	<CAFEAcA9Odi+ZtT1FmDoD8pjk=cgHS54BOVwopqXRi+TTf4PA8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Odi+ZtT1FmDoD8pjk=cgHS54BOVwopqXRi+TTf4PA8g@mail.gmail.com>
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 21 July 2017 at 10:13, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > I don't fully understand the way memory_region_do_invalidate_mmio_ptr
> > works; I see it dropping the memory region; if that's also dropping
> > the RAMBlock then it will upset migration.   Even if the CPU is stopped
> > I dont think that stops the migration thread walking through the list of
> > RAMBlocks.
> 
> memory_region_do_invalidate_mmio_ptr() calls memory_region_unref(),
> which will eventually result in memory_region_finalize() being
> called, which will call the MR destructor, which in this case is
> memory_region_destructor_ram(), which calls qemu_ram_free() on
> the RAMBlock, which removes the RAMBlock from the list (after
> taking the ramlist lock).

OK

> > Even then, the problem is migration keeps a 'dirty_pages' count which is
> > calculated at the start of migration and updated as we dirty and send
> > pages; if we add/remove a RAMBlock then that dirty_pages count is wrong
> > and we either never finish migration (since dirty_pages never reaches
> > zero) or finish early with some unsent data.
> > And then there's the 'received' bitmap currently being added for
> > postcopy which tracks each page that's been received (that's not in yet
> > though).
> 
> It sounds like we really need to make migration robust against
> RAMBlock changes -- in the hotplug case it's certainly possible
> for RAMBlocks to be newly created or destroyed while migration
> is in progress.

Juan recently added a patch that disables hotplug/unplug during
migration (b06424de) - although we did figure out later that it's
not quite enough because it stops the request to hotunplug, but
one of those might already be in flight.

Adding a RAMBlock isn't too bad a problem, removing one is much hairier.

  a) Somehow it has to be coordinated with the destination - my
  suggestion for this is to send a QMP command down the migration stream
  to do the hot-add.

  b) Migration traverses RAMBlock lists over quite a long time; we can't
  hold an RCU lock for the whole period we're doing migration,
  so the FOREACH_RCU isn't really protecting us from much.
  (We probably should hold ram_list.mutex or the whole migration at
  the moment)

  c) RAMBlocks themselves aren't reference counted

  d) We've got 2ndary structures such as that counter, a queue of
  requests, bitmaps etc - that are all either based off RAMBlock list
  data or actually contain pointers to RAMBlocks

  e) Then the RAMBlocks are registered with the kernel for dirty
  tracking.

None of those feel easily fixable.

Dave


> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
