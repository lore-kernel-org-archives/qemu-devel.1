Received: from eggs.gnu.org ([2001:4830:134:3::10]:58615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhfxR-0002KJ-Gy
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhfxO-0000mn-Ch
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:48:49 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhfxO-0000mc-8A
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:48:46 -0400
Received: by mail-qt0-x241.google.com with SMTP id i19so1383933qte.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 10:48:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
	<20170815145714.17635-4-richard.henderson@linaro.org>
	<c30ad9c1-bd1c-0fdf-085e-2449d9034dd6@amsat.org>
	<CAFEAcA_N8Gnzkuy9=p-wgS1OUMDhgXU30r=Lww10y=9E7O4SkA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <820bdd5c-cd7c-758f-f333-d31f656d80e1@amsat.org>
Date: Tue, 15 Aug 2017 14:48:40 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_N8Gnzkuy9=p-wgS1OUMDhgXU30r=Lww10y=9E7O4SkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/3] target/arm: Require
 alignment for load exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

On 08/15/2017 01:14 PM, Peter Maydell wrote:
> On 15 August 2017 at 16:56, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Richard,
>>
>> On 08/15/2017 11:57 AM, Richard Henderson wrote:
>>>
>>> From: Alistair Francis <alistair.francis@xilinx.com>
>>>
>>> Acording to the ARM ARM exclusive loads require the same allignment as
>>> exclusive stores. Let's update the memops used for the load to match
>>> that of the store. This adds the alignment requirement to the memops.
>>>
>>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> [rth: Require 16-byte alignment for 64-bit LDXP.]
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/arm/translate-a64.c | 11 ++++++-----
>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>>> index eac545e4f2..2200e25be0 100644
>>> --- a/target/arm/translate-a64.c
>>> +++ b/target/arm/translate-a64.c
>>> @@ -1861,7 +1861,7 @@ static void gen_load_exclusive(DisasContext *s, int
>>> rt, int rt2,
>>>            g_assert(size >= 2);
>>>            if (size == 2) {
>>>                /* The pair must be single-copy atomic for the doubleword.
>>> */
>>> -            memop |= MO_64;
>>> +            memop |= MO_64 | MO_ALIGN;
>>
>>
>> isn't MO_ALIGN_8 enough?
> 
> MO_ALIGN is "align to size of access", ie to 8 bytes in this case.
> MO_ALIGN_8 is "align to a specified size (8 bytes) which isn't the
>   size of the access".
> In this case the access size is 8 bytes so we don't need MO_ALIGN_8.
> 
> Alignments to something other than the access size are the oddball
> case, so I think it makes sense to stick with MO_ALIGN for the
> common case of "just aligned to the access size" so you can
> spot the odd cases when you're reading the source.

Ok, I misunderstood "MO_ALIGN supposes the alignment size is the size of 
a memory access."

thanks!

> 
> thanks
> -- PMM
> 
