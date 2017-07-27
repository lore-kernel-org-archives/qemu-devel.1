Received: from eggs.gnu.org ([2001:4830:134:3::10]:33577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1daoED-0004Aj-Pj
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1daoEA-0005la-Gq
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1daoEA-0005kq-7v
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:13:42 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA9Odi+ZtT1FmDoD8pjk=cgHS54BOVwopqXRi+TTf4PA8g@mail.gmail.com>
	(Peter Maydell's message of "Fri, 21 Jul 2017 10:29:10 +0100")
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
	<20170720100232.GA2456@work-vm>
	<408f467d-08dc-bb3e-0bfc-9825ca07107c@adacore.com>
	<20170721091337.GA2133@work-vm>
	<CAFEAcA9Odi+ZtT1FmDoD8pjk=cgHS54BOVwopqXRi+TTf4PA8g@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Thu, 27 Jul 2017 21:13:40 +0200
Message-ID: <87shhh7kwr.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 21 July 2017 at 10:13, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> I don't fully understand the way memory_region_do_invalidate_mmio_ptr
>> works; I see it dropping the memory region; if that's also dropping
>> the RAMBlock then it will upset migration.   Even if the CPU is stopped
>> I dont think that stops the migration thread walking through the list of
>> RAMBlocks.
>
> memory_region_do_invalidate_mmio_ptr() calls memory_region_unref(),
> which will eventually result in memory_region_finalize() being
> called, which will call the MR destructor, which in this case is
> memory_region_destructor_ram(), which calls qemu_ram_free() on
> the RAMBlock, which removes the RAMBlock from the list (after
> taking the ramlist lock).
>
>> Even then, the problem is migration keeps a 'dirty_pages' count which is
>> calculated at the start of migration and updated as we dirty and send
>> pages; if we add/remove a RAMBlock then that dirty_pages count is wrong
>> and we either never finish migration (since dirty_pages never reaches
>> zero) or finish early with some unsent data.
>> And then there's the 'received' bitmap currently being added for
>> postcopy which tracks each page that's been received (that's not in yet
>> though).
>
> It sounds like we really need to make migration robust against
> RAMBlock changes -- in the hotplug case it's certainly possible
> for RAMBlocks to be newly created or destroyed while migration
> is in progress.

There is code to disable hotplug while we are migrating.  For 2.10 we
disabled *all* hotplug/unplug.  If there are things that are safe, we
can add them as we do them.

The problem with ramblocks is that we do the equivalent of:

foreach ramblock
  for each page in this ramblock
     if page is dirty, send page

But we could take a lot of time/rounds sending a single ramblock,
because we go back/forth with top level migration functions/loops.

Later, Juan.
