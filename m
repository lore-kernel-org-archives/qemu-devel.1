Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1exIFO-0007vv-41
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 16:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1exIFL-0004UG-11
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 16:16:10 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:32833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1exIFK-0004RJ-Jp
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 16:16:06 -0400
Received: by mail-wm0-x22a.google.com with SMTP id s206so7231103wme.0
	for <qemu-devel@nongnu.org>; Sat, 17 Mar 2018 13:16:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
References: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 18 Mar 2018 04:16:04 +0800
Message-ID: <CAK3tnvLTAtcy_tYH1Ud1T0oNYv2+58hGAyFmMirrS6Zkter3HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1754542] [NEW] colo: secondary vm crash when
 execute x-colo-lost-heartbeat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1754542 <1754542@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

 Hi Suiheng,

Sorry for slow reply, the document 'COLO-FT.txt' in qemu is out of date, I
will update it lately.
Please follow this step to run COLO(the command has been changed).
https://wiki.qemu.org/Features/COLO

Thanks
Zhang Chen

On Fri, Mar 9, 2018 at 10:54 AM, =E6=9D=8E=E7=A9=97=E6=81=92 <1754542@bugs.=
launchpad.net> wrote:

> Public bug reported:
>
> I use Arch Linux x86_64
> both qemu 2.11.1 and Zhang Chen's(https://github.com/
> zhangckid/qemu/commits/colo-with-virtio-net-internal-jul10)
> Following document 'COLO-FT.txt',
> I test colo feature on my hosts
>
> I run this command
> Primary:
> sudo qemu-system-x86_64 -boot c   -enable-kvm -m 2048 -smp 2  -qmp stdio
> -name primary \
> -device piix3-usb-uhci \
> -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
> -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
> -drive if=3Dvirtio,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3D
> fifo,vote-threshold=3D1,children.0.file.filename=3D/var/
> lib/libvirt/images/1.raw,children.0.driver=3Draw -S
>
> Secondary:
> sudo qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qmp stdio
> -name secondary \
> -device piix3-usb-uhci \
> -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
> -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
> -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/
> images/2.raw,driver=3Draw,node-name=3Dnode0 \
> -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondar=
y,\
> file.driver=3Dqcow2,top-id=3Dactive-disk0,\
> file.file.filename=3D/mnt/ramfs/active_disk.img,\
> file.backing.driver=3Dqcow2,\
> file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
> file.backing.backing=3Dcolo-disk0 \
> -incoming tcp:0:8888
>
> Secondary:
> {'execute':'qmp_capabilities'}
> { 'execute': 'nbd-server-start',
>   'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.33',
> 'port': '8889'} } }
> }
> {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0',
> 'writable': true } }
>
> Primary:
> {'execute':'qmp_capabilities'}
> { 'execute': 'human-monitor-command',
>   'arguments': {'command-line': 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.
> host=3D192.168.0.34,file.port=3D8889,file.export=3Dcolo-disk0,
> node-name=3Dnbd_client0'}}
> { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0',
> 'node': 'nbd_client0' } }
> { 'execute': 'migrate-set-capabilities',
>       'arguments': {'capabilities': [ {'capability': 'x-colo', 'state':
> true } ] } }
> { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } }
> { 'execute': 'migrate-set-parameters' , 'arguments':{
> 'x-checkpoint-delay': 2000 } }
>
> Above are all OK.Two VM syncing.
>
> Primary:
> { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0',
> 'child': 'children.1'}}
> { 'execute': 'human-monitor-command','arguments': {'command-line':
> 'drive_del blk-buddy0'}}
>
> Secondary:
> { 'execute': 'nbd-server-stop' }
> { 'execute': 'x-colo-lost-heartbeat' }
>
> But When I execute x-colo-lost-heartbeat.Primary run Secondary cash
>
>  { 'execute': 'nbd-server-stop' }
> {"return": {}}
> qemu-system-x86_64: Disconnect client, due to: Unexpected end-of-file
> before all bytes were read
>  { 'execute': 'x-colo-lost-heartbeat' }
> {"return": {}}
> qemu-system-x86_64: Can't receive COLO message: Input/output error
> **
> ERROR:/build/qemu/src/qemu-2.11.1/qom/object.c:907:object_unref:
> assertion failed (obj->ref > 0): (0 > 0)
> [1]    2972 abort      sudo /usr/bin/qemu-system-x86_64 -boot c
> -enable-kvm -m 2048 -smp 2 -qmp stdi
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
>
> ** Tags: colo
>
> ** Description changed:
>
>   I use Arch Linux x86_64
> - both qemu 2.11.1 Zhang Chen's(https://github.com/
> zhangckid/qemu/commits/colo-with-virtio-net-internal-jul10)
> + both qemu 2.11.1 and Zhang Chen's(https://github.com/
> zhangckid/qemu/commits/colo-with-virtio-net-internal-jul10)
>   Following document 'COLO-FT.txt',
>   I test colo feature on my hosts
>
>   I run this command
>   Primary:
>   sudo qemu-system-x86_64 -boot c   -enable-kvm -m 2048 -smp 2  -qmp
> stdio  -name primary \
>   -device piix3-usb-uhci \
>   -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
>   -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
>   -drive if=3Dvirtio,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3D
> fifo,vote-threshold=3D1,children.0.file.filename=3D/var/
> lib/libvirt/images/1.raw,children.0.driver=3Draw -S
>
>   Secondary:
>   sudo qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qmp stdio
> -name secondary \
>   -device piix3-usb-uhci \
>   -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
>   -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
>   -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/
> images/2.raw,driver=3Draw,node-name=3Dnode0 \
>   -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecond=
ary,\
>   file.driver=3Dqcow2,top-id=3Dactive-disk0,\
>   file.file.filename=3D/mnt/ramfs/active_disk.img,\
>   file.backing.driver=3Dqcow2,\
>   file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
>   file.backing.backing=3Dcolo-disk0 \
>   -incoming tcp:0:8888
>
>   Secondary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'nbd-server-start',
> -   'arguments': {'addr': {'type': 'inet', 'data': {'host':
> '192.168.0.33', 'port': '8889'} } }
> +   'arguments': {'addr': {'type': 'inet', 'data': {'host':
> '192.168.0.33', 'port': '8889'} } }
>   }
>   {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0',
> 'writable': true } }
>
>   Primary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'human-monitor-command',
> -   'arguments': {'command-line': 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.
> host=3D192.168.0.33,file.port=3D8889,file.export=3Dcolo-disk0,
> node-name=3Dnbd_client0'}}
> +   'arguments': {'command-line': 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.
> host=3D192.168.0.33,file.port=3D8889,file.export=3Dcolo-disk0,
> node-name=3Dnbd_client0'}}
>   { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0',
> 'node': 'nbd_client0' } }
>   { 'execute': 'migrate-set-capabilities',
> -       'arguments': {'capabilities': [ {'capability': 'x-colo', 'state':
> true } ] } }
> +       'arguments': {'capabilities': [ {'capability': 'x-colo', 'state':
> true } ] } }
>   { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.33:8888' } =
}
>   { 'execute': 'migrate-set-parameters' , 'arguments':{
> 'x-checkpoint-delay': 2000 } }
>
>   Above are all OK.Two VM syncing.
>
>   Primary:
>   { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0',
> 'child': 'children.1'}}
>   { 'execute': 'human-monitor-command','arguments': {'command-line':
> 'drive_del blk-buddy0'}}
>
>   Secondary:
>   { 'execute': 'nbd-server-stop' }
>   { 'execute': 'x-colo-lost-heartbeat' }
>
>   But When I execute x-colo-lost-heartbeat.Primary run Secondary cash
>
> -
> -  { 'execute': 'nbd-server-stop' }
> +  { 'execute': 'nbd-server-stop' }
>   {"return": {}}
>   qemu-system-x86_64: Disconnect client, due to: Unexpected end-of-file
> before all bytes were read
> -  { 'execute': 'x-colo-lost-heartbeat' }
> +  { 'execute': 'x-colo-lost-heartbeat' }
>   {"return": {}}
>   qemu-system-x86_64: Can't receive COLO message: Input/output error
>   **
>   ERROR:/build/qemu/src/qemu-2.11.1/qom/object.c:907:object_unref:
> assertion failed (obj->ref > 0): (0 > 0)
>   [1]    2972 abort      sudo /usr/bin/qemu-system-x86_64 -boot c
> -enable-kvm -m 2048 -smp 2 -qmp stdi
>
> ** Tags added: colo
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1754542
>
> Title:
>   colo: secondary vm crash when execute x-colo-lost-heartbeat
>
> Status in QEMU:
>   New
>
> Bug description:
>   I use Arch Linux x86_64
>   both qemu 2.11.1 and Zhang Chen's(https://github.com/
> zhangckid/qemu/commits/colo-with-virtio-net-internal-jul10)
>   Following document 'COLO-FT.txt',
>   I test colo feature on my hosts
>
>   I run this command
>   Primary:
>   sudo qemu-system-x86_64 -boot c   -enable-kvm -m 2048 -smp 2  -qmp
> stdio  -name primary \
>   -device piix3-usb-uhci \
>   -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
>   -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
>   -drive if=3Dvirtio,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3D
> fifo,vote-threshold=3D1,children.0.file.filename=3D/var/
> lib/libvirt/images/1.raw,children.0.driver=3Draw -S
>
>   Secondary:
>   sudo qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qmp stdio
> -name secondary \
>   -device piix3-usb-uhci \
>   -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
>   -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
>   -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/
> images/2.raw,driver=3Draw,node-name=3Dnode0 \
>   -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecond=
ary,\
>   file.driver=3Dqcow2,top-id=3Dactive-disk0,\
>   file.file.filename=3D/mnt/ramfs/active_disk.img,\
>   file.backing.driver=3Dqcow2,\
>   file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
>   file.backing.backing=3Dcolo-disk0 \
>   -incoming tcp:0:8888
>
>   Secondary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'nbd-server-start',
>     'arguments': {'addr': {'type': 'inet', 'data': {'host':
> '192.168.0.33', 'port': '8889'} } }
>   }
>   {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0',
> 'writable': true } }
>
>   Primary:
>   {'execute':'qmp_capabilities'}
>   { 'execute': 'human-monitor-command',
>     'arguments': {'command-line': 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.
> host=3D192.168.0.34,file.port=3D8889,file.export=3Dcolo-disk0,
> node-name=3Dnbd_client0'}}
>   { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0',
> 'node': 'nbd_client0' } }
>   { 'execute': 'migrate-set-capabilities',
>         'arguments': {'capabilities': [ {'capability': 'x-colo', 'state':
> true } ] } }
>   { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } =
}
>   { 'execute': 'migrate-set-parameters' , 'arguments':{
> 'x-checkpoint-delay': 2000 } }
>
>   Above are all OK.Two VM syncing.
>
>   Primary:
>   { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0',
> 'child': 'children.1'}}
>   { 'execute': 'human-monitor-command','arguments': {'command-line':
> 'drive_del blk-buddy0'}}
>
>   Secondary:
>   { 'execute': 'nbd-server-stop' }
>   { 'execute': 'x-colo-lost-heartbeat' }
>
>   But When I execute x-colo-lost-heartbeat.Primary run Secondary cash
>
>    { 'execute': 'nbd-server-stop' }
>   {"return": {}}
>   qemu-system-x86_64: Disconnect client, due to: Unexpected end-of-file
> before all bytes were read
>    { 'execute': 'x-colo-lost-heartbeat' }
>   {"return": {}}
>   qemu-system-x86_64: Can't receive COLO message: Input/output error
>   **
>   ERROR:/build/qemu/src/qemu-2.11.1/qom/object.c:907:object_unref:
> assertion failed (obj->ref > 0): (0 > 0)
>   [1]    2972 abort      sudo /usr/bin/qemu-system-x86_64 -boot c
> -enable-kvm -m 2048 -smp 2 -qmp stdi
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions
>
>
