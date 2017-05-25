Received: from eggs.gnu.org ([2001:4830:134:3::10]:54415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bruno.alvisio@gmail.com>) id 1dDxkD-0003BJ-7G
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bruno.alvisio@gmail.com>) id 1dDxkB-0000nm-GF
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:44:21 -0400
MIME-Version: 1.0
In-Reply-To: <539d9960-d554-032f-3e88-b2531743a0a1@redhat.com>
References: <CADNMjEBdXZeOonsKNf9LpFKK0NFUzAth=CDaSj8q22k+o=ZEFA@mail.gmail.com>
	<539d9960-d554-032f-3e88-b2531743a0a1@redhat.com>
From: Bruno Alvisio <bruno.alvisio@gmail.com>
Date: Thu, 25 May 2017 11:44:17 -0700
Message-ID: <CADNMjECLPFyZp1Rm_M4KuSqnY1cp7k0T38=zmWidYvinrutFPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Behavior of QMP "query-block"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

Hello John,

Thanks. Yes, typo when I wrote the e-mail.

It might be possible that XEN does that (I will ask in the XEN forum).
However, I have noticed that it is not the case for all of the VMs I have
launched. In some of them I can query the block devices even after a long
time the VM has been running.

I was wondering if the device is removed in case the disk is corrupted or
something. When I mention it runs normally, I can log into ithe VM and
perform read/write operations such creating files.

Also, is there an easy way to log all qemu events so that I can see what
might be going on with the 'ide' device?

Thanks,

Bruno

On Thu, May 25, 2017 at 11:18 AM, John Snow <jsnow@redhat.com> wrote:

>
>
> On 05/25/2017 12:27 AM, Bruno Alvisio wrote:
> > Hello all,
> >
> > Summary
> >
> > I am using XEN hypervisor to run a HVM with a QEMU backed disk. After I
> > start the HVM I use QMP "query-block" command to see the devices of the
> VM.
> > Initially the command returns the disk that I set as part of the
> > configuration. After a few seconds the a DEVICE_DELETE event occurs (for
> > device nic0) and after that the "query-block" command returns an empty
> > result.
> >
> > QEMU Version: 4.6.5
>
> I assume this is the KVM version.
>
> > Arch: x86-64
> > QMP : 2.2.1
>
> And I assume this is the QEMU version.
>
> >
> > Note:
> > 1. I was not performing any activity on the VM when the event occurs.
> > 2. After the event, the QEMU process is still alive and the VM runs
> > normally.
> > 3. This behavior is consistently reproduced.
> >
> >
> > Any help on how can I debug this issue would be greatly appreciated .
> >
> > Thanks,
> >
> > Bruno
> >
>
> I'm not very familiar with XEN, I do know that it likes to add more
> devices than it needs and then deletes them before starting the VM
> proper. The VM actually still runs normally despite the fact that query
> block returns no information? ...
>
> CCing qemu-block.
>
> --js
>
> >
> >
> > DETAILED LOGS
> >
> > I am using XEN hypervisor to run a HVM with QEMU backed disk. When I
> start
> > the HVM I see the following QEMU process started:
> >
> > root      2199     1  0 18:57 ?        00:00:02
> > /usr/local/lib/xen/bin/qemu-system-i386
> > -xen-domid 3 -chardev socket,id=libxl-cmd,path=/var/
> > run/xen/qmp-libxl-3,server,nowait -no-shutdown -mon
> > chardev=libxl-cmd,mode=control -chardev socket,id=libxenstat-cmd,path=
> > /var/run/xen/qmp-libxenstat-3,server,nowait -mon
> > chardev=libxenstat-cmd,mode=control -nodefaults -no-user-config -name
> > debianL2 -vnc :0,to=99 -display none -serial pty -device
> > cirrus-vga,vgamem_mb=8 -boot order=d -device
> > rtl8139,id=nic0,netdev=net0,mac=00:16:3e:1b:d0:7e
> > -netdev type=tap,id=net0,ifname=vif3.0-emu,script=no,downscript=no
> -machine
> > xenfv -m 1016 -drive file=/home/balvisio/debian-
> > disk.img,if=ide,index=0,media=disk,format=raw,cache=writeback -drive
> > if=ide,index=2,readonly=on,media=cdrom,id=ide-5632,file=/
> > home/balvisio/debian-live-8.7.1-amd64-gnome-desktop.iso,format=raw
> >
> > After launching the VM, I connected to the QMP socket:
> >
> > # rlwrap -C qmp socat STDIO UNIX:/var/run/xen/qmp-libxl-2
> >
> > {"QMP": {"version": {"qemu": {"micro": 1, "minor": 2, "major": 2},
> > "package": ""}, "capabilities": []}}
> >
> > {"execute":"qmp_capabilities"}
> >
> > {"return": {}}
> >
> > I issue the "query-block" command and I get:
> >
> > {"execute":"query-block"}
> >
> > {"return": [{"io-status": "ok", "device": "ide0-hd0", "locked": false,
> > "removable": false, "inserted": {"iops_rd": 0, "detect_zeroes": "off",
> > "image": {"virtual-size": 10737418240, "filename":
> > "/home/balvisio/debian-disk.img", "format": "raw", "actual-size":
> > 4940075008, "dirty-flag": false}, "iops_wr": 0, "ro": false,
> > "backing_file_depth": 0, "drv": "raw", "iops": 0, "bps_wr": 0,
> "encrypted":
> > false, "bps": 0, "bps_rd": 0, "file": "/home/balvisio/debian-disk.img",
> > "encryption_key_missing": false}, "type": "unknown"}]}
> >
> >
> >
> > After a few seconds, the following event happens asynchronoausly:
> >
> > {"timestamp": {"seconds": 1495590969, "microseconds": 898981}, "event":
> > "DEVICE_DELETED", "data": {"device": "nic0", "path":
> > "/machine/peripheral/nic0"}}
> >
> > After that event, I perform a "query-block" command again but now the
> block
> > device is gone:
> >
> > {"execute":"query-block"}
> >
> > {"return": []}
> >
> >
> > Xen Config File Used
> >
> > kernel="/usr/local/lib/xen/boot/hvmloader"
> >
> > builder='hvm'
> >
> > memory=1024
> >
> > vcpus=1
> >
> > name="debianL2"
> >
> > vfb = ['type=vnc']
> >
> > vif= ['bridge=xenbr0']
> >
> > boot='b'
> >
> > disk=['file:/home/balvisio/debian-disk.img,xvda,w']
> >
> > acpi=1
> >
> > device_model_version='qemu-xen'
> >
> > serial='pty'
> >
> > vnc=1
> >
> > vnclisten=""
> >
> > vncpasswd=""
> >
>
