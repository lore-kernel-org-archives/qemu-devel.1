Received: from eggs.gnu.org ([2001:4830:134:3::10]:37017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7yC3-0004tk-AZ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 03:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7yC2-0004iN-66
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 03:37:07 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1532433124-25881-1-git-send-email-thuth@redhat.com>
Message-ID: <2c5507d4-5cf3-58f7-25f5-f0e6fb34eadb@redhat.com>
Date: Thu, 4 Oct 2018 09:36:46 +0200
MIME-Version: 1.0
In-Reply-To: <1532433124-25881-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] block/vvfat: Fix crash when reporting
 error about too many files in directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2018-07-24 13:52, Thomas Huth wrote:
> When using the vvfat driver with a directory that contains too many files,
> QEMU currently crashes. This can be triggered like this for example:
> 
>  mkdir /tmp/vvfattest
>  cd /tmp/vvfattest
>  for ((x=0;x<=513;x++)); do mkdir $x; done
>  qemu-system-x86_64 -drive \
>    file.driver=vvfat,file.dir=.,read-only=on,media=cdrom
> 
> Seems like read_directory() is changing the mapping->path variable. Make
> sure we use the right pointer instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/vvfat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index fc41841..f2e7d50 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -973,10 +973,10 @@ static int init_directories(BDRVVVFATState* s,
>          mapping = array_get(&(s->mapping), i);
>  
>          if (mapping->mode & MODE_DIRECTORY) {
> +            char *path = mapping->path;
>              mapping->begin = cluster;
>              if(read_directory(s, i)) {
> -                error_setg(errp, "Could not read directory %s",
> -                           mapping->path);
> +                error_setg(errp, "Could not read directory %s", path);
>                  return -1;
>              }
>              mapping = array_get(&(s->mapping), i);
> 

Ping?
