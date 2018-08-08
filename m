Received: from eggs.gnu.org ([2001:4830:134:3::10]:38885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnK8h-0001hB-HX
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnK8e-0001ku-Ao
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:48:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fnK8e-0001kc-3k
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:48:16 -0400
References: <40d9df00-f80d-02a4-58ec-b407e7dd8cdb@redhat.com>
	<da05f804-31f4-e820-12ed-22a240bf2d07@ilande.co.uk>
	<CACXAS8CE9OZ+bxOUQCjDVedqGNUXMRvDWfCWmhf4jqeVzLVGZA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0c11695e-88b9-29f0-caf5-d06612ff49bd@redhat.com>
Date: Wed, 8 Aug 2018 10:48:13 +0200
MIME-Version: 1.0
In-Reply-To: <CACXAS8CE9OZ+bxOUQCjDVedqGNUXMRvDWfCWmhf4jqeVzLVGZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] valgrind problem in sun4u_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 06/19/2018 10:03 AM, Artyom Tarasenko wrote:
> On Sun, Jun 17, 2018 at 12:22 PM, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> On 15/06/18 11:37, Thomas Huth wrote:
>>
>>>   Hi Mark, hi Artyom,
>>>
>>> while using valgrind to fix some issues with the rom_ptr() function
>>> today, I noticed that there is one more problem in sun4u_load_kernel():
>>> The kernel_top variable can be used uninitialized in some cases:
>>> If load_elf() fails and the kernel is loaded via load_aout() or
>>> load_image_targphys(), the kernel_top variable is never set to a valid
>>> value. This could cause some trouble when loading the initrd later. When
>>> you've got some spare time, could you please have a look?
>>
>>
>> Hmmm that's an interesting one - I'm not immediately aware of any 64-bit
>> kernels that are a.out rather than ELF, so I wonder if this has been used to
>> run a.out executables on startup? Any thoughts, Artyom?
> 
> I think there are no Linux/SPARC64 kernels in the a.out format.
> NetBSD should not be a problem either
> 
>> If this is the case then we can only have a valid kernel_top with an ELF
>> kernel then maybe the following is a good enough solution:
>>
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 3975a7b65a..35acf8c96e 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -139,7 +139,7 @@ static uint64_t sun4u_load_kernel(const char
>> *kernel_filename,
>>      unsigned int i;
>>      long kernel_size;
>>      uint8_t *ptr;
>> -    uint64_t kernel_top;
>> +    uint64_t kernel_top = 0;
>>
>>      linux_boot = (kernel_filename != NULL);
>>
>> @@ -172,7 +172,7 @@ static uint64_t sun4u_load_kernel(const char
>> *kernel_filename,
>>          }
>>          /* load initrd above kernel */
>>          *initrd_size = 0;
>> -        if (initrd_filename) {
>> +        if (initrd_filename && kernel_top) {
>>              *initrd_addr = TARGET_PAGE_ALIGN(kernel_top);
>>
>>              *initrd_size = load_image_targphys(initrd_filename,
>>
>>
> Looks good to me.
> Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

 Hi Mark,

that looked also fine to me. Could you post it as a proper patch, please?

 Thanks,
  Thomas
