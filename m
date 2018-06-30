Received: from eggs.gnu.org ([2001:4830:134:3::10]:50003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZLsr-0004SH-FW
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 15:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZLsq-0005rJ-Hd
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 15:50:13 -0400
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+iV3fTRtSKx8Y-Y4_e16i21shLOch2PS3v_xR_c+L0ww@mail.gmail.com>
References: <20180620130619.11362-1-peter.maydell@linaro.org>
	<20180620130619.11362-2-peter.maydell@linaro.org>
	<CAMo8BfLRr16q4_nj0vacK4N4fb0EBymXZB6SHon72h7BJ9M5jw@mail.gmail.com>
	<CAMo8Bf+iV3fTRtSKx8Y-Y4_e16i21shLOch2PS3v_xR_c+L0ww@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 30 Jun 2018 12:50:09 -0700
Message-ID: <CAMo8Bf+2+2XEOQQY=EYO6VsS-ZtesTRf=S1ULgh2GcTFo5JU3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Patch Tracking <patches@linaro.org>, Laurent Vivier <laurent@vivier.eu>

On Sat, Jun 30, 2018 at 12:42 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Sat, Jun 30, 2018 at 12:20 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Hi Peter,
>>
>> On Wed, Jun 20, 2018 at 6:06 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Add support for MMU protection regions that are smaller than
>>> TARGET_PAGE_SIZE. We do this by marking the TLB entry for those
>>> pages with a flag TLB_RECHECK. This flag causes us to always
>>> take the slow-path for accesses. In the slow path we can then
>>> special case them to always call tlb_fill() again, so we have
>>> the correct information for the exact address being accessed.
>>>
>>> This change allows us to handle reading and writing from small
>>> regions; we cannot deal with execution from the small region.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  accel/tcg/softmmu_template.h |  24 ++++---
>>>  include/exec/cpu-all.h       |   5 +-
>>>  accel/tcg/cputlb.c           | 131 +++++++++++++++++++++++++++++------
>>>  3 files changed, 130 insertions(+), 30 deletions(-)
>>
>> I'm observing the following failure with xtensa tests:
>>
>> (qemu) qemu: fatal: Unable to handle guest executing from RAM within a
>> small MPU region at 0xd0000804
>>
>> Bisection points to this patch. Any idea what happened?
>
> Ok, I think I've found the issue: the following check in the
> get_page_addr_code does not work correctly when -1 is in the
> addr_code in the QEMU TLB:
>
> if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK))
>
> tlb_set_page_with_attrs sets addr_code to -1 in the TLB entry
> when the translation is not executable.

Looks like it can be fixed with the following:

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eebe97dabb75..633cffe9ed74 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -692,16 +692,16 @@ void tlb_set_page_with_attrs(CPUState *cpu,
target_ulong vaddr,
     if (prot & PAGE_READ) {
         tn.addr_read = address;
     } else {
-        tn.addr_read = -1;
+        tn.addr_read = TLB_INVALID_MASK;
     }

     if (prot & PAGE_EXEC) {
         tn.addr_code = code_address;
     } else {
-        tn.addr_code = -1;
+        tn.addr_code = TLB_INVALID_MASK;
     }

-    tn.addr_write = -1;
+    tn.addr_write = TLB_INVALID_MASK;
     if (prot & PAGE_WRITE) {
         if ((memory_region_is_ram(section->mr) && section->readonly)
             || memory_region_is_romd(section->mr)) {


-- 
Thanks.
-- Max
