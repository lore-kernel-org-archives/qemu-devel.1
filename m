Received: from eggs.gnu.org ([2001:4830:134:3::10]:48681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dN8pO-0008Ce-Sh
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 22:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dN8pM-0005wM-Fc
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 22:23:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170619094543.GC2640@redhat.com>
References: <CAOE=1Z2Dtzt7xsiE=XR=MShSHwb6Z-=JnHdtvRr2MwQpFhpuiQ@mail.gmail.com>
	<CAOE=1Z2PwNNk0KyEPC+cYSYtD62Vx=VZacaTKTHMBX=SaiBgGQ@mail.gmail.com>
	<20170619094543.GC2640@redhat.com>
From: Sam <batmanustc@gmail.com>
Date: Tue, 20 Jun 2017 10:23:35 +0800
Message-ID: <CAOE=1Z1utX_z-C9CUr-4Eo+mMwLevh6zkwBMrdn1kHoiinF=xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Fwd: [DPDK-memory] how qemu waste such long time
 under dpdk huge page envriment?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

OK,

Grub is bellow, which use huge page 1G.

linux16 /boot/vmlinuz-0-rescue-1324ca4d8099476d99a8633e7cb952b7
> root=UUID=9c3cf5ff-7c35-40c4-a6d9-0fc67683c4ed ro crashkernel=auto rhgb
> quiet default_hugepagesz=1G hugepagesz=1G hugepages=112, isolcpus=2,18


this is command line, ddc979cd is vhostuser interface connect with
ovs-dpdk. For normal ovs, which is not ovs-dpdk, start time is 2 second,
and there is no dpdk vhost user interface. For ovs-dpdk, start time is 15+
second, and there is dpdk vhost user interface.

CMD="$QEMU_CMD -enable-kvm -cpu
> qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,+pat,+ss,+pclmulqdq,+xsave,level=13
> -machine pc,accel=kvm -chardev
> socket,id=hmqmondev,port=55902,host=127.0.0.1,nodelay,server,nowait -mon
> chardev=hmqmondev,id=hmqmon,mode=readline -rtc
> base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
> -nodefaults -nodefconfig -no-kvm-pit-reinjection -global
> kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 8 -name test-name-5
> -m 40960 -boot order=cdn -vnc :2,password -drive
> file=$DISK_0,if=none,id=drive_0,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5 -drive
> file=$DISK_1,if=none,id=drive_1,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6 -drive
> file=$DISK_2,if=none,id=drive_2,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_2,drive=drive_2,bus=pci.0,addr=0x7 -device
> ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
> id=ide0-cd0,media=cdrom,if=none -chardev
> socket,id=char-n-ddc979cd,path=/usr/local/var/run/openvswitch/n-ddc979cd,server
> -netdev type=vhost-user,id=n-ddc979cd,chardev=char-n-ddc979cd,vhostforce=on
> -device
> virtio-net-pci,netdev=n-ddc979cd,mac=00:22:dd:c9:79:cd,id=netdev-n-ddc979cd,addr=0xf$(nic_speed
> 10000) -object
> memory-backend-file,id=mem,size=40960M,mem-path=/mnt/huge,share=on -numa
> node,memdev=mem -mem-prealloc -pidfile $PID_FILE -chardev
> socket,path=/opt/cloud/workspace/servers/b2cebb02-d171-4929-95d6-61e54cd647f7/qga.sock,server,nowait,id=qga0
> -device virtio-serial -device
> virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"


$QEMU_CMD is qemu binary file like 'qemu-system-x86_64_2.6.0'.

BTW, when I only start ovs-dpdk in huge page enviroment, ovs-dpdk start
time is also longer then normal ovs, and it is hang in EAL initializition
and seetting up physical contiguous memory, log like this:

EAL: Setting up physically contiguous memory...


But qemu don't need EAL initilizition, that's the question I can't figure
out.

And qemu long time start up only happened in huge page enviroment, I don't
know why.









2017-06-19 17:45 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Mon, Jun 19, 2017 at 05:30:59PM +0800, Sam wrote:
> > Hi all,
> >
> > I'm running `QEMU_CMD ...` to create a vm under dpdk huge page envriment
> > (which set huge page 1G). And I enable all events in qemu.
>
> Please provide the full QEMU command line you are using.
>
> > For qemu and ovs-dpdk(ovs-2.4.9 with dpdk-2.2.0) environment, detail log
> is:
> >
> > > 30012@1497443246.678304:object_dynamic_cast_assert
> > qemu:memory-region->qemu:memory-region (/home/hu
> > > anghuai/cloud/contrib/qemu-2.6.0/memory.c:1076:memory_region_initfn)
> > > 30012@1497443256.274866:object_dynamic_cast_assert
> > qio-channel-socket->qio-channel-socket (io/chann
> > > el-socket.c:389:qio_channel_socket_init)
> >
> >
> > I don't know why qemu doing 'memory_region_initfn' function in this 10
> > second, does anyone know this?
>
> If memory initialization takes a long time, this is likely a result of
> QEMU pre-allocating the memory pages, which is a fairly slow procedure,
> that can have noticable startup time impact for guests with large RAM
>
>
> > static void memory_region_initfn(Object *obj)
> > > {
> > >     MemoryRegion *mr = MEMORY_REGION(obj);
> > >     ObjectProperty *op;
> > >     mr->ops = &unassigned_mem_ops;
> > >     mr->enabled = true;
> > >     mr->romd_mode = true;
> > >     mr->global_locking = true;
> > >     mr->destructor = memory_region_destructor_none;
> > >     QTAILQ_INIT(&mr->subregions);
> > >     QTAILQ_INIT(&mr->coalesced);
> > >     op = object_property_add(OBJECT(mr), "container",
> > >                              "link<" TYPE_MEMORY_REGION ">",
> > >                              memory_region_get_container,
> > >                              NULL, /* memory_region_set_container */
> > >                              NULL, NULL, &error_abort);
> > >     op->resolve = memory_region_resolve_container;
> > >     object_property_add(OBJECT(mr), "addr", "uint64",
> > >                         memory_region_get_addr,
> > >                         NULL, /* memory_region_set_addr */
> > >                         NULL, NULL, &error_abort);
> > >     object_property_add(OBJECT(mr), "priority", "uint32",
> > >                         memory_region_get_priority,
> > >                         NULL, /* memory_region_set_priority */
> > >                         NULL, NULL, &error_abort);
> > >     object_property_add_bool(OBJECT(mr), "may-overlap",
> > >                              memory_region_get_may_overlap,
> > >                              NULL, /* memory_region_set_may_overlap */
> > >                              &error_abort);
> > >     object_property_add(OBJECT(mr), "size", "uint64",
> > >                         memory_region_get_size,
> > >                         NULL, /* memory_region_set_size, */
> > >                         NULL, NULL, &error_abort);
> > > }
> >
> >
> > I print all system call by `strace -f -T -tt -e trace=all -o output.txt
> > $QEMU_CMD`, and I found this:
> >
> > 5900  11:08:11.288701 nanosleep({0, 10000000}, 0x7ff103c13a80) = 0
> > > <0.010171>
> > > 5900  11:08:11.299052 futex(0x7ff10be24340, FUTEX_WAIT_PRIVATE, 2, NULL
> > > <unfinished ...>
> > > 5899  11:08:20.138492 rt_sigaction(SIGBUS, {0x7ff10b5b1040, [],
> > > SA_RESTORER|SA_SIGINFO, 0x7ff1085fd100}, NULL, 8) = 0 <0.000012>
> > > 5899  11:08:20.138598 rt_sigprocmask(SIG_SETMASK, [BUS USR1 ALRM IO],
> > > NULL, 8) = 0 <0.000008>
> > > 5899  11:08:20.138646 mmap(NULL, 266240, PROT_READ|PROT_WRITE,
> > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff10b380000 <0.000013>
> > > 5899  11:08:20.138793 mmap(NULL, 266240, PROT_READ|PROT_WRITE,
> > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff10b33f000 <0.000009>
> >
> >
> > I don't know who call `futex`, and why waste such long time.
>
> This trace doesn't show enough info to say what is happening - a futex
> is just the syscall used for mutex locking, so that just shows that
> thread 5900 is waiting for some lock. This doesn't imply the time is
> wasted, or really saying anything useful at all.
>
> Meanwhile thread 5899 was doing some mmap calls. There's no obvious
> relationship between the times in thread 5900 and 58909 in this trace.
> The 9 second gap here is just coincidental.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
