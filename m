Received: from eggs.gnu.org ([209.51.188.92]:56212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmdNW-0001mW-Sd
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmdNW-0003Fb-1u
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:41:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmdNV-0003EM-Rb
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:41:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2698284wmt.0
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:41:01 -0800 (PST)
References: <20190124112055.547-1-kraxel@redhat.com>
	<20190124112055.547-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99f2275f-5d9a-e4a3-ff7f-7cadd46988dd@redhat.com>
Date: Thu, 24 Jan 2019 12:40:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190124112055.547-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/6] audio: error message tweak
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
> Only print a message about the failed driver initialization in case it
> was the driver explicitly requested by the user via QEMU_AUDIO_DRV=$drv.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  audio/audio.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 1ace47f510..d163ffbc88 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1762,7 +1762,7 @@ void AUD_help (void)
>          );
>  }
>  
> -static int audio_driver_init (AudioState *s, struct audio_driver *drv)
> +static int audio_driver_init(AudioState *s, struct audio_driver *drv, bool msg)
>  {
>      if (drv->options) {
>          audio_process_options (drv->name, drv->options);
> @@ -1776,7 +1776,9 @@ static int audio_driver_init (AudioState *s, struct audio_driver *drv)
>          return 0;
>      }
>      else {
> -        dolog ("Could not init `%s' audio driver\n", drv->name);
> +        if (msg) {
> +            dolog("Could not init `%s' audio driver\n", drv->name);
> +        }
>          return -1;
>      }
>  }
> @@ -1901,7 +1903,7 @@ static void audio_init (void)
>      if (drvname) {
>          driver = audio_driver_lookup(drvname);
>          if (driver) {
> -            done = !audio_driver_init(s, driver);
> +            done = !audio_driver_init(s, driver, true);
>          } else {
>              dolog ("Unknown audio driver `%s'\n", drvname);
>              dolog ("Run with -audio-help to list available drivers\n");
> @@ -1912,14 +1914,14 @@ static void audio_init (void)
>          for (i = 0; !done && i < ARRAY_SIZE(audio_prio_list); i++) {
>              driver = audio_driver_lookup(audio_prio_list[i]);
>              if (driver && driver->can_be_default) {
> -                done = !audio_driver_init(s, driver);
> +                done = !audio_driver_init(s, driver, false);
>              }
>          }
>      }
>  
>      if (!done) {
>          driver = audio_driver_lookup("none");
> -        done = !audio_driver_init(s, driver);
> +        done = !audio_driver_init(s, driver, false);
>          assert(done);
>          dolog("warning: Using timer based audio emulation\n");
>      }
> 
