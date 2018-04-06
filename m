Received: from eggs.gnu.org ([2001:4830:134:3::10]:60454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f4MsU-0006Ry-A0
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 04:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f4MsR-0006dz-5B
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 04:37:46 -0400
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1522940844-12336-3-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ddf921bf-95f1-b710-d122-cbe245fa35bd@redhat.com>
Date: Fri, 6 Apr 2018 10:37:33 +0200
MIME-Version: 1.0
In-Reply-To: <1522940844-12336-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390: Ensure IPL from SCSI works as
 expected
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
> Operating systems may request an IPL from a virtio-scsi device
> by specifying an IPL parameter type of CCW. In this case QEMU
> won't set up the IPLB correctly. The BIOS will still detect
> it's a SCSI device to boot from, but it will now have to search
> for the first LUN and attempt to boot from there.
> However this may not be the original boot LUN if there's more than
> one SCSI disk attached to the HBA.
> 
> With this change QEMU will detect that the request is for a
> SCSI device and will rebuild the initial IPL parameter info
> if it's the SCSI device used for the first boot. In consequence
> the BIOS can use the boot LUN from the IPL information block.
> 
> In case a different SCSI device has been set, the BIOS will find
> and use the first available LUN.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 58e33c5..fb554ab 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -427,7 +427,8 @@ unref_mr:
>      return img_size;
>  }
>  
> -static bool is_virtio_net_device(IplParameterBlock *iplb)
> +static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
> +                                         int virtio_id)
>  {
>      uint8_t cssid;
>      uint8_t ssid;
> @@ -447,13 +448,23 @@ static bool is_virtio_net_device(IplParameterBlock *iplb)
>              sch = css_find_subch(1, cssid, ssid, schid);
>  
>              if (sch && sch->devno == devno) {
> -                return sch->id.cu_model == VIRTIO_ID_NET;
> +                return sch->id.cu_model == virtio_id;
>              }
>          }
>      }
>      return false;
>  }
>  
> +static bool is_virtio_net_device(IplParameterBlock *iplb)
> +{
> +    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_NET);
> +}
> +
> +static bool is_virtio_scsi_device(IplParameterBlock *iplb)
> +{
> +    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
> +}

Not sure whether we need a separate wrapper function for this ... using
is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI) in place would be
fine, too, I think.

>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>  {
>      S390IPLState *ipl = get_ipl_device();
> @@ -478,6 +489,22 @@ void s390_reipl_request(void)
>      S390IPLState *ipl = get_ipl_device();
>  
>      ipl->reipl_requested = true;
> +    if (ipl->iplb_valid &&
> +        !ipl->netboot &&
> +        ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
> +        is_virtio_scsi_device(&ipl->iplb)) {
> +        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0));
> +
> +        if (ccw_dev &&
> +            cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
> +            (ccw_dev->sch->ssid & 3) == ipl->iplb.ccw.ssid) {
> +            /*
> +             * this is the original boot device's SCSI
> +             * so restore IPL parameter info from it
> +             */
> +            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
> +        }
> +    }
>      qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
