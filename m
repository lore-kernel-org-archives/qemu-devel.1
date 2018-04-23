Received: from eggs.gnu.org ([2001:4830:134:3::10]:48857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1fAWhR-0006ks-L0
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1fAWhP-0001DE-Kv
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:19:49 -0400
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Mon, 23 Apr 2018 16:19:45 +0800
Message-ID: <CAMxP3BQJPODXSrZiUAOaHBxu3Bj4DfJJczPCqWFQciz-rfbkDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [QEMU + SPDK] The demo in the official document is not
 working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>

Hi,

I was trying to run qemu with spdk, referring to http://www.spdk.io/doc/
vhost.html#vhost_qemu_config . Steps were strictly followed.

# Environment: latest CentOS 7 kernel, nvme ssd, spdk v18.01.x,
> dpdk 17.11.1, qemu 2.11.1



cd spdk
> sudo su
> ulimit -l unlimited
> HUGEMEM=2048 ./scripts/setup.sh
> ./app/vhost/vhost -S /var/tmp -s 1024 -m 0x1 &
> ./scripts/rpc.py construct_nvme_bdev -b Nvme0 -t pcie -a 0000:03:00.0
> ./scripts/rpc.py construct_malloc_bdev 128 4096 -b Malloc0
> ./scripts/rpc.py construct_vhost_scsi_controller --cpumask 0x1 vhost.0
> ./scripts/rpc.py add_vhost_scsi_lun vhost.0 0 Nvme0n1
> ./scripts/rpc.py add_vhost_scsi_lun vhost.0 1 Malloc0
>
> qemu-system-x86_64 -enable-kvm -cpu host -machine pc,accel=kvm -daemonize
> -vnc :1 \
> -smp 1 -m 1G -object
> memory-backend-file,id=mem0,size=1G,mem-path=/dev/hugepages,share=on -numa
> node,memdev=mem0 \
> -drive file=<guest-os-image.qcow2>,if=none,id=disk -device
> ide-hd,drive=disk,bootindex=0 \
> -chardev socket,id=spdk_vhost_scsi0,path=/var/tmp/vhost.0 \
> -device vhost-user-scsi-pci,id=scsi0,chardev=spdk_vhost_scsi0



Unfortunately the demo was not able to work, stopped at the boot-loader
screen saying that not bootable device. But if I removed the last two lines(
vhost-user-scsi-pci), the guest could start successfully. So there must be
something wrong with the spdk device.

Is there anyone in this community who happened to be familiar with spdk? Or
should I seek for help from Intel? Don't know who is responsible for
maintaining this document.


Thanks,
Bob
