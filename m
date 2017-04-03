Received: from eggs.gnu.org ([2001:4830:134:3::10]:34883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cv3Ze-0004x8-6F
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cv3Za-0002ob-49
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:07:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:37012
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cv3ZZ-0002mX-St
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:07:14 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
	<1491221026.17505.39.camel@redhat.com>
	<b8daec8e-86ed-56e6-d42d-d948508e5b6f@ilande.co.uk>
	<1491223335.17505.48.camel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <81c92413-024a-5448-1160-b24ca944e88e@ilande.co.uk>
Date: Mon, 3 Apr 2017 16:06:46 +0100
MIME-Version: 1.0
In-Reply-To: <1491223335.17505.48.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 03/04/17 13:42, Gerd Hoffmann wrote:

> On Mo, 2017-04-03 at 13:24 +0100, Mark Cave-Ayland wrote:
>> On 03/04/17 13:03, Gerd Hoffmann wrote:
>>
>>>   Hi,
>>>
>>>> I checked the branch, is bitmap_copy_and_clear_atomic correct when you
>>>> have partial updates?  Maybe you need to handle partial updates of the
>>>> first and last word?
>>>
>>> Should not be a problem.  We might clear some more bits, but these are
>>> outsize the visible area so they should cause visible corruption (and if
>>> the visible area changes the display code needs to do a full refresh
>>> anyway).
>>
>> Right. Also is there a reason that
>> cpu_physical_memory_snapshot_and_clear_dirty() uses BITS_PER_LEVEL when
>> calculating the alignment used for the first/last addresses?
> 
> The code copy doesn't operate on bits but on bitmap longs, so I can just
> copy the whole long instead of fiddeling with bits.  So I round down to
> a bitmap long start.  On 64bit hosts that are units of 64 pages.
> 
> Actually querying the copied bitmap operates on page granularity of
> course.
> 
>> Otherwise you end up expanding the range of your last address
>> considerably beyond the next page alignment.
> 
> Yes, it's larger, but as it expands to the start of the long word I
> expect the penalty is almost zero (same cache line) and being able to
> just copy the whole long instead of dealing with individual bits should
> be a win.
> 
>> And also in the main page
>> loop why is BITS_PER_LEVEL used? I see that several of the internal
>> bitmap routines appear to use BITS_PER_LONG for compressing into the
>> bitmap which might be more appropriate?
> 
> shift by BITS_PER_LEVEL is the same as division by BITS_PER_LONG

Right hopefully I understand this now. The following diff appears to fix
CG3/TCX for me:

diff --git a/exec.c b/exec.c
index 000af18..66bdcf4 100644
--- a/exec.c
+++ b/exec.c
@@ -1071,7 +1071,7 @@ DirtyBitmapSnapshot
*cpu_physical_memory_snapshot_and_clear_dirty
      (ram_addr_t start, ram_addr_t length, unsigned client)
 {
     DirtyMemoryBlocks *blocks;
-    unsigned long align = 1 << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
+    unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
     ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
     ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
     DirtyBitmapSnapshot *snap;
@@ -1097,7 +1097,6 @@ DirtyBitmapSnapshot
*cpu_physical_memory_snapshot_and_clear_dirty

         assert(QEMU_IS_ALIGNED(offset, (1 << BITS_PER_LEVEL)));
         assert(QEMU_IS_ALIGNED(num,    (1 << BITS_PER_LEVEL)));
-        offset >>= BITS_PER_LEVEL;

         bitmap_copy_and_clear_atomic(snap->dirty + dest,
                                      blocks->blocks[idx] + (offset >>
BITS_PER_LEVEL),


There were 2 issues here: without the UL suffix on align I was getting
incorrect first/last addresses since the high bits of align weren't
being cleared, and then offset appeared to be shifted twice.

Does this look reasonable to you?


ATB,

Mark.
