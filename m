Received: from eggs.gnu.org ([209.51.188.92]:55697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmdLe-0000wX-2j
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmdLd-0000Vl-7B
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:39:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmdLd-0000VG-0y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:39:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so2723069wmc.5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:39:04 -0800 (PST)
References: <20190124112055.547-1-kraxel@redhat.com>
	<20190124112055.547-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3313a4dc-4abb-d24f-83d5-c5ac1c4f4647@redhat.com>
Date: Thu, 24 Jan 2019 12:39:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190124112055.547-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] audio: use pkg-config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>

On 1/24/19 12:20 PM, Gerd Hoffmann wrote:
> Use pkg-config to probe for alsa and pulseaudio.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/configure b/configure
> index 8f312ac3e2..5fcd0f4795 100755
> --- a/configure
> +++ b/configure
> @@ -3342,39 +3342,26 @@ fi
>  ##########################################
>  # Sound support libraries probe
>  
> -audio_drv_probe()
> -{
> -    drv=$1
> -    hdr=$2
> -    lib=$3
> -    exp=$4
> -    cfl=$5
> -        cat > $TMPC << EOF
> -#include <$hdr>
> -int main(void) { $exp }
> -EOF
> -    if compile_prog "$cfl" "$lib" ; then
> -        :
> -    else
> -        error_exit "$drv check failed" \
> -            "Make sure to have the $drv libs and headers installed."
> -    fi
> -}
> -
>  audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/,/ /g')
>  for drv in $audio_drv_list; do
>      case $drv in
>      alsa)
> -    audio_drv_probe $drv alsa/asoundlib.h -lasound \
> -        "return snd_pcm_close((snd_pcm_t *)0);"
> -    alsa_libs="-lasound"
> +    if $pkg_config alsa --exists; then
> +        alsa_libs=$($pkg_config alsa --libs)
> +    else
> +        error_exit "$drv check failed" \
> +            "Make sure to have the $drv libs and headers installed."
> +    fi
>      ;;
>  
>      pa)
> -    audio_drv_probe $drv pulse/pulseaudio.h "-lpulse" \
> -        "pa_context_set_source_output_volume(NULL, 0, NULL, NULL, NULL); return 0;"
> -    pulse_libs="-lpulse"
> -    audio_pt_int="yes"
> +    if $pkg_config libpulse --exists; then
> +        pulse_libs=$($pkg_config libpulse --libs)
> +        audio_pt_int="yes"
> +    else
> +        error_exit "$drv check failed" \
> +            "Make sure to have the $drv libs and headers installed."
> +    fi
>      ;;
>  
>      sdl)
> 
