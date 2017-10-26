Received: from eggs.gnu.org ([2001:4830:134:3::10]:39057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1e7ZFP-0006HN-FG
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 23:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1e7ZFO-00066k-6W
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 23:54:23 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:51119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1e7ZFO-00065V-1W
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 23:54:22 -0400
Received: by mail-qt0-x233.google.com with SMTP id d9so2711279qtd.7
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 20:54:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z31T6nHcO4P6GWW8GK_o0VB66HivPc-m1LZRh_x6nY_6g@mail.gmail.com>
References: <CAOE=1Z31T6nHcO4P6GWW8GK_o0VB66HivPc-m1LZRh_x6nY_6g@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Thu, 26 Oct 2017 11:54:20 +0800
Message-ID: <CAOE=1Z2fEjHHAeAi2DA8kpP7Bc_iy0eY_KTDFFk01=0_Y+1jww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu start VM in huge page without '-mem-prealloc'
 will get memory leak?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

BTW, I start VM by this command, and then stop it, then memory leak happens.

To compare, I start another VM, and wait for about 10 minutes, and then
kill it as I does above, then no memory leak happens.

So is this a bug of KVM or qemu ?

2017-10-26 11:09 GMT+08:00 Sam <batmanustc@gmail.com>:

> For qemu-2.6.0, in huge page (1G) environment, after kill the qemu
> process, memory which is alloc for the vm could not be released. Detail is
> bellow.
> Or should I use some specific command to stop vm? I want to know if there
> someone has the same problem?
>
> The start up command is:
>
> CMD1="$QEMU_CMD -D qemu.log -trace events=qemu-events-all -enable-kvm -cpu
> qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,+
> pat,+ss,+pclmulqdq,+xsave,level=13 -machine pc,accel=kvm -chardev
> socket,id=hmqmondev,port=55908,host=127.0.0.1,nodelay,server,nowait -mon
> chardev=hmqmondev,id=hmqmon,mode=readline -rtc
> base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
> -nodefaults -nodefconfig -no-kvm-pit-reinjection -global
> kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 8 -name
> gangyewei-qemutime-1 -m 40960 -boot order=cdn -vnc :8,password -drive
> file=$DISK_0,if=none,id=drive_0,format=qcow2,cache=none,aio=native
> -device virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5
> -drive file=$DISK_1,if=none,id=drive_1,format=qcow2,cache=none,aio=native
> -device virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6
> -drive file=$DISK_2,if=none,id=drive_2,format=qcow2,cache=none,aio=native
> -device virtio-blk-pci,id=dev_drive_2,drive=drive_2,bus=pci.0,addr=0x7
> -device ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
> id=ide0-cd0,media=cdrom,if=none -chardev socket,id=char-n-52b49b80,path
> =/usr/local/var/run/openvswitch/n-52b49b80,server -netdev
> type=vhost-user,id=n-52b49b80,chardev=char-n-52b49b80,vhostforce=on
> -device virtio-net-pci,netdev=n-52b49b80,mac=00:22:52:b4:9b:80,id=
> netdev-n-52b49b80,addr=0xf$(nic_speed 10000) -object
> memory-backend-file,id=mem,size=40960M,mem-path=/mnt/huge,share=on -numa
> node,memdev=mem -pidfile $PID_FILE -chardev socket,path=/opt/cloud/workspa
> ce/servers/4511f52a-f450-40d3-9417-a1e0a27ed507/qga.sock,server,nowait,id=qga0
> -device virtio-serial -device virtserialport,chardev=qga0,na
> me=org.qemu.guest_agent.0"
>
> The stop script is just kill this process.
>
> the result of `cat /proc/meminfo` show memory is still there.
>
