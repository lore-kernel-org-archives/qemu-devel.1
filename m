Received: from eggs.gnu.org ([2001:4830:134:3::10]:36898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cvOx0-0007vT-Li
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cvOwx-0005QR-K0
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:56:50 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cvOwx-0005Pb-De
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:56:47 -0400
Received: by mail-vk0-f49.google.com with SMTP id r69so175845033vke.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 06:56:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403191158.GI3539@stefanha-x1.localdomain>
References: <58DEB834.6060405@windriver.com>
	<20170403191158.GI3539@stefanha-x1.localdomain>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 4 Apr 2017 15:56:44 +0200
Message-ID: <CABdb737NXTBJGvk+nuyFTccK_-g=N=PHO+ZRd1qSZcTgai=feQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] hitting intermittent issue with live migration
 from qemu-kvm-ev 2.3.0 to qemu-kvm-ev 2.6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Chris Friesen <chris.friesen@windriver.com>, qemu-devel <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Apr 3, 2017 at 9:11 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Mar 31, 2017 at 02:12:36PM -0600, Chris Friesen wrote:
>> I'm running into an issue with live-migrating a guest from a host runnin=
g
>> qemu-kvm-ev 2.3.0-31 to a host running qemu-kvm-ev 2.6.0-27.1.  This is =
a
>> libvirt-tunnelled migration, in the context of upgrading an OpenStack
>> install to newer software.  The source host is running CentOS 7.2.1511,
>> while the dest host is running CentOS 7.3.1611.
>>
>> I'll include the qemu commandlines for the source/dest at the bottom.
>>
>> Initially we have a bunch of guests running on compute-2 (which is runni=
ng
>> qemu-kvm-ev 2.3.0).  We then started live-migrating them one at a time t=
o
>> compute-0 (which is running qemu-kvm-ev 2.6.0).  Three of them migrated
>> successfully.  The fourth (which was essentially identical in configurat=
ion
>> to the first three) failed, as per the following logs in
>> /var/log/libvirt/qemu/instance-0000000e.log:
>>
>>
>> 2017-03-29T06:38:37.886940Z qemu-kvm: VQ 2 size 0x80 < last_avail_idx 0x=
47b
>> - used_idx 0x47c
>> 2017-03-29T06:38:37.886974Z qemu-kvm: error while loading state for inst=
ance
>> 0x0 of device '0000:00:07.0/virtio-balloon'
>> 2017-03-29T06:38:37.888684Z qemu-kvm: load of migration failed: Operatio=
n
>> not permitted
>> 2017-03-29 06:38:37.896+0000: shutting down
>>
>>
>> Does anyone know of an existing bug report covering this issue?  (I took=
 a
>> look and didn't see anything obviously related.)
>
> This is the virtio-balloon device.  If you remove the device the live
> migration should work reliably.
>
> Alternatively, you can temporarily rmmod virtio_balloon inside the guest
> for live migration.  After migration you can modprobe virtio_balloon
> again.
>
> last_avail_idx 0x47b with used_idx 0x47c is an invalid device state.
> I've diffed qemu-kvm-ev 2.6.0-27.1 hw/virtio/virtio-balloon.c against
> qemu.git/master and do not see an obvious bug.  I also compared
> qemu-kvm-ev 2.3.0-31 with qemu-kvm-ev 2.6.0-27.1.

The device likely got into the invalid state as part of a previous
migration to an unfixed QEMU. I second Stefan's suggestion to
temporarily remove the device or unload the driver.

Thanks!
Ladi

>>
>>
>> The qemu commandline on the source compute node is:
>>
>>
>> /usr/libexec/qemu-kvm -c 0x00000000000000000000000000000001 -n 4
>> --proc-type=3Dsecondary --file-prefix=3Dvs -- -enable-dpdk -name
>> instance-0000000e -S -machine pc-i440fx-rhel7.2.0,accel=3Dkvm,usb=3Doff =
-m 512
>> -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -object m=
emory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=3D/mnt/huge-2048k=
B/libvirt/qemu,share=3Dyes,size=3D536870912,host-nodes=3D1,policy=3Dbind
>> -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0 -uuid
>> 57ae849f-aa66-422a-90a2-62db6c59db29 -smbios type=3D1,manufacturer=3DFed=
ora
>> Project,product=3DOpenStack Nova,version=3D13.0.0-0.tis.4,serial=3D4c812=
1f1-d927-424e-8712-88b1de45be37,uuid=3D57ae849f-aa66-422a-90a2-62db6c59db29=
,family=3DVirtual
>> Machine -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,pat=
h=3D/var/lib/libvirt/qemu/domain-instance-0000000e/monitor.sock,server,nowa=
it
>> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,d=
riftfix=3Dslew
>> -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot
>> reboot-timeout=3D5000,strict=3Don -device
>> piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/dev/di=
sk/by-path/ip-192.168.205.6:3260-iscsi-iqn.2010-10.org.openstack:volume-ac5=
7fcaa-7ecd-4d3b-8671-3bc740337a42-lun-0,if=3Dnone,id=3Ddrive-virtio-disk0,f=
ormat=3Draw,serial=3Dac57fcaa-7ecd-4d3b-8671-3bc740337a42,cache=3Dnone,aio=
=3Dnative
>> -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-v=
irtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
>> -chardev socket,id=3Dcharnet0,path=3D/var/run/vswitch/usvhost-9e574d3c-3=
2dd-4d39-97e6-447b15fb00b4
>> -netdev type=3Dvhost-user,id=3Dhostnet0,chardev=3Dcharnet0 -device virti=
o-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:b0:59:a9,bus=3Dpci.0,a=
ddr=3D0x3
>> -chardev socket,id=3Dcharnet1,path=3D/var/run/vswitch/usvhost-7bc48d91-f=
215-4394-99ff-eb7f20d9ff1e
>> -netdev type=3Dvhost-user,id=3Dhostnet1,chardev=3Dcharnet1 -device virti=
o-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3Dfa:16:3e:8b:6f:09,bus=3Dpci.0,a=
ddr=3D0x4
>> -chardev socket,id=3Dcharnet2,path=3D/var/run/vswitch/usvhost-c32e2d0d-9=
ed4-4f4b-abc9-539a12a86008
>> -netdev type=3Dvhost-user,id=3Dhostnet2,chardev=3Dcharnet2 -device virti=
o-net-pci,netdev=3Dhostnet2,id=3Dnet2,mac=3Dfa:16:3e:07:ca:a0,bus=3Dpci.0,a=
ddr=3D0x5
>> -chardev file,id=3Dcharserial0,path=3D/etc/nova/instances/57ae849f-aa66-=
422a-90a2-62db6c59db29/console.log
>> -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
>> pty,id=3Dcharserial1 -device isa-serial,chardev=3Dcharserial1,id=3Dseria=
l1 -device
>> usb-tablet,id=3Dinput0 -vnc 0.0.0.0:11 -k en-us -device
>> cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -incoming fd:25 -device
>> virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -msg timestamp=
=3Don
>>
>>
>>
>> The complete instance-0000000e.log file on the destination is:
>>
>> 2017-03-29 06:38:35.962+0000: starting up libvirt version: 2.0.0, packag=
e:
>> 10.el7_3.2.tis.24 (Unknown, 2017-03-15-14:59:22,
>> yow-dsulliva-lx-vm1.wrs.com), qemu version: 2.6.0
>> (qemu-kvm-ev-2.6.0-27.1.el7.tis.31), hostname: compute-0
>> LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
>> QEMU_AUDIO_DRV=3Dnone /usr/libexec/qemu-kvm '-c
>> 0x00000000000000000000000000000001' '-n 4' --proc-type=3Dsecondary
>> --file-prefix=3Dvs -- -enable-dpdk -name
>> guest=3Dinstance-0000000e,debug-threads=3Don -S -object secret,id=3Dmast=
erKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-10-instance-0000000=
e/master-key.aes
>> -machine pc-i440fx-rhel7.2.0,accel=3Dkvm,usb=3Doff -m 512 -realtime mloc=
k=3Doff
>> -smp 1,sockets=3D1,cores=3D1,threads=3D1 -object memory-backend-file,id=
=3Dram-node0,prealloc=3Dyes,mem-path=3D/mnt/huge-2048kB/libvirt/qemu,share=
=3Dyes,size=3D536870912,host-nodes=3D0,policy=3Dbind
>> -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0 -uuid
>> 57ae849f-aa66-422a-90a2-62db6c59db29 -smbios 'type=3D1,manufacturer=3DFe=
dora
>> Project,product=3DOpenStack Nova,version=3D13.0.0-0.tis.4,serial=3D4c812=
1f1-d927-424e-8712-88b1de45be37,uuid=3D57ae849f-aa66-422a-90a2-62db6c59db29=
,family=3DVirtual
>> Machine' -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,pa=
th=3D/var/lib/libvirt/qemu/domain-10-instance-0000000e/monitor.sock,server,=
nowait
>> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,d=
riftfix=3Dslew
>> -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot
>> reboot-timeout=3D5000,strict=3Don -device
>> piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/dev/di=
sk/by-path/ip-192.168.205.6:3260-iscsi-iqn.2010-10.org.openstack:volume-ac5=
7fcaa-7ecd-4d3b-8671-3bc740337a42-lun-0,format=3Draw,if=3Dnone,id=3Ddrive-v=
irtio-disk0,serial=3Dac57fcaa-7ecd-4d3b-8671-3bc740337a42,cache=3Dnone,aio=
=3Dnative
>> -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-v=
irtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
>> -chardev socket,id=3Dcharnet0,path=3D/var/run/vswitch/usvhost-9e574d3c-3=
2dd-4d39-97e6-447b15fb00b4
>> -netdev type=3Dvhost-user,id=3Dhostnet0,chardev=3Dcharnet0 -device virti=
o-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:b0:59:a9,bus=3Dpci.0,a=
ddr=3D0x3
>> -chardev socket,id=3Dcharnet1,path=3D/var/run/vswitch/usvhost-7bc48d91-f=
215-4394-99ff-eb7f20d9ff1e
>> -netdev type=3Dvhost-user,id=3Dhostnet1,chardev=3Dcharnet1 -device virti=
o-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3Dfa:16:3e:8b:6f:09,bus=3Dpci.0,a=
ddr=3D0x4
>> -chardev socket,id=3Dcharnet2,path=3D/var/run/vswitch/usvhost-c32e2d0d-9=
ed4-4f4b-abc9-539a12a86008
>> -netdev type=3Dvhost-user,id=3Dhostnet2,chardev=3Dcharnet2 -device virti=
o-net-pci,netdev=3Dhostnet2,id=3Dnet2,mac=3Dfa:16:3e:07:ca:a0,bus=3Dpci.0,a=
ddr=3D0x5
>> -add-fd set=3D0,fd=3D51 -chardev file,id=3Dcharserial0,path=3D/dev/fdset=
/0,append=3Don
>> -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
>> pty,id=3Dcharserial1 -device isa-serial,chardev=3Dcharserial1,id=3Dseria=
l1 -device
>> usb-tablet,id=3Dinput0 -vnc 0.0.0.0:9 -k en-us -device
>> cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -incoming defer -device
>> virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -msg timestamp=
=3Don
>> Domain id=3D10 is tainted: high-privileges
>> EAL:eal_memory.c:1591: WARNING: Address Space Layout Randomization (ASLR=
) is
>> enabled in the kernel.
>> EAL:eal_memory.c:1593:    This may cause issues with mapping memory into
>> secondary processes
>> char device redirected to /dev/pts/9 (label charserial1)
>> 2017-03-29T06:38:37.886940Z qemu-kvm: VQ 2 size 0x80 < last_avail_idx 0x=
47b
>> - used_idx 0x47c
>> 2017-03-29T06:38:37.886974Z qemu-kvm: error while loading state for inst=
ance
>> 0x0 of device '0000:00:07.0/virtio-balloon'
>> 2017-03-29T06:38:37.888684Z qemu-kvm: load of migration failed: Operatio=
n
>> not permitted
>> 2017-03-29 06:38:37.896+0000: shutting down
>>
>>
>> For what it's worth, the differences between the two qemu command lines =
are
>> as follows:
>>
>> source:
>> -name instance-0000000e -chardev file,id=3Dcharserial0,path=3D/etc/nova/=
instances/57ae849f-aa66-422a-90a2-62db6c59db29/console.log
>> -vnc 0.0.0.0:9 -incoming fd:25
>>
>> destination:
>> -name guest=3Dinstance-0000000e,debug-threads=3Don -object secret,id=3Dm=
asterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-10-instance-0000=
000e/master-key.aes
>> -add-fd set=3D0,fd=3D51 -chardev file,id=3Dcharserial0,path=3D/dev/fdset=
/0,append=3Don
>> -vnc 0.0.0.0:11 -incoming defer
>>
>> Thanks,
>> Chris
>>
