Received: from eggs.gnu.org ([2001:4830:134:3::10]:40955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faLx3-0006NM-Tb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faLwz-0008IC-L3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:06:41 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faLwz-0008I1-Fu
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:06:37 -0400
Received: by mail-qt0-x243.google.com with SMTP id q12-v6so1635960qtp.6
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 07:06:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180703121924.11411-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a53564fb-c2d8-967f-1264-f9e2a895366b@amsat.org>
Date: Tue, 3 Jul 2018 11:06:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180703121924.11411-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pulseaudio: process audio data in smaller
 chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Martin Schrodt <martin@schrodt.org>, Max Ehrlich <maxehr@umiacs.umd.edu>

On 07/03/2018 09:19 AM, Gerd Hoffmann wrote:
> The rate of pulseaudio absorbing the audio stream is used to control the
> the rate of the guests audio stream.  When the emulated hardware uses
> small chunks (like intel-hda does) we need small chunks on the audio
> backend side too, otherwise that feedback loop doesn't work very well.
> 
> Cc: Max Ehrlich <maxehr@umiacs.umd.edu>
> Cc: Martin Schrodt <martin@schrodt.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  audio/paaudio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 949769774d..4c100bc318 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -227,7 +227,7 @@ static void *qpa_thread_out (void *arg)
>              }
>          }
>  
> -        decr = to_mix = audio_MIN (pa->live, pa->g->conf.samples >> 2);
> +        decr = to_mix = audio_MIN(pa->live, pa->g->conf.samples >> 5);
>          rpos = pa->rpos;
>  
>          if (audio_pt_unlock(&pa->pt, __func__)) {
> @@ -319,7 +319,7 @@ static void *qpa_thread_in (void *arg)
>              }
>          }
>  
> -        incr = to_grab = audio_MIN (pa->dead, pa->g->conf.samples >> 2);
> +        incr = to_grab = audio_MIN(pa->dead, pa->g->conf.samples >> 5);

Same pattern/value: can we have a #define?

I looked at the PA intel-hda code and couldn't find the chunk size,
anyway this change looks sane.

>          wpos = pa->wpos;
>  
>          if (audio_pt_unlock(&pa->pt, __func__)) {
> 
