Received: from eggs.gnu.org ([2001:4830:134:3::10]:46717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMvDt-0007rl-0c
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMvDq-00063m-Ne
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:28:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMvDh-0005lJ-Py
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:28:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id e3-v6so17316095wrs.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:28:32 -0800 (PST)
References: <20181114125546.4319-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6dfb7997-3fe3-0c52-adff-f417714c5414@redhat.com>
Date: Wed, 14 Nov 2018 14:28:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181114125546.4319-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

On 14/11/18 13:55, Kevin Wolf wrote:
> Don't leak 'cluster' in the mapping == NULL case. Found by Coverity
> (CID 1055918).
> 
> Fixes: 8d9401c2791ee2d2805b741b1ee3006041edcd3e
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
