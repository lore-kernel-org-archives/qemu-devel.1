Received: from eggs.gnu.org ([209.51.188.92]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goSWs-0007CC-Vx
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goSWn-0006ng-Br
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:30:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goSWm-0006l3-V5
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:30:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so17557232wmd.2
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 04:30:06 -0800 (PST)
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-2-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e68fc72f-2973-ee85-d346-8e392360dab2@redhat.com>
Date: Tue, 29 Jan 2019 13:30:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190125174653.4604-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] scsi-disk: Don't use empty string as
 device id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, libvir-list@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On 1/25/19 6:46 PM, Kevin Wolf wrote:
> scsi-disk includes in the Device Identification VPD page, depending on
> configuration amongst others, a vendor specific designator that consists
> either of the serial number if given or the BlockBackend name (which is
> a host detail that better shouldn't have been leaked to the guest, but
> now we have to maintain it for compatibility).
> 
> With anonymous BlockBackends, i.e. scsi-disk devices constructed with
> drive=<node-name>, and no serial number explicitly specified, this ends
> up as an empty string. If this happens to more than one disk, we have
> accidentally signalled to the OS that this is a multipath setup, which
> is obviously not what was intended.
> 
> Instead of using an empty string for the vendor specific designator,
> simply leave out that designator, which makes Linux detect such setups
> as separate disks again.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/scsi/scsi-disk.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 0e9027c8f3..93eef40b87 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -652,12 +652,14 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
>          DPRINTF("Inquiry EVPD[Device identification] "
>                  "buffer size %zd\n", req->cmd.xfer);
>  
> -        outbuf[buflen++] = 0x2; /* ASCII */
> -        outbuf[buflen++] = 0;   /* not officially assigned */
> -        outbuf[buflen++] = 0;   /* reserved */
> -        outbuf[buflen++] = id_len; /* length of data following */
> -        memcpy(outbuf + buflen, str, id_len);
> -        buflen += id_len;
> +        if (id_len) {
> +            outbuf[buflen++] = 0x2; /* ASCII */
> +            outbuf[buflen++] = 0;   /* not officially assigned */
> +            outbuf[buflen++] = 0;   /* reserved */
> +            outbuf[buflen++] = id_len; /* length of data following */
> +            memcpy(outbuf + buflen, str, id_len);
> +            buflen += id_len;
> +        }
>  
>          if (s->qdev.wwn) {
>              outbuf[buflen++] = 0x1; /* Binary */
> 
