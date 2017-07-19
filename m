Received: from eggs.gnu.org ([2001:4830:134:3::10]:60767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXs7G-0005Li-Pm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXs7D-0000IU-Ml
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXs7D-0000IF-DD
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:46:23 -0400
Date: Wed, 19 Jul 2017 17:46:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170719164617.GO2103@work-vm>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<bb8781a1-602b-d77d-a103-6f8d23d7ff5f@adacore.com>
	<20170719122943.GJ2103@work-vm>
	<3fe1df9e-6b49-621f-53b6-271fd2f77305@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe1df9e-6b49-621f-53b6-271fd2f77305@adacore.com>
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

* KONRAD Frederic (frederic.konrad@adacore.com) wrote:
> 
> 
> On 07/19/2017 02:29 PM, Dr. David Alan Gilbert wrote:
> > * KONRAD Frederic (frederic.konrad@adacore.com) wrote:
> > > 
> > > 
> > > On 07/17/2017 07:27 PM, Edgar E. Iglesias wrote:
> > > > On Mon, Jul 17, 2017 at 11:33 PM, Peter Maydell <peter.maydell@linaro.org>
> > > > wrote:
> > > > 
> > > > > On 14 June 2017 at 18:45, Edgar E. Iglesias <edgar.iglesias@gmail.com>
> > > > > wrote:
> > > > > > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > > > > > Paolo suggested offline that we send a pull request for this series.
> > > > > > Here it is, I've run it through my testsuite + tested the LQSPI testcase
> > > > > > on Zynq.
> > > > > 
> > > > > > ----------------------------------------------------------------
> > > > > > mmio-exec.for-upstream
> > > > > > 
> > > > > > ----------------------------------------------------------------
> > > > > > KONRAD Frederic (7):
> > > > > >         cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
> > > > > >         cputlb: move get_page_addr_code
> > > > > >         cputlb: fix the way get_page_addr_code fills the tlb
> > > > > >         qdev: add MemoryRegion property
> > > > > >         introduce mmio_interface
> > > > > >         exec: allow to get a pointer for some mmio memory region
> > > > > >         xilinx_spips: allow mmio execution
> > > > > 
> > > > > Hi Edgar -- can you or Fred explain how this code interacts with
> > > > > VM migration? The mmio-interface device creates a RAM memory
> > > > > region with memory_region_init_ram_ptr(), but it doesn't call
> > > > > vmstate_register_ram(). On the other hand the core migration code
> > > > > will try to migrate the contents of the RAMBlock anyway, just
> > > > > without a name.
> > > > > 
> > > > > It's not clear to me how this works, and it would be nice to
> > > > > get it clear so that we can make any necessary fixes before the
> > > > > 2.10 release hits and we lose the opportunity to make any
> > > > > migration-compatibility-breaking changes.
> > > > > 
> > > > > thanks
> > > > > -- PMM
> > > > > 
> > > > 
> > > > Hi Peter,
> > > > 
> > > > These temporary regions should be read-only and treated as temporary caches
> > > > AFAIU things.
> > > > I would say that they don't need to be migrated. After migration, the new
> > > > VM will recreate the ram areas from device backing.
> > > > 
> > > > Is there a way we can prevent migration of the RAMBlock?
> > > > 
> > > > Cheers,
> > > > Edgar
> > > > 
> > > 
> > > Hi All,
> > > 
> > > Yes Edgar is right, they don't need to be migrated (as the old
> > > Xilinx SPI cache).
> > > And it will be the case for all the other stuff using this as
> > > well.
> > > 
> > > Maybe we can simply drop the region before the migration?
> > 
> > Dont forget the VM is still running during migration, so you
> > can't drop anything that's needed for it to be able to execute.
> > 
> > Dave
> 
> Scary.. Yes your right. I still think it doesn't need to be
> migrated.. But how..

One question about the way your device works; being a cache, is
there something bad that the guest could do which would make
a reload into the cache fail - i.e the real program could
be reliant on running out of data in the cache?
i.e. could the state of the cache actually be system state
which really does need migrating.
(e.g. reprogram the flash via another route or something?)

(I've seen real code rely on an ARM TLB like this).

> BTW taking a look at this I found the comment below which seems
> to implies that the content won't be migrated?
> 
> /**
> 
>  * memory_region_init_ram_ptr:  Initialize RAM memory region from a
>  *                              user-provided pointer.  Accesses into the
>  *                              region will modify memory directly.
>  *
> 
>  * @mr: the #MemoryRegion to be initialized.
> 
>  * @owner: the object that tracks the region's reference count
> 
>  * @name: Region name, becomes part of RAMBlock name used in migration
> stream
>  *        must be unique within any device
> 
>  * @size: size of the region.
> 
>  * @ptr: memory to be mapped; must contain at least @size bytes.
> 
>  *
> 
>  * Note that this function does not do anything to cause the data in the
>  * RAM memory region to be migrated; that is the responsibility of the
> caller.
>  */
> 
> And I guess we have the same issue when we try to unplug a device
> during migration?

plug/unplugging during a migration is a bad idea; I've sene suggestions
some of the code is safe for bits of it; I'm not convinced.

Dave

> Fred
> 
> > 
> > > Fred
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
