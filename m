Received: from eggs.gnu.org ([209.51.188.92]:47407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLfjx-00021J-LM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLfju-0000Uo-Kf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:17:01 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:45938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hLfju-0000Tq-3j
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 23:16:58 -0400
Received: by mail-yw1-xc44.google.com with SMTP id r139so7500820ywe.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 20:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190428110258.86681-1-liboxuan@connect.hku.hk>
	<a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
	<5fe13664-cabc-6fc9-7437-285cc1452944@redhat.com>
In-Reply-To: <5fe13664-cabc-6fc9-7437-285cc1452944@redhat.com>
From: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date: Wed, 1 May 2019 11:16:20 +0800
Message-ID: <CALM0=-msXgYqraKzKcxCZgH-+VM7=MUvGLRAjP_r2im_Oj2Spw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi Eric and Phil,

Thanks for your reviews. I am looking into trace events and I'll send a
patch v2 soon.

Eric Blake <eblake@redhat.com> =E6=96=BC 2019=E5=B9=B44=E6=9C=8830=E6=97=A5=
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:03=E5=AF=AB=E9=81=93=EF=BC=9A

> On 4/30/19 5:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Li,
> >
> > On 4/28/19 1:02 PM, Boxuan Li wrote:
> >> Wrap printf calls inside debug macros (DPRINTF) in `if` statement, and
> >> change output to stderr as well. This will ensure that printf function
> >> will always compile and prevent bitrot of the format strings.
> >
> > There is an effort in QEMU to replace the obsolete DPRINTF() macros by
> > trace events (which prevent format strings bitroting).
>
> Trace events are even more powerful than conditional debugs (in that you
> can turn them on or off at runtime, instead of compile time). But
> incremental improvements are still better than nothing.


> >>
> >> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> >> index 5807aa87fe..693b3c9eb4 100644
> >> --- a/hw/virtio/virtio-mmio.c
> >> +++ b/hw/virtio/virtio-mmio.c
> >> @@ -28,15 +28,14 @@
> >>  #include "hw/virtio/virtio-bus.h"
> >>  #include "qemu/error-report.h"
> >>
> >> -/* #define DEBUG_VIRTIO_MMIO */
> >> -
> >> -#ifdef DEBUG_VIRTIO_MMIO
>
The old code let a user pass CFLAGS=3D-DDEBUG_VIRTIO_MMIO to turn things on=
...
>
> >> -
> >> -#define DPRINTF(fmt, ...) \
> >> -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
> >> -#else
> >> -#define DPRINTF(fmt, ...) do {} while (0)
> >> -#endif
> >> +#define DEBUG_VIRTIO_MMIO 0
>
> ...the new code requires a source code edit. This can be considered a
> step backwards in developer friendliness.  Better might be:
>
> #ifdef DEBUG_VIRTIO_MMIO
> #define DEBUG_VIRTIO_MMIO_PRINT 1
> #else
> #define DEBUG_VIRTIO_MMIO_PRINT 0
> #endif
>
> >> +
> >> +#define DPRINTF(fmt, ...)                                            =
\
> >> +    do {                                                             =
\
> >> +        if (DEBUG_VIRTIO_MMIO) {                                     =
\
>
> and the corresponding use of DEBUG_VIRTIO_MMIO_PRINT here, so that you
> preserve the ability to do a command-line CFLAGS=3D-D override, rather
> than forcing a source code edit.
>
>
Got it. Actually, I learned from
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dc691320faa6, which is=
 used
as an example of Bitrot prevention part in
https://wiki.qemu.org/Contribute/BiteSizedTasks. Maybe the wiki page can be
updated.


> >> +            fprintf(stderr, "virtio_mmio: " fmt , ## __VA_ARGS__);   =
\
>
> No space before ,
>
> >> +        }                                                            =
\
> >> +    } while (0)
> >>
> >>  /* QOM macros */
> >>  /* virtio-mmio-bus */
> >>
> >
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
Best regards,
Boxuan Li
