Received: from eggs.gnu.org ([2001:4830:134:3::10]:46009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj2gx-0007Tr-Ed
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj2gw-0003rN-EH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:21:59 -0400
References: <20180727081939.28185-1-ndevos@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26dfbdc3-b3f3-4532-6dbb-f25b8a6dec7a@redhat.com>
Date: Fri, 27 Jul 2018 08:21:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180727081939.28185-1-ndevos@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-3.0] block/gluster: Handle changed
 glfs_ftruncate signature
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

On 07/27/2018 03:19 AM, Niels de Vos wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> 
> New versions of Glusters libgfapi.so have an updated glfs_ftruncate()

s/Glusters/Gluster's/

> function that returns additional 'struct stat' structures to enable
> advanced caching of attributes. This is useful for file servers, not so
> much for QEMU. Nevertheless, the API has changed and needs to be
> adopted.
> 
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> Signed-off-by: Niels de Vos <ndevos@redhat.com>
> 
> ---
> v2: do a compile check as suggested by Eric Blake
> v3: define old backwards compatible glfs_ftruncate() macro, from Eric Blake
> ---
>   block/gluster.c | 11 +++++++++--
>   configure       | 18 ++++++++++++++++++
>   2 files changed, 27 insertions(+), 2 deletions(-)

Seems reasonable to get into 3.0 if we still can (for fewer platforms 
with failed builds); but not the end of the world if it slips into 3.1.

> @@ -997,6 +1001,7 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
>                                       PreallocMode prealloc, Error **errp)
>   {
>       int64_t current_length;
> +    int ret;
>   
>       current_length = glfs_lseek(fd, 0, SEEK_END);
>       if (current_length < 0) {
> @@ -1024,7 +1029,8 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
>   #endif /* CONFIG_GLUSTERFS_FALLOCATE */
>   #ifdef CONFIG_GLUSTERFS_ZEROFILL
>       case PREALLOC_MODE_FULL:
> -        if (glfs_ftruncate(fd, offset)) {
> +        ret = glfs_ftruncate(fd, offset, NULL, NULL);
> +        if (ret) {

Adding 'ret' is not strictly necessary (checking the return directly in 
the 'if' still works), but doesn't hurt. So,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
