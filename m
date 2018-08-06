Received: from eggs.gnu.org ([2001:4830:134:3::10]:38876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUOr-00036K-JJ
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUOm-0004mc-LV
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:33:33 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fmUOm-0004lq-4r
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:33:28 -0400
Received: by mail-pl0-x242.google.com with SMTP id d5-v6so4928972pll.4
	for <qemu-devel@nongnu.org>; Sun, 05 Aug 2018 18:33:27 -0700 (PDT)
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180703151732.29843-8-richard.henderson@linaro.org>
	<B9095EFA-A3D5-4EEE-A5DA-E4284FD8881E@gmail.com>
	<128b92a6-7b0e-5e27-2bad-63da14bb3a6a@linaro.org>
	<3ed18a14-886b-a40b-7c63-176297b5171b@ilande.co.uk>
	<9809e9bc-7fca-5555-f738-5c848d36bbf3@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e5134b9-4014-65ad-9b39-157a2a31c55d@linaro.org>
Date: Sun, 5 Aug 2018 18:33:24 -0700
MIME-Version: 1.0
In-Reply-To: <9809e9bc-7fca-5555-f738-5c848d36bbf3@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 7/7] target/ppc: Use
 non-arithmetic conversions for fp load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Programmingkid <programmingkidx@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 08/05/2018 04:41 AM, Mark Cave-Ayland wrote:
> On 06/07/18 10:03, Mark Cave-Ayland wrote:
> 
>> On 05/07/18 17:48, Richard Henderson wrote:
>>
>>> On 07/05/2018 09:31 AM, Programmingkid wrote:
>>>>> On Jul 3, 2018, at 11:17 AM, Richard Henderson
>>>>> <richard.henderson@linaro.org> wrote:
>>>>>
>>>>> Memory operations have no side effects on fp state.
>>>>> The use of a "real" conversions between float64 and float32
>>>>> would raise exceptions for SNaN and out-of-range inputs.
>>>>
>>>> Would you have any documentation that tells us about converting
>>>> between 64 bit and 32 bit floating points?
>>>
>>> Spelled out right at the beginning of sections 4.6 (load) and 4.7 (store) of
>>> Book 1 of the Power ISA manual (version 3.0B) [0].
>>>
>>> I've double-checked vs RISU[1] testing of LFS and STFS, with master traces
>>> generated on Power 8 ppc64le, so I don't see anything immediately wrong with
>>> the patch.  But I haven't had time to look further than that.
>>
>> I've had a quick look at this with the attached patch to compare the helper
>> results before your patch and after, writing any differences to the console.
>>
>> With this patch applied to ppc-for-3.1 I've booted MacOS 9 and recorded the
>> output below:
>>
>>
>> $ ./qemu-system-ppc -cdrom MacOS921-macsbug.iso -boot d -M mac99
>>
>> helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret:
>> 3bf0000000000000
>> helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret:
>> 3bf0000000000000
>>
>> (note: MacOS 9 will hang here unless the line marked "Uncommenting this
>> allows MacOS to run" in my patch is enabled)
>>
>> helper_todouble diff for arg: 3f000000  d.ll: 3fe0000000000000  ret:
>> 3be0000000000000
>> helper_todouble diff for arg: 3f000000  d.ll: 3fe0000000000000  ret:
>> 3be0000000000000
>> helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret:
>> 3bf0000000000000
>> helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret:
>> 3bf0000000000000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_todouble diff for arg: be61b08a  d.ll: bfcc361140000000  ret:
>> bbcc361140000000
>> helper_todouble diff for arg: 3fdf81a5  d.ll: 3ffbf034a0000000  ret:
>> 3bfbf034a0000000
>> helper_todouble diff for arg: bf402647  d.ll: bfe804c8e0000000  ret:
>> bbe804c8e0000000
>> helper_todouble diff for arg: 3e61b08a  d.ll: 3fcc361140000000  ret:
>> 3bcc361140000000
>> helper_tosingle diff for arg: bfcc361140000000  f.l: be61b08a  ret: 9e61b08a
>> helper_todouble diff for arg: 3f0ccccd  d.ll: 3fe19999a0000000  ret:
>> 3be19999a0000000
>> helper_tosingle diff for arg: 3ffbf034a0000000  f.l: 3fdf81a5  ret: 1fdf81a5
>> helper_tosingle diff for arg: bfe804c8e0000000  f.l: bf402647  ret: 9f402647
>> helper_tosingle diff for arg: 3fcc361140000000  f.l: 3e61b08a  ret: 1e61b08a
>> helper_tosingle diff for arg: 3fe19999a0000000  f.l: 3f0ccccd  ret: 1f0ccccd
>> helper_todouble diff for arg: 3b800000  d.ll: 3f70000000000000  ret:
>> 3b70000000000000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_todouble diff for arg: 3b800000  d.ll: 3f70000000000000  ret:
>> 3b70000000000000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>> helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
>>
>>
>> It looks like the differences are related to a flag or flags in the MSB byte
>> of ret.
> 
> Hi Richard,
> 
> Have you had a chance to look at this yet? I've been working on top of David's
> ppc-for-3.1 branch over the weekend and ran into this again during my testing :/

Thanks for the reminder and the test cases.
I've posted a fix for this now.


r~
