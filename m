Received: from eggs.gnu.org ([209.51.188.92]:32877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1h1LNP-0002Oa-EF
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1h1LNO-0000BT-Jd
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:29:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2181 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fangying1@huawei.com>)
	id 1h1LNN-0008UR-KQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:29:42 -0500
References: <20190305130930.24516-1-kraxel@redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <2e78c5bd-b978-42da-1272-b8ddeacfcc49@huawei.com>
Date: Wed, 6 Mar 2019 09:29:20 +0800
MIME-Version: 1.0
In-Reply-To: <20190305130930.24516-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vnc: fix update stalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 2019/3/5 21:09, Gerd Hoffmann wrote:
> vnc aborts display update jobs on video mode switches and page flips.
> That can cause vnc update stalls in case an unfinished vnc job gets
> aborted.  The vnc client will never receive the requested update then.
> Fix that by copying the state from job_update back to update in that
> case.
> 
> Reports complain about stalls with two or more clients being connected
> at the same time, on some but not all connections.  I suspect it can
> also happen with a single connection, multiple connections only make
> this more much likely to happen.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1662260
> Reported-by: Ying Fang <fangying1@huawei.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ying Fang <fangying1@huawei.com>

> ---
>  ui/vnc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index da4a21d4ce94..2f2ab62fcf71 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -700,6 +700,12 @@ static void vnc_abort_display_jobs(VncDisplay *vd)
>      }
>      QTAILQ_FOREACH(vs, &vd->clients, next) {
>          vnc_lock_output(vs);
> +        if (vs->update == VNC_STATE_UPDATE_NONE &&
> +            vs->job_update != VNC_STATE_UPDATE_NONE) {
> +            /* job aborted before completion */
> +            vs->update = vs->job_update;
> +            vs->job_update = VNC_STATE_UPDATE_NONE;
> +        }
>          vs->abort = false;
>          vnc_unlock_output(vs);
>      }
> 
