Received: from eggs.gnu.org ([2001:4830:134:3::10]:60115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fih2N-0006Ut-G0
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fih2K-00086a-FB
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:14:39 -0400
References: <20180412111614.9724-1-prasanna.kalever@redhat.com>
	<20180726091907.26839-1-ndevos@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aeab9925-6dd8-bd1e-8073-7fc95b3f9c5f@redhat.com>
Date: Thu, 26 Jul 2018 09:14:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180726091907.26839-1-ndevos@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] block/gluster: defend on legacy
 ftruncate api use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

On 07/26/2018 04:19 AM, Niels de Vos wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

When sending a v2, it's best to start a new thread instead of 
in-reply-to v1, so that the automated tooling spots it easier.

Subject line is awkward, may I suggest:

block/gluster: Handle changed glfs_ftruncate signature

> 
> New versions of Glusters libgfapi.so have an updated glfs_ftruncate()
> function that returns additional 'struct stat' structures to enable
> advanced caching of attributes. This is useful for file servers, not so
> much for QEMU. Never the less, the API has changed and needs to be

s/Never the less/Nevertheless/

> adopted.
> 
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> Signed-off-by: Niels de Vos <ndevos@redhat.com>
> 
> --
> v2: do a compile check as suggested by Eric Blake
> ---
>   block/gluster.c | 15 +++++++++++++--
>   configure       | 18 ++++++++++++++++++
>   2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index 4fd55a9cc5..d1c6f81f5c 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -997,6 +997,7 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
>                                       PreallocMode prealloc, Error **errp)
>   {
>       int64_t current_length;
> +    int ret;
>   
>       current_length = glfs_lseek(fd, 0, SEEK_END);
>       if (current_length < 0) {
> @@ -1024,7 +1025,12 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
>   #endif /* CONFIG_GLUSTERFS_FALLOCATE */
>   #ifdef CONFIG_GLUSTERFS_ZEROFILL
>       case PREALLOC_MODE_FULL:
> -        if (glfs_ftruncate(fd, offset)) {
> +#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
> +        ret = glfs_ftruncate(fd, offset);
> +#else
> +        ret = glfs_ftruncate(fd, offset, NULL, NULL);
> +#endif

I'm personally a fan of minimizing in-function #ifdef, where it is easy. 
This could be done by a top-level:

#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
# define glfs_ftruncate(fd, offs, _1, _2) glfs_ftruncate(fd, offs)
#endif

then just using glfs_ftruncate(fd, offs, NULL, NULL) unconditionally in 
the rest of the file.

At any rate, the configure test looks a lot better than the v1 patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
