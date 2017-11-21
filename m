Received: from eggs.gnu.org ([2001:4830:134:3::10]:60943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH5tc-0003S1-5T
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH5tZ-0006Tu-02
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:35:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eH5tY-0006TA-QX
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:35:12 -0500
Date: Tue, 21 Nov 2017 11:35:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121113506.78788104.cohuck@redhat.com>
In-Reply-To: <1510854715-7081-2-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-2-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/7] s390x/pci: factor out endianess
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

On Thu, 16 Nov 2017 18:51:49 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> There are two places where the same endianness conversion
> is done.
> Let's factor this out into a static function.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>

Your two s-o-bs look a bit odd...

> ---
>  hw/s390x/s390-pci-inst.c | 59 +++++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 8e088f3..ded1556 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -314,6 +314,36 @@ out:
>      return 0;
>  }
>  
> +/**
> + * This function is called when endianess is fixed, whatever the host endianess
> + * is, like in our case from s390x BIG endian registers to little endian PCI
> + * Bars, to translate the uint64_t pointed from one endianess to the other.

I would rephrase this a bit:

"Swap data contained in s390x big endian registers to little endian PCI
bars."

That makes it clear that this function is for a specialized use case.

> + *
> + * @ptr: a pointer to a uint64_t data field
> + * @len: the length of the valid data, must be 1,2,4 or 8
> + */
> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
> +{
> +    uint64_t data = *ptr;

Please add an extra empty line.

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
>  int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>  {
>      CPUS390XState *env = &cpu->env;

Other than the nits above, looks good.
