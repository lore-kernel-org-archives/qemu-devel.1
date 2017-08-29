Received: from eggs.gnu.org ([2001:4830:134:3::10]:37995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmjIk-0004Eu-OF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmjIf-0004TS-6g
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:23:42 -0400
MIME-Version: 1.0
In-Reply-To: <3148d084-9bff-2d8e-f1a7-fba94a1e7f87@linaro.org>
References: <20170829063313.10237-1-bobby.prani@gmail.com>
	<20170829063313.10237-5-bobby.prani@gmail.com>
	<3148d084-9bff-2d8e-f1a7-fba94a1e7f87@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 29 Aug 2017 12:23:05 -0400
Message-ID: <CAJhHMCCgYRTc6yyPkYowV=ie4ZxdFzDEFupUv5EVjbgOzXi_QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v3 PATCH 5/5] tcg/softmmu: Increase size of
 TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:AArch64 target" <qemu-arm@nongnu.org>

On Tue, Aug 29, 2017 at 11:01 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/28/2017 11:33 PM, Pranith Kumar wrote:
>> + * TODO: rewrite this comment
>>   */
>> -#define CPU_TLB_BITS                                             \
>> -    MIN(8,                                                       \
>> -        TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
>> -        (NB_MMU_MODES <= 1 ? 0 :                                 \
>> -         NB_MMU_MODES <= 2 ? 1 :                                 \
>> -         NB_MMU_MODES <= 4 ? 2 :                                 \
>> -         NB_MMU_MODES <= 8 ? 3 : 4))
>> +#define CPU_TLB_BITS MIN(12, TCG_TARGET_TLB_MAX_INDEX_BITS)
>>
>
> Ah, no.  This will cause several builds to fail.
> You still need to restrict the *total* size of
> the TLB to TCG_TARGET_TLB_DISPLACEMENT_BITS.
>
> (That's not a 100% accurate statement, but is close.
> See the QEMU_BUILD_BUG_ON in tcg/*/*.c for specifics.)
>
> The upshot is that if a target has 2 MMU modes,
> we can allow them to be bigger.  But if it has 8,
> we have to make them smaller.
>
> I was expecting you to write
>
>   MIN(MIN(12, TCG_TARGET_TLB_MAX_INDEX_BITS)
>       TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -
>       ...)

I see what you mean. I will fix the blunder and send an updated patch.

Thanks!
-- 
Pranith
