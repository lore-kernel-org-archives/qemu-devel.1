Received: from eggs.gnu.org ([2001:4830:134:3::10]:42947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2OW-0001HV-DE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2OV-0002Sa-C2
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:32 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2OV-0002SD-4k
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:31 -0400
Received: by mail-ot0-x242.google.com with SMTP id w4-v6so1772814ote.12
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:22:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1488382850-19252-2-git-send-email-kraxel@redhat.com>
References: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
	<1488382850-19252-2-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:22:10 +0100
Message-ID: <CAFEAcA828YS+TfiiCfgAM6WMrSr1PGrTBgHrL0NNiw87LW+Mzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 1/3] replay: add record/replay for audio
 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

On 1 March 2017 at 15:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>
> This patch adds recording and replaying audio data. Is saves synchronization
> information for audio out and inputs from the microphone.
>
> v2: removed unneeded whitespace change
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Message-id: 20170202055054.4848.94901.stgit@PASHA-ISP.lan02.inno
>
> [ kraxel: add qemu/error-report.h include to fix osx build failure ]
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  audio/audio.c            |  9 ++++--
>  audio/audio.h            |  5 +++
>  audio/mixeng.c           | 32 ++++++++++++++++++++
>  docs/replay.txt          |  7 +++++
>  include/sysemu/replay.h  |  7 +++++
>  replay/Makefile.objs     |  1 +
>  replay/replay-audio.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h |  4 +++
>  8 files changed, 142 insertions(+), 2 deletions(-)
>  create mode 100644 replay/replay-audio.c
>
> diff --git a/audio/audio.c b/audio/audio.c
> index c845a44..21f7b0b 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -28,6 +28,7 @@
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/cutils.h"
> +#include "sysemu/replay.h"
>
>  #define AUDIO_CAP "audio"
>  #include "audio_int.h"
> @@ -1387,6 +1388,7 @@ static void audio_run_out (AudioState *s)
>
>          prev_rpos = hw->rpos;
>          played = hw->pcm_ops->run_out (hw, live);
> +        replay_audio_out(&played);
>          if (audio_bug (AUDIO_FUNC, hw->rpos >= hw->samples)) {
>              dolog ("hw->rpos=%d hw->samples=%d played=%d\n",
>                     hw->rpos, hw->samples, played);

Hi. Coverity produces a new warning because of this change (CID1390632),
because it treats the replay file as "tainted data", and complains
that we trust a value from the file to become a sample count
passed to audio_capture_mix_and_clear() and eventually used as
a byte count for a memset.

Do we trust the replay file to be non-malicious (making this
a false-positive), or not (in which case we need to sanitize
or check its contents somehow) ?

thanks
-- PMM
