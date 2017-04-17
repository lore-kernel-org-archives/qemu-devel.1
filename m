Received: from eggs.gnu.org ([2001:4830:134:3::10]:36574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d03rO-0003zi-Gi
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 06:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d03rL-0005pY-Dc
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 06:26:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d03rL-0005nS-8F
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 06:26:15 -0400
Date: Mon, 17 Apr 2017 18:26:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170417102607.GE16703@pxdev.xzpeter.org>
References: <CADUDsAo4-QypkwSR9p8ABpBRqtvCO886fec2BGdq1JtgCgt-6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADUDsAo4-QypkwSR9p8ABpBRqtvCO886fec2BGdq1JtgCgt-6w@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu memory manage question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "jack.chen" <zhunxun@gmail.com>
Cc: qemu <qemu-devel@nongnu.org>

On Mon, Apr 17, 2017 at 06:09:11PM +0800, jack.chen wrote:
> hello,I have some questions about memory allocation in qemu for
> virtual machine.I found when configure_accelerator function was called
> ,memory slots  were registered to KVM,but at that time address_space
> have not been initialized and ram have not been allocated,it is really
> confused me,Thanks a lot!!

Here's how I understand it...

configure_accelerator() does not register memory slots in KVM.
Instead, it registers memory listeners. See
kvm_memory_listener_register(), especially:

    kml->listener.region_add = kvm_region_add;

That's the hook function to be called when there are new memory region
added to the system.

Further, when RAM is initialzed, it'll modify the address space layout
of system_memory, and the registered listener of KVM (kvm_region_add)
will be invoked, it'll further sync with kvm. It should be in the
following path if you break at kvm_region_add in gdb:

#0  0x00005555557ba13a in kvm_region_add (listener=0x5555568330c0, section=0x7fffffffd310) at /root/git/qemu/kvm-all.c:859
#1  0x00005555557c1910 in address_space_update_topology_pass (as=0x55555629e240 <address_space_memory>, old_view=0x5555567a7090, new_view=0x5555568d3460, adding=true) at /root/git/qemu/memory.c:871
#2  0x00005555557c19f3 in address_space_update_topology (as=0x55555629e240 <address_space_memory>) at /root/git/qemu/memory.c:886
#3  0x00005555557c1b41 in memory_region_transaction_commit () at /root/git/qemu/memory.c:922
#4  0x00005555557c4bfd in memory_region_update_container_subregions (subregion=0x5555568d2fc0) at /root/git/qemu/memory.c:2075
#5  0x00005555557c4c64 in memory_region_add_subregion_common (mr=0x5555567a5830, offset=0, subregion=0x5555568d2fc0) at /root/git/qemu/memory.c:2085
#6  0x00005555557c4ca0 in memory_region_add_subregion (mr=0x5555567a5830, offset=0, subregion=0x5555568d2fc0) at /root/git/qemu/memory.c:2093
#7  0x000055555583fd68 in pc_memory_init (pcms=0x5555567a4100, system_memory=0x5555567a5830, rom_memory=0x5555568d21a0, ram_memory=0x7fffffffd550) at /root/git/qemu/hw/i386/pc.c:1383
#8  0x0000555555847363 in pc_q35_init (machine=0x5555567a4100) at /root/git/qemu/hw/i386/pc_q35.c:147
#9  0x0000555555847cac in pc_init_v2_9 (machine=0x5555567a4100) at /root/git/qemu/hw/i386/pc_q35.c:310
#10 0x00005555558f7cf8 in main (argc=11, argv=0x7fffffffda78, envp=0x7fffffffdad8) at /root/git/qemu/vl.c:4557

Hope this helps. Thanks.

-- 
Peter Xu
