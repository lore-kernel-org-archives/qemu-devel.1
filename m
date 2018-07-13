Received: from eggs.gnu.org ([2001:4830:134:3::10]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fdzTb-0003om-RQ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fdzTa-0007eM-Ik
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:55:19 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fdzTa-0007dI-5w
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:55:18 -0400
Received: by mail-wm0-x243.google.com with SMTP id n17-v6so9716154wmh.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 07:55:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710154800.7ea50b73@redhat.com>
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
	<4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
	<20180710154800.7ea50b73@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 13 Jul 2018 16:55:15 +0200
Message-ID: <CAJ+F1CJVQn5zucYgn9dUFOu76MZkqd2Vaep52c89AORWF=sOrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Jul 10, 2018 at 3:48 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 5 Jun 2018 11:18:35 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> On 05/06/2018 09:54, Sergio Lopez wrote:
>> > Only retry on serial_xmit if qemu_chr_fe_write returns 0, as this is t=
he
>> > only recoverable error.
>> >
>> > Retrying with any other scenario, in addition to being a waste of CPU
>> > cycles, can compromise the Guest stability if by the vCPU issuing the
>> > write and the main loop thread are, by chance or explicit pinning,
>> > running on the same pCPU.
>> >
>> > Previous discussion:
>> >
>> > https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06998.html
>> >
>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
>> > ---
>> >  hw/char/serial.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/hw/char/serial.c b/hw/char/serial.c
>> > index 605b0d0..6de6c29 100644
>> > --- a/hw/char/serial.c
>> > +++ b/hw/char/serial.c
>> > @@ -260,7 +260,7 @@ static void serial_xmit(SerialState *s)
>> >          if (s->mcr & UART_MCR_LOOP) {
>> >              /* in loopback mode, say that we just received a char */
>> >              serial_receive1(s, &s->tsr, 1);
>> > -        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) !=3D 1 &&
>> > +        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) =3D=3D 0 &&
>> >                     s->tsr_retry < MAX_XMIT_RETRY) {
>> >              assert(s->watch_tag =3D=3D 0);
>> >              s->watch_tag =3D
>> >
> Hi Sergio, Paolo,
>
> it looks like commit
> commit 019288bf137183bf3407c9824655b753bfafc99f
> Author: Sergio Lopez <slp@redhat.com>
> Date:   Tue Jun 5 03:54:55 2018 -0400
>
>     hw/char/serial: Only retry if qemu_chr_fe_write returns 0
>
> introduced regression wrt 2.12 and broke windows guest remote kernel debu=
g over
> serial, where windbg can't connect to target and target hangs when windbg=
 tries
> to connect to it.
>
> Reverting the commit fixes issue
>

is this a possible solution?

diff --git a/hw/char/serial.c b/hw/char/serial.c
index cd7d747c68..046c4684ff 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -261,15 +261,20 @@ static void serial_xmit(SerialState *s)
         if (s->mcr & UART_MCR_LOOP) {
             /* in loopback mode, say that we just received a char */
             serial_receive1(s, &s->tsr, 1);
-        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) =3D=3D 0 &&
-                   s->tsr_retry < MAX_XMIT_RETRY) {
-            assert(s->watch_tag =3D=3D 0);
-            s->watch_tag =3D
-                qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
-                                      serial_watch_cb, s);
-            if (s->watch_tag > 0) {
-                s->tsr_retry++;
-                return;
+        } else {
+            int rc =3D qemu_chr_fe_write(&s->chr, &s->tsr, 1);
+
+            if ((rc =3D=3D 0 ||
+                 (rc =3D=3D -1 && (errno =3D=3D EAGAIN || errno =3D=3D EIN=
TR))) &&
+                s->tsr_retry < MAX_XMIT_RETRY) {
+                assert(s->watch_tag =3D=3D 0);
+                s->watch_tag =3D
+                    qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                          serial_watch_cb, s);
+                if (s->watch_tag > 0) {
+                    s->tsr_retry++;
+                    return;
+                }
             }
         }
         s->tsr_retry =3D 0;


--=20
Marc-Andr=C3=A9 Lureau
