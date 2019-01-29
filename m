Received: from eggs.gnu.org ([209.51.188.92]:38570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goN0o-0008CU-1U
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goN0n-0006Lj-3r
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:36:45 -0500
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
	<3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
	<5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
	<897875e0-fc56-c280-0cd0-c7e0dac04fa1@ilande.co.uk>
	<3f43ac97-26d0-98b3-a8b4-8102acb73457@linaro.org>
	<20190129022847.GG1870@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <622b9eaf-712c-9e9b-a416-ea79a5687e01@ilande.co.uk>
Date: Tue, 29 Jan 2019 06:36:05 +0000
MIME-Version: 1.0
In-Reply-To: <20190129022847.GG1870@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 29/01/2019 02:28, David Gibson wrote:

> On Sun, Jan 27, 2019 at 10:07:12AM -0800, Richard Henderson wrote:
>> On 1/27/19 9:45 AM, Mark Cave-Ayland wrote:
>>>> I would expect the i < n/2 loop to be faster, because the assignments are
>>>> unconditional.  FWIW.
>>>
>>> Do you have any idea as to how much faster? Is it something that would show
>>> up as significant within the context of QEMU?
>>
>> I don't have any numbers on that, no.
>>
>>> As well as eliminating the HI_IDX/LO_IDX constants I do find the updated
>>> version much easier to read, so I would prefer to keep it if possible.
>>> What about unrolling the loop into 2 separate ones...
>>
>> I doubt that would be helpful.
>>
>> I would think that
>>
>> #define VMRG_DO(name, access, ofs)
>> ...
>>     int i, half = ARRAY_SIZE(r->access(0)) / 2;
>> ...
>>     for (i = 0; i < half; i++) {
>>         result.access(2 * i + 0) = a->access(i + ofs);
>>         result.access(2 * i + 1) = b->access(i + ofs);
>>     }
>>
>> where OFS = 0 for HI and half for LO is best.  I find it quite readable, and it
>> avoids duplicating code between LO and HI as you're currently doing.
> 
> Marc, Richard, where are we at with this?
> 
> Should I wait on a revised version of this patch before applying the
> series?

Certainly the v3 as posted is correct (I've tested this particular patch on both big
and small endian machines), so I believe the only question is whether this introduces
any noticeable performance penalty.

Let me try and run a few simple tests and report back.

BTW are you able to take my qemu-macppc queue posted yesterday at
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07263.html? There's no
functional change except for PPC MacOS users who explicitly enable the new QEMU EDID
support on the command line.


ATB,

Mark.
