Received: from eggs.gnu.org ([2001:4830:134:3::10]:34906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbMU-0002ml-JQ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbMS-0006dO-0j
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:34:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEbMR-0006ci-R4
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:34:43 -0500
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
	<20171114081700.27640.34609.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ceb7136-b83b-b210-c41f-acb8583f2b92@redhat.com>
Date: Tue, 14 Nov 2017 14:34:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171114081700.27640.34609.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 05/26] replay: fixed
 replay_enable_events
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

On 14/11/2017 09:17, Pavel Dovgalyuk wrote:
> This patch fixes assignment to internal events_enabled variable.
> Now it is set only in record/replay mode. This affects the behavior
> of the external functions that check this flag.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> ---
>  replay/replay-events.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/replay/replay-events.c b/replay/replay-events.c
> index 768b505..e858254 100644
> --- a/replay/replay-events.c
> +++ b/replay/replay-events.c
> @@ -67,7 +67,9 @@ static void replay_run_event(Event *event)
>  
>  void replay_enable_events(void)
>  {
> -    events_enabled = true;
> +    if (replay_mode != REPLAY_MODE_NONE) {
> +        events_enabled = true;
> +    }
>  }
>  
>  bool replay_has_events(void)
> @@ -141,7 +143,7 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
>  
>  void replay_bh_schedule_event(QEMUBH *bh)
>  {
> -    if (replay_mode != REPLAY_MODE_NONE && events_enabled) {
> +    if (events_enabled) {
>          uint64_t id = replay_get_current_step();
>          replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
>      } else {
> @@ -161,7 +163,7 @@ void replay_add_input_sync_event(void)
>  
>  void replay_block_event(QEMUBH *bh, uint64_t id)
>  {
> -    if (replay_mode != REPLAY_MODE_NONE && events_enabled) {
> +    if (events_enabled) {
>          replay_add_event(REPLAY_ASYNC_EVENT_BLOCK, bh, NULL, id);
>      } else {
>          qemu_bh_schedule(bh);
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
