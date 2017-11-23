Received: from eggs.gnu.org ([2001:4830:134:3::10]:47587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnBj-0002XP-Fa
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnBe-000653-Ks
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:48:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eHnBe-00064h-Ee
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:48:46 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3acc6fdb-5638-97b2-2dc7-bce34d22cd1f@redhat.com>
Date: Thu, 23 Nov 2017 09:48:41 +0100
MIME-Version: 1.0
In-Reply-To: <1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] s390x/pci: factor out endianess
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de

On 22.11.2017 23:05, Pierre Morel wrote:
> There are two places where the same endianness conversion
> is done.
> Let's factor this out into a static function.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 59 +++++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 8e088f3..3e1f1a0 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -314,6 +314,36 @@ out:
>      return 0;
>  }
>  
> +/**
> + * Swap data contained in s390x big endian registers to little endian
> + * PCI bars.
> + *
> + * @ptr: a pointer to a uint64_t data field
> + * @len: the length of the valid data, must be 1,2,4 or 8
> + */
> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
> +{
> +    uint64_t data = *ptr;
> +
> +    switch (len) {
> +    case 1:
> +        break;
> +    case 2:
> +        data = bswap16(data);
> +        break;
> +    case 4:
> +        data = bswap32(data);
> +        break;
> +    case 8:
> +        data = bswap64(data);
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +    *ptr = data;
> +    return 0;
> +}

While you're at it, I think that should rather be leXX_to_cpu() instead
of bswapXX() here, though I'm not 100% sure, and we still can also fix
that later, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
