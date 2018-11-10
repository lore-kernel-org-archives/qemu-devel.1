Received: from eggs.gnu.org ([2001:4830:134:3::10]:43491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLZ3m-0000UW-Bg
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLZ3i-0000wn-Qj
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:36:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLZ3i-0000wA-KY
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:36:42 -0500
Received: by mail-wr1-x442.google.com with SMTP id 74-v6so5226195wrb.13
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 11:36:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181109142032.1628-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
Date: Sat, 10 Nov 2018 20:36:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181109142032.1628-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] pulseaudio: process audio data in
 smaller chunks
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

Hi Gerd,

On 11/9/18 3:20 PM, Gerd Hoffmann wrote:
> The rate of pulseaudio absorbing the audio stream is used to control the
> the rate of the guests audio stream.  When the emulated hardware uses
> small chunks (like intel-hda does) we need small chunks on the audio
> backend side too, otherwise that feedback loop doesn't work very well.

Shouldn't this be user-configurable?

> 
> Cc: Max Ehrlich <maxehr@umiacs.umd.edu>
> Cc: Martin Schrodt <martin@schrodt.org>
> Buglink: https://bugs.launchpad.net/bugs/1795527
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
>          wpos = pa->wpos;
>  
>          if (audio_pt_unlock(&pa->pt, __func__)) {
> 
