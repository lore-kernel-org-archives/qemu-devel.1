Received: from eggs.gnu.org ([2001:4830:134:3::10]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYshC-0002ZI-4i
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYsh7-0002fQ-FV
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:03:26 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cYsh7-0002fE-9n
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:03:21 -0500
Received: by mail-wm0-x22e.google.com with SMTP id b65so33434499wmf.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 03:03:20 -0800 (PST)
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-17-alex.bennee@linaro.org>
	<70fe24bb-c8f1-43c4-010f-a682bdd507ef@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <70fe24bb-c8f1-43c4-010f-a682bdd507ef@twiddle.net>
Date: Wed, 01 Feb 2017 11:03:19 +0000
Message-ID: <87efzi41hk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 16/25] cputlb and arm/sparc targets:
 convert mmuidx flushes from varg to bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 01/27/2017 02:39 AM, Alex Bennée wrote:
>> +    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>>
>> -        tlb_debug("%d\n", mmu_idx);
>> +        if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
>> +            tlb_debug("%d\n", mmu_idx);
>>
>> -        memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
>> -        memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
>> +            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
>> +            memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
>> +        }
>
> Perhaps it doesn't matter since NB_MMU_MODES is so small but
>
>    for (; idxmap != 0; idxmap &= idxmap - 1) {
>      int mmu_idx = ctz32(idxmap);
>      ...
>    }

Perhaps but if it is OK with you I'll skip this optimisation for now? We
are basically in the slow path by this point and for clarity I'd prefer
to keep it as is.

--
Alex Bennée
