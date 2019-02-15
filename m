Received: from eggs.gnu.org ([209.51.188.92]:48689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gubh9-0001L9-PZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gubh9-0006Ht-1i
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:30:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gubh8-0006Fk-S3
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:30:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so9934086wrn.11
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:30:14 -0800 (PST)
References: <20190214185351.5927-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55487011-3538-f64e-0972-52a0a01a315e@redhat.com>
Date: Fri, 15 Feb 2019 12:30:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190214185351.5927-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Fix qemu_rdma_cleanup null
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org

On 2/14/19 7:53 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> If the migration fails before the channel is open (e.g. a bad
> address) we end up in the cleanup with rdma->channel==NULL.
> 
> Spotted by Coverity: CID 1398634
> Fixes: fbbaacab2758cb3f32a0
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/rdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 54a3c11540..9fa3b176eb 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2321,7 +2321,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>          rdma->connected = false;
>      }
>  
> -    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> +    if (rdma->channel) {
> +        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> +    }
>      g_free(rdma->dest_blocks);
>      rdma->dest_blocks = NULL;
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
