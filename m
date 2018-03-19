Received: from eggs.gnu.org ([2001:4830:134:3::10]:57950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey1zs-000620-Vs
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey1zq-0000RY-PJ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:07:12 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:36305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey1zq-0000Qa-FL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:07:10 -0400
Received: by mail-oi0-x234.google.com with SMTP id t16so2167983oih.3
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:07:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <34ebe3f6-3ae6-cd7f-ab52-727119666632@redhat.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
	<1521229281-73637-11-git-send-email-mjc@sifive.com>
	<34ebe3f6-3ae6-cd7f-ab52-727119666632@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:07:09 -0700
Message-ID: <CAHNT7NsjiXpLOAii3sWv9rGe0h-+xAwwuO5srNPNxX+sxi9Udg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 10/24] RISC-V: Hold rcu_read_lock when
 accessing memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stefan O'Rear <sorear2@gmail.com>

On Mon, Mar 19, 2018 at 2:41 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/03/2018 20:41, Michael Clark wrote:
> > From reading other code that accesses memory regions directly,
> > it appears that the rcu_read_lock needs to be held. Note: the
> > original code for accessing RAM directly was added because
> > there is no other way to use atomic_cmpxchg on guest physical
> > address space.
> >
> > Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> > Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  target/riscv/helper.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
>
> I think the bug here is that rcu_read_lock/unlock is missing in
> cpu_memory_rw_debug.  Are there any other callers you had in mind?


So this is not a bug in our patch per se, rather a bug in
cpu_memory_rw_debug?

It seems that most other code that that uses the address_space_* interfaces
(e.g. hw/virtio/virtio.c) holds the rcu_read_lock, presumably to handle
cases where the memory map might change at runtime, e.g. during ballooning.
This would be exhibited if a page walk collided with a balloon.

Ideally we could add a cpu_physical_memory_atomic_cmpxchg API to generic
code, and we could avoid holding the rcu_read_lock in target/riscv i.e.
encapsulate guest physical memory atomic_cmpxchg. The atomic_cmpxchg
wrapper handles multiple word widthes, so we would need
cpu_physical_memory_atomic_cmpxchg32
and cpu_physical_memory_atomic_cmpxchg64. We need to use atomic_cmpxchg in
the PTE update to detect the case where the PTE has changed between reading
it and updating the accessed dirty bits. As far as I can tell, the code is
correct. In fact we are reading a very strong interpretation of the RISC-V
specification.

This is what The RISC-V Instruction Set Manual Volume II: Privileged
Architecture says about accessed and dirty updates, which is the reason for
the code in question:

    When a virtual page is accessed and the A bit is clear, or is written
and the D bit is clear,
    the implementation sets the corresponding bit in the PTE. The PTE
update must be atomic
    with respect to other accesses to the PTE, and must atomically check
that the PTE is valid
    and grants suffi cient permissions. The PTE update must be exact (i.e.,
not speculative), and
    observed in program order by the local hart. The ordering on loads and
stores provided by
    FENCE instructions and the acquire/release bits on atomic instructions
also orders the PTE
    updates associated with those loads and stores as observed by remote
harts.

This is an interesting constraint. I believe the intent is that we just
AMOOR bit A+D bits on the PTE (although we don't have AMOOR, we have
atomic_cmpxchg), however we have read a stronger interpretation (while
stronger, it is not incorrect), and that is that the atomicity guarantee
extends from the page walker reading the PTE entry, checking its
permissions and then updating it, which in hardware would require the page
walker to take load reservations, and I don't think it does. Apparently the
hardware just AMOORs the bits, so the PTE could actually be pointing
somewhere else by the time we go to update the bits, although it is the
same virtual address has been accessed or dirtied (albiet with a different
physical translation). In any case, we have a very strong interpretation of
the specification wording, potentially stronger than hardware may provide.
We had a long discussion about this on the RISC-V QEMU issue tracker.
Stefan O'Rear mentioned he might make a test that hammers a PTE from
another thread while one thread is doing a page walk to try to cause the
page walker to set the A+D bits on a PTE that is different to the one it
used to create the virtual to physical mapping. That's some background
around why the code exists in the first place, which provides the strongest
possible gaurantee on PTE atomicity.

- https://github.com/riscv/riscv-qemu/pull/103
- https://github.com/riscv/riscv-qemu/pull/105

The get_physical_address bug that this patch fixes does not show up in
practice. i.e. we aren't actually hitting cases where we have page walks
colliding with address space changes, however I think holding rcu_read_lock
seems to be correct and this bug may show up in the future.

> diff --git a/target/riscv/helper.c b/target/riscv/helper.c
> > index 02cbcea..e71633a 100644
> > --- a/target/riscv/helper.c
> > +++ b/target/riscv/helper.c
> > @@ -209,6 +209,9 @@ restart:
> >                     as the PTE is no longer valid */
> >                  MemoryRegion *mr;
> >                  hwaddr l = sizeof(target_ulong), addr1;
> > +                enum { success, translate_fail, restart_walk} action =
> success;
> > +
> > +                rcu_read_lock();
> >                  mr = address_space_translate(cs->as, pte_addr,
> >                      &addr1, &l, false);
> >                  if (memory_access_is_direct(mr, true)) {
> > @@ -222,7 +225,7 @@ restart:
> >                      target_ulong old_pte =
> >                          atomic_cmpxchg(pte_pa, pte, updated_pte);
> >                      if (old_pte != pte) {
> > -                        goto restart;
> > +                        action = restart_walk;
> >                      } else {
> >                          pte = updated_pte;
> >                      }
> > @@ -230,7 +233,14 @@ restart:
> >                  } else {
> >                      /* misconfigured PTE in ROM (AD bits are not
> preset) or
> >                       * PTE is in IO space and can't be updated
> atomically */
> > -                    return TRANSLATE_FAIL;
> > +                    action = translate_fail;
> > +                }
> > +                rcu_read_unlock();
> > +
> > +                switch (action) {
> > +                    case success: break;
> > +                    case translate_fail: return TRANSLATE_FAIL;
> > +                    case restart_walk: goto restart;
> >                  }
> >              }
> >
> >
>
>
