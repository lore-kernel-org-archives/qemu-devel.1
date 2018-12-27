Received: from eggs.gnu.org ([208.118.235.92]:50356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcayE-0000rd-Bo
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 14:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcawv-0006il-EQ
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 14:04:09 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcawv-0006hs-Ab
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 14:04:05 -0500
Received: by mail-yb1-f194.google.com with SMTP id 2so5717066ybw.4
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 11:04:05 -0800 (PST)
MIME-Version: 1.0
References: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
In-Reply-To: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 27 Dec 2018 20:03:53 +0100
Message-ID: <CAAdtpL5L-BgsUJ_yNkGQBPvPhyneN=csQMaRxqiaZDx-XZzaag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] smbus_eeprom: Limit data writes to 255
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Hanselmann <public@hansmi.ch>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

Hi Michael,

On Thu, Dec 27, 2018 at 12:53 PM Michael Hanselmann <public@hansmi.ch> wrote:
&gt; The "eeprom_write_data" function in "smbus_eeprom.c" had no provisions
&gt; to limit the length of data written. If a caller were able to manipulate
&gt; the "len" parameter they could potentially write before or after the
&gt; target buffer.

You forgot to sign your commit:
"Signed-off-by: Michael Hanselmann <public@hansmi.ch>"

(See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297)

> ---
>  hw/i2c/smbus_eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index f18aa3de35..74fa1c328c 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -76,6 +76,7 @@ static void eeprom_write_data(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int l
>         It is a block write without a length byte.  Fortunately we
>         get the full block anyway.  */
>      /* TODO: Should this set the current location?  */
> +    len &= 0xff;
>      if (cmd + len > 256)

Corey Minyard sent a cleanup series [1] because this device model is
known to be unsafe and need rewrite.
There is a particular patch [2] which add the SMBUS_EEPROM_SIZE definition.
He also provided a intent at cleaning this problem here [3] where
Peter suggested to split it in fewer patches.

Regards,

Phil.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05293.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05295.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05298.html

>          n = 256 - cmd;
>      else
> --
> 2.11.0
>
>
