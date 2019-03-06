Received: from eggs.gnu.org ([209.51.188.92]:45758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1Zhk-0003jD-Qf
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1Zhi-0004Nx-Rk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:47:40 -0500
References: <201902270125.36158.randrianasulu@gmail.com>
	<b3f9b42e-5895-51ca-9313-506b857e65d8@ilande.co.uk>
	<201902281139.14787.randrianasulu@gmail.com>
	<a984d6e6-4b9c-fecf-d0c6-3ff9b80cc07c@ilande.co.uk>
	<95377a0f-a947-57d7-98af-82f105a23073@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ee99116d-3ba8-ce9d-6cc4-fb2a76c91a02@ilande.co.uk>
Date: Wed, 6 Mar 2019 16:47:30 +0000
MIME-Version: 1.0
In-Reply-To: <95377a0f-a947-57d7-98af-82f105a23073@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] regression: target/ppc: convert VSX
 logical operations to vector operations broke X for ppc64le guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/03/2019 16:42, Laurent Vivier wrote:

> On 28/02/2019 17:59, Mark Cave-Ayland wrote:
>> On 28/02/2019 08:39, Andrew Randrianasulu wrote:
>>
>>>>> configure line:
>>>>> setarch i686 ./configure --target-list=ppc64-softmmu
>>>>>
>>>>> launch line:
>>>>> ppc64-softmmu/qemu-system-ppc64 -display
>>>>> sdl,gl=on -hda /mnt/sdb1/PPC-img/alpine_disk.img
>>>>>
>>>>> where alpine_disk.img is HDD installed Alpine 3.7 for ppc64le with xfce4
>>>>> desktop.
>>>>
>>>> AFAICT the vector instructions converted here are independent of endian, so
>>>> I can't see why this patch on its own would have any effect.
>>>>
>>>> Maybe it could be because the "setarch i686" part forces use of some
>>>> lesser-used 32-bit paths in the vector code - is this required? And do you
>>>> see the same issue on a x86_64 build?
>>>
>>> I use 32-bit Slackware userland with x86_64 kerenl - so setarch prevent most of 
>>> configures from detecting my arch wrongly.
>>>
>>> Yes, bug was and is present with qemu compiled for x86_64 (inside chroot).
>>> I initially discovered it there, and after dropping -O3 and even march=native, 
>>> and even disabling avx2 via configure switch - moved to bisect.
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06414.html
>>
>> Can you upload your alpine_disk.img somewhere and then email me the link off-list?
>> I'll see if I can take a look when I get a spare moment.
> 
> I've also bisected to this commit for a problem with qemu-pp64le.
> 
> commit 7b8fe477e12b164dda97f79e27b55b805d90384f
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Fri Feb 15 10:00:46 2019 +0000
> 
>     target/ppc: convert VSX logical operations to vector operations
> 
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>     Acked-by: David Gibson <david@gibson.dropbear.id.au>
>     Message-Id: <20190215100058.20015-6-mark.cave-ayland@ilande.co.uk>
>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> 
> debian stretch ppc64el fails to build the well known hello.c example:
> # $ cat /tmp/hello.c
> #include <stdio.h>
> int main(void)
> {
>     printf("Hello World!\n");
>     return 0;
> }
> # cc -o /tmp/hello /tmp/hello.c
> In file included from <command-line>:0:0:
> /usr/include/stdc-predef.h:26:2: error: unknown type name '_STDC_'
>     explicitly includes a system header.  GCC knows the name of this
>   ^ ~~~~
> /usr/include/stdc-predef.h:28:1: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before '_STDC_PREDEF_H'
> 
>  ^
> /usr/include/stdc-predef.h:42:2: error: missing terminating ' character
>  #endif
>   ^~~~~
> ...

Hi Laurent,

This should be fixed by the patchset at
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00473.html - can you test
and confirm that it also works for you?

I'm currently in the process of working on a v2 to address Richard's comments,
hopefully I will be able to send it through later this evening or tomorrow.


ATB,

Mark.
