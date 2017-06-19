Received: from eggs.gnu.org ([2001:4830:134:3::10]:50652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dMt1S-0004Df-Ig
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dMt1R-0005Pn-4x
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:31:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z2Dtzt7xsiE=XR=MShSHwb6Z-=JnHdtvRr2MwQpFhpuiQ@mail.gmail.com>
References: <CAOE=1Z2Dtzt7xsiE=XR=MShSHwb6Z-=JnHdtvRr2MwQpFhpuiQ@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Mon, 19 Jun 2017 17:30:59 +0800
Message-ID: <CAOE=1Z2PwNNk0KyEPC+cYSYtD62Vx=VZacaTKTHMBX=SaiBgGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Fwd: [DPDK-memory] how qemu waste such long time under
 dpdk huge page envriment?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I'm running `QEMU_CMD ...` to create a vm under dpdk huge page envriment
(which set huge page 1G). And I enable all events in qemu.

For qemu and ovs-dpdk(ovs-2.4.9 with dpdk-2.2.0) environment, detail log is:

> 30012@1497443246.678304:object_dynamic_cast_assert
qemu:memory-region->qemu:memory-region (/home/hu
> anghuai/cloud/contrib/qemu-2.6.0/memory.c:1076:memory_region_initfn)
> 30012@1497443256.274866:object_dynamic_cast_assert
qio-channel-socket->qio-channel-socket (io/chann
> el-socket.c:389:qio_channel_socket_init)


I don't know why qemu doing 'memory_region_initfn' function in this 10
second, does anyone know this?

static void memory_region_initfn(Object *obj)
> {
>     MemoryRegion *mr = MEMORY_REGION(obj);
>     ObjectProperty *op;
>     mr->ops = &unassigned_mem_ops;
>     mr->enabled = true;
>     mr->romd_mode = true;
>     mr->global_locking = true;
>     mr->destructor = memory_region_destructor_none;
>     QTAILQ_INIT(&mr->subregions);
>     QTAILQ_INIT(&mr->coalesced);
>     op = object_property_add(OBJECT(mr), "container",
>                              "link<" TYPE_MEMORY_REGION ">",
>                              memory_region_get_container,
>                              NULL, /* memory_region_set_container */
>                              NULL, NULL, &error_abort);
>     op->resolve = memory_region_resolve_container;
>     object_property_add(OBJECT(mr), "addr", "uint64",
>                         memory_region_get_addr,
>                         NULL, /* memory_region_set_addr */
>                         NULL, NULL, &error_abort);
>     object_property_add(OBJECT(mr), "priority", "uint32",
>                         memory_region_get_priority,
>                         NULL, /* memory_region_set_priority */
>                         NULL, NULL, &error_abort);
>     object_property_add_bool(OBJECT(mr), "may-overlap",
>                              memory_region_get_may_overlap,
>                              NULL, /* memory_region_set_may_overlap */
>                              &error_abort);
>     object_property_add(OBJECT(mr), "size", "uint64",
>                         memory_region_get_size,
>                         NULL, /* memory_region_set_size, */
>                         NULL, NULL, &error_abort);
> }


I print all system call by `strace -f -T -tt -e trace=all -o output.txt
$QEMU_CMD`, and I found this:

5900  11:08:11.288701 nanosleep({0, 10000000}, 0x7ff103c13a80) = 0
> <0.010171>
> 5900  11:08:11.299052 futex(0x7ff10be24340, FUTEX_WAIT_PRIVATE, 2, NULL
> <unfinished ...>
> 5899  11:08:20.138492 rt_sigaction(SIGBUS, {0x7ff10b5b1040, [],
> SA_RESTORER|SA_SIGINFO, 0x7ff1085fd100}, NULL, 8) = 0 <0.000012>
> 5899  11:08:20.138598 rt_sigprocmask(SIG_SETMASK, [BUS USR1 ALRM IO],
> NULL, 8) = 0 <0.000008>
> 5899  11:08:20.138646 mmap(NULL, 266240, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff10b380000 <0.000013>
> 5899  11:08:20.138793 mmap(NULL, 266240, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff10b33f000 <0.000009>


I don't know who call `futex`, and why waste such long time.

Thank you~
