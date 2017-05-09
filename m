Received: from eggs.gnu.org ([2001:4830:134:3::10]:32798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d83Wd-0003Sc-Bq
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d83Wa-0005Ka-8Q
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d83WZ-0005KU-Ux
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:41:52 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C800080470
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:41:50 +0000 (UTC)
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-8-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6abdd634-4c04-6491-18f3-32c5bc553d8e@redhat.com>
Date: Tue, 9 May 2017 13:41:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/13] chardev: serial & parallel
 declaration to own headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 09/05/2017 13:33, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char-parallel.h | 20 +++++++++++++++++++-
>  include/chardev/char-serial.h   | 22 ++++++++++++++++++++++
>  include/chardev/char.h          | 36 ---------------------------------=
---
>  hw/arm/strongarm.c              |  2 +-
>  hw/bt/hci-csr.c                 |  2 +-
>  hw/char/cadence_uart.c          |  2 +-
>  hw/char/escc.c                  |  2 +-
>  hw/char/exynos4210_uart.c       |  2 +-
>  hw/char/parallel.c              |  2 +-
>  hw/char/serial.c                |  2 +-
>  hw/usb/dev-serial.c             |  2 +-
>  11 files changed, 49 insertions(+), 45 deletions(-)
>=20
> diff --git a/include/chardev/char-parallel.h b/include/chardev/char-par=
allel.h
> index 26742f9d5c..3284a1b96b 100644
> --- a/include/chardev/char-parallel.h
> +++ b/include/chardev/char-parallel.h
> @@ -24,9 +24,27 @@
>  #ifndef CHAR_PARALLEL_H
>  #define CHAR_PARALLEL_H
> =20
> -#if defined(__linux__) || defined(__FreeBSD__) || \
> +#include "chardev/char.h"
> +
> +#if defined(__linux__) || defined(__FreeBSD__) ||               \
>      defined(__FreeBSD_kernel__) || defined(__DragonFly__)
>  #define HAVE_CHARDEV_PARPORT 1
>  #endif
> =20
> +#define CHR_IOCTL_PP_READ_DATA        3
> +#define CHR_IOCTL_PP_WRITE_DATA       4
> +#define CHR_IOCTL_PP_READ_CONTROL     5
> +#define CHR_IOCTL_PP_WRITE_CONTROL    6
> +#define CHR_IOCTL_PP_READ_STATUS      7
> +#define CHR_IOCTL_PP_EPP_READ_ADDR    8
> +#define CHR_IOCTL_PP_EPP_READ         9
> +#define CHR_IOCTL_PP_EPP_WRITE_ADDR  10
> +#define CHR_IOCTL_PP_EPP_WRITE       11
> +#define CHR_IOCTL_PP_DATA_DIR        12
> +
> +struct ParallelIOArg {
> +    void *buffer;
> +    int count;
> +};
> +
>  #endif /* CHAR_PARALLEL_H */
> diff --git a/include/chardev/char-serial.h b/include/chardev/char-seria=
l.h
> index 64a27f63b1..cb2e59e82a 100644
> --- a/include/chardev/char-serial.h
> +++ b/include/chardev/char-serial.h
> @@ -24,6 +24,8 @@
>  #ifndef CHAR_SERIAL_H
>  #define CHAR_SERIAL_H
> =20
> +#include "chardev/char.h"
> +
>  #ifdef _WIN32
>  #define HAVE_CHARDEV_SERIAL 1
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)  =
  \
