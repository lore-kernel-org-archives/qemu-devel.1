Received: from eggs.gnu.org ([2001:4830:134:3::10]:48307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEDcT-0000MQ-9u
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEDcR-0007Bm-HA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:41:25 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dEDcR-0007Be-55
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:41:23 -0400
Received: by mail-lf0-x242.google.com with SMTP id 99so784330lfu.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-8-marcandre.lureau@redhat.com>
	<6abdd634-4c04-6491-18f3-32c5bc553d8e@redhat.com>
In-Reply-To: <6abdd634-4c04-6491-18f3-32c5bc553d8e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 11:41:11 +0000
Message-ID: <CAJ+F1C+WkbSuy724KNby=77jLdU=6F3+uGnvVGBcav8PWF5+DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi

On Tue, May 9, 2017 at 3:49 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 09/05/2017 13:33, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/chardev/char-parallel.h | 20 +++++++++++++++++++-
> >  include/chardev/char-serial.h   | 22 ++++++++++++++++++++++
> >  include/chardev/char.h          | 36
> ------------------------------------
> >  hw/arm/strongarm.c              |  2 +-
> >  hw/bt/hci-csr.c                 |  2 +-
> >  hw/char/cadence_uart.c          |  2 +-
> >  hw/char/escc.c                  |  2 +-
> >  hw/char/exynos4210_uart.c       |  2 +-
> >  hw/char/parallel.c              |  2 +-
> >  hw/char/serial.c                |  2 +-
> >  hw/usb/dev-serial.c             |  2 +-
> >  11 files changed, 49 insertions(+), 45 deletions(-)
> >
> > diff --git a/include/chardev/char-parallel.h
> b/include/chardev/char-parallel.h
> > index 26742f9d5c..3284a1b96b 100644
> > --- a/include/chardev/char-parallel.h
> > +++ b/include/chardev/char-parallel.h
> > @@ -24,9 +24,27 @@
> >  #ifndef CHAR_PARALLEL_H
> >  #define CHAR_PARALLEL_H
> >
> > -#if defined(__linux__) || defined(__FreeBSD__) || \
> > +#include "chardev/char.h"
> > +
> > +#if defined(__linux__) || defined(__FreeBSD__) ||               \
> >      defined(__FreeBSD_kernel__) || defined(__DragonFly__)
> >  #define HAVE_CHARDEV_PARPORT 1
> >  #endif
> >
> > +#define CHR_IOCTL_PP_READ_DATA        3
> > +#define CHR_IOCTL_PP_WRITE_DATA       4
> > +#define CHR_IOCTL_PP_READ_CONTROL     5
> > +#define CHR_IOCTL_PP_WRITE_CONTROL    6
> > +#define CHR_IOCTL_PP_READ_STATUS      7
> > +#define CHR_IOCTL_PP_EPP_READ_ADDR    8
> > +#define CHR_IOCTL_PP_EPP_READ         9
> > +#define CHR_IOCTL_PP_EPP_WRITE_ADDR  10
> > +#define CHR_IOCTL_PP_EPP_WRITE       11
> > +#define CHR_IOCTL_PP_DATA_DIR        12
> > +
> > +struct ParallelIOArg {
> > +    void *buffer;
> > +    int count;
> > +};
> > +
> >  #endif /* CHAR_PARALLEL_H */
> > diff --git a/include/chardev/char-serial.h
> b/include/chardev/char-serial.h
> > index 64a27f63b1..cb2e59e82a 100644
> > --- a/include/chardev/char-serial.h
> > +++ b/include/chardev/char-serial.h
> > @@ -24,6 +24,8 @@
> >  #ifndef CHAR_SERIAL_H
> >  #define CHAR_SERIAL_H
> >
> > +#include "chardev/char.h"
> > +
> >  #ifdef _WIN32
> >  #define HAVE_CHARDEV_SERIAL 1
> >  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)
> \
> > @@ -32,4 +34,24 @@
> >  #define HAVE_CHARDEV_SERIAL 1
> >  #endif
> >
> > +#define CHR_IOCTL_SERIAL_SET_PARAMS   1
> > +typedef struct {
> > +    int speed;
> > +    int parity;
> > +    int data_bits;
> > +    int stop_bits;
> > +} QEMUSerialSetParams;
> > +
> > +#define CHR_IOCTL_SERIAL_SET_BREAK    2
> > +
> > +#define CHR_IOCTL_SERIAL_SET_TIOCM   13
> > +#define CHR_IOCTL_SERIAL_GET_TIOCM   14
> > +
> > +#define CHR_TIOCM_CTS   0x020
> > +#define CHR_TIOCM_CAR   0x040
> > +#define CHR_TIOCM_DSR   0x100
> > +#define CHR_TIOCM_RI    0x080
> > +#define CHR_TIOCM_DTR   0x002
> > +#define CHR_TIOCM_RTS   0x004
> > +
> >  #endif
> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> > index ea9f2cb7d6..0e1ef1ea4f 100644
> > --- a/include/chardev/char.h
> > +++ b/include/chardev/char.h
> > @@ -27,42 +27,6 @@ typedef enum {
> >
> >  #define CHR_READ_BUF_LEN 4096
> >
> > -#define CHR_IOCTL_SERIAL_SET_PARAMS   1
> > -typedef struct {
> > -    int speed;
> > -    int parity;
> > -    int data_bits;
> > -    int stop_bits;
> > -} QEMUSerialSetParams;
> > -
> > -#define CHR_IOCTL_SERIAL_SET_BREAK    2
> > -
> > -#define CHR_IOCTL_PP_READ_DATA        3
> > -#define CHR_IOCTL_PP_WRITE_DATA       4
> > -#define CHR_IOCTL_PP_READ_CONTROL     5
> > -#define CHR_IOCTL_PP_WRITE_CONTROL    6
> > -#define CHR_IOCTL_PP_READ_STATUS      7
> > -#define CHR_IOCTL_PP_EPP_READ_ADDR    8
> > -#define CHR_IOCTL_PP_EPP_READ         9
> > -#define CHR_IOCTL_PP_EPP_WRITE_ADDR  10
> > -#define CHR_IOCTL_PP_EPP_WRITE       11
> > -#define CHR_IOCTL_PP_DATA_DIR        12
> > -
> > -struct ParallelIOArg {
> > -    void *buffer;
> > -    int count;
> > -};
> > -
> > -#define CHR_IOCTL_SERIAL_SET_TIOCM   13
> > -#define CHR_IOCTL_SERIAL_GET_TIOCM   14
> > -
> > -#define CHR_TIOCM_CTS        0x020
> > -#define CHR_TIOCM_CAR        0x040
> > -#define CHR_TIOCM_DSR        0x100
> > -#define CHR_TIOCM_RI 0x080
> > -#define CHR_TIOCM_DTR        0x002
> > -#define CHR_TIOCM_RTS        0x004
> > -
> >  typedef void IOEventHandler(void *opaque, int event);
> >
> >  typedef enum {
>
> Hmm, this makes the previous patch more desirable.
>

Yeah, I think it's a bit simpler if we put all chardev/ headers under
include/chardev, since files outside chardev/ include headers like
char-serial.h or char-parallel.h and it helps cleaning the headers.

We could limit it to headers accessed outside chardev/, that is probably
mainly -serial and -parellel (I haven't checked)


> > diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> > index 66cad198d4..967caea749 100644
> > --- a/hw/arm/strongarm.c
> > +++ b/hw/arm/strongarm.c
> > @@ -34,7 +34,7 @@
> >  #include "strongarm.h"
> >  #include "qemu/error-report.h"
> >  #include "hw/arm/arm.h"
> > -#include "chardev/char.h"
> > +#include "chardev/char-serial.h"
>
> Should this include both?  Likewise for all those below.
>

Well the patch makes char-serial.h implicitely includes char.h. Anything
wrong with that?

thanks


--=20
Marc-Andr=C3=A9 Lureau
