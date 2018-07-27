Received: from eggs.gnu.org ([2001:4830:134:3::10]:57030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fiwkq-00048W-LF
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fiwkl-0000hB-N1
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:01:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:58046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fiwkl-0000fx-Cg
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:01:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fiwkj-0004Ny-Ns
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 07:01:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 732042E80CC
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 07:01:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Jul 2018 06:55:35 -0000
From: Zhang Chen <zhangckid@gmail.com>
Reply-To: Bug 1754542 <1754542@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
	<153266718785.9788.12692328451705208317.malone@chaenomeles.canonical.com>
Message-Id: <CAK3tnv+zu6v7bxgGsOxeCLH0L-LM3LERG8vSzOyc6WNPCqRtVQ@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1754542] Re: colo: vm crash with segmentation
 fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Chao,

Yes, virtio blk isn't supported by current COLO, you can try the "-drive
if=3Dide xxxxxxxx".

Thanks
Zhang Chen

On Fri, Jul 27, 2018 at 12:53 PM, WANG Chao <wangchao19890207@gmail.com>
wrote:

> Hi, Zhang Chen
>
> It seems virtio blk isn't working.
>
> I test coloft against https://github.com/zhangckid/qemu/tree/qemu-colo-
> 18jul22, got the following error on very early stage:
>
> On primary:
> qemu-system-x86_64: Can't receive COLO message: Input/output error
>
> On secondary:
> qemu-system-x86_64: block.c:4893: bdrv_detach_aio_context: Assertion
> `!bs->walking_aio_notifiers' failed.
>
> Run the test as follows:
>
> 1. Setup primary:
>
> # qemu-img create -b centos6base.img -f qcow2 centos6sp.img
> # qemu-system-x86_64 -machine dump-guest-core=3Doff -accel kvm -m 128 \
> -smp 2 -name primary -serial stdio \
> -qmp unix://root/wangchao/pvm.monitor.sock,server,nowait -vnc :10 \
> -netdev tap,id=3Dhn0,vhost=3Doff,script=3Dno,downscript=3Dno -drive \
> if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3D
> fifo,vote-threshold=3D1,children.0.file.filename=3D/root/wangchao/images/
> centos6sp.img,children.0.driver=3Dqcow2 \
> -S -nodefaults
>
> 2. Setup secondary:
>
> # qemu-img create -b centos6base.img -f qcow2 centos6sp.img
> # qemu-img create -f qcow2 /dev/shm/active.img 20G
> # qemu-img create -f qcow2 /dev/shm/hidden.img 20G
> # qemu-system-x86_64 -machine dump-guest-core=3Doff -accel kvm -m 128 \
> -smp 2 -name secondary -serial stdio \
> -qmp unix://root/wangchao/svm.monitor.sock,server,nowait -vnc :10 \
> -netdev tap,id=3Dhn0,vhost=3Doff,script=3Dno,downscript=3Dno \
> -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D/root/wangchao/
> images/centos6sp.img,driver=3Dqcow2,node-name=3Dnode0 \
> -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3D
> secondary,top-id=3Dactive-disk0,file.driver=3Dqcow2,file.file.
> filename=3D/dev/shm/active.img,file.backing.driver=3Dqcow2,
> file.backing.file.filename=3D/dev/shm/hidden.img,file.
> backing.backing=3Dsecondary-disk0 \
> -incoming tcp:0:8888 -nodefaults
>
> 3. Issue the following qmp:
>
> On secondary:
> {'execute':'qmp_capabilities'}
> {'execute': 'nbd-server-start', 'arguments': {'addr': {'type': 'inet',
> 'data': {'host': 'x.x.x.x', 'port': '8889'} } } }
> {'execute': 'nbd-server-add', 'arguments': {'device':'secondary-disk0',
> 'writable': true } }
>
> On primary:
> {'execute': 'qmp_capabilities'}
> {'execute': 'human-monitor-command', 'arguments': {'command-line':
> 'drive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd=
,file.
> host=3Dx.x.x.x,file.port=3D8889,file.export=3Dsecondary-disk0,
> node-name=3Dnbd_client0'}}
> {'execute': 'x-blockdev-change', 'arguments':{'parent': 'primary-disk0',
> 'node': 'nbd_client0' } }
> {'execute': 'migrate-set-capabilities', 'arguments': {'capabilities':
> [{'capability': 'x-colo', 'state': true } ] } }
> {'execute': 'migrate', 'arguments': {'uri': 'tcp:x.x.x.x:8888'}}
>
> 4. Then secondary immediately crashed:
> qemu-system-x86_64: block.c:4893: bdrv_detach_aio_context: Assertion
> `!bs->walking_aio_notifiers' failed.
>
> (gdb) bt
> #0  0x00007fb50d241277 in raise () from /lib64/libc.so.6
> #1  0x00007fb50d242968 in abort () from /lib64/libc.so.6
> #2  0x00007fb50d23a096 in __assert_fail_base () from /lib64/libc.so.6
> #3  0x00007fb50d23a142 in __assert_fail () from /lib64/libc.so.6
> #4  0x0000000000706ae9 in bdrv_detach_aio_context (bs=3D0x2e84000) at
> block.c:4893
> #5  0x0000000000706ab8 in bdrv_detach_aio_context (bs=3Dbs@entry=3D0x315d=
400)
> at block.c:4911
> #6  0x0000000000706c16 in bdrv_set_aio_context (bs=3D0x315d400,
> new_context=3D0x2e17180) at block.c:4960
> #7  0x000000000070a43d in block_job_attached_aio_context
> (new_context=3D<optimized out>, opaque=3D0x2d92000) at blockjob.c:111
> #8  0x0000000000706b93 in bdrv_attach_aio_context (bs=3D0x2e84000,
> new_context=3Dnew_context@entry=3D0x2e17180) at block.c:4942
> #9  0x0000000000706b2b in bdrv_attach_aio_context (bs=3D0x315d400,
> new_context=3Dnew_context@entry=3D0x2e17180) at block.c:4930
> #10 0x0000000000706b2b in bdrv_attach_aio_context (bs=3D0x2ff8800,
> new_context=3Dnew_context@entry=3D0x2e17180) at block.c:4930
> #11 0x0000000000706b2b in bdrv_attach_aio_context (bs=3Dbs@entry=3D0x2ff5=
400,
> new_context=3Dnew_context@entry=3D0x2e17180) at block.c:4930
> #12 0x0000000000706c29 in bdrv_set_aio_context (bs=3D0x2ff5400,
> new_context=3D0x2e17180) at block.c:4966
> #13 0x0000000000748a17 in blk_set_aio_context (blk=3D<optimized out>,
> new_context=3D<optimized out>) at block/block-backend.c:1894
> #14 0x000000000049b60a in virtio_blk_data_plane_start (vdev=3D<optimized
> out>) at /root/wangchao/qemu-colo-18jul22/hw/block/dataplane/
> virtio-blk.c:215
> #15 0x000000000069ceda in virtio_bus_start_ioeventfd (bus=3Dbus@entry=3D0=
x46280f8)
> at hw/virtio/virtio-bus.c:223
> #16 0x00000000006a2480 in virtio_pci_start_ioeventfd (proxy=3D0x4620000) =
at
> hw/virtio/virtio-pci.c:288
> #17 virtio_pci_common_write (opaque=3D0x4620000, addr=3D<optimized out>,
> val=3D<optimized out>, size=3D<optimized out>) at hw/virtio/virtio-pci.c:=
1288
> #18 0x00000000004673b8 in memory_region_write_accessor (mr=3D0x46209d0,
> addr=3D20, value=3D<optimized out>, size=3D1, shift=3D<optimized out>,
> mask=3D<optimized out>, attrs=3D...) at /root/wangchao/qemu-colo-
> 18jul22/memory.c:527
> #19 0x0000000000466c63 in access_with_adjusted_size (addr=3Daddr@entry=3D=
20,
> value=3Dvalue@entry=3D0x7fb509ba4788, size=3Dsize@entry=3D1,
> access_size_min=3D<optimized out>, access_size_max=3D<optimized out>,
> access_fn=3Daccess_fn@entry=3D0x467340 <memory_region_write_accessor>,
> mr=3Dmr@entry=3D0x46209d0, attrs=3Dattrs@entry=3D...) at /root/wangchao/q=
emu-colo-
> 18jul22/memory.c:594
> #20 0x0000000000469388 in memory_region_dispatch_write (mr=3Dmr@entry=3D0=
x46209d0,
> addr=3Daddr@entry=3D20, data=3D15, size=3D1, attrs=3Dattrs@entry=3D...) at
> /root/wangchao/qemu-colo-18jul22/memory.c:1473
> #21 0x000000000041ada0 in flatview_write_continue (fv=3Dfv@entry=3D0x459e=
c80,
> addr=3Daddr@entry=3D4273963028, attrs=3D..., attrs@entry=3D..., buf=3Dbuf=
@entry=3D0x7fb51019a028
> <Address 0x7fb51019a028 out of bounds>, len=3Dlen@entry=3D1, addr1=3D20,
> l=3D1,mr=3D0x46209d0) at /root/wangchao/qemu-colo-18jul22/exec.c:3255
> #22 0x000000000041af62 in flatview_write (fv=3D0x459ec80, addr=3D42739630=
28,
> attrs=3D..., buf=3D0x7fb51019a028 <Address 0x7fb51019a028 out of bounds>,
> len=3D1) at /root/wangchao/qemu-colo-18jul22/exec.c:3294
>
> It seems we were trying to do another aio_notifiers walk *inside a
> aio_notifiers walk*.
>
> Thanks
> WANG Chao
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1754542
>
> Title:
>   colo:  vm crash with segmentation fault
>
> Status in QEMU:
>   New
>
> Bug description:
>   I use Arch Linux x86_64
>   Zhang Chen's(https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10)
>   Following document 'COLO-FT.txt',
>   I test colo feature on my hosts
>
>   I run this command
>   Primary:
>   sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp
> stdio -name primary \
>   -device piix3-usb-uhci \
>   -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
>   -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
>   -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3D
> fifo,vote-threshold=3D1,\
>   children.0.file.filename=3D/var/lib/libvirt/images/1.raw,\
>   children.0.driver=3Draw -S
>
>   Secondary:
>   sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp
> stdio -name secondary \
>   -device piix3-usb-uhci \
>   -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
>   -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
>   -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D/var/lib/
> libvirt/images/2.raw,driver=3Draw,node-name=3Dnode0 \
>   -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecond=
ary,\
>   file.driver=3Dqcow2,top-id=3Dactive-disk0,\
>   file.file.filename=3D/mnt/ramfs/active_disk.img,\
>   file.backing.driver=3Dqcow2,\
>   file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
>   file.backing.backing=3Dsecondary-disk0 \
>   -incoming tcp:0:8888
>
>   Secondary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'nbd-server-start',
>     'arguments': {'addr': {'type': 'inet', 'data': {'host':
> '192.168.0.34', 'port': '8889'} } }
>   }
>   {'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0',
> 'writable': true } }
>
>   Primary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'human-monitor-command',
>     'arguments': {'command-line': 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.
> host=3D192.168.0.34,file.port=3D8889,file.export=3Dsecondary-
> disk0,node-name=3Dnbd_client0'}}
>   { 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0',
> 'node': 'nbd_client0' } }
>   { 'execute': 'migrate-set-capabilities',
>         'arguments': {'capabilities': [ {'capability': 'x-colo', 'state':
> true } ] } }
>   { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } }
>   And two VM with cash
>   Primary:
>   {"timestamp": {"seconds": 1520763655, "microseconds": 511415}, "event":
> "RESUME"}
>   [1]    329 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64
> -boot c -enable-kvm -m 2048 -smp 2 -qm
>
>   Secondary:
>   {"timestamp": {"seconds": 1520763655, "microseconds": 510907}, "event":
> "RESUME"}
>   [1]    367 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64
> -boot c -enable-kvm -m 2048 -smp 2 -qm
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754542

