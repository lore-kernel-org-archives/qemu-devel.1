Received: from eggs.gnu.org ([2001:4830:134:3::10]:39818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cPWND-0008IV-Tx
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cPWNC-0005YC-Q0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:24:07 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:33031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cPWNC-0005Xq-L5
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:24:06 -0500
Received: by mail-it0-x241.google.com with SMTP id c20so2360416itb.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 07:24:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mQPT=pSNTfLqrvuBNX9QYggiMwyoHitV1c5LCVZv-2Q@mail.gmail.com>
References: <20170105225210.GA5235@octofox.metropolis>
	<CAFEAcA-mQPT=pSNTfLqrvuBNX9QYggiMwyoHitV1c5LCVZv-2Q@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 6 Jan 2017 07:24:05 -0800
Message-ID: <CAMo8BfJCa63pARSvbQKytpAUFpZdACALpT+xaQV4UOEOnavJgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-softmmu aborted with "Bad ram pointer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 6, 2017 at 2:23 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 January 2017 at 22:52, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Hello,
>>
>> debugging XIP kernel running directly from CFI FLASH I've got to a point
>> where QEMU aborts with the message "Bad ram pointer 0xbb4".
>>
>> It turns out that that happens when QEMU tries to translate code from FLASH
>> immediately after the kernel has written to the FLASH address range:
>> writing to FLASH address range turns off romd_mode of its memory region:
>
> This sounds like
> https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03273.html

Right. Strange that I haven't found it...

> It's a bug that we fail with this unhelpful message and abort,
> but the fix to the bug would only cause us to print the more
> useful "can't execute from a device" instead. You can't
> execute from a ROM that's not in ROMD mode, I'm afraid.

Yes, aborting is my main concern.
Shouldn't we do something like the following?

diff --git a/exec.c b/exec.c
index 8d4bb0e..d3f1818 100644
--- a/exec.c
+++ b/exec.c
@@ -381,7 +381,8 @@ static MemoryRegionSection
*phys_page_find(PhysPageEntry lp, hwaddr addr,

 bool memory_region_is_unassigned(MemoryRegion *mr)
 {
-    return mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
+    return mr != &io_mem_rom && mr != &io_mem_notdirty
+        && !(mr->rom_device && mr->romd_mode)
         && mr != &io_mem_watch;
 }

-- 
Thanks.
-- Max
