Received: from eggs.gnu.org ([2001:4830:134:3::10]:40788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyM69-0007nM-N3
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyM68-0005gv-Ql
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:35:01 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-8-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31ee5185-a503-5b51-0343-68dcdb0e28ad@redhat.com>
Date: Tue, 20 Mar 2018 13:34:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 07/12] parallels: Check maximum
 cluster size on create
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
> It's unclear what the real maximum cluster size is for the Parallels
> format, but let's at least make sure that we don't get integer
> overflows in our .bdrv_co_create implementation.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/parallels.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 2da5e56a9d..e4ca018c2e 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -526,6 +526,11 @@ static int coroutine_fn parallels_co_create(BlockdevCreateOptions* opts,
>           cl_size = DEFAULT_CLUSTER_SIZE;
>       }
>   
> +    /* XXX What is the real limit here? This is an insanely large maximum. */
> +    if (cl_size >= UINT64_MAX / MAX_PARALLELS_IMAGE_FACTOR) {

INT64_MAX is probably a saner starting point for the division...

> +        error_setg(errp, "Cluster size is too large");
> +        return -EINVAL;
> +    }
>       if (total_size >= MAX_PARALLELS_IMAGE_FACTOR * cl_size) {

since total_size still has to fit within off_t (63 bits, not 64)

>           error_setg(errp, "Image size is too large for this cluster size");
>           return -E2BIG;
> 

With that change,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
