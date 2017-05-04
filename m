Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6E24-000182-4j
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6E20-0004gl-Hd
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6E20-0004fb-B7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:30:44 -0400
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084159.7488.97487.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <45373040-0232-a324-5965-2a70d17e5c08@redhat.com>
Date: Thu, 4 May 2017 12:30:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170504084159.7488.97487.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 04/10] replay: fix processing async
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 04/05/2017 10:41, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> Asynchronous events saved at checkpoints may invoke
> callbacks when processed. These callbacks may also generate/read
> new events (e.g. clock reads). Therefore event processing flag must be
> reset before callback invocation.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  replay/replay-events.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/replay/replay-events.c b/replay/replay-events.c
> index 94a6dcccfc..768b505f3d 100644
> --- a/replay/replay-events.c
> +++ b/replay/replay-events.c
> @@ -295,13 +295,13 @@ void replay_read_events(int checkpoint)
>          if (!event) {
>              break;
>          }
> +        replay_finish_event();
> +        read_event_kind = -1;
>          replay_mutex_unlock();
>          replay_run_event(event);
>          replay_mutex_lock();
>  
>          g_free(event);
> -        replay_finish_event();
> -        read_event_kind = -1;

While at it, g_free can be moved outside the lock.

Also, replay_flush_events and replay_save_events are leaving the event
in events_list while releasing the lock, and only doing QTAILQ_REMOVE
after taking it back.  This can cause events to be processed twice.

I think it is worth fixing all of these.

Paolo

>      }
>  }
>  
> 
