Received: from eggs.gnu.org ([2001:4830:134:3::10]:47999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eyWs1-0001dP-1N
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eyWrt-0003R1-Dr
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:05:09 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eyWrt-0003QK-2y
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:05:01 -0400
Received: by mail-wr0-x244.google.com with SMTP id f14so3952016wre.8
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 23:05:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152142533512.7381.1938340023148732379.malone@soybean.canonical.com>
References: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
	<152142533512.7381.1938340023148732379.malone@soybean.canonical.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 21 Mar 2018 14:04:58 +0800
Message-ID: <CAK3tnvK-zMB1t7+jdxa0o+4f1c05=sbuDpRw0QWGot0CW-ZFUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Bug 1754542 <1754542@bugs.launchpad.net>, qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, c zhang <zhangckid@gmail.com>, Lukas Straub <lukasstraub2@web.de>

Hi Suiheng,

I made a new guest image and retest it, and got the same bug from latest
branch.
I found that after the COLO checkpoint begin, the secondary guest always
send
reset request to Qemu like someone still push the reset button in the guest=
.
And this bug occurred in COLO frame related codes. This part of codes wrote
by Li zhijian and Zhang hailiang and currently maintained by Zhang hailiang=
.
So, I add them to this thread.

CC Zhijian and Hailiang:
Any idea or comments about this bug?

If you want to test COLO currently, you can try the old version of COLO:
https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10-legacy


Thanks
Zhang Chen

On Mon, Mar 19, 2018 at 10:08 AM, =E6=9D=8E=E7=A9=97=E6=81=92 <1754542@bugs=
.launchpad.net> wrote:

> Hi Zhang Chen=EF=BC=8C
> I follow the https://wiki.qemu.org/Features/COLO, And Vm no crash.
> But SVM rebooting constantly after print RESET, PVM normal startup.
>
> Secondary:
> {"timestamp": {"seconds": 1521421788, "microseconds": 541058}, "event":
> "RESUME"}
> {"timestamp": {"seconds": 1521421808, "microseconds": 493484}, "event":
> "STOP"}
> {"timestamp": {"seconds": 1521421808, "microseconds": 686466}, "event":
> "RESUME"}
> {"timestamp": {"seconds": 1521421808, "microseconds": 696152}, "event":
> "RESET", "data": {"guest": true}}
> {"timestamp": {"seconds": 1521421808, "microseconds": 740653}, "event":
> "RESET", "data": {"guest": true}}
> {"timestamp": {"seconds": 1521421818, "microseconds": 742222}, "event":
> "STOP"}
> {"timestamp": {"seconds": 1521421818, "microseconds": 969883}, "event":
> "RESUME"}
> {"timestamp": {"seconds": 1521421818, "microseconds": 979986}, "event":
> "RESET", "data": {"guest": true}}
> {"timestamp": {"seconds": 1521421819, "microseconds": 22652}, "event":
> "RESET", "data": {"guest": true}}
>
>
> The command(I run two VM in sample machine):
>
> Primary:
> sudo /home/lee/Documents/qemu/x86_64-softmmu/qemu-system-x86_64
> -enable-kvm -boot c -m 2048 -smp 2 -qmp stdio  -name primary -cpu
> qemu64,+kvmclock -device piix3-usb-uhci -device usb-tablet \
>     -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=
=3D/etc/qemu-ifdown
> -device rtl8139,id=3De0,netdev=3Dhn0 \
>     -chardev socket,id=3Dmirror0,host=3D192.168.0.33,port=3D9003,server,n=
owait \
>     -chardev socket,id=3Dcompare1,host=3D192.168.0.33,port=3D9004,server,=
wait \
>     -chardev socket,id=3Dcompare0,host=3D192.168.0.33,port=3D9001,server,=
nowait
> \
>     -chardev socket,id=3Dcompare0-0,host=3D192.168.0.33,port=3D9001 \
>     -chardev socket,id=3Dcompare_out,host=3D192.168.0.33,port=3D9005,serv=
er,nowait
> \
>     -chardev socket,id=3Dcompare_out0,host=3D192.168.0.33,port=3D9005 \
>     -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror=
0 \
>     -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=
=3Dcompare_out
> \
>     -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=
=3Dcompare0
> \
>     -object iothread,id=3Diothread1 \
>     -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=
=3D
> compare1,outdev=3Dcompare_out0,iothread=3Diothread1 \
>     -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,v=
ote-
> threshold=3D1,children.0.file.filename=3D/var/lib/libvirt/
> images/1.raw,children.0.driver=3Draw -S
>
> Secondary:
> sudo /home/lee/Documents/qemu/x86_64-softmmu/qemu-system-x86_64 -boot c
> -m 2048 -smp 2 -qmp stdio  -name secondary -enable-kvm -cpu
> qemu64,+kvmclock \
>     -device piix3-usb-uhci -device usb-tablet \
>     -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=
=3D/etc/qemu-ifdown
> \
>     -device rtl8139,netdev=3Dhn0 \
>     -chardev socket,id=3Dred0,host=3D192.168.0.33,port=3D9003,reconnect=
=3D1 \
>     -chardev socket,id=3Dred1,host=3D192.168.0.33,port=3D9004,reconnect=
=3D1 \
>     -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred=
0 \
>     -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dre=
d1 \
>     -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
>     -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/
> images/2.raw,driver=3Draw,node-name=3Dnode0 \
>     -drive if=3Dide,id=3Dactive-disk0,driver=3Dreplication,mode=3Dseconda=
ry,
> file.driver=3Dqcow2,top-id=3Dactive-disk0,file.file.
> filename=3D/mnt/ramfs/active_disk.img,file.backing.driver=3D
> qcow2,file.backing.file.filename=3D/mnt/ramfs/hidden_
> disk.img,file.backing.backing=3Dcolo-disk0 \
>     -incoming tcp:0:8888
>
> Secondary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'nbd-server-start',
>     'arguments': {'addr': {'type': 'inet', 'data': {'host':
> '192.168.0.33', 'port': '8889'} } }
>   }
>   {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0',
> 'writable': true } }
>   {'execute': 'trace-event-set-state', 'arguments': {'name': 'colo*',
> 'enable': true} }
>
>
> Primary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'human-monitor-command',
>     'arguments': {'command-line': 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.
> host=3D192.168.0.33,file.port=3D8889,file.export=3Dcolo-disk0,node-name=
=3Dnode0'}}
>   { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0',
> 'node': 'node0' } }
>   { 'execute': 'migrate-set-capabilities',
>         'arguments': {'capabilities': [ {'capability': 'x-colo', 'state':
> true } ] } }
>   { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.33:8888' } =
}
>
> Thanks
> Suiheng
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
>   {'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0'=
,
> 'writable': true } }
>
>   Primary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'human-monitor-command',
>     'arguments': {'command-line': 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.
> host=3D192.168.0.34,file.port=3D8889,file.export=3Dsecondary-
> disk0,node-name=3Dnbd_client0'}}
>   { 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0'=
,
> 'node': 'nbd_client0' } }
>   { 'execute': 'migrate-set-capabilities',
>         'arguments': {'capabilities': [ {'capability': 'x-colo', 'state':
> true } ] } }
>   { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } =
}
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