Title:
  colo:  vm crash with segmentation fault

Status in QEMU:
  New

Bug description:
  I use Arch Linux x86_64
  Zhang Chen's(https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10)
  Following document 'COLO-FT.txt',
  I test colo feature on my hosts

  I run this command
  Primary:
  sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp st=
dio -name primary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
  -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3Dfifo=
,vote-threshold=3D1,\
  children.0.file.filename=3D/var/lib/libvirt/images/1.raw,\
  children.0.driver=3Draw -S

  Secondary:
  sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp st=
dio -name secondary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
  -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D/var/lib/libvirt/im=
ages/2.raw,driver=3Draw,node-name=3Dnode0 \
  -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondar=
y,\
  file.driver=3Dqcow2,top-id=3Dactive-disk0,\
  file.file.filename=3D/mnt/ramfs/active_disk.img,\
  file.backing.driver=3Dqcow2,\
  file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
  file.backing.backing=3Dsecondary-disk0 \
  -incoming tcp:0:8888

  Secondary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'nbd-server-start',
    'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.34',=
 'port': '8889'} } }
  }
  {'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', =
'writable': true } }

  Primary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'human-monitor-command',
    'arguments': {'command-line': 'drive_add -n buddy driver=3Dreplication,=
mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.34,file.port=3D8889,=
file.export=3Dsecondary-disk0,node-name=3Dnbd_client0'}}
  { 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0', =
'node': 'nbd_client0' } }
  { 'execute': 'migrate-set-capabilities',
        'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': t=
rue } ] } }
  { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } }
  And two VM with cash
  Primary:
  {"timestamp": {"seconds": 1520763655, "microseconds": 511415}, "event": "=
RESUME"}
  [1]    329 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -bo=
ot c -enable-kvm -m 2048 -smp 2 -qm

  Secondary:
  {"timestamp": {"seconds": 1520763655, "microseconds": 510907}, "event": "=
RESUME"}
  [1]    367 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -bo=
ot c -enable-kvm -m 2048 -smp 2 -qm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions
