Received: from eggs.gnu.org ([2001:4830:134:3::10]:38446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekALV-000880-Kh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekALU-0000HQ-RN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:12:13 -0500
Date: Fri, 9 Feb 2018 16:12:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209151201.GI3998@localhost.localdomain>
References: <1518172615-1260-1-git-send-email-sarna@skytechnology.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518172615-1260-1-git-send-email-sarna@skytechnology.pl>
Subject: Re: [Qemu-devel] [PATCH v3] block: unify blocksize types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Piotr Sarna <sarna@skytechnology.pl>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, mreitz@redhat.com

Am 09.02.2018 um 11:36 hat Piotr Sarna geschrieben:
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
>  hw/core/qdev-properties.c    | 12 ++++++------
>  include/hw/block/block.h     |  4 ++--
>  include/hw/qdev-properties.h |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5bbc2d9..c4a1b8f 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -728,17 +728,17 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
>  {
>      DeviceState *dev = DEVICE(obj);
>      Property *prop = opaque;
> -    uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t value, *ptr = qdev_get_prop_ptr(dev, prop);
>      Error *local_err = NULL;
>      const int64_t min = 512;
> -    const int64_t max = 32768;
> +    const int64_t max = 2147483648;

Please see my reply to the v1 patch, this breaks IDE at least.

Kevin
