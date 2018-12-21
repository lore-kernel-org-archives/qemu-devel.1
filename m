Received: from eggs.gnu.org ([2001:4830:134:3::10]:56048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaNPb-0001KI-Pc
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaNPX-0001V7-Hi
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:12:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gaNPU-0001Ns-1K
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:12:25 -0500
Date: Fri, 21 Dec 2018 11:12:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181221111136-mutt-send-email-mst@kernel.org>
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-3-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544063533-10139-3-git-send-email-lizhijian@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 2/4] refactor load_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com, philmd@redhat.com

On Thu, Dec 06, 2018 at 10:32:11AM +0800, Li Zhijian wrote:
> Don't expect read(2) can always read as many as it's told.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This is more a theoretical bugfix than a refactoring right?

> ---
> V4: add reviewed-by tag
> ---
>  hw/core/loader.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index fa41842..9cbceab 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -77,21 +77,20 @@ int64_t get_image_size(const char *filename)
>  ssize_t load_image_size(const char *filename, void *addr, size_t size)
>  {
>      int fd;
> -    ssize_t actsize;
> +    ssize_t actsize, l = 0;
>  
>      fd = open(filename, O_RDONLY | O_BINARY);
>      if (fd < 0) {
>          return -1;
>      }
>  
> -    actsize = read(fd, addr, size);
> -    if (actsize < 0) {
> -        close(fd);
> -        return -1;
> +    while ((actsize = read(fd, addr + l, size - l)) > 0) {
> +        l += actsize;
>      }
> +
>      close(fd);
>  
> -    return actsize;
> +    return actsize < 0 ? -1 : l;
>  }
>  
>  /* read()-like version */
> -- 
> 2.7.4
