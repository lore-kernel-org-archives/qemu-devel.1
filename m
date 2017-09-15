Received: from eggs.gnu.org ([2001:4830:134:3::10]:36896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsqAu-0001ML-4s
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsqAp-0005gE-6m
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:56:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dsqAo-0005fN-Sv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:56:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8FCsR60006746
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:56:45 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d0cn37qte-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:56:45 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 15 Sep 2017 08:56:44 -0400
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
	<f6c9e7ec8ad585ce7c8f401aae2ec1fddf157fd7.1505403478.git.alifm@linux.vnet.ibm.com>
	<1505460680.18776.1.camel@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 15 Sep 2017 08:56:41 -0400
MIME-Version: 1.0
In-Reply-To: <1505460680.18776.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <2d100ec2-a09b-159c-5d8e-68b2a845b36a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] virtio-gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com



On 09/15/2017 03:31 AM, Gerd Hoffmann wrote:
>   Hi,
>
>> +static void
>> +virtio_gpu_ctrl_hdr_bswap_cpu(struct virtio_gpu_ctrl_hdr *hdr)
>> +{
>> +    hdr->type =  le32_to_cpu(hdr->type);
>> +    hdr->flags = le32_to_cpu(hdr->flags);
>> +    hdr->fence_id = le64_to_cpu(hdr->fence_id);
>> +    hdr->ctx_id = le32_to_cpu(hdr->ctx_id);
>> +    hdr->padding = le32_to_cpu(hdr->padding);
>> +}
>> +
>> +static void
>> +virtio_gpu_ctrl_hdr_bswap_le(struct virtio_gpu_ctrl_hdr *hdr)
>> +{
>> +    hdr->type =  cpu_to_le32(hdr->type);
>> +    hdr->flags = cpu_to_le32(hdr->flags);
>> +    hdr->fence_id = cpu_to_le64(hdr->fence_id);
>> +    hdr->ctx_id = cpu_to_le32(hdr->ctx_id);
>> +    hdr->padding = cpu_to_le32(hdr->padding);
>> +}
>
> These two functions do exactly the same thing because cpu_to_le32 and
> le32_to_cpu are the same operation.  The two variants only exist to
> make the code more readable.  So this isn't needed twice.  I'd suggest
> to just call the functions "*_bswap" and drop any _le or _cpu postfix.
> Note that there are also variants for in-place swapping.
>
> Have a look at the comments in include/qemu/bswap.h
>
Thanks for pointing that out. I will re-spin another version.

>> +
>> +static void virtio_gpu_bswap_cpu_32(void *ptr,
>> +                                    size_t size)
>> +{
>
> #ifdef HOST_WORDS_BIGENDIAN
>
>> +    size_t i;
>> +    struct virtio_gpu_ctrl_hdr *hdr = (struct virtio_gpu_ctrl_hdr *)
>> ptr;
>> +
>> +    virtio_gpu_ctrl_hdr_bswap_cpu(hdr);
>> +
>> +    i = sizeof(struct virtio_gpu_ctrl_hdr);
>> +    while (i < size) {
>> +        *(uint32_t *)(ptr + i) = le32_to_cpu(*(uint32_t *)(ptr +
>> i));
>> +        i = i + sizeof(uint32_t);
>> +    }
>
> #endif
>
> I suspect the compiler isn't clever enough to figure the whole function
> is a nop on little endian hosts.

This makes sense.

Thanks
Farhan
>
> cheers,
>   Gerd
>
