Received: from eggs.gnu.org ([2001:4830:134:3::10]:55291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePo01-00012W-OF
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePnzy-0007Ye-JS
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:17:53 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePnzy-0007YO-FO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:17:50 -0500
Received: by mail-qk0-x241.google.com with SMTP id r184so2205580qke.8
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 03:17:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171210172703.27866-1-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3a81346c-76ac-a283-4749-706a09f22afb@amsat.org>
Date: Fri, 15 Dec 2017 08:17:46 -0300
MIME-Version: 1.0
In-Reply-To: <20171210172703.27866-1-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] smbus: do not immediately complete commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 12/10/2017 02:27 PM, Hervé Poussineau wrote:
> PIIX4 errata says that "immediate polling of the Host Status Register BUSY
> bit may indicate that the SMBus is NOT busy."
> Due to this, some code does the following steps:
> (a) set parameters
> (b) start command
> (c) check for smbus busy bit set (to know that command started)
> (d) check for smbus busy bit not set (to know that command finished)
> 
> Let (c) happen, by immediately setting the busy bit, and really executing
> the command when status register has been read once.
> 
> This fixes a problem with AMIBIOS, which can now properly initialize the PIIX4.
> 
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>

This looks sane, so:

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/i2c/pm_smbus.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 6fc3923f56..ec060d58cc 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -63,6 +63,9 @@ static void smb_transaction(PMSMBus *s)
>      I2CBus *bus = s->smbus;
>      int ret;
>  
> +    assert(s->smb_stat & STS_HOST_BUSY);
> +    s->smb_stat &= ~STS_HOST_BUSY;
> +
>      SMBUS_DPRINTF("SMBus trans addr=0x%02x prot=0x%02x\n", addr, prot);
>      /* Transaction isn't exec if STS_DEV_ERR bit set */
>      if ((s->smb_stat & STS_DEV_ERR) != 0)  {
> @@ -135,6 +138,13 @@ error:
>  
>  }
>  
> +static void smb_transaction_start(PMSMBus *s)
> +{
> +    /* Do not execute immediately the command ; it will be
> +     * executed when guest will read SMB_STAT register */
> +    s->smb_stat |= STS_HOST_BUSY;
> +}
> +
>  static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>                                unsigned width)
>  {
> @@ -150,7 +160,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>      case SMBHSTCNT:
>          s->smb_ctl = val;
>          if (val & 0x40)
> -            smb_transaction(s);
> +            smb_transaction_start(s);
>          break;
>      case SMBHSTCMD:
>          s->smb_cmd = val;
> @@ -182,6 +192,10 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
>      switch(addr) {
>      case SMBHSTSTS:
>          val = s->smb_stat;
> +        if (s->smb_stat & STS_HOST_BUSY) {
> +            /* execute command now */
> +            smb_transaction(s);
> +        }
>          break;
>      case SMBHSTCNT:
>          s->smb_index = 0;
> 
