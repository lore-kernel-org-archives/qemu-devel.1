Received: from eggs.gnu.org ([2001:4830:134:3::10]:48486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0Uc4-0001S8-MF
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0Uc0-0002hO-6K
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:00:16 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d0Uc0-0002h6-1z
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:00:12 -0400
Received: by mail-qk0-x242.google.com with SMTP id v75so24116408qkb.3
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 08:00:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
	<575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
	<382ab324-39c0-5549-ff01-3fe7cc1319de@twiddle.net>
	<20170418141846.GA2599@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <54fe7d09-7f47-2c7d-c0f5-2f90daf6caba@twiddle.net>
Date: Tue, 18 Apr 2017 08:00:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170418141846.GA2599@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] target/openrisc: Fixes for memory
 debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org

On 04/18/2017 07:18 AM, Stafford Horne wrote:
> On Tue, Apr 18, 2017 at 12:47:30AM -0700, Richard Henderson wrote:
>> On 04/16/2017 04:23 PM, Stafford Horne wrote:
>>> When debugging in gdb you might want to inspect instructions in mapped
>>> pages or in exception vectors like 0x800 etc.  This was previously not
>>> possible in qemu since the *get_phys_page_debug() routine only looked
>>> into the data tlb.
>>>
>>> Change to fall back to look into instruction tlb and plain physical
>>> pages.
>>>
>>> Signed-off-by: Stafford Horne <shorne@gmail.com>
>>
>> Oh the horrors of a software managed TLB.
>>
>> You might do well to architecturally define an SPR that holds the page table
>> base, even if for real hardware that's only used by the software refill to
>> load up the address.
>>
>> That would give qemu the option of performing a real page table walk.  This
>> would fix this debug hook properly (so that you can examine pages that
>> aren't in the TLB at all).  It would also optionally allow QEMU to skip the
>> software refill, which *significantly* speeds up emulation.
>
> Understood, I guess we would also need a way to represent which paging
> model we are using (1 level, 2 level etc)?

I suppose.  You really have a 1-level lookup?  For huge pages only, or is this 
a virtual 2-level lookup with double-faulting to handle the second level?


r~
