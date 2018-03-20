Received: from eggs.gnu.org ([2001:4830:134:3::10]:46210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyMLf-0006zj-Vy
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyMLb-0008Ug-Vv
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:51:04 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyMLb-0008Tk-M0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:50:59 -0400
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-11-lukeshu@lukeshu.com>
	<CAFEAcA9joyBcXSOqDu=hWRUZPKA1wEKMpYhRr5+p0YCKQOs5Kw@mail.gmail.com>
	<87tvtawpk2.wl-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <032a74fa-25fb-6ae3-d3c0-5050ccf2cf61@vivier.eu>
Date: Tue, 20 Mar 2018 19:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <87tvtawpk2.wl-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/10] linux-user: init_guest_space: Try to
 make ARM space+commpage continuous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, Paul Brook <paul@codesourcery.com>

Le 20/03/2018 à 19:49, Luke Shumaker a écrit :
> On Fri, 02 Mar 2018 09:13:12 -0500,
> Peter Maydell wrote:
>> On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
>>> +        guest_full_size =
>>> +            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
>                         ^
>> I think this is probably more clearly written as 0x100000000ULL,
>> since rounding down to the host-page-size then adding the host-page-size
>> gets us the full 32-bit size of the guest address space.
> 
> Wait, is that right?  Isn't that only true if qemu_host_page_size is
> at least 8KiB (16 bits), enough to fill the zero in the middle?  Won't
> a typical qemu_host_page_size be only 4KiB?
> 
>> That shows up that there's a potential problem here if the host
>> is 32-bit, because in that case guest_full_size (being only unsigned
>> long) will be 0, and we'll end up trying an mmap with an incorrect size.
>>
>>> +        host_full_size = guest_full_size - guest_start;
>>> +        real_start = (unsigned long)
>>> +            mmap(NULL, host_full_size, PROT_NONE, flags, -1, 0);
>>
>> I think the general approach is right, though. Sorry it took so long
>> for us to get to reviewing this patchset.
> 
> It's all good.  I'm amazed at the amount of traffic qemu-devel gets!
> 
>> Incidentally, this code would be rather less complicated if it didn't
>> have to account for qemu_host_page_size not actually being the host
>> page size (since then you couldn't get a return from mmap() that wasn't
>> aligned properly). Does anybody know why we allow the user to specify
>> it on the command line? (git revision history doesn't help, it just says
>> there's been a -pagesize argument since commit 54936004fddc5 in 2003,
>> right back when mmap emulation was first added...)
> 
> I have no idea, I just assumed that it was a feature useful to people
> far smarter than me.
> 

I'm going to add this patch in my upcoming linux-user pull-request
(currently running regression tests).

Thanks,
Laurent
