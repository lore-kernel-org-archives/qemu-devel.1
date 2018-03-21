Received: from eggs.gnu.org ([2001:4830:134:3::10]:54545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyeDg-0003ew-HH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyeDc-0002KR-Ol
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:56:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyeDc-0002KB-JM
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:55:56 -0400
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
	<1521229281-73637-11-git-send-email-mjc@sifive.com>
	<34ebe3f6-3ae6-cd7f-ab52-727119666632@redhat.com>
	<CAHNT7NsjiXpLOAii3sWv9rGe0h-+xAwwuO5srNPNxX+sxi9Udg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50d30ea4-2abf-e1e7-ca3b-e686313b07e0@redhat.com>
Date: Wed, 21 Mar 2018 14:55:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsjiXpLOAii3sWv9rGe0h-+xAwwuO5srNPNxX+sxi9Udg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stefan O'Rear <sorear2@gmail.com>

On 19/03/2018 22:07, Michael Clark wrote:
>=20
>=20
> On Mon, Mar 19, 2018 at 2:41 AM, Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>     On 16/03/2018 20:41, Michael Clark wrote:
>     > From reading other code that accesses memory regions directly,
>     > it appears that the rcu_read_lock needs to be held. Note: the
>     > original code for accessing RAM directly was added because
>     > there is no other way to use atomic_cmpxchg on guest physical
>     > address space.
>     >
>     > Cc: Sagar Karandikar <sagark@eecs.berkeley.edu <mailto:sagark@eec=
s.berkeley.edu>>
>     > Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de <mailto:kb=
astian@mail.uni-paderborn.de>>
>     > Signed-off-by: Michael Clark <mjc@sifive.com <mailto:mjc@sifive.c=
om>>
>     > Signed-off-by: Palmer Dabbelt <palmer@sifive.com <mailto:palmer@s=
ifive.com>>
>     > ---
>     >=C2=A0 target/riscv/helper.c | 14 ++++++++++++--
>     >=C2=A0 1 file changed, 12 insertions(+), 2 deletions(-)
>=20
>     I think the bug here is that rcu_read_lock/unlock is missing in
>     cpu_memory_rw_debug.=C2=A0 Are there any other callers you had in m=
ind?
>=20
>=20
> So this is not a bug in our patch per se, rather a bug in
> cpu_memory_rw_debug?

Yes.

> It seems that most other code that that uses the address_space_*
> interfaces (e.g. hw/virtio/virtio.c) holds the rcu_read_lock, presumabl=
y
> to=C2=A0handle cases where the memory map might change at runtime, e.g.
> during ballooning. This would be exhibited if a page walk collided with
> a balloon.

Note that hw/virtio/virtio.c calls rcu_read_lock() not so much to
protect from memory map changes, but rather to protect reads of
vq->vring.caches.

In general, exec.c and memory.c take care of taking the lock.  Functions
that need the caller to take the lock are annotated with something like

    /* Called from RCU critical section.  */

(see for example flatview_write).

> Ideally we could add a cpu_physical_memory_atomic_cmpxchg API to generi=
c
> code, and we could avoid holding the rcu_read_lock in target/riscv i.e.
> encapsulate guest physical memory atomic_cmpxchg. The=C2=A0atomic_cmpxc=
hg
> wrapper handles multiple word widthes, so we would
> need=C2=A0cpu_physical_memory_atomic_cmpxchg32
> and=C2=A0cpu_physical_memory_atomic_cmpxchg64. We need to use=C2=A0atom=
ic_cmpxchg
> in the PTE update to detect the case where the PTE has changed between
> reading it and updating the accessed dirty bits.

Yes, this makes sense.  In fact having such a function (more precisely
address_space_atomic_cmpxchg) would be useful for x86 too.  Right now
x86 is wrong in not using cmpxchg.

Even without such a function, however, I have two more things that I
noticed:

1) you're using a very low-level function, which complicates things a
bit for yourself.  You can use address_space_map/unmap too, which is a
bit simpler.

2) I'm wondering if the page walk needs to use load-acquire instructions
(and I cannot really find the relevant text in the privileged spec)

> This is an interesting constraint. I believe the intent is that we just
> AMOOR bit A+D bits on the PTE (although we don't have AMOOR, we have
> atomic_cmpxchg), however we have read a stronger interpretation (while
> stronger, it is not incorrect),

Stronger is never incorrect. :)

> and that is that the atomicity guarantee
> extends from the page walker reading the PTE entry, checking its
> permissions and then updating it, which in hardware would require the
> page walker to take load reservations, and I don't think it does.

Indeed.  But maybe another possibility could be to do an atomic_cmpxchg
and ignore it if the comparison failed?  This would be susceptible to
ABA problems, but apart from that it would be the same as taking a load
reservation (in assembly language tems, that's
load-link/or/store-conditional).

> Apparently the hardware just AMOORs the bits, so the PTE could actually
> be pointing somewhere else by the time we go to update the bits,
> although it is the same virtual address has been accessed or dirtied
> (albiet with a different physical translation). In any case, we have a
> very strong interpretation of the specification wording, potentially
> stronger than hardware may provide. We had a long discussion about this
> on the RISC-V QEMU issue tracker. Stefan O'Rear mentioned he might make
> a test that hammers a PTE from another thread while one thread is doing
> a page walk to try to cause the page walker to set the A+D bits on a PT=
E
> that is different to the one it used to create the virtual to physical
> mapping. That's some background around why the code exists in the first
> place, which provides the strongest possible gaurantee on PTE atomicity=
.
>=20
> -=C2=A0https://github.com/riscv/riscv-qemu/pull/103
> -=C2=A0https://github.com/riscv/riscv-qemu/pull/105
>=20
> The get_physical_address=C2=A0bug that this patch fixes does not show u=
p in
> practice. i.e. we aren't actually hitting cases where we have page walk=
s
> colliding with address space changes, however I think
> holding=C2=A0rcu_read_lock seems to be correct and this bug may show up=
 in
> the future.

Yes, it is correct, but it shouldn't be your responsibility---the bug is
not in your code.

tlb_fill and thus riscv_cpu_handle_mmu_fault are already called with
rcu_read_lock (translated code always is) and the same ought to be true
for riscv_cpu_get_phys_page_debug.

All the callers of cpu_get_phys_page_attrs_debug must therefore call
rcu_read_lock(), and that leaves us two possibilities:

1) cpu_memory_rw_debug and breakpoint_invalidate (in this case,
tb_invalidate_phys_addr's RCU lock/unlock can also be pushed up to
breakpoint_invalidate)

2) cpu_get_phys_page_attrs_debug itself.

I'll try to set aside some time, and post a patch for this before 2.12.

Paolo
