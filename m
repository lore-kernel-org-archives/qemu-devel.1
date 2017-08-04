Received: from eggs.gnu.org ([2001:4830:134:3::10]:45607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddaAM-0001Cp-LH
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dda9I-0007oX-Is
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:49:14 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dda9I-0007nO-AM
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:48:08 -0400
Received: by mail-wr0-f177.google.com with SMTP id y43so15314513wrd.3
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 03:48:08 -0700 (PDT)
References: <1501835795-92331-1-git-send-email-hare@suse.de>
	<1501835795-92331-5-git-send-email-hare@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f049ca6c-aa7e-e10b-91c0-208f12d61263@redhat.com>
Date: Fri, 4 Aug 2017 12:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <1501835795-92331-5-git-send-email-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 4/4] scsi: Add 'enclosure' option for
 scsi devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@suse.com>, qemu-devel@nongnu.org

On 04/08/2017 10:36, Hannes Reinecke wrote:
> Make enclosure support optional with the 'enclosure' argument to
> the scsi device.
> Adding 'enclosure=on' as option to the SCSI device will present
> an enclosure service device on LUN0, either as a stand-alone
> LUN (in case LUN0 is not assigned) or by setting the EncServ bit
> int the inquiry data if LUN0 is assigned to a block devices.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  hw/scsi/scsi-bus.c     | 11 ++++++++---
>  hw/scsi/scsi-disk.c    |  4 +++-
>  include/hw/scsi/scsi.h |  1 +
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 79a222f..c11422b 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -22,6 +22,7 @@ static Property scsi_props[] = {
>      DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
>      DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
>      DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
> +    DEFINE_PROP_BOOL("enclosure", SCSIDevice, enclosure, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -494,11 +495,14 @@ static bool scsi_target_emulate_inquiry(SCSITargetReq *r)
>      if (r->req.lun != 0) {
>          r->buf[0] = TYPE_NO_LUN;
>      } else {
> -        r->buf[0] = TYPE_ENCLOSURE;
> +        r->buf[0] = r->req.dev->enclosure ?
> +            TYPE_ENCLOSURE : TYPE_NOT_PRESENT | TYPE_INACTIVE;
>          r->buf[2] = 5; /* Version */
>          r->buf[3] = 2 | 0x10; /* HiSup, response data format */
>          r->buf[4] = r->len - 5; /* Additional Length = (Len - 1) - 4 */
> -        r->buf[6] = 0x40; /* Enclosure service */
> +        if (r->req.dev->enclosure) {
> +            r->buf[6] = 0x40; /* Enclosure service */
> +        }
>          r->buf[7] = 0x10 | (r->req.bus->info->tcq ? 0x02 : 0); /* Sync, TCQ.  */
>          memcpy(&r->buf[8], "QEMU    ", 8);
>          memcpy(&r->buf[16], "QEMU TARGET     ", 16);
> @@ -600,7 +604,8 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>          }
>          break;
>      case RECEIVE_DIAGNOSTIC:
> -        if (!scsi_target_emulate_receive_diagnostic(r)) {
> +        if (!r->req.dev->enclosure ||
> +            !scsi_target_emulate_receive_diagnostic(r)) {
>              goto illegal_request;
>          }
>          break;
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5f1e5e8..153d97d 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -792,7 +792,9 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>                 the additional length is not adjusted */
>          outbuf[4] = 36 - 5;
>      }
> -
> +    if (s->qdev.lun == 0 && s->qdev.enclosure) {
> +            outbuf[6] = 0x40; /* Enclosure service */
> +    }

Should this really be set on disks even if you do have a LUN0?

Why don't you instead add a very simple scsi-enclosure device that you
can specify as the LUN0?

Thanks,

Paolo

>      /* Sync data transfer and TCQ.  */
>      outbuf[7] = 0x10 | (req->bus->info->tcq ? 0x02 : 0);
>      return buflen;
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index 6b85786..243c185 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -100,6 +100,7 @@ struct SCSIDevice
>      BlockConf conf;
>      SCSISense unit_attention;
>      bool sense_is_ua;
> +    bool enclosure;
>      uint8_t sense[SCSI_SENSE_BUF_SIZE];
>      uint32_t sense_len;
>      QTAILQ_HEAD(, SCSIRequest) requests;
> 
