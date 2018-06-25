Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXTLV-0001CB-TO
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXTLS-0006lN-Pi
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:24:01 -0400
In-Reply-To: <dbbebf00-9b32-4639-1e26-a888c48f6203@linaro.org>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
	<c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
	<2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
	<dbbebf00-9b32-4639-1e26-a888c48f6203@linaro.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CDA6AAA3-1452-4CBA-93A9-94CD83705E1A@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 25 Jun 2018 11:23:54 -0400
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>


On Jun 24, 2018, at 11:47 PM, Richard Henderson wrote:

> On 06/24/2018 11:38 AM, Programmingkid wrote:
>> void test_division_by_zero()
>> {
>>     Converter c;
>>     uint64_t expected_answer = 0x0;
>>     uint32_t actual_fpscr, expected_fpscr = 0xc4000010;
>>     reset_fpscr();
>>     set_fpscr_bit(ZE);
>>     asm volatile("fdiv %0, %1, %2" : "=f"(c.d) : "f"(1.0), "f"(0.0));
>
> Try
>
>     uint64_t expected_answer = 0xffff0000deadbeef;
>     ...
>     c.i = expected_answer;
>     asm volatile("fdiv %0, %1, %2" : "+f"(c.d) : "f"(1.0), "f"(0.0));
>
> to avoid depending on uninitialized data.  (This expected value is
> an SNaN with a deadbeef marker Just to be Sure.)
>
>
> r~


Ok I made this program and tried it on my iMac G5 (PowerPC 970).

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
     answer.i = 0xffff0000deadbeef;
     //asm volatile("mtfsb1 27"); /* Set ZE bit */
     asm volatile("fdiv %0, %1, %2" : "=f"(answer.d) : "f"(1.0),  
"f"(0.0));
     printf("answer = 0x%" PRIx64 "\n", answer.i);
     return 0;
}

The result was the same.

When the FPSCR[ZE] bit is set, the answer is 0x0.

When the FPSCR[ZE] bit is not set, the answer is 0x7ff0000000000000.

This seems to be an undocumented feature. 
