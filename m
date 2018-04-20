Received: from eggs.gnu.org ([2001:4830:134:3::10]:51659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9aJ4-0003dY-Ow
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9aJ1-0001bT-ML
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:58:46 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9aJ1-0001bB-IN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:58:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id a25-v6so10758702qtm.1
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 10:58:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd389ee4-2937-7343-cdd0-3a195b48994f@amsat.org>
Date: Fri, 20 Apr 2018 14:58:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/13] superio: Don't use MAX_SERIAL_PORTS
 for serial port limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/20/2018 11:52 AM, Peter Maydell wrote:
> The superio device has a limit on the number of serial
> ports it supports which is really only there because
> it has a fixed-size array serial[]. This limit isn't
> related particularly to the global MAX_SERIAL_PORTS limit,
> so use a different #define for it.
> 
> (In practice the users of superio only ever want 2 serial ports.)

The F81866A and IT8783 have 6 uarts :)

For this reason I'd prefer to dynamically allocate
ISASuperIODevice->serial, I might add that later on top of your series.

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/isa/superio.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
> index f9ba29aa30..345f006081 100644
> --- a/include/hw/isa/superio.h
> +++ b/include/hw/isa/superio.h
> @@ -22,13 +22,15 @@
>  #define ISA_SUPERIO_CLASS(klass) \
>      OBJECT_CLASS_CHECK(ISASuperIOClass, (klass), TYPE_ISA_SUPERIO)
>  
> +#define SUPERIO_MAX_SERIAL_PORTS 4
> +
>  typedef struct ISASuperIODevice {
>      /*< private >*/
>      ISADevice parent_obj;
>      /*< public >*/
>  
>      ISADevice *parallel[MAX_PARALLEL_PORTS];
> -    ISADevice *serial[MAX_SERIAL_PORTS];
> +    ISADevice *serial[SUPERIO_MAX_SERIAL_PORTS];
>      ISADevice *floppy;
>      ISADevice *kbc;
>      ISADevice *ide;
> 
