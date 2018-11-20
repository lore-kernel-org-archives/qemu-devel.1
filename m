Received: from eggs.gnu.org ([2001:4830:134:3::10]:38110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP821-00084F-FK
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP820-0001v6-NX
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:33:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP820-0001uJ-ID
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:33:40 -0500
Received: by mail-ot1-x344.google.com with SMTP id g27so2014963oth.6
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:33:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181115192446.17187-5-minyard@acm.org>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-5-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 15:33:19 +0000
Message-ID: <CAFEAcA8uTFRiYZuJx=9o0Bs483TgVt=TTAV50n3JNsZCJaqKfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 04/12] i2c: Add a length check to the
 SMBus write handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 15 November 2018 at 19:24,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Avoid an overflow.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/i2c/smbus_slave.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index 83ca041b5d..fa988919d8 100644
> --- a/hw/i2c/smbus_slave.c
> +++ b/hw/i2c/smbus_slave.c
> @@ -182,7 +182,11 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
>      switch (dev->mode) {
>      case SMBUS_WRITE_DATA:
>          DPRINTF("Write data %02x\n", data);
> -        dev->data_buf[dev->data_len++] = data;
> +        if (dev->data_len >= sizeof(dev->data_buf)) {
> +            BADF("Too many bytes sent\n");
> +        } else {
> +            dev->data_buf[dev->data_len++] = data;
> +        }
>          break;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

What happens on a real device in this situation ?

thanks
-- PMM
