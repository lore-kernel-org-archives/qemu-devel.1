Received: from eggs.gnu.org ([2001:4830:134:3::10]:38913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fBMzI-0007DV-FP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fBMzC-0007Tl-Gy
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:09:44 -0400
Message-ID: <1524672566.23669.15.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 25 Apr 2018 18:09:26 +0200
In-Reply-To: <20180420102117.GQ2434@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Fri, 2018-04-20 at 20:21 +1000, David Gibson wrote:
> On Fri, Apr 20, 2018 at 11:31:10AM +0200, Andrea Bolognani wrote:
> > Is the 16 MiB page size available for both POWER8 and POWER9?
> 
> No.  That's a big part of what makes this such a mess.  HPT has 16MiB
> and 16GiB hugepages, RPT has 2MiB and 1GiB hugepages.  (Well, I guess
> tecnically Power9 does have 16MiB pages - but only in hash mode, which
> the host won't be).
> 
[...]
> > > This does mean, for example, that if
> > > it was just set to the hugepage size on a p9, 21 (2MiB) things should
> > > work correctly (in practice it would act identically to setting it to
> > > 16).
> > 
> > Wouldn't that lead to different behavior depending on whether you
> > start the guest on a POWER9 or POWER8 machine? The former would be
> > able to use 2 MiB hugepages, while the latter would be stuck using
> > regular 64 KiB pages.
> 
> Well, no, because 2MiB hugepages aren't a thing in HPT mode.  In RPT
> mode it'd be able to use 2MiB hugepages either way, because the
> limitations only apply to HPT mode.
> 
> > Migration of such a guest from POWER9 to
> > POWER8 wouldn't work because the hugepage allocation couldn't be
> > fulfilled,
> 
> Sort of, you couldn't even get as far as staring the incoming qemu
> with hpt-mps=21 on the POWER8 (unless you gave it 16MiB hugepages for
> backing).
> 
> > but the other way around would probably work and lead to
> > different page sizes being available inside the guest after a power
> > cycle, no?
> 
> Well.. there are a few cases here.  If you migrated p8 -> p8 with
> hpt-mps=21 on both ends, you couldn't actually start the guest on the
> source without giving it hugepage backing.  In which case it'll be
> fine on the p9 with hugepage mapping.
> 
> If you had hpt-mps=16 on the source and hpt-mps=21 on the other end,
> well, you don't get to count on anything because you changed the VM
> definition.  In fact it would work in this case, and you wouldn't even
> get new page sizes after restart because HPT mode doesn't support any
> pagesizes between 64kiB and 16MiB.
> 
> > > > I guess 34 corresponds to 1 GiB hugepages?
> > > 
> > > No, 16GiB hugepages, which is the "colossal page" size on HPT POWER
> > > machines.  It's a simple shift, (1 << 34) == 16 GiB, 1GiB pages would
> > > be 30 (but wouldn't let the guest do any more than 24 ~ 16 MiB in
> > > practice).
> > 
> > Isn't 1 GiB hugepages support at least being worked on[1]?
> 
> That's for radix mode.  Hash mode has 16MiB and 16GiB, no 1GiB.

So, I've spent some more time trying to wrap my head around the
whole ordeal I'm still unclear about some of the details, though;
hopefully you'll be willing to answer a few more questions.

Basically the only page sizes you can have for HPT guests are
4 KiB, 64 KiB, 16 MiB and 16 GiB; in each case, for KVM, you need
the guest memory to be backed by host pages which are at least as
big, or it won't work. The same limitation doesn't apply to either
RPT or TCG guests.

The new parameter would make it possible to make sure you will
actually be able to use the page size you're interested in inside
the guest, by preventing it from starting at all if the host didn't
provide big enough backing pages; it would also ensure the guest
gets access to different page sizes when running using TCG as an
accelerator instead of KVM.

For a KVM guest running on a POWER8 host, the matrix would look
like

    b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
  -------- -------- -------- -------- -------- --------
   64 KiB | 64 KiB | 64 KiB |        |        |        |
  -------- -------- -------- -------- -------- --------
   16 MiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
  -------- -------- -------- -------- -------- --------
   16 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
  -------- -------- -------- -------- -------- --------

with backing page sizes from top to bottom, requested max page
sizes from left to right, actual max page sizes in the cells and
empty cells meaning the guest won't be able to start; on a POWER9
machine, the matrix would look like

    b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
  -------- -------- -------- -------- -------- --------
   64 KiB | 64 KiB | 64 KiB |        |        |        |
  -------- -------- -------- -------- -------- --------
    2 MiB | 64 KiB | 64 KiB |        |        |        |
  -------- -------- -------- -------- -------- --------
    1 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
  -------- -------- -------- -------- -------- --------

instead, and finally on TCG the backing page size wouldn't matter
and you would simply have

    b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
  -------- -------- -------- -------- -------- --------
          | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
  -------- -------- -------- -------- -------- --------

Does everything up until here make sense?

While trying to figure out this, one of the things I attempted to
do was run a guest in POWER8 compatibility mode on a POWER9 host
and use hugepages for backing, but that didn't seem to work at
all, possibly hinting at the fact that not all of the above is
actually accurate and I need you to correct me :)

This is the command line I used:

  /usr/libexec/qemu-kvm \
  -machine pseries,accel=kvm \
  -cpu host,compat=power8 \
  -m 2048 \
  -mem-prealloc \
  -mem-path /dev/hugepages \
  -smp 8,sockets=8,cores=1,threads=1 \
  -display none \
  -no-user-config \
  -nodefaults \
  -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x2,drive=vda \
  -drive file=/var/lib/libvirt/images/huge.qcow2,format=qcow2,if=none,id=vda \
  -serial mon:stdio

-- 
Andrea Bolognani / Red Hat / Virtualization
