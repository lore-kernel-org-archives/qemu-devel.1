Received: from eggs.gnu.org ([2001:4830:134:3::10]:36623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1exx6Q-00067f-Bb
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1exx6L-0006QJ-07
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:53:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1exx6K-0006Q3-R2
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:53:32 -0400
References: <20180319092505.20283.81523.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3499e1d7-03fd-21b7-16a6-2cfa42703e59@redhat.com>
Date: Mon, 19 Mar 2018 16:53:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180319092505.20283.81523.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] replay: finish record/replay before
 closing the disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru

On 19/03/2018 10:25, Pavel Dovgalyuk wrote:
> After recent updates block devices cannot be closed on qemu exit.
> This happens due to the block request polling when replay is not finished.
> Therefore now we stop execution recording before closing the block devices.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  replay/replay.c |    2 ++
>  vl.c            |    1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/replay/replay.c b/replay/replay.c
> index 8228261..58a986f 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -366,6 +366,8 @@ void replay_finish(void)
>      g_free(replay_snapshot);
>      replay_snapshot = NULL;
>  
> +    replay_mode = REPLAY_MODE_NONE;
> +
>      replay_finish_events();
>  }
>  
> diff --git a/vl.c b/vl.c
> index e8bebda..f4d9153 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4733,6 +4733,7 @@ int main(int argc, char **argv, char **envp)
>  
>      /* No more vcpu or device emulation activity beyond this point */
>      vm_shutdown();
> +    replay_finish();
>  
>      bdrv_close_all();
>  
> 

Queued, thanks.

Paolo
