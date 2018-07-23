Received: from eggs.gnu.org ([2001:4830:134:3::10]:42212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbuH-0004cJ-5o
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbuG-0004JQ-Em
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:33:49 -0400
Date: Mon, 23 Jul 2018 16:33:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180723143340.GJ8817@localhost.localdomain>
References: <1531927703-9799-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531927703-9799-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix crash when reporting
 error about too many files in directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Am 18.07.2018 um 17:28 hat Thomas Huth geschrieben:
> When using the vvfat driver with a directory that contains too many files,
> QEMU currently crashes. We are trying to print the wrong path variable here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/vvfat.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index fc41841..6ae7458 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -975,8 +975,7 @@ static int init_directories(BDRVVVFATState* s,
>          if (mapping->mode & MODE_DIRECTORY) {
>              mapping->begin = cluster;
>              if(read_directory(s, i)) {
> -                error_setg(errp, "Could not read directory %s",
> -                           mapping->path);
> +                error_setg(errp, "Could not read directory \"%s\"", s->path);

Hm, I'm not sure if that's right. Before this patch we were printing
the name of the subdirectory that couldn't be loaded, now it's the
parent directory.

My test case where this difference is visible is a subdirectory with
chmod 000.

>                  return -1;
>              }
>              mapping = array_get(&(s->mapping), i);

Maybe the right solution would be moving the reloading of mapping to
between the read_directory() call and the error path?

Kevin
