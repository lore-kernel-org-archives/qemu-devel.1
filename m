Received: from eggs.gnu.org ([2001:4830:134:3::10]:42497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCrzW-0004M3-Os
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCrzT-000290-Mg
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:55:54 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:50601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCrzT-00028l-Hu
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:55:51 -0500
Received: by mail-qk0-x241.google.com with SMTP id p7so8986036qkd.7
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 10:55:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109173802.7a43dcc3.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <92ed4a36-5db9-9f76-069f-cd663bbe8aee@amsat.org>
Date: Thu, 9 Nov 2017 15:55:46 -0300
MIME-Version: 1.0
In-Reply-To: <20171109173802.7a43dcc3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de

On 11/09/2017 01:38 PM, Cornelia Huck wrote:
> On Tue,  7 Nov 2017 18:24:33 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> 
>> There are two places where the same endianness conversion
>> is done.
>> Let's factor this out into a static function.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/s390-pci-inst.c | 58 ++++++++++++++++++++++++++----------------------
>>  1 file changed, 32 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 8e088f3..8fcb02d 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -314,6 +314,35 @@ out:
>>      return 0;
>>  }
>>  
>> +/**
>> + * This function swaps the data at ptr according from one
>> + * endianness to the other.
>> + * valid data in the uint64_t data field.
> 
> I'm not sure what that line is supposed to mean?
> 
>> + * @ptr: a pointer to a uint64_t data field
>> + * @len: the length of the valid data, must be 1,2,4 or 8
>> + */
>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>> +{
>> +    uint64_t data = *ptr;
>> +    switch (len) {
>> +    case 1:
>> +        break;
>> +    case 2:
>> +        data = bswap16(data);
>> +        break;
>> +    case 4:
>> +        data = bswap32(data);
>> +        break;
>> +    case 8:
>> +        data = bswap64(data);
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +    *ptr = data;
>> +    return 0;
>> +}

This is usually care taken by memory::adjust_endianness() ...

> I was expecting more code to use a similar pattern, but it seems
> surprisingly uncommon.

Which ring a bell for latent bug?

This remind me of a similar issue on ppc:

http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05121.html
...
http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05666.html
