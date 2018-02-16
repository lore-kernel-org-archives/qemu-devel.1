Received: from eggs.gnu.org ([2001:4830:134:3::10]:37314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emd0p-0007QS-Or
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emd0m-0003To-J9
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:13:03 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1518169992-19288-1-git-send-email-sarna@skytechnology.pl>
References: <1518169992-19288-1-git-send-email-sarna@skytechnology.pl>
Date: Fri, 16 Feb 2018 11:12:21 +0100
Message-ID: <w51y3jtkzui.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] block: unify blocksize
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Piotr Sarna <sarna@skytechnology.pl>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Fri 09 Feb 2018 10:53:12 AM CET, Piotr Sarna wrote:
> BlockSizes structure used in block size probing has uint32_t types
> for logical and physical sizes. These fields are wrongfully assigned
> to uint16_t in BlockConf, which results, among other errors,
> in assigning 0 instead of 65536 (which will be the case in at least
> future LizardFS block device driver among other things).
>
> This commit makes BlockConf's physical_block_size and logical_block_size
> fields uint32_t to avoid inconsistencies.
>
> Signed-off-by: Piotr Sarna <sarna@skytechnology.pl>
> ---
>  hw/core/qdev-properties.c    | 10 +++++-----
>  include/hw/block/block.h     |  4 ++--
>  include/hw/qdev-properties.h |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5bbc2d9..1400ba5 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -731,14 +731,14 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
>      uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
>      Error *local_err = NULL;
>      const int64_t min = 512;
> -    const int64_t max = 32768;
> +    const int64_t max = 2147483648;
>  
>      if (dev->realized) {
>          qdev_prop_set_after_realize(dev, name, errp);
>          return;
>      }
>  
> -    visit_type_uint16(v, name, &value, &local_err);
> +    visit_type_uint32(v, name, &value, &local_err);

I'm not familiar with this code so apologies if there's something that I
have overlooked, but it catches my attention that

   a) you're using 2147483648 as an upper limit, that's INT32_MAX + 1.
      Where does that value come from? It's certainly not the highest
      value that a uint32_t can hold, and it doesn't fit in an int32_t
      either.

   b) you're using visit_type_uint32() but the 'value' you're passing is
      a uint16_t (also *ptr later in the same function).

Berto
