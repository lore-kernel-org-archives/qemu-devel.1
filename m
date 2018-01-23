Received: from eggs.gnu.org ([2001:4830:134:3::10]:57187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ee3SJ-0003dO-AI
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ee3SG-00030i-6H
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:37:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58158
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ee3SG-00030Z-1V
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:37:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIYqd7033155
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:37:55 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fp8bt60mb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:37:54 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:37:53 -0700
References: <20180123175409.9349-1-joserz@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 16:37:46 -0200
MIME-Version: 1.0
In-Reply-To: <20180123175409.9349-1-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <b6e5beda-f5d9-7fb3-b814-0e5be86879df@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] kvm-all: Partially reverts 4fe6d78b2e
 to remove the cleanup call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com
Cc: ghammer@redhat.com, anton@samba.org


On 01/23/2018 03:54 PM, Jose Ricardo Ziviani wrote:
> This commit partially reverts the commit 4fe6d78b2e because of issues
> reported in the virtio.
>
> Examples:
>
> $ qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G \
>    -M pseries,accel=kvm -netdev type=user,id=net0 \
>    -device virtio-net-pci,netdev=net0 -drive file=../disk.qcow2,if=virtio
>
> Populating /vdevice/nvram@71000001
> Populating /vdevice/v-scsi@71000002
>         SCSI: Looking for devices
>            8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> Populating /pci@800000020000000
>                       00 0000 (D) : 1af4 1000    virtio [ net ]
> Aborted
>
> $ qemu-system-x86_64 -m 4G -enable-kvm -drive file=util.qcow2,if=virtio
>
> Running QEMU with GTK 2.x is deprecated, and will be removed
> in a future release. Please switch to GTK 3.x instead
> [1]    5282 abort
>
> Reference http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---

This patch also fixed a migration problem I was investigating today. 
Turns out 4fe6d78b2e
is also to be blamed for this P8 -> P8 migration being broken in current 
master:


$ sudo ./qemu-system-ppc64 --enable-kvm --nographic -vga none -machine 
pseries -m 4G,slots=32,maxmem=32G -smp 1,maxcpus=32 -device 
virtio-blk-pci,drive=rootdisk -drive 
file=/home/danielhb/vm_imgs/f26.qcow2,if=none,cache=none,format=qcow2,id=rootdisk 
-incoming tcp:0:4444
qemu-system-ppc64: load of migration failed: Input/output error


Reverting 4fe6d78b2e or applying this patch fixes this migration issue too.


Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


>   accel/kvm/kvm-all.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 071f4f57c0..f290f487a5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
>       if (r < 0) {
>           abort();
>       }
> -
> -    if (e->cleanup) {
> -        e->cleanup(e);
> -    }
>   }
>
>   static void kvm_io_ioeventfd_add(MemoryListener *listener,
