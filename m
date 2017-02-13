Received: from eggs.gnu.org ([2001:4830:134:3::10]:52182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyy@google.com>) id 1cdLYB-00010Y-Bw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyy@google.com>) id 1cdLYA-0002IQ-2v
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:40:35 -0500
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:34853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zyy@google.com>) id 1cdLY9-0002I7-Mn
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:40:33 -0500
Received: by mail-it0-x233.google.com with SMTP id 203so198291644ith.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 10:40:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000d01d285b6$b1f12a40$15d37ec0$@ru>
References: <20170131115913.6828.12266.stgit@PASHA-ISP>
	<000d01d285b6$b1f12a40$15d37ec0$@ru>
From: Yurii Zubrytskyi <zyy@google.com>
Date: Mon, 13 Feb 2017 10:40:30 -0800
Message-ID: <CAJeUaNA=hBEb3ULxCxSX-0OkV2XncyRqO2v0muuHOFqdBYrhag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com

Hi,

It looks to me that this behavior can be achieved with "timer_mod_anticipate()"
function instead of a separate check.

On Sun, Feb 12, 2017 at 9:04 PM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:

> Ping?
>
> Pavel Dovgalyuk
>
>
> > -----Original Message-----
> > From: Pavel Dovgalyuk [mailto:pavel.dovgaluk@ispras.ru]
> > Sent: Tuesday, January 31, 2017 2:59 PM
> > To: qemu-devel@nongnu.org
> > Cc: pbonzini@redhat.com; dovgaluk@ispras.ru; kraxel@redhat.com
> > Subject: [PATCH] audio: make audio poll timer deterministic
> >
> > This patch changes resetting strategy of the audio polling timer.
> > It does not change expiration time if the timer is already set.
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  audio/audio.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/audio/audio.c b/audio/audio.c
> > index c845a44..1ee95a5 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -1112,8 +1112,10 @@ static int audio_is_timer_needed (void)
> >  static void audio_reset_timer (AudioState *s)
> >  {
> >      if (audio_is_timer_needed ()) {
> > -        timer_mod (s->ts,
> > -            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
> > +        if (!timer_pending(s->ts)) {
> > +            timer_mod (s->ts,
> > +                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> conf.period.ticks);
> > +        }
> >      }
> >      else {
> >          timer_del (s->ts);
>
>
>
>


-- 
Thanks, Yurii