> @@ -32,4 +34,24 @@
>  #define HAVE_CHARDEV_SERIAL 1
>  #endif
> =20
> +#define CHR_IOCTL_SERIAL_SET_PARAMS   1
> +typedef struct {
> +    int speed;
> +    int parity;
> +    int data_bits;
> +    int stop_bits;
> +} QEMUSerialSetParams;
> +
> +#define CHR_IOCTL_SERIAL_SET_BREAK    2
> +
> +#define CHR_IOCTL_SERIAL_SET_TIOCM   13
> +#define CHR_IOCTL_SERIAL_GET_TIOCM   14
> +
> +#define CHR_TIOCM_CTS   0x020
> +#define CHR_TIOCM_CAR   0x040
> +#define CHR_TIOCM_DSR   0x100
> +#define CHR_TIOCM_RI    0x080
> +#define CHR_TIOCM_DTR   0x002
> +#define CHR_TIOCM_RTS   0x004
> +
>  #endif
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index ea9f2cb7d6..0e1ef1ea4f 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -27,42 +27,6 @@ typedef enum {
> =20
>  #define CHR_READ_BUF_LEN 4096
> =20
> -#define CHR_IOCTL_SERIAL_SET_PARAMS   1
> -typedef struct {
> -    int speed;
> -    int parity;
> -    int data_bits;
> -    int stop_bits;
> -} QEMUSerialSetParams;
> -
> -#define CHR_IOCTL_SERIAL_SET_BREAK    2
> -
> -#define CHR_IOCTL_PP_READ_DATA        3
> -#define CHR_IOCTL_PP_WRITE_DATA       4
> -#define CHR_IOCTL_PP_READ_CONTROL     5
> -#define CHR_IOCTL_PP_WRITE_CONTROL    6
> -#define CHR_IOCTL_PP_READ_STATUS      7
> -#define CHR_IOCTL_PP_EPP_READ_ADDR    8
> -#define CHR_IOCTL_PP_EPP_READ         9
> -#define CHR_IOCTL_PP_EPP_WRITE_ADDR  10
> -#define CHR_IOCTL_PP_EPP_WRITE       11
> -#define CHR_IOCTL_PP_DATA_DIR        12
> -
> -struct ParallelIOArg {
> -    void *buffer;
> -    int count;
> -};
> -
> -#define CHR_IOCTL_SERIAL_SET_TIOCM   13
> -#define CHR_IOCTL_SERIAL_GET_TIOCM   14
> -
> -#define CHR_TIOCM_CTS	0x020
> -#define CHR_TIOCM_CAR	0x040
> -#define CHR_TIOCM_DSR	0x100
> -#define CHR_TIOCM_RI	0x080
> -#define CHR_TIOCM_DTR	0x002
> -#define CHR_TIOCM_RTS	0x004
> -
>  typedef void IOEventHandler(void *opaque, int event);
> =20
>  typedef enum {

Hmm, this makes the previous patch more desirable.

> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 66cad198d4..967caea749 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -34,7 +34,7 @@
>  #include "strongarm.h"
>  #include "qemu/error-report.h"
>  #include "hw/arm/arm.h"
> -#include "chardev/char.h"
> +#include "chardev/char-serial.h"

Should this include both?  Likewise for all those below.

Thanks,

Paolo

>  #include "sysemu/sysemu.h"
>  #include "hw/ssi/ssi.h"
>  #include "qemu/cutils.h"
> diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
> index cc2087392e..0f2021086d 100644
> --- a/hw/bt/hci-csr.c
> +++ b/hw/bt/hci-csr.c
> @@ -20,7 +20,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "chardev/char.h"
> +#include "chardev/char-serial.h"
>  #include "qemu/timer.h"
>  #include "qemu/bswap.h"
>  #include "hw/irq.h"
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index cf4c1d56ff..4bfc185376 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -23,7 +23,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> -#include "chardev/char.h"
> +#include "chardev/char-serial.h"
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "hw/char/cadence_uart.h"
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index df89d58eed..81d792cb47 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -26,7 +26,7 @@
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "hw/char/escc.h"
> -#include "chardev/char.h"
> +#include "chardev/char-serial.h"
>  #include "ui/console.h"
>  #include "ui/input.h"
>  #include "trace.h"
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index 94952fb90f..d93125645a 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -23,7 +23,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/sysemu.h"
> -#include "chardev/char.h"
> +#include "chardev/char-serial.h"
> =20
>  #include "hw/arm/exynos4210.h"
> =20
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index c926df0bee..1d6c6e9f33 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
> -#include "chardev/char.h"
> +#include "chardev/char-parallel.h"
>  #include "hw/isa/isa.h"
>  #include "hw/i386/pc.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index aa336333be..23e5fe9d18 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -25,7 +25,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/char/serial.h"
> -#include "chardev/char.h"
> +#include "chardev/char-serial.h"
>  #include "qapi/error.h"
>  #include "qemu/timer.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index c19cd310c2..4f592d0f82 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -15,7 +15,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/usb.h"
>  #include "hw/usb/desc.h"
> -#include "chardev/char.h"
> +#include "chardev/char-serial.h"
> =20
>  //#define DEBUG_Serial
> =20
>=20
