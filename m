Received: from eggs.gnu.org ([2001:4830:134:3::10]:51147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSnIR-00049n-SL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSnIK-0002s7-2l
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:13:47 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSnIJ-0002ru-To
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:13:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id 40so5934943oth.4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 10:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-6-minyard@acm.org>
In-Reply-To: <20181126200435.23408-6-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 18:13:28 +0000
Message-ID: <CAFEAcA8NC2hODB45v7apNvjsEQ=GavBDnJR=bV+djdd8QjH34w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/16] i2c: Simplify and correct the
 SMBus state machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On Mon, 26 Nov 2018 at 20:04, <minyard@acm.org> wrote:
>
> From: Corey Minyard <cminyard@mvista.com>
>
> The SMBus slave code had an unneeded state, unnecessary function
> pointers and incorrectly handled quick commands.  Rewrite it
> to simplify the code and make it work correctly.
>
> smbus_eeprom is the only user, so no other effects and the eeprom
> code also gets a significant simplification.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/i2c/smbus_eeprom.c        | 58 ++++++-----------------
>  hw/i2c/smbus_slave.c         | 91 ++++++++++++++++--------------------
>  include/hw/i2c/smbus_slave.h | 45 +++++++++++++-----
>  3 files changed, 86 insertions(+), 108 deletions(-)

I'm finding this patch difficult to understand -- it
feels like it's trying to do too many things at once.
Is it possible to split it? For instance it looks like
we're getting rid of send_byte and just handling
all writes to the device with write_data -- is that
right? That sounds like it should be its own patch.
Whatever the change is that means that we don't pass in
the cmd argument to the various methods is probably its
own patch. And fixing quick commands sounds like something
that goes in its own patch.

Stray whitespace change (there are more of these below too).
If you want to do formatting tidyups please put those in
their own patch.

>  #ifdef DEBUG
>      printf("eeprom_receive_byte: addr=0x%02x val=0x%02x\n",
>             dev->i2c.address, val);
> @@ -65,37 +49,26 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>      return val;
>  }
>
> -static void eeprom_write_data(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int len)
> +static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
>  {
>      SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
> -    int n;
> +    uint8_t *data = eeprom->data;
> +
>  #ifdef DEBUG
>      printf("eeprom_write_byte: addr=0x%02x cmd=0x%02x val=0x%02x\n",
>             dev->i2c.address, cmd, buf[0]);

The "cmd" argument has been removed from the prototype
but is still used in this debug printf.

>  #endif

thanks
-- PMM
