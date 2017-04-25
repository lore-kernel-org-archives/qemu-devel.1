Received: from eggs.gnu.org ([2001:4830:134:3::10]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d352h-0001bm-SI
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d352d-0006A9-KU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:18:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57022
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d352d-00069u-DV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:18:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PI8k9s012989
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 14:18:22 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1v5175g6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 14:18:22 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 25 Apr 2017 12:18:21 -0600
References: <1493126327-13162-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Apr 2017 20:18:15 +0200
MIME-Version: 1.0
In-Reply-To: <1493126327-13162-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <2c3464b1-268b-f8a1-9935-cbd77c8ffc2a@de.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

On 04/25/2017 03:18 PM, Thomas Huth wrote:
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

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

applied thanks.

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
> 
