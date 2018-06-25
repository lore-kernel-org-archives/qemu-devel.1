Received: from eggs.gnu.org ([2001:4830:134:3::10]:34182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXI77-000604-Rx
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXI74-0002D4-N6
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:24:25 -0400
In-Reply-To: <20180625004658.GB22971@umbus.fritz.box>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<20180625004658.GB22971@umbus.fritz.box>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A7359F37-F1CD-4AE4-9594-36557AAD0386@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Sun, 24 Jun 2018 23:24:17 -0400
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


On Jun 24, 2018, at 8:46 PM, David Gibson wrote:

> On Fri, Jun 22, 2018 at 10:22:58PM -0400, John Arbuckle wrote:
>> When the fdiv instruction divides a finite number by zero,
>> the result actually depends on the FPSCR[ZE] bit. If this
>> bit is set, the return value is zero. If it is not set
>> the result should be either positive or negative infinity.
>> The sign of this result would depend on the sign of the
>> two inputs. What currently happens is only infinity is
>> returned even if the FPSCR[ZE] bit is set. This patch
>> fixes this problem by actually checking the FPSCR[ZE] bit
>> when deciding what the answer should be.
>>
>> fdiv is suppose to only set the FPSCR's FPRF bits during a
>> division by zero situation when the FPSCR[ZE] is not set.
>> What currently happens is these bits are always set. This
>> patch fixes this problem by checking the FPSCR[ZE] bit to
>> decide if the FPRF bits should be set.
>>
>> https://www.pdfdrive.net/powerpc-microprocessor-family-the- 
>> programming-environments-for-32-e3087633.html
>> This document has the information on the fdiv. Page 133 has the
>> information on what action is executed when a division by zero
>> situation takes place.
>
> I'm looking at that table and there is definitely no mention of a 0
> *result* in any situation.  So this patch is definitely wrong on that
> point.  If there's something else this is fixing, then the commit
> message needs to describe that.

I did not find any mention of a zero result *yet*. There could be  
mention of something in another document. I will see what I can find.  
Right now I do have example code that I ran on a PowerPC 970 CPU and  
the results are as follows:

When dividing by zero:

if FPSCR[ZE] is enabled
	then answer = 0
if FPSCR[ZE] is disabled
	then answer = 0x7ff0000000000000

I think this feature may be undocumented.

Here is the example program I used. When I ran this program, the  
FPSCR is set to zero initially (all bits disabled). When the mtfsb1  
instruction is executed, the ZE bit is set. I ran this program twice.  
Once with the mtfsb1 line uncommented, and another time with the line  
commented. The result for the answer was different in each situation.

#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

// Used to convert unsigned integer <--> double
union Converter
{
     double d;
     uint64_t i;
};
typedef union Converter Converter;

int main (int argc, const char * argv[]) {
     Converter answer;
     //asm volatile("mtfsb1 27"); /* Set ZE bit */
     asm volatile("fdiv %0, %1, %2" : "=f"(answer.d) : "f"(1.0),  
"f"(0.0));
     printf("answer = 0x%" PRIx64 "\n", answer.i);
     return 0;
}
