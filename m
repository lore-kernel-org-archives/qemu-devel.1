Received: from eggs.gnu.org ([2001:4830:134:3::10]:34182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRNZn-0002lP-0v
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRNZj-0006r9-SJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:33:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRNZj-0006qx-Ml
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:33:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so19871486wmf.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:33:47 -0800 (PST)
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-7-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <105ccb98-5526-e8d2-3842-854bcb56e935@redhat.com>
Date: Mon, 26 Nov 2018 21:33:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200435.23408-7-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/16] i2c: Add a length check to the
 SMBus write handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, qemu-stable@nongnu.org

On 26/11/18 21:04, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Avoid an overflow.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/i2c/smbus_slave.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index 70ff29c095..d03f714608 100644
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
>  
>      default:
> 
