Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3KHW-0003zU-8l
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3KHT-0007IF-4H
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:34:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d3KHS-0007H3-SI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:34:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QAXog6112903
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:34:41 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebubwfv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:34:41 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 26 Apr 2017 11:34:39 +0100
Date: Wed, 26 Apr 2017 12:34:27 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1493126327-13162-1-git-send-email-thuth@redhat.com>
References: <1493126327-13162-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170426123427.48528f3c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix crash with
 virtio-scsi-pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, 25 Apr 2017 15:18:47 +0200
Thomas Huth <thuth@redhat.com> wrote:

> qemu-system-s390x currently crashes when it is started with a
> virtio-scsi-pci device, e.g.:
> 
>  qemu-system-s390x -nographic -enable-kvm -device virtio-scsi-pci \
>                    -drive file=/tmp/disk.dat,if=none,id=d1,format=raw \
>                    -device scsi-cd,drive=d1,bootindex=1
> 
> The problem is that the code in s390_gen_initial_iplb() currently assumes
> that all SCSI devices are also CCW devices, which is not the case for
> virtio-scsi-pci of course. Fix it by adding an appropriate check for
> TYPE_CCW_DEVICE here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 7978c7d..f674d50 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -248,7 +248,13 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>              SCSIBus *bus = scsi_bus_from_device(sd);
>              VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
>              VirtIOSCSICcw *scsi_ccw = container_of(vdev, VirtIOSCSICcw, vdev);
> -            CcwDevice *ccw_dev = CCW_DEVICE(scsi_ccw);
> +            CcwDevice *ccw_dev;
> +
> +            ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
> +                                                       TYPE_CCW_DEVICE);
> +            if (!ccw_dev) {       /* It might be a PCI device instead */
> +                return false;
> +            }
> 
>              ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>              ipl->iplb.blk0_len =

This patch made me look at what we do if we have a non-ccw virtio-net
device for ipl. We'll set ->netboot (which implies that we load the
netboot fw later), but leave the iplb as invalid (so setting the start
address in the iplb won't have any effect as we ignore an invalid iplb
later on). The s390-ccw bios cannot deal with non-ccw boot devices
anyway.

In the end, it's just a bit odd, but no harm is done.
