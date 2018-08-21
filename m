Received: from eggs.gnu.org ([2001:4830:134:3::10]:52314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs07y-0001yE-Ra
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs07u-0007i2-Od
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:26:54 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:44358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs07u-0007hl-K2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:26:50 -0400
Received: by mail-vk0-x243.google.com with SMTP id 125-v6so7703416vke.11
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 23:26:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
	<1534796770-10295-8-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <60d8fd78-479a-5ee9-3612-5c24e9d56fc5@amsat.org>
Date: Tue, 21 Aug 2018 03:26:44 -0300
MIME-Version: 1.0
In-Reply-To: <1534796770-10295-8-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/10] Don't delay host status register
 busy bit when interrupts are enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 08/20/2018 05:26 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Change 880b1ffe6ec2f0ae "smbus: do not immediately complete commands"
> changed pm_smbus to delay setting the host busy bit until the status
> register was read, to work around a bug in AMIBIOS.  Unfortunately,
> when interrupts are enabled, the status register will never get read
> and the processing will never happen.
> 
> Modify the code to only delay setting the host busy bit if interrupts
> are not enabled.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Hervé Poussineau <hpoussin@reactos.org>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/i2c/pm_smbus.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 664a6b1..10ba208 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -80,9 +80,6 @@ static void smb_transaction(PMSMBus *s)
>      I2CBus *bus = s->smbus;
>      int ret;
>  
> -    assert(s->smb_stat & STS_HOST_BUSY);
> -    s->smb_stat &= ~STS_HOST_BUSY;
> -
>      SMBUS_DPRINTF("SMBus trans addr=0x%02x prot=0x%02x\n", addr, prot);
>      /* Transaction isn't exec if STS_DEV_ERR bit set */
>      if ((s->smb_stat & STS_DEV_ERR) != 0)  {
> @@ -209,9 +206,18 @@ error:
>  
>  static void smb_transaction_start(PMSMBus *s)
>  {
> -    /* Do not execute immediately the command ; it will be
> -     * executed when guest will read SMB_STAT register */
> -    s->smb_stat |= STS_HOST_BUSY;
> +    if (s->smb_ctl & CTL_INTREN) {
> +        smb_transaction(s);
> +    } else {
> +        /* Do not execute immediately the command; it will be
> +         * executed when guest will read SMB_STAT register.  This
> +         * is to work around a bug in AMIBIOS (that is working
> +         * around another bug in some specific hardware) where
> +         * it waits for STS_HOST_BUSY to be set before waiting
> +         * checking for status.  If STS_HOST_BUSY doesn't get
> +         * set, it gets stuck. */
> +        s->smb_stat |= STS_HOST_BUSY;
> +    }
>  }
>  
>  static bool
> @@ -330,6 +336,7 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
>          val = s->smb_stat;
>          if (s->smb_stat & STS_HOST_BUSY) {
>              /* execute command now */
> +            s->smb_stat &= ~STS_HOST_BUSY;
>              smb_transaction(s);
>          }
>          break;
> 
