Received: from eggs.gnu.org ([2001:4830:134:3::10]:54103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cvqTt-0003Nx-Gg
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cvqTs-0000Ai-LQ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:20:37 -0400
References: <cover.1491416061.git.jcody@redhat.com>
	<6c82b83fae72a5b5909993f0cf65a90f12efb669.1491416061.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4a5f39ab-50ad-6071-130a-fe77493221ec@redhat.com>
Date: Wed, 5 Apr 2017 15:20:24 -0400
MIME-Version: 1.0
In-Reply-To: <6c82b83fae72a5b5909993f0cf65a90f12efb669.1491416061.git.jcody@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/9] block: honor
 BDRV_O_ALLOW_RDWR when clearing bs->read_only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org



On 04/05/2017 02:28 PM, Jeff Cody wrote:
> The BDRV_O_ALLOW_RDWR flag allows / prohibits the changing of
> the BDS 'read_only' state, but there are a few places where it
> is ignored.  In the bdrv_set_read_only() helper, make sure to
> honor the flag.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block.c b/block.c
> index f60d5ea..4a61ff0 100644
> --- a/block.c
> +++ b/block.c
> @@ -201,6 +201,13 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
>          return -EINVAL;
>      }
>  
> +    /* Do not clear read_only if it is prohibited */
> +    if (!read_only && !(bs->open_flags & BDRV_O_ALLOW_RDWR)) {
> +        error_setg(errp, "Node '%s' is read only",
> +                   bdrv_get_device_or_node_name(bs));
> +        return -EPERM;
> +    }
> +
>      bs->read_only = read_only;
>      return 0;
>  }
> 

Conceptually straightforward.

looks like this might change behavior for... RBD and vvfat, right?
RBD is the subject of this series so we'll just assume that was broken
and stupid.

What's vvfat's story? It always set the read-only property to false
regardless of what you asked for?
