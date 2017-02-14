Received: from eggs.gnu.org ([2001:4830:134:3::10]:52219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdbjc-00069H-3P
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdbjY-0002gY-53
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdbjX-0002fs-Ur
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:57:24 -0500
References: <20170131115913.6828.12266.stgit@PASHA-ISP>
	<000d01d285b6$b1f12a40$15d37ec0$@ru>
	<CAJeUaNA=hBEb3ULxCxSX-0OkV2XncyRqO2v0muuHOFqdBYrhag@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df95f74b-b96f-e889-2191-b23b9ab4e6b1@redhat.com>
Date: Tue, 14 Feb 2017 12:57:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAJeUaNA=hBEb3ULxCxSX-0OkV2XncyRqO2v0muuHOFqdBYrhag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yurii Zubrytskyi <zyy@google.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kraxel@redhat.com



On 13/02/2017 19:40, Yurii Zubrytskyi wrote:
> Hi,
> 
> It looks to me that this behavior can be achieved with
> "timer_mod_anticipate()" function instead of a separate check.

True, but I think Pavel's version is more readable.  Since the timer is
set to a fixed value from QEMU_CLOCK_VIRTUAL, timer_mod_anticipate is
never going to do anything if the timer is already set.

Paolo

>     > diff --git a/audio/audio.c b/audio/audio.c
>     > index c845a44..1ee95a5 100644
>     > --- a/audio/audio.c
>     > +++ b/audio/audio.c
>     > @@ -1112,8 +1112,10 @@ static int audio_is_timer_needed (void)
>     >  static void audio_reset_timer (AudioState *s)
>     >  {
>     >      if (audio_is_timer_needed ()) {
>     > -        timer_mod (s->ts,
>     > -            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>     conf.period.ticks);
>     > +        if (!timer_pending(s->ts)) {
>     > +            timer_mod (s->ts,
>     > +                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>     conf.period.ticks);
>     > +        }
>     >      }
>     >      else {
>     >          timer_del (s->ts);
> 
> 
> 
> 
> 
> 
> -- 
> Thanks, Yurii
