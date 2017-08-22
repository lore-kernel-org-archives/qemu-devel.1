Received: from eggs.gnu.org ([2001:4830:134:3::10]:56945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9OC-0003n2-CI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9OB-0001k8-BH
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:38:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13c0147f-b87d-88f8-1a77-3b026b487190@amsat.org>
Date: Tue, 22 Aug 2017 10:38:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170822131832.20191-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] scsi: rename scsi_convert_sense
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

On 08/22/2017 10:18 AM, Paolo Bonzini wrote:
> After introducing the scsi/ subdirectory, there will be a scsi_build_sense
> function that is the same as scsi_req_build_sense but without needing
> a SCSIRequest.  The existing scsi_build_sense function gets in the way,
> remove it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/scsi/scsi-bus.c     | 10 +++++-----
>   hw/scsi/scsi-disk.c    |  4 ++--
>   include/hw/scsi/scsi.h |  4 ++--
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index e364410a23..890f8fcc83 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -769,7 +769,7 @@ int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len)
>           return 0;
>       }
>   
> -    ret = scsi_build_sense(req->sense, req->sense_len, buf, len, true);
> +    ret = scsi_convert_sense(req->sense, req->sense_len, buf, len, true);
>   
>       /*
>        * FIXME: clearing unit attention conditions upon autosense should be done
> @@ -790,7 +790,7 @@ int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len)
>   
>   int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed)
>   {
> -    return scsi_build_sense(dev->sense, dev->sense_len, buf, len, fixed);
> +    return scsi_convert_sense(dev->sense, dev->sense_len, buf, len, fixed);
>   }
>   
>   void scsi_req_build_sense(SCSIRequest *req, SCSISense sense)
> @@ -1510,12 +1510,12 @@ const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
>   };
>   
>   /*
> - * scsi_build_sense
> + * scsi_convert_sense
>    *
>    * Convert between fixed and descriptor sense buffers
>    */
> -int scsi_build_sense(uint8_t *in_buf, int in_len,
> -                     uint8_t *buf, int len, bool fixed)
> +int scsi_convert_sense(uint8_t *in_buf, int in_len,
> +                       uint8_t *buf, int len, bool fixed)
>   {
>       bool fixed_in;
>       SCSISense sense;
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5f1e5e8070..0a1f4ef0c7 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1978,8 +1978,8 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
>           break;
>       case REQUEST_SENSE:
>           /* Just return "NO SENSE".  */
> -        buflen = scsi_build_sense(NULL, 0, outbuf, r->buflen,
> -                                  (req->cmd.buf[1] & 1) == 0);
> +        buflen = scsi_convert_sense(NULL, 0, outbuf, r->buflen,
> +                                    (req->cmd.buf[1] & 1) == 0);
>           if (buflen < 0) {
>               goto illegal_request;
>           }
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index 6b85786dbf..6ef67fb504 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -244,8 +244,8 @@ extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
>   uint32_t scsi_data_cdb_xfer(uint8_t *buf);
>   uint32_t scsi_cdb_xfer(uint8_t *buf);
>   int scsi_cdb_length(uint8_t *buf);
> -int scsi_build_sense(uint8_t *in_buf, int in_len,
> -                     uint8_t *buf, int len, bool fixed);
> +int scsi_convert_sense(uint8_t *in_buf, int in_len,
> +                       uint8_t *buf, int len, bool fixed);
>   
>   SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
>                               uint32_t tag, uint32_t lun, void *hba_private);
> 
