Received: from eggs.gnu.org ([2001:4830:134:3::10]:48806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZc6y-0002vV-MG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZc6v-0001RK-Gt
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:37:36 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZc6v-0001QD-88
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:37:33 -0500
Received: by mail-lf0-x242.google.com with SMTP id e203so2622806lfg.3
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 04:37:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<20180111082744.27295.25934.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <621213e6-91cc-908e-225f-efb898bb6747@redhat.com>
Date: Thu, 11 Jan 2018 13:37:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180111082744.27295.25934.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 30/30] replay: don't process async
 events when warping the clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 11/01/2018 09:27, Pavel Dovgalyuk wrote:
> Virtual clock is wapred from iothread and vcpu thread. When the hardware
> events associated with warp checkpoint, then interrupt delivering may be
> non-deterministic if checkpoint is processed in different threads in record
> and replay.
> This patch disables event processing for clock warp checkpoint and leaves
> all hardware events to other checkpoints (e.g., virtual clock).
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  replay/replay.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/replay/replay.c b/replay/replay.c
> index b9c496a..cc43c38 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -211,7 +211,12 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
>      } else if (replay_mode == REPLAY_MODE_RECORD) {
>          g_assert(replay_mutex_locked());
>          replay_put_event(EVENT_CHECKPOINT + checkpoint);
> -        replay_save_events(checkpoint);
> +        /* This checkpoint belongs to several threads.
> +           Processing events from different threads is
> +           non-deterministic */
> +        if (checkpoint != CHECKPOINT_CLOCK_WARP_START) {
> +            replay_save_events(checkpoint);
> +        }
>          res = true;
>      }
>  out:
> 

Please add an assertion in replay_read_event that the read_checkpoint is
never CHECKPOINT_CLOCK_WARP_START.  Why is the checkpoint still needed?

Thanks,

Paolo
