Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1d0Qgu-0003uJ-P9
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1d0Qgt-0000Ib-Ih
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:49:00 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhunxun@gmail.com>) id 1d0Qgt-0000IG-9e
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:48:59 -0400
Received: by mail-wr0-x241.google.com with SMTP id l28so24147503wre.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 03:48:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADUDsAqfy96pAVx6yfuG-4gk0-_hO2t+gB8JEUq-jzj_353ibA@mail.gmail.com>
References: <CADUDsAo4-QypkwSR9p8ABpBRqtvCO886fec2BGdq1JtgCgt-6w@mail.gmail.com>
	<20170417102607.GE16703@pxdev.xzpeter.org>
	<CADUDsAqnRJDhYcu2nR-zk5fkJDQ8GKkR7GjO-MrAEiJTt_X+oA@mail.gmail.com>
	<143C0AFC63FC204CB0C55BB88F3A8ABB333D79D0@EX01.corp.qihoo.net>
	<CADUDsAqfy96pAVx6yfuG-4gk0-_hO2t+gB8JEUq-jzj_353ibA@mail.gmail.com>
From: "jack.chen" <zhunxun@gmail.com>
Date: Tue, 18 Apr 2017 18:48:57 +0800
Message-ID: <CADUDsApd-xWDFb03bJ15+45T2hLJ2vv-5s1+HKC9FwVrWMwdYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu memory manage question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu <qemu-devel@nongnu.org>

Hello, now I am confused about some structures in qemu related to
memory management,they are
MemoryRegion=E3=80=81AddressSpace=E3=80=81FlatView=E3=80=81FlatRange=E3=80=
=81MemoryRegionSection=E3=80=81RAMList=E3=80=81RAMBlock=E3=80=81KVMSlot=E3=
=80=81kvm_userspace_memory_region,who
can tell me the concrete connection among these structures.
thanks a lot!

2017-04-18 10:25 GMT+08:00 jack.chen <zhunxun@gmail.com>:
> Thanks very much!!
>
> 2017-04-17 19:19 GMT+08:00 =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>:
>>
>>
>>> -----Original Message-----
>>> From: Qemu-devel
>>> [mailto:qemu-devel-bounces+liqiang6-s=3D360.cn@nongnu.org] On Behalf Of
>>> jack.chen
>>> Sent: Monday, April 17, 2017 6:56 PM
>>> To: Peter Xu
>>> Cc: qemu
>>> Subject: Re: [Qemu-devel] qemu memory manage question
>>>
>>> Thanks,from the path you have list to me,it can be  well explained,but
>>> according to the source code,in the end of kvm_init,kvm_memory_listener=
 and
>>> kvm_io_listener were registered by memory_listener_register(),and  in t=
he
>>> end of
>>> memory_listener_register(),listener_add_address_space() was called for =
each
>>> address_space,so the listener->region_add was executed then.I do not kn=
ow
>>> what mistake I have made,can you explain it to me ?? thank you very muc=
h!
>>>
>>
>> They are callbacks.
>> Every change of memory topology will call these listeners, add subregion=
(Peter's example),
>> modify the property of memory, create address space for example.
>>
>> Thanks.
>>
>> --
>> Li Qiang /the Gear Team, Qihoo 360 Inc
>>
>>
>>> 2017-04-17 18:26 GMT+08:00 Peter Xu <peterx@redhat.com>:
>>> > On Mon, Apr 17, 2017 at 06:09:11PM +0800, jack.chen wrote:
>>> >> hello,I have some questions about memory allocation in qemu for
>>> >> virtual machine.I found when configure_accelerator function was
>>> >> called ,memory slots  were registered to KVM,but at that time
>>> >> address_space have not been initialized and ram have not been
>>> >> allocated,it is really confused me,Thanks a lot!!
>>> >
>>> > Here's how I understand it...
>>> >
>>> > configure_accelerator() does not register memory slots in KVM.
>>> > Instead, it registers memory listeners. See
>>> > kvm_memory_listener_register(), especially:
>>> >
>>> >     kml->listener.region_add =3D kvm_region_add;
>>> >
>>> > That's the hook function to be called when there are new memory regio=
n
>>> > added to the system.
>>> >
>>> > Further, when RAM is initialzed, it'll modify the address space layou=
t
>>> > of system_memory, and the registered listener of KVM (kvm_region_add)
>>> > will be invoked, it'll further sync with kvm. It should be in the
>>> > following path if you break at kvm_region_add in gdb:
>>> >
>>> > #0  0x00005555557ba13a in kvm_region_add (listener=3D0x5555568330c0,
>>> > section=3D0x7fffffffd310) at /root/git/qemu/kvm-all.c:859
>>> > #1  0x00005555557c1910 in address_space_update_topology_pass
>>> > (as=3D0x55555629e240 <address_space_memory>,
>>> old_view=3D0x5555567a7090,
>>> > new_view=3D0x5555568d3460, adding=3Dtrue) at /root/git/qemu/memory.c:=
871
>>> > #2  0x00005555557c19f3 in address_space_update_topology
>>> > (as=3D0x55555629e240 <address_space_memory>) at
>>> > /root/git/qemu/memory.c:886
>>> > #3  0x00005555557c1b41 in memory_region_transaction_commit () at
>>> > /root/git/qemu/memory.c:922
>>> > #4  0x00005555557c4bfd in memory_region_update_container_subregions
>>> > (subregion=3D0x5555568d2fc0) at /root/git/qemu/memory.c:2075
>>> > #5  0x00005555557c4c64 in memory_region_add_subregion_common
>>> > (mr=3D0x5555567a5830, offset=3D0, subregion=3D0x5555568d2fc0) at
>>> > /root/git/qemu/memory.c:2085
>>> > #6  0x00005555557c4ca0 in memory_region_add_subregion
>>> > (mr=3D0x5555567a5830, offset=3D0, subregion=3D0x5555568d2fc0) at
>>> > /root/git/qemu/memory.c:2093
>>> > #7  0x000055555583fd68 in pc_memory_init (pcms=3D0x5555567a4100,
>>> > system_memory=3D0x5555567a5830, rom_memory=3D0x5555568d21a0,
>>> > ram_memory=3D0x7fffffffd550) at /root/git/qemu/hw/i386/pc.c:1383
>>> > #8  0x0000555555847363 in pc_q35_init (machine=3D0x5555567a4100) at
>>> > /root/git/qemu/hw/i386/pc_q35.c:147
>>> > #9  0x0000555555847cac in pc_init_v2_9 (machine=3D0x5555567a4100) at
>>> > /root/git/qemu/hw/i386/pc_q35.c:310
>>> > #10 0x00005555558f7cf8 in main (argc=3D11, argv=3D0x7fffffffda78,
>>> > envp=3D0x7fffffffdad8) at /root/git/qemu/vl.c:4557
>>> >
>>> > Hope this helps. Thanks.
>>> >
>>> > --
>>> > Peter Xu
>>
