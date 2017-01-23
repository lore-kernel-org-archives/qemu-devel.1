Received: from eggs.gnu.org ([2001:4830:134:3::10]:33431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVare-0008Oo-OF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVard-0006Z1-FQ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:24:38 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cVard-0006Yh-A8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:24:37 -0500
Received: by mail-it0-x242.google.com with SMTP id o138so9524504ito.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 01:24:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE519-kc6j8jZCq2o5SrxP1a8W9H3P3YB+P_c2vQox0rH+eckQ@mail.gmail.com>
References: <CAE519-k8poR3Qi99rg__9hYWS2ACw8a=3S+cx4s1xJW6QDFSjA@mail.gmail.com>
	<20170112141417.GB14042@stefanha-x1.localdomain>
	<CAE519-k2TdnntRLKK=2p2tOg2Nxrd+kfwyuUJBWXa2QBnMKh0A@mail.gmail.com>
	<CAJSP0QXrVtqkwxnokqf=d+RLx0yT55iuLcxs1ovuJc6bZCsbiw@mail.gmail.com>
	<CAE519-kab+PFnq98eO=G+M4dXZsPNQcBHzB=JLMXGJAKNiqZoA@mail.gmail.com>
	<CAJSP0QWG_qBnAMHZ86bVJmPkL=Sxh3WJWs6ZdBaLcrTZihojXw@mail.gmail.com>
	<CAE519-=U4YwENeuJHPfRLGuECZMdkUb9NV0BHXw5nCpXCmb41g@mail.gmail.com>
	<CAJSP0QW7t+nqDN6Gg5wZjJq=OWhaJhd_HX6PZ3K+ZwZ=Xi911w@mail.gmail.com>
	<CAE519-=qJqkshtHgGNZ1sQ6prJHfaLrikE+B7vNpZ5WESBZBXg@mail.gmail.com>
	<CAJSP0QWf6yNQ0BVjdXcSPT+wv3aQoefC5GUdcbGW+5iShXB8xA@mail.gmail.com>
	<CAE519-kc6j8jZCq2o5SrxP1a8W9H3P3YB+P_c2vQox0rH+eckQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 23 Jan 2017 09:24:34 +0000
Message-ID: <CAJSP0QV71O7nGMJUR0pCTKoRc7NnkRszsdiZN+0MGShkns3E6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Question about io mode & cache mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: morgenlette madeBy <sgh8183@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Mon, Jan 23, 2017 at 8:59 AM, morgenlette madeBy <sgh8183@gmail.com> wrote:

Please keep qemu-devel@nongnu.org CCed so the discussion stays on the
mailing list where others can follow it.

> I am sorry to bother you.
>
> so, Where is the part that I have to check additionally?

Failing syscalls can be debugged using kernel function graph tracing:
https://www.kernel.org/doc/Documentation/trace/ftrace.txt

It shows you the code path executed by the kernel.  You can
cross-reference the kernel source to see why an error return path is
being taken.

There are other approaches, like adding printks to the kernel.

Before you embark on any of this, it might be a good idea to write a
tiny test program that opens the file exactly the same way you are
doing it in QEMU.  See if it fails in the same way.

Stefan

> On Mon, Jan 23, 2017 at 5:31 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Mon, Jan 23, 2017 at 7:43 AM, morgenlette madeBy <sgh8183@gmail.com>
>> wrote:
>> > I am using Centos 7.
>> >
>> > So I set up SELinux=disabled...
>> >
>> > /dev/mydev is operated by root and its permission is 0777.
>> >
>> > 6 S root      3221     1 14  80   0 - 409221 poll_s 16:40 ?
>> > 00:00:14
>> > /usr/libexec/qemu-kvm -name centos6.5-1 -S -machine
>> > pc-i440fx-rhel7.0.0,accel=kvm,usb=off -cpu
>> > SandyBridge,+vme,+f16c,+rdrand,+fsgsbase,+smep,+erms -m 1024 -realtime
>> > mlock=off -smp 1,sockets=1,cores=1,threads=1 -uuid
>> > c1878d8a-0902-42f1-9c20-509302412f45 -no-user-config -nodefaults
>> > -chardev
>> >
>> > socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-1-centos6.5-1/monitor.sock,server,nowait
>> > -mon chardev=charmonitor,id=monitor,mode=control -rtc
>> > base=utc,driftfix=slew
>> > -global kvm-pit.lost_tick_policy=discard -no-hpet -no-shutdown -global
>> > PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 -boot strict=on
>> > -device
>> > ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x6.0x7 -device
>> >
>> > ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x6
>> > -device
>> > ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x6.0x1
>> > -device
>> > ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x6.0x2
>> > -device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5 -drive
>> >
>> > file=/var/lib/libvirt/images/centos6.5-1.qcow2,format=qcow2,if=none,id=drive-virtio-disk0
>> > -device
>> >
>> > virtio-blk-pci,scsi=off,bus=pci.0,addr=0x7,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
>> > -drive if=none,id=drive-ide0-0-0,readonly=on -device
>> > ide-cd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0 -netdev
>> > tap,fd=26,id=hostnet0,vhost=on,vhostfd=28 -device
>> >
>> > virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:f2:d9:fa,bus=pci.0,addr=0x3
>> > -chardev pty,id=charserial0 -device
>> > isa-serial,chardev=charserial0,id=serial0 -chardev
>> >
>> > socket,id=charchannel0,path=/var/lib/libvirt/qemu/channel/target/domain-1-centos6.5-1/org.qemu.guest_agent.0,server,nowait
>> > -device
>> >
>> > virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=org.qemu.guest_agent.0
>> > -chardev spicevmc,id=charchannel1,name=vdagent -device
>> >
>> > virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel1,id=channel1,name=com.redhat.spice.0
>> > -device usb-tablet,id=input0,bus=usb.0,port=1 -spice
>> >
>> > port=5900,addr=127.0.0.1,disable-ticketing,image-compression=off,seamless-migration=on
>> > -vga qxl -global qxl-vga.ram_size=67108864 -global
>> > qxl-vga.vram_size=67108864 -global qxl-vga.vgamem_mb=16 -device
>> > intel-hda,id=sound0,bus=pci.0,addr=0x4 -device
>> > hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 -chardev
>> > spicevmc,id=charredir0,name=usbredir -device
>> > usb-redir,chardev=charredir0,id=redir0,bus=usb.0,port=2 -chardev
>> > spicevmc,id=charredir1,name=usbredir -device
>> > usb-redir,chardev=charredir1,id=redir1,bus=usb.0,port=3 -device
>> > virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x8 -msg timestamp=on
>> >
>> > QEMU file is also operated by root.
>> >
>> > I can't understand what is problem...
>> >
>> > In qemu, is open function disabled???
>>
>> No, it is not.
>>
>> Stefan
>
>
