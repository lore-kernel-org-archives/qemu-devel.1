Received: from eggs.gnu.org ([2001:4830:134:3::10]:51642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cnQfF-0005hU-FD
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cnQfC-0005tB-BQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:09:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:63053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cnQfC-0005sG-23
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:09:30 -0400
References: <20170311183016.GA20514@ls3530.fritz.box>
	<ccf72219-1498-4434-8dd4-625c49afee7c@twiddle.net>
From: Helge Deller <deller@gmx.de>
Message-ID: <198870a8-664f-06a0-e479-2167ebbfb01d@gmx.de>
Date: Mon, 13 Mar 2017 15:09:14 +0100
MIME-Version: 1.0
In-Reply-To: <ccf72219-1498-4434-8dd4-625c49afee7c@twiddle.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add TARGET_MAP_STACK and
 TARGET_MAP_HUGETLB for all remaining architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On 11.03.2017 22:53, Richard Henderson wrote:
> On 03/12/2017 04:30 AM, Helge Deller wrote:
>> Add the missing defines and for TARGET_MAP_STACK and TARGET_MAP_HUGETLB
>> for alpha, mips, ppc and x86, and fix the mmap_flags translation table
>> to translate those flags between host and target architecture.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index cec8428..03ed370 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -5875,6 +5875,8 @@ static bitmask_transtbl mmap_flags_tbl[] = {
>>      { TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
>>          { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE, MAP_NORESERVE,
>>            MAP_NORESERVE },
>> +    { TARGET_MAP_STACK, TARGET_MAP_STACK, MAP_STACK, MAP_STACK },
>> +    { TARGET_MAP_HUGETLB, TARGET_MAP_HUGETLB, MAP_HUGETLB, MAP_HUGETLB },
> 
> I don't see any point in this. First, MAP_STACK is ignored by the
> kernel, and has been for some time. 

Yes, the kernel ignores the native MAP_STACK define.

> Second, the size of huge pages varies widely between different targets,
> and we're not really able to map the sizes between guest and host.

This might probably not be necessary, if the userspace app simply asks
which huge page sizes are supported (e.g. by procfs entries or via 
"hugeadm --page-sizes-all").

But the main intention of my patch was not to fix MAP_STACK or MAP_HUGETLB,
but more to ensure that those flags are avoided to be handed over to the host.
For example, TARGET_MAP_STACK is 0x40000 on hppa, and if it's not filtered out
in e.g. a mmap() call, then this becomes to MAP_HUGETLB on x86_64 (which is 
0x40000 on x86_64).  

Helge
