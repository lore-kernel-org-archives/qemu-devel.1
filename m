Received: from eggs.gnu.org ([2001:4830:134:3::10]:36506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1edxmq-0007RV-Oz
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1edxmm-0002RQ-Qu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:34:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1edxmm-0002R4-Hq
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:34:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NCYarG068605
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 07:34:43 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp53cg7ed-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 07:34:38 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 05:34:17 -0700
Date: Tue, 23 Jan 2018 10:34:04 -0200
From: joserz@linux.vnet.ibm.com
References: <20180123030528.GA5780@pacoca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180123030528.GA5780@pacoca>
Message-Id: <20180123123404.GA3765@pacoca.br.ibm.com>
Subject: Re: [Qemu-devel] virtio block device is not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ghammer@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org

On Tue, Jan 23, 2018 at 01:05:28AM -0200, joserz@linux.vnet.ibm.com wrote:
> Hello people!
> 
> I'm not able to boot any guest that sets a virtio block device like:
> (branch master)
> 
> [PPC64]
> qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G -M pseries,accel=kvm,kvm-type=PR -drive file=disk.qcow2,if=virtio

my bad, actually the command line is:

qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G -M pseries,accel=kvm -netdev type=user,id=net0 -device virtio-net-pci,netdev=net0 -drive file=../disk.qcow2,if=virtio

and the problem seem to be in virtio-net-pci, not in the block device


> QEMU Starting
>  Build Date = Dec 18 2017 13:08:00
>  FW Version = git-fa981320a1e0968d
>  Press "s" to enter Open Firmware.
> 
> Populating /vdevice methods
> Populating /vdevice/vty@71000000
> Populating /vdevice/nvram@71000001
> Populating /vdevice/v-scsi@71000002
>        SCSI: Looking for devices
>           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> Populating /pci@800000020000000
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
> Aborted
> 
> [x86]
> 
> qemu-system-x86_64 -m 4G -enable-kvm -drive file=util.qcow2,if=virtio
> Running QEMU with GTK 2.x is deprecated, and will be removed
> in a future release. Please switch to GTK 3.x instead
> [1]    5282 abort
> 
> [Cause]
> 
> The commit 4fe6d78b2e introduces the
> 
> ...
> kvm_mem_ioeventfd_del(...) {
>     ...
>     r = kvm_set_ioeventfd_mmio(fd, ...
>     if (r < 0) {
>         abort();
>     }
> 
> +    if (e->cleanup) {
> +        e->cleanup(e);
> +    }
> }
> 
> For some reason, not yet clear to me, cleanup() calls the same
> kvm_mem_ioeventfd_del again and again until kvm_set_ioeventfd_mmio
> returns < 0 and abort().
> 
> I was going to send a patch to revert that 'if ()' but I think it could
> cause a regression. What do you guys think?
> 
> Thanks,
> 
> Jose Ricardo Ziviani
> 
> 
