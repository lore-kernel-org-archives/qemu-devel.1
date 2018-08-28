Received: from eggs.gnu.org ([2001:4830:134:3::10]:44032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fug0z-0007LI-T1
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fufqR-0003U2-5r
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:23:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.vnet.ibm.com>)
	id 1fufqQ-0003Tj-TJ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:23:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7SFKbwB070771
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 11:23:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m585dahtq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 11:23:49 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.vnet.ibm.com>;
	Tue, 28 Aug 2018 16:23:47 +0100
References: <153537327445.92657.5884855110375406189.stgit@lep8c.aus.stglabs.ibm.com>
	<9ab7a80d-9289-2d65-9d87-238cfa69f456@vivier.eu>
From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Date: Tue, 28 Aug 2018 20:53:42 +0530
MIME-Version: 1.0
In-Reply-To: <9ab7a80d-9289-2d65-9d87-238cfa69f456@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <901aa049-0acf-0f6b-4257-9d785713d2cd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: elf: mmap all the target-pages
 of hostpage for data segment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 08/27/2018 06:55 PM, Laurent Vivier wrote:
> Le 27/08/2018 =C3=A0 14:37, Shivaprasad G Bhat a =C3=A9crit=C2=A0:
>> If the hostpage size is greater than the TARGET_PAGESIZE, the
>> target-pages of size TARGET_PAGESIZE are marked valid only till the
>> length requested during the elfload. The glibc attempts to consume unu=
sed
>> space in the last page of data segment(__libc_memalign() in
>> elf/dl-minimal.c). The GLRO(dl_pagesize) is actually the host pagesize=
 as
>> set in the auxillary vectors. So, there is no explicit mmap request fo=
r
>> the remaining target-pages on the last hostpage. The glibc assumes tha=
t
>> particular space as available and subsequent attempts to use
>> those addresses lead to crash as the target_mmap has not marked them v=
alid
>> for those target-pages.
>>
>> The issue is seen when trying to chroot to 16.04-x86_64 ubuntu on a PP=
C64
>> host where the fork fails to access the thread_id as it is allocated o=
n a
>> page not marked valid. The recent glibc doesnt have checks for thread-=
id in
>> fork, but the issue can manifest somewhere else, none the less.
>>
>> The fix here is to map all the target-pages of the hostpage during the
>> ELF load for data segment to allow the glibc for proper consumption.
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
>> ---
>>   linux-user/elfload.c |   24 +++++++++++++++++-------
>>   1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 8638612aec..1d86034c8d 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -1438,9 +1438,17 @@ struct exec
>>  =20
>>   /* Necessary parameters */
>>   #define TARGET_ELF_EXEC_PAGESIZE TARGET_PAGE_SIZE
>> -#define TARGET_ELF_PAGESTART(_v) ((_v) & \
>> -                                 ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZ=
E-1))
>> -#define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1=
))
>> +#define TARGET_ELF_PAGESTART(_v, _s) \
>> +        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
>> +         (_v) & ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE - 1) : \
>> +         (_v) & ~(abi_ulong)(_s - 1));
>> +#define TARGET_ELF_PAGEOFFSET(_v, _s) \
>> +        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
>> +         (_v) & (TARGET_ELF_EXEC_PAGESIZE - 1) : \
>> +         (_v) & (_s - 1));
>> +#define TARGET_ELF_PAGELENGTH(_v, _s) \
>> +        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
>> +         TARGET_PAGE_ALIGN(_v) : HOST_PAGE_ALIGN(_v));
> I think it's only possible if the PT_LOAD p_align value is greater or
> equal to qemu_host_page_size.
>
> See 33143c446e ("linux-user: fix ELF load alignment error").
>
> You could check this with qemu-s390x or qemu-arm on ppc64 host.
Ah, right! I should have added the extra conditional to check the=20
p_align with qemu_host_page_mask
along with the existing ones.

Posted the v2 accordingly.

Thanks and Regards,
Shivaprasad

> Thanks,
> Laurent
>
