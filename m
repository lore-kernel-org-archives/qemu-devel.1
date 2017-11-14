Received: from eggs.gnu.org ([2001:4830:134:3::10]:34859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbMQ-0002kF-Kv
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbMP-0006ak-Ji
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:34:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEbMP-0006Za-Dj
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:34:41 -0500
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
	<20171114081654.27640.84867.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <500c71c0-931a-5483-8a00-792d3145663f@redhat.com>
Date: Tue, 14 Nov 2017 14:34:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171114081654.27640.84867.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/26] replay: fix processing async
 events
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

On 14/11/2017 09:16, Pavel Dovgalyuk wrote:
> Asynchronous events saved at checkpoints may invoke
> callbacks when processed. These callbacks may also generate/read
> new events (e.g. clock reads). Therefore event processing flag must be
> reset before callback invocation.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> ---
>  replay/replay-events.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/replay/replay-events.c b/replay/replay-events.c
> index 94a6dcc..768b505 100644
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
>      }
>  }
>  
> 

For 2.11

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
