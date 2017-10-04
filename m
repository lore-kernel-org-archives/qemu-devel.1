Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dzmrt-0000XQ-FV
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dzmrq-0008Eu-D0
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:49:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dzmrq-0008CR-46
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:49:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 135A9C2D0D30
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 16:49:52 +0000 (UTC)
Date: Wed, 4 Oct 2017 17:49:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171004164943.GB2195@work-vm>
References: <20171004114008.14849-1-berrange@redhat.com>
	<20171004114008.14849-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004114008.14849-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] scsi-disk: support reporting of
 rotation rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> The Linux kernel will query the SCSI "Block device characteristics"
> VPD to determine the rotations per minute of the disk. If this has
> the value 1, it is taken to be an SSD and so Linux sets the
> 'rotational' flag to 0 for the I/O queue and will stop using that
> disk as a source of random entropy. Other operating systems may
> also take into account rotation rate when setting up default
> behaviour.
> 
> Mgmt apps should be able to set the rotation rate for virtualized
> block devices, based on characteristics of the host storage in use,
> so that the guest OS gets sensible behaviour out of the box. This
> patch thus adds a 'rotation-rate' parameter for 'scsi-hd' and
> 'scsi-block' device types. For the latter, this parameter will be
> ignored unless the host device has TYPE_DISK.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 6e841fb5ff..a518080e7d 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -104,6 +104,14 @@ typedef struct SCSIDiskState
>      char *product;
>      bool tray_open;
>      bool tray_locked;
> +    /*
> +     * 0x0000        - rotation rate not reported
> +     * 0x0001        - non-rotating medium (SSD)
> +     * 0x0002-0x0400 - reserved
> +     * 0x0401-0xffe  - rotations per minute
> +     * 0xffff        - reserved
> +     */
> +    uint16_t rotation_rate;
>  } SCSIDiskState;
>  
>  static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed);
> @@ -605,6 +613,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>              outbuf[buflen++] = 0x83; // device identification
>              if (s->qdev.type == TYPE_DISK) {
>                  outbuf[buflen++] = 0xb0; // block limits
> +                outbuf[buflen++] = 0xb1; /* block device characteristics */
>                  outbuf[buflen++] = 0xb2; // thin provisioning
>              }
>              break;
> @@ -747,6 +756,15 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>              outbuf[43] = max_io_sectors & 0xff;
>              break;
>          }
> +        case 0xb1: /* block device characteristics */
> +        {
> +            buflen = 8;
> +            outbuf[4] = (s->rotation_rate >> 8) & 0xff;
> +            outbuf[5] = s->rotation_rate & 0xff;
> +            outbuf[6] = 0;
> +            outbuf[7] = 0;
> +            break;
> +        }
>          case 0xb2: /* thin provisioning */
>          {
>              buflen = 8;
> @@ -2911,6 +2929,7 @@ static Property scsi_hd_properties[] = {
>                         DEFAULT_MAX_UNMAP_SIZE),
>      DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
>                         DEFAULT_MAX_IO_SIZE),
> +    DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
>      DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -2982,6 +3001,7 @@ static const TypeInfo scsi_cd_info = {
>  static Property scsi_block_properties[] = {
>      DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
>      DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
> +    DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };

Are you sure you want this as a property of SCSIDiskState etc rather
than a property on the underlying drive?
Then if virtio devices etc wanted to pick this up later they could
without needing extra parameters.

Dave

>  
> -- 
> 2.13.5
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
