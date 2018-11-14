Received: from eggs.gnu.org ([2001:4830:134:3::10]:43306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gMwVR-0005mE-2w
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gMwVQ-0007Lf-CT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:51:01 -0500
References: <20181114125546.4319-1-kwolf@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <9afd325c-5af6-e154-936e-61557d85822a@oracle.com>
Date: Wed, 14 Nov 2018 14:50:47 +0000
MIME-Version: 1.0
In-Reply-To: <20181114125546.4319-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vvfat: Fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org



On 14/11/2018 12:55, Kevin Wolf wrote:
> Don't leak 'cluster' in the mapping == NULL case. Found by Coverity
> (CID 1055918).
> 
> Fixes: 8d9401c2791ee2d2805b741b1ee3006041edcd3e
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Thanks.

> ---
>   block/vvfat.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 1de5de1db4..b7b61ea8b7 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -2510,7 +2510,7 @@ static int commit_one_file(BDRVVVFATState* s,
>       uint32_t first_cluster = c;
>       mapping_t* mapping = find_mapping_for_cluster(s, c);
>       uint32_t size = filesize_of_direntry(direntry);
> -    char* cluster = g_malloc(s->cluster_size);
> +    char *cluster;
>       uint32_t i;
>       int fd = 0;
>   
> @@ -2528,17 +2528,17 @@ static int commit_one_file(BDRVVVFATState* s,
>       if (fd < 0) {
>           fprintf(stderr, "Could not open %s... (%s, %d)\n", mapping->path,
>                   strerror(errno), errno);
> -        g_free(cluster);
>           return fd;
>       }
>       if (offset > 0) {
>           if (lseek(fd, offset, SEEK_SET) != offset) {
>               qemu_close(fd);
> -            g_free(cluster);
>               return -3;
>           }
>       }
>   
> +    cluster = g_malloc(s->cluster_size);
> +
>       while (offset < size) {
>           uint32_t c1;
>           int rest_size = (size - offset > s->cluster_size ?
> 
