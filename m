Received: from eggs.gnu.org ([2001:4830:134:3::10]:36001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f4MB0-0003OX-H5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 03:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f4MAx-0006Kp-CJ
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 03:52:50 -0400
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1522940844-12336-2-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ad080c45-9bbe-43e3-1482-b291dd249a75@redhat.com>
Date: Fri, 6 Apr 2018 09:52:35 +0200
MIME-Version: 1.0
In-Reply-To: <1522940844-12336-2-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] s390: Refactor IPL parameter block
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 05.04.2018 17:07, Viktor Mihajlovski wrote:
> Splitting out the the CCW device extraction allows reuse.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c | 81 ++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index fdeaec3..58e33c5 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -279,44 +279,52 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>      *timeout = cpu_to_be32(splash_time);
>  }
>  
> +static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
> +{
> +    CcwDevice *ccw_dev = NULL;
> +
> +    if (dev_st) {
> +        VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
> +            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
> +                                TYPE_VIRTIO_CCW_DEVICE);
> +        if (virtio_ccw_dev) {
> +            ccw_dev = CCW_DEVICE(virtio_ccw_dev);
> +        } else {
> +            SCSIDevice *sd = (SCSIDevice *)
> +                object_dynamic_cast(OBJECT(dev_st),
> +                                    TYPE_SCSI_DEVICE);
> +            if (sd) {
> +                SCSIBus *bus = scsi_bus_from_device(sd);
> +                VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
> +                VirtIOSCSICcw *scsi_ccw = container_of(vdev, VirtIOSCSICcw,
> +                                                       vdev);
> +
> +                ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
> +                                                           TYPE_CCW_DEVICE);
> +            }
> +        }
> +    }
> +    return ccw_dev;
> +}
> +
>  static bool s390_gen_initial_iplb(S390IPLState *ipl)
>  {
>      DeviceState *dev_st;
> +    CcwDevice *ccw_dev = NULL;
>  
>      dev_st = get_boot_device(0);
>      if (dev_st) {
> -        VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
> -            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
> -                TYPE_VIRTIO_CCW_DEVICE);
> +        ccw_dev = s390_get_ccw_device(dev_st);
> +    }
> +
> +    /*
> +     * Currently allow IPL only from CCW devices.
> +     */
> +    if (ccw_dev) {
>          SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
>                                                              TYPE_SCSI_DEVICE);

The SCSIDevice dynamic cast now has to be done twice ... but I guess
that's ok (we're only doing this for the boot device, so it this should
not be time-critical, right?).

Reviewed-by: Thomas Huth <thuth@redhat.com>
