Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCpqH-0005Y8-HP
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCpqC-0003pB-F8
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:38:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eCpqC-0003oq-8m
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:38:08 -0500
Date: Thu, 9 Nov 2017 17:38:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171109173802.7a43dcc3.cohuck@redhat.com>
In-Reply-To: <1510075479-17224-2-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-2-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] s390x/pci: factor out endianess
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Tue,  7 Nov 2017 18:24:33 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> There are two places where the same endianness conversion
> is done.
> Let's factor this out into a static function.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 58 ++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 8e088f3..8fcb02d 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -314,6 +314,35 @@ out:
>      return 0;
>  }
>  
> +/**
> + * This function swaps the data at ptr according from one
> + * endianness to the other.
> + * valid data in the uint64_t data field.

I'm not sure what that line is supposed to mean?

> + * @ptr: a pointer to a uint64_t data field
> + * @len: the length of the valid data, must be 1,2,4 or 8
> + */
> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
> +{
> +    uint64_t data = *ptr;
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
> +

I was expecting more code to use a similar pattern, but it seems
surprisingly uncommon.
