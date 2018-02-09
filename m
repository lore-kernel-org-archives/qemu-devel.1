Received: from eggs.gnu.org ([2001:4830:134:3::10]:47911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAwY-0008NE-FN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAwX-00073U-Mz
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:50:30 -0500
References: <1518172615-1260-1-git-send-email-sarna@skytechnology.pl>
From: Eric Blake <eblake@redhat.com>
Message-ID: <942cb943-c794-cc7f-4c6c-6123cca369a6@redhat.com>
Date: Fri, 9 Feb 2018 09:50:08 -0600
MIME-Version: 1.0
In-Reply-To: <1518172615-1260-1-git-send-email-sarna@skytechnology.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] block: unify blocksize types
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

On 02/09/2018 04:36 AM, Piotr Sarna wrote:
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

> -    const int64_t max = 32768;
> +    const int64_t max = 2147483648;
>   

> @@ -762,9 +762,9 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
>   }
>   
>   const PropertyInfo qdev_prop_blocksize = {
> -    .name  = "uint16",
> -    .description = "A power of two between 512 and 32768",
> -    .get   = get_uint16,
> +    .name  = "uint32",
> +    .description = "A power of two between 512 and 2147483648",
> +    .get   = get_uint32,

I can understand a block size larger than 16 bits, but all the way up to 
2G seems rather perverse (as we have to perform read-modify-write on 
anything that is smaller than the blocksize, and that adds 4G of 
overhead for a blocksize of 2G).  Would it be better to cap this at 1M 
for now?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
