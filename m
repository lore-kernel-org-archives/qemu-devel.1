Received: from eggs.gnu.org ([2001:4830:134:3::10]:37331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eZGfD-00085U-66
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eZGfC-0000fI-82
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:43:31 -0500
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-2-laurent@vivier.eu>
	<66de9088-f8ed-2be4-c71a-5d149c63587b@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <525f7d10-54c5-eca9-0b45-62771afe9c59@vivier.eu>
Date: Wed, 10 Jan 2018 14:42:42 +0100
MIME-Version: 1.0
In-Reply-To: <66de9088-f8ed-2be4-c71a-5d149c63587b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/6] accel/tcg: add size
 paremeter in tlb_fill()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>

Le 10/01/2018 à 09:43, David Hildenbrand a écrit :
> On 09.01.2018 00:10, Laurent Vivier wrote:
>> The MC68040 MMU provides the size of the access that
>> triggers the page fault.
>>
>> This size is set in the Special Status Word which
>> is written in the stack frame of the access fault
>> exception.
>>
>> So we need the size in m68k_cpu_unassigned_access() and
>> m68k_cpu_handle_mmu_fault().
>>
>> To be able to do that, this patch modifies the prototype of
>> handle_mmu_fault handler, tlb_fill() and probe_write().
>> do_unassigned_access() already includes a size parameter.
>>
>> This patch also updates handle_mmu_fault handlers and
>> tlb_fill() of all targets (only parameter, no code change).
>>
> 
> There are a couple of places where you use "1" (when no other size is
> available). e.g. in get_page_addr_code().
> 
> Wonder if that's the right thing to do - are there any architectures
> that e.g. always fetch at least 2 bytes in these conditions?
> 

It's a good question.

"1" is passed to probe_write() and tlb_fill() and handle_mmu_fault().
probe_write() calls tlb_fill(), and tlb_fill() calls machine
handle_mmu_fault handler.

As no existing handle_mmu_fault takes care of the access size, I think
passing 1 and ignoring it doesn't change the existing behavior.

probe_write() is used to check if a page is writable, and none of the
callers is guessing the write can cross a page boundary, so 1 is the
good value in this case.

get_page_addr_code() is the only user of tlb_fill() with 1. and callers
of get_page_addr_code() never guess the code address can run across a
page boundary. Some of them calls get_page_addr_code() a second time to
check this case. So I think using 1 is good solution, but perhaps the
code could be improved by adding the size parameter to get_page_addr_code().

My purpose was not to change the functions behavior, only to add the new
parameter. So using "1" when the size is not obvious is a good solution
to me.

Thank you for your comment!

Laurent
