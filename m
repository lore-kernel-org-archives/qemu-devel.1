Received: from eggs.gnu.org ([2001:4830:134:3::10]:45681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYXMO-0003JK-Uc
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYXMN-0003CZ-Tz
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:16:32 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cYXMN-0003CT-M9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:16:31 -0500
Received: by mail-yb0-x241.google.com with SMTP id 123so29508408ybe.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 04:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20170131115913.6828.12266.stgit@PASHA-ISP>
In-Reply-To: <20170131115913.6828.12266.stgit@PASHA-ISP>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jan 2017 12:16:20 +0000
Message-ID: <CAJ+F1CKUVDvnyhOT6XR1=bQL8ia9GCUBx=0xotGCBmojtR6XSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kraxel@redhat.com

Hi

On Tue, Jan 31, 2017 at 4:03 PM Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
wrote:

> This patch changes resetting strategy of the audio polling timer.
> It does not change expiration time if the timer is already set.
>
>
You describe the change, but could you explain the reasons you propose it?


> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  audio/audio.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index c845a44..1ee95a5 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1112,8 +1112,10 @@ static int audio_is_timer_needed (void)
>  static void audio_reset_timer (AudioState *s)
>  {
>      if (audio_is_timer_needed ()) {
> -        timer_mod (s->ts,
> -            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
> +        if (!timer_pending(s->ts)) {
> +            timer_mod (s->ts,
> +                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> conf.period.ticks);
> +        }
>      }
>      else {
>          timer_del (s->ts);
>
>
> --
Marc-Andr=C3=A9 Lureau
