Received: from eggs.gnu.org ([2001:4830:134:3::10]:35875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1fAYZ5-0002i9-Jg
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1fAYZ1-0005Dw-DU
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:19:19 -0400
MIME-Version: 1.0
In-Reply-To: <CAMxP3BQJPODXSrZiUAOaHBxu3Bj4DfJJczPCqWFQciz-rfbkDQ@mail.gmail.com>
References: <CAMxP3BQJPODXSrZiUAOaHBxu3Bj4DfJJczPCqWFQciz-rfbkDQ@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Mon, 23 Apr 2018 18:19:13 +0800
Message-ID: <CAMxP3BTKv0gmpPvdmDvjd_Jd6QSXXFi9-Qyhv0JkTuHaSrsz6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [QEMU + SPDK] The demo in the official document is
 not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>

Problem solved. Got a reply from Intel just now.


---------- Forwarded message ----------
From: Liu, Changpeng <changpeng.liu@intel.com>
Date: 2018-04-23 18:06 GMT+08:00
Subject: [Qemu-devel] [QEMU + SPDK] The demo in the official document is
not working
To: "a175818323@gmail.com" <a175818323@gmail.com>


Hi Bob,

The issues was introduced by the following commit:
commit fb20fbb764 "vhost: avoid to start/stop virtqueue which is not ready".


When you starting with seabios, the virtio-scsi driver in seabios will only
enumerate 1 I/O queue,
but didn't include task management and event queue,  while SPDK vhost
target must get all the 3 queues
when starting, so this process will be blocked at seabios.

One workaround for now, you can start with the chardev, after booting to
OS, you can use -device_add to add the
virtio-scsi controller. We are developing the right fix, ethier in seabios
or SPDK, this will be fixed very soon.


Best Regards,
Changpeng Liu


2018-04-23 16:19 GMT+08:00 Bob Chen <a175818323@gmail.com>:

> Hi,
>
> I was trying to run qemu with spdk, referring to
> http://www.spdk.io/doc/vhost.html#vhost_qemu_config . Steps were strictly
> followed.
>
> # Environment: latest CentOS 7 kernel, nvme ssd, spdk v18.01.x,
>> dpdk 17.11.1, qemu 2.11.1
>
>
>
> cd spdk
>> sudo su
>> ulimit -l unlimited
>> HUGEMEM=2048 ./scripts/setup.sh
>> ./app/vhost/vhost -S /var/tmp -s 1024 -m 0x1 &
>> ./scripts/rpc.py construct_nvme_bdev -b Nvme0 -t pcie -a 0000:03:00.0
>> ./scripts/rpc.py construct_malloc_bdev 128 4096 -b Malloc0
>> ./scripts/rpc.py construct_vhost_scsi_controller --cpumask 0x1 vhost.0
>> ./scripts/rpc.py add_vhost_scsi_lun vhost.0 0 Nvme0n1
>> ./scripts/rpc.py add_vhost_scsi_lun vhost.0 1 Malloc0
>>
>> qemu-system-x86_64 -enable-kvm -cpu host -machine pc,accel=kvm -daemonize
>> -vnc :1 \
>> -smp 1 -m 1G -object memory-backend-file,id=mem0,size=1G,mem-path=/dev/hugepages,share=on
>> -numa node,memdev=mem0 \
>> -drive file=<guest-os-image.qcow2>,if=none,id=disk -device
>> ide-hd,drive=disk,bootindex=0 \
>> -chardev socket,id=spdk_vhost_scsi0,path=/var/tmp/vhost.0 \
>> -device vhost-user-scsi-pci,id=scsi0,chardev=spdk_vhost_scsi0
>
>
>
> Unfortunately the demo was not able to work, stopped at the boot-loader
> screen saying that not bootable device. But if I removed the last two lines(
> vhost-user-scsi-pci), the guest could start successfully. So there must
> be something wrong with the spdk device.
>
> Is there anyone in this community who happened to be familiar with spdk?
> Or should I seek for help from Intel? Don't know who is responsible for
> maintaining this document.
>
>
> Thanks,
> Bob
>
