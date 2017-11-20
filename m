Received: from eggs.gnu.org ([2001:4830:134:3::10]:35893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eGiSv-0005B1-6r
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eGiSq-00034G-8o
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:34:09 -0500
References: <1510942228-22822-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <70a17598-7361-0470-5d44-7fb4727719e0@redhat.com>
Date: Mon, 20 Nov 2017 10:34:00 +0100
MIME-Version: 1.0
In-Reply-To: <1510942228-22822-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.11] pc-bios/s390-ccw:
 Fix problem with invalid virtio-scsi LUN when rebooting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org

On 17.11.2017 19:10, Thomas Huth wrote:
> When rebooting a guest that has a virtio-scsi disk, the s390-ccw
> bios sometimes bails out with an error message like this:
> 
> ! SCSI cannot report LUNs: STATUS=02 RSPN=70 KEY=05 CODE=25 QLFR=00, sure !
> 
> Enabling the scsi_req* tracing in QEMU shows that the ccw bios is
> trying to execute the REPORT LUNS SCSI command with a LUN != 0, and
> this causes the SCSI command to fail.
> Looks like we neither clear the BSS of the s390-ccw bios during reboot,
> nor do we explicitly set the default_scsi_device.lun value to 0, so
> this variable can contain random values from the OS after the reboot.
> By setting this variable explicitly to 0, the problem is fixed and
> the reboots always succeed.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1514352
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/virtio-scsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
> index c92f5d3..4fe4b9d 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -223,7 +223,8 @@ static void virtio_scsi_locate_device(VDev *vdev)
>  
>      for (target = 0; target <= vdev->config.scsi.max_target; target++) {
>          sdev->channel = channel;
> -        sdev->target = target; /* sdev->lun will be 0 here */
> +        sdev->target = target;
> +        sdev->lun = 0;          /* LUN has to be 0 for REPORT LUNS */
>          if (!scsi_report_luns(vdev, data, sizeof(data))) {
>              if (resp.response == VIRTIO_SCSI_S_BAD_TARGET) {
>                  continue;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
