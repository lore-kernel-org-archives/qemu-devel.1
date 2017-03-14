Received: from eggs.gnu.org ([2001:4830:134:3::10]:37653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cniyk-0004Bf-3R
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cniyj-0002xj-A1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:42:54 -0400
Date: Tue, 14 Mar 2017 17:42:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170314094245.GA8399@lemon.lan>
References: <20170314090922.28083-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314090922.28083-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: clean up max_segments buffer
 termination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Tue, 03/14 17:09, Stefan Hajnoczi wrote:
> The following pattern is unsafe:
> 
>   char buf[32];
>   ret = read(fd, buf, sizeof(buf));
>   ...
>   buf[ret] = 0;
> 
> If read(2) returns 32 then a byte beyond the end of the buffer is
> zeroed.
> 
> In practice this buffer overflow does not occur because the sysfs
> max_segments file only contains an unsigned short + '\n'.  The string is
> always shorter than 32 bytes.
> 
> Regardless, avoid this pattern because static analysis tools might
> complain and it could lead to real buffer overflows if copy-pasted
> elsewhere in the codebase.

Yes that's a good point, thanks!

Fam

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index c4c0663..ac6bd9f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -686,7 +686,7 @@ static int hdev_get_max_segments(const struct stat *st)
>          goto out;
>      }
>      do {
> -        ret = read(fd, buf, sizeof(buf));
> +        ret = read(fd, buf, sizeof(buf) - 1);
>      } while (ret == -1 && errno == EINTR);
>      if (ret < 0) {
>          ret = -errno;
> -- 
> 2.9.3
> 
