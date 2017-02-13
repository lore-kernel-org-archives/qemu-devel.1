Received: from eggs.gnu.org ([2001:4830:134:3::10]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cd8oh-0002eZ-R5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cd8og-0006PU-Ql
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:04:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60266)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cd8og-0006PQ-Ji
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:04:46 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170131115913.6828.12266.stgit@PASHA-ISP>
In-Reply-To: <20170131115913.6828.12266.stgit@PASHA-ISP>
Date: Mon, 13 Feb 2017 08:04:46 +0300
Message-ID: <000d01d285b6$b1f12a40$15d37ec0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kraxel@redhat.com

Ping?

Pavel Dovgalyuk


> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:pavel.dovgaluk@ispras.ru]
> Sent: Tuesday, January 31, 2017 2:59 PM
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; dovgaluk@ispras.ru; kraxel@redhat.com
> Subject: [PATCH] audio: make audio poll timer deterministic
> 
> This patch changes resetting strategy of the audio polling timer.
> It does not change expiration time if the timer is already set.
> 
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
> +                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
> +        }
>      }
>      else {
>          timer_del (s->ts);
