Received: from eggs.gnu.org ([2001:4830:134:3::10]:44153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyMGd-00042Q-4Y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyMGc-0003i7-81
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:45:51 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-12-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33440c63-6b80-19d2-3381-f3ac0a0114e9@redhat.com>
Date: Tue, 20 Mar 2018 13:45:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 11/12] vhdx: Check for 4 GB
 maximum log size on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> It's unclear what the real maximum is, but we use an uint32_t to store
> the log size in vhdx_co_create(), so we should check that the given
> value fits in 32 bits.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/vhdx.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 0e48179b81..a1a0302799 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1829,6 +1829,10 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>       if (!vhdx_opts->has_log_size) {
>           log_size = DEFAULT_LOG_SIZE;
>       } else {
> +        if (vhdx_opts->log_size > UINT32_MAX) {
> +            error_setg(errp, "Log size must be smaller than 4 GB");
> +            return -EINVAL;
> +        }
>           log_size = vhdx_opts->log_size;
>       }
>       if (log_size < MiB || (log_size % MiB) != 0) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
