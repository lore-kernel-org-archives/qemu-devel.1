Received: from eggs.gnu.org ([2001:4830:134:3::10]:44242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Is-0000GE-75
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72Ir-0003zh-Ah
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:11:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506124314.23354-1-aurelien@aurel32.net>
	<20170506124314.23354-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <699890c4-e750-b742-a5fa-9de07848a990@amsat.org>
Date: Sat, 6 May 2017 13:11:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170506124314.23354-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] scsi-disk: export rotational qdev
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 05/06/2017 09:43 AM, Aurelien Jarno wrote:
> Export the rotational qdev property to the block device characteristics
> VPD page.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/scsi/scsi-disk.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index a53f058621..21b7e21a23 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -597,6 +597,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>              outbuf[buflen++] = 0x83; // device identification
>              if (s->qdev.type == TYPE_DISK) {
>                  outbuf[buflen++] = 0xb0; // block limits
> +                outbuf[buflen++] = 0xb1; /* block device characteristics */
>                  outbuf[buflen++] = 0xb2; // thin provisioning
>              }
>              break;
> @@ -739,6 +740,19 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>              outbuf[43] = max_io_sectors & 0xff;
>              break;
>          }
> +        case 0xb1: /* block device characteristics */
> +        {
> +            buflen = 0x40;
> +            memset(outbuf + 4, 0, buflen - 4);
> +
> +            /* medium rotation rate: 0 = not reported, 1 = non-rotating */
> +            outbuf[4] = 0;
> +            outbuf[5] = s->qdev.conf.rotational ? 0 : 1;
> +
> +            /* nominal form factor */
> +            outbuf[7] = 0; /* not reported */
> +            break;
> +        }
>          case 0xb2: /* thin provisioning */
>          {
>              buflen = 8;
>
