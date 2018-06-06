Received: from eggs.gnu.org ([2001:4830:134:3::10]:44994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQeIm-0006VZ-Ey
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQeIh-0001fj-HZ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:41:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180606190955.20845-1-jsnow@redhat.com>
	<20180606190955.20845-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ff7fd70-7cf3-a555-bb55-8df7f4eeac3b@amsat.org>
Date: Wed, 6 Jun 2018 16:40:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180606190955.20845-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] libqos/ahci: track sector size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 06/06/2018 04:09 PM, John Snow wrote:
> It's not always 512, and it does wind up mattering for PIO tranfers,
> because this means DRQ blocks are four times as big for ATAPI.
> Replace an instance of 2048 with the correct define, too.
> 
> This patch by itself winds changing no behavior. fis->count is ignored
> for CMD_PACKET, and sect_count only gets used in non-ATAPI cases.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/libqos/ahci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
> index bc201d762b..63e1f9b92d 100644
> --- a/tests/libqos/ahci.c
> +++ b/tests/libqos/ahci.c
> @@ -90,6 +90,7 @@ struct AHCICommand {
>      uint32_t interrupts;
>      uint64_t xbytes;
>      uint32_t prd_size;
> +    uint32_t sector_size;
>      uint64_t buffer;
>      AHCICommandProp *props;
>      /* Data to be transferred to the guest */
> @@ -796,7 +797,7 @@ static void command_header_init(AHCICommand *cmd)
>  static void command_table_init(AHCICommand *cmd)
>  {
>      RegH2DFIS *fis = &(cmd->fis);
> -    uint16_t sect_count = (cmd->xbytes / AHCI_SECTOR_SIZE);
> +    uint16_t sect_count = (cmd->xbytes / cmd->sector_size);
>  
>      fis->fis_type = REG_H2D_FIS;
>      fis->flags = REG_H2D_FIS_CMD; /* "Command" bit */
> @@ -819,7 +820,7 @@ static void command_table_init(AHCICommand *cmd)
>          if (cmd->props->lba28 || cmd->props->lba48) {
>              fis->device = ATA_DEVICE_LBA;
>          }
> -        fis->count = (cmd->xbytes / AHCI_SECTOR_SIZE);
> +        fis->count = (cmd->xbytes / cmd->sector_size);
>      }
>      fis->icc = 0x00;
>      fis->control = 0x00;
> @@ -857,6 +858,7 @@ AHCICommand *ahci_command_create(uint8_t command_name)
>      cmd->xbytes = props->size;
>      cmd->prd_size = 4096;
>      cmd->buffer = 0xabad1dea;
> +    cmd->sector_size = props->atapi ? ATAPI_SECTOR_SIZE : AHCI_SECTOR_SIZE;
>  
>      if (!cmd->props->ncq) {
>          cmd->interrupts = AHCI_PX_IS_DHRS;
> @@ -1033,7 +1035,7 @@ void ahci_command_set_buffer(AHCICommand *cmd, uint64_t buffer)
>  static void ahci_atapi_set_size(AHCICommand *cmd, uint64_t xbytes)
>  {
>      unsigned char *cbd = cmd->atapi_cmd;
> -    uint64_t nsectors = xbytes / 2048;
> +    uint64_t nsectors = xbytes / ATAPI_SECTOR_SIZE;
>      uint32_t tmp;
>      g_assert(cbd);
>  
> @@ -1080,7 +1082,7 @@ void ahci_command_set_sizes(AHCICommand *cmd, uint64_t xbytes,
>          cmd->prd_size = prd_size;
>      }
>      cmd->xbytes = xbytes;
> -    sect_count = (cmd->xbytes / AHCI_SECTOR_SIZE);
> +    sect_count = (cmd->xbytes / cmd->sector_size);
>  
>      if (cmd->props->ncq) {
>          NCQFIS *nfis = (NCQFIS *)&(cmd->fis);
> 
