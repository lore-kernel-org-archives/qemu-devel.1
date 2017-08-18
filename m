Received: from eggs.gnu.org ([2001:4830:134:3::10]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1diqAz-00019x-Ja
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1diqAw-0008JN-Gt
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:55:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1diqAw-0008DA-11
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:55:34 -0400
References: <1503049022-14749-1-git-send-email-hare@suse.de>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <09f093ef-a073-7374-0f40-330febc7c196@redhat.com>
Date: Sat, 19 Aug 2017 00:55:28 +0200
MIME-Version: 1.0
In-Reply-To: <1503049022-14749-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-bus: correct responses for INQUIRY
 and REQUEST SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.com>

Hello Hannes,

On 08/18/17 11:37, Hannes Reinecke wrote:
> According to SPC-3 INQUIRY and REQUEST SENSE should return GOOD
> even on unsupported LUNS.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  hw/scsi/scsi-bus.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index e364410a23..ade31c11f5 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -516,8 +516,10 @@ static size_t scsi_sense_len(SCSIRequest *req)
>  static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>  {
>      SCSITargetReq *r = DO_UPCAST(SCSITargetReq, req, req);
> +    int fixed_sense = (req->cmd.buf[1] & 1) == 0;
>  
> -    if (req->lun != 0) {
> +    if (req->lun != 0 &&
> +        buf[0] != INQUIRY && buf[0] != REQUEST_SENSE) {
>          scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
>          scsi_req_complete(req, CHECK_CONDITION);
>          return 0;
> @@ -535,9 +537,28 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>          break;
>      case REQUEST_SENSE:
>          scsi_target_alloc_buf(&r->req, scsi_sense_len(req));
> -        r->len = scsi_device_get_sense(r->req.dev, r->buf,
> -                                       MIN(req->cmd.xfer, r->buf_len),
> -                                       (req->cmd.buf[1] & 1) == 0);
> +        if (req->lun != 0) {
> +            const struct SCSISense sense = SENSE_CODE(LUN_NOT_SUPPORTED);
> +
> +            if (fixed_sense) {
> +                r->buf[0] = 0x70;
> +                r->buf[2] = sense.key;
> +                r->buf[10] = 10;
> +                r->buf[12] = sense.asc;
> +                r->buf[13] = sense.ascq;
> +                r->len = MIN(req->cmd.xfer, SCSI_SENSE_LEN);
> +            } else {
> +                r->buf[0] = 0x72;
> +                r->buf[1] = sense.key;
> +                r->buf[2] = sense.asc;
> +                r->buf[3] = sense.ascq;
> +                r->len = 8;
> +            }
> +        } else {
> +            r->len = scsi_device_get_sense(r->req.dev, r->buf,
> +                                           MIN(req->cmd.xfer, r->buf_len),
> +                                           fixed_sense);
> +        }
>          if (r->req.dev->sense_is_ua) {
>              scsi_device_unit_attention_reported(req->dev);
>              r->req.dev->sense_len = 0;
> 

thank you for the quick patch.

I've repeated my original testing steps now, in the following scenarios:

                             edk2:ba40cb31b69d  ovmf:ce13d2d8c81f
qemu:v2.10.0-rc3             [1]                [2]
qemu:v2.10.0-rc3+this patch  [3]                [4]

(Edk2 commit ba40cb31b69d was edk2 master just before I pushed my
respective edk2 patches, and edk2 commit ce13d2d8c81f is current edk2
master, with my respective patches.)

[1] FAIL: as reported originally
[2] PASS: my edk2 patches fix ScsiBusDxe (which is justified in itself),
          and then it deals with QEMU post-ded6ddc5a7b9
[3] PASS: this patch of yours makes the reported symptoms vanish even
          without applying my patches to edk2
[4] PASS: your patch works fine with the current (fixed) ScsiBusDxe as
          well, no regressions found.

Tested-by: Laszlo Ersek <lersek@redhat.com>

If you agree, I'd suggest two additional tags for the commit message:

Reported-by: Laszlo Ersek <lersek@redhat.com>
Fixes: ded6ddc5a7b95217557fa360913d1213e12d4a6d

Thanks!
Laszlo
