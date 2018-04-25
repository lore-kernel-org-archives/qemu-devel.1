Received: from eggs.gnu.org ([2001:4830:134:3::10]:33592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLY5-00013k-Gb
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLY2-0008L0-BN
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35174 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLY2-0008Ke-4P
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:30 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-2-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <77b09eff-83b6-436f-1510-73ccc221a210@redhat.com>
Date: Wed, 25 Apr 2018 16:37:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/13] hw/char/serial: Allow disconnected
 chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Currently the serial.c realize code has an explicit check that it is not
> connected to a disconnected backend (ie one with a NULL chardev).
> This isn't what we want -- you should be able to create a serial device
> even if it isn't attached to anything. Remove the check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/char/serial.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index eb72191ee7..2c080c9862 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -923,11 +923,6 @@ static int serial_be_change(void *opaque)
>  
>  void serial_realize_core(SerialState *s, Error **errp)
>  {
> -    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> -        error_setg(errp, "Can't create serial device, empty char device");
> -        return;
> -    }
> -
>      s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
>  
>      s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
> 

Acked-by: Thomas Huth <thuth@redhat.com>
