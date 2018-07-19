Received: from eggs.gnu.org ([2001:4830:134:3::10]:43302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fgFTu-0008Oo-L1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fgFTt-0005qz-Hr
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:24:58 -0400
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bad5d90c-9d9f-8abf-35de-9c109b7772fd@redhat.com>
Date: Thu, 19 Jul 2018 16:24:46 -0400
MIME-Version: 1.0
In-Reply-To: <20180718211256.29774-1-naravamudan@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 07/18/2018 05:12 PM, Nishanth Aravamudan via Qemu-devel wrote:
> In ed6e2161 ("linux-aio: properly bubble up errors from initialzation"),
> I only added a bdrv_attach_aio_context callback for the bdrv_file
> driver. There are several other drivers that use the shared
> aio_plug callback, though, and they will trip the assertion added to
> aio_get_linux_aio because they did not call aio_setup_linux_aio first.
> Add the appropriate callback definition to the affected driver
> definitions.
> 
> Fixes: ed6e2161 ("linux-aio: properly bubble up errors from initialization")
> Reported-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  block/file-posix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 60af4b3d51..ad299beb38 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3158,6 +3158,7 @@ static BlockDriver bdrv_host_device = {
>      .bdrv_refresh_limits = raw_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
> +    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>  
>      .bdrv_co_truncate       = raw_co_truncate,
>      .bdrv_getlength	= raw_getlength,
> @@ -3280,6 +3281,7 @@ static BlockDriver bdrv_host_cdrom = {
>      .bdrv_refresh_limits = raw_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
> +    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>  
>      .bdrv_co_truncate    = raw_co_truncate,
>      .bdrv_getlength      = raw_getlength,
> @@ -3410,6 +3412,7 @@ static BlockDriver bdrv_host_cdrom = {
>      .bdrv_refresh_limits = raw_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
> +    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>  
>      .bdrv_co_truncate    = raw_co_truncate,
>      .bdrv_getlength      = raw_getlength,
> 

Seems sane to me, at a glance.

Reviewed-by: John Snow <jsnow@redhat.com>
