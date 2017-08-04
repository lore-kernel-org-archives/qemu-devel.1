Received: from eggs.gnu.org ([2001:4830:134:3::10]:49099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddaCP-0002uL-6a
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddaAP-0000Zg-9E
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:51:21 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddaAO-0000Xw-SZ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:49:17 -0400
Received: by mail-wr0-f171.google.com with SMTP id y43so15324458wrd.3
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 03:49:16 -0700 (PDT)
References: <1501835795-92331-1-git-send-email-hare@suse.de>
	<1501835795-92331-4-git-send-email-hare@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cecc5581-7013-f870-dbd7-da28ac80d2a4@redhat.com>
Date: Fri, 4 Aug 2017 12:49:12 +0200
MIME-Version: 1.0
In-Reply-To: <1501835795-92331-4-git-send-email-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 3/4] scsi: clarify sense codes for LUN0
 emulation
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
> The LUN0 emulation is just that, an emulation for a non-existing
> LUN0. So we should be returning LUN_NOT_SUPPORTED for any request
> coming from any other LUN.
> And we should be aborting unhandled commands with INVALID OPCODE,
> not LUN NOT SUPPORTED.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  hw/scsi/scsi-bus.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 8419c75..79a222f 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -583,6 +583,11 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>  {
>      SCSITargetReq *r = DO_UPCAST(SCSITargetReq, req, req);
>  
> +    if (req->lun != 0) {
> +        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
> +        scsi_req_complete(req, CHECK_CONDITION);
> +        return 0;
> +    }
>      switch (buf[0]) {
>      case REPORT_LUNS:
>          if (!scsi_target_emulate_report_luns(r)) {
> @@ -613,7 +618,7 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>      case TEST_UNIT_READY:
>          break;
>      default:
> -        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
> +        scsi_req_build_sense(req, SENSE_CODE(INVALID_OPCODE));
>          scsi_req_complete(req, CHECK_CONDITION);
>          return 0;
>      illegal_request:
> 

I am queuing this one since it's an independent bugfix.

Paolo
