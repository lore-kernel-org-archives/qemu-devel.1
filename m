Received: from eggs.gnu.org ([2001:4830:134:3::10]:40445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1foX3X-0008E3-IX
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1foX3T-0002IA-LR
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:47:59 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1foX3T-0002HZ-Dl
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:47:55 -0400
Received: by mail-ed1-x542.google.com with SMTP id h4-v6so6245537edi.6
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 09:47:55 -0700 (PDT)
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
	<80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
	<d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
	<1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <5434c03d-7d03-8255-ea0f-d85ec96ac844@gmail.com>
Date: Sat, 11 Aug 2018 19:47:49 +0300
MIME-Version: 1.0
In-Reply-To: <1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Rebecca Cran <rebecca@bluestop.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>, Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>

Hi,

On 08/06/2018 11:51 AM, Thomas Huth wrote:
> On 07/28/2018 05:50 AM, Rebecca Cran wrote:
>> On 7/25/18 5:14 AM, Thomas Huth wrote:
>>
>>> Note that the error has been reported to happen on FreeBSD - so I doubt
>>> that this <linux/types.h> header should be here.
>>>
>>> Anyway, our include/standard-headers/linux/types.h is also empty ... so
>>> could you try whether it compiles if you simply remove this #include
>>> line, Rebecca?
>>
>> Sorry for the delay, I'm just getting back to this. Removing the include
>> causes it to fail later on, with:
>>
>> /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning:
>> implicit declaration of function 'mremap' is invalid in C99
>> [-Wimplicit-function-declaration]
>>      host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
> OK, thanks for checking. According to
>
>   https://www.freebsd.org/cgi/man.cgi?query=mremap&manpath=NetBSD+5.0
>
> that syscall should also be available on FreeBSD. So could you please do
> one more test and see whether it works when you add the following line
> somewhere at the beginning of the file:
>
>    #include <sys/mman.h>

It took some time, but I finally have a FreeBSD VM with RDMA enabled.

My findings:
- The RDMA libraries are there, so the flag  "RDMA"=yes is set correctly.
- include of <linux/types.h> is not needed, I will remove it.
- In FreeBSD mremap is not implemented in all configurations, it depends
   on some SANITIZER_LINUX flag (Linux emulation?), I think;
   so pvrdma cannot be compiled.  I think we should have a different 
QEMU configuration
   flag --enable-pvrdma that will specifically check it is not a "bsd" 
platform.
   I'll send a patch for that too.

Thanks,
Marcel


>
>   Thanks,
>    Thomas
