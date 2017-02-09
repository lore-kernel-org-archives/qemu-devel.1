Received: from eggs.gnu.org ([2001:4830:134:3::10]:33079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cbppy-00061J-5m
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cbppv-000088-1a
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:36:42 -0500
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<20170202051445.5735-96-david@gibson.dropbear.id.au>
	<922cc254-3d39-c21e-3ac6-7f8bd3b95d90@ilande.co.uk>
	<b8c77dc9-6083-bf26-3750-f0847ad1d6ed@redhat.com>
	<83f44e87-d1aa-3c9f-f383-e06717dfa54c@ilande.co.uk>
	<999b15a2-2388-4397-64f4-06875f7f6d92@redhat.com>
	<824f7332-4893-fa64-d61d-7cb9497e5371@ilande.co.uk>
	<ff33796b-742b-f54c-a3c7-ee19b9d23759@redhat.com>
	<6d995fa3-f699-8f00-740c-5d622d8df08a@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <06f8967c-5f1c-f976-5987-b5d21b355f49@redhat.com>
Date: Thu, 9 Feb 2017 15:36:31 +0100
MIME-Version: 1.0
In-Reply-To: <6d995fa3-f699-8f00-740c-5d622d8df08a@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 095/107] spapr: clock should count only if
 vm is running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, agraf@suse.de, qemu-ppc@nongnu.org

On 09/02/2017 14:11, Mark Cave-Ayland wrote:
> On 07/02/17 15:46, Laurent Vivier wrote:
> 
>>> If you do this enough times (maybe 10 or so?) you'll see the progress
>>> bars stop working correctly and get out of sync, i.e. it will freeze for
>>> long periods of time and then "jump" to catch-up but not all the way.
>>>
>>> With my above patch applied to include the decrementer in the migration,
>>> the bug was no longer visible in my tests.
>>
>> Thank you for all these details.
>>
>> I've been able to reproduce the problem, and I think the proposition you
>> did in:
>>
>>    https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg01114.html
>>
>> is the good one:
>>
>> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
>> index df9f7a4..1dc95b8 100644
>> --- a/target/ppc/machine.c
>> +++ b/target/ppc/machine.c
>> @@ -172,6 +172,7 @@ static void cpu_pre_save(void *opaque)
>>      env->spr[SPR_CFAR] = env->cfar;
>>  #endif
>>      env->spr[SPR_BOOKE_SPEFSCR] = env->spe_fscr;
>> +    env->spr[SPR_DECR] = cpu_ppc_load_decr(env);
>>
>>      for (i = 0; (i < 4) && (i < env->nb_BATs); i++) {
>>          env->spr[SPR_DBAT0U + 2*i] = env->DBAT[0][i];
>> @@ -214,6 +215,7 @@ static int cpu_post_load(void *opaque, int version_id)
>>      env->cfar = env->spr[SPR_CFAR];
>>  #endif
>>      env->spe_fscr = env->spr[SPR_BOOKE_SPEFSCR];
>> +    cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
>>
>>      for (i = 0; (i < 4) && (i < env->nb_BATs); i++) {
>>          env->DBAT[0][i] = env->spr[SPR_DBAT0U + 2*i];
>>
>>
>> It's interesting because it doesn't break migration between different
>> qemu releases as the register is already part of the migration stream.
>> It was just not updated in the case of TCG (KVM is keeping it alive).
>> And in case of KVM, calling cpu_ppc_load_decr()/cpu_ppc_store_decr()
>> will not break anything as:
>>
>> - cpu_ppc_load_decr() returns "env->spr[SPR_DECR]",
>> - cpu_ppc_store_decr() does nothing.
>>
>> Could you re-send this patch with your S-o-b, please?
> 
> Hi Laurent,
> 
> No problem, and thanks for the analysis. In fact, I have a couple of
> other patches up on github which should fix up the remainder of the
> issues and make g3beige migrateable (I would add the mac99 is currently
> fairly close, however Ben has several WIP patches that change the mac99
> model so I don't think it's worth making that machine officially
> migrateable yet).
> 
> The one question I would ask is that if cpu_ppc_store_decr() does
> nothing on KVM then would this causes issues attempting a migration
> between TCG and KVM? In theory I believe I would still need to add

It should work: on the TCG one we read/write the decr_next field of
ppc_tb_t, on the KVM one we write/read the spr[SPR_DECR] field.

> VMSTATE_PPC_TIMEBASE_V to the vmstate and encode the decrementer offset
> relative to the timebase for this to work correctly as per the original

VMSTATE_PPC_TIMEBASE_V is used to update tb_offset.

With TCG, tb_offset is always 0 because TBR is based on a
QEMU_CLOCK_VIRTUAL clock: this clock is started with guest and stopped
when the guest is stopped. With KVM the guest uses the real TBR of the
host, and so when the guest is started it is not 0 and when the guest is
stopped, it continues to count. So we need an offset to adjust the guest
TBR.

So:
- TCG doesn't need VMSTATE_PPC_TIMEBASE_V,
- VMSTATE_PPC_TIMEBASE_V can't be used to migrate between TCG and KVM
guests.

If we want to migrate the TBR between TCG and KVM, I think we should
update spr[SPR_TBL]/spr[SPR_TBU] as we do for spr[SPR_DECR]. In the case
of KVM, it will be overwritten by the computed one from tb_offset when
the guest is restarted.

But of course, if you want to migrate g3beige/mac99 with KVM you need
VMSTATE_PPC_TIMEBASE_V in the machine structures. But only for the TBR,
not for the DECR, as it is a relative time (it's a decrementer :) )not
an absolute time like TBR.

> thread.
> 
> I'm just thinking if we are close to finalising the g3beige vmstate then
> it would make sense to get it right so a KVM<>TCG migration can happen
> if at all feasible.

I'm wondering if it works on the other architectures?

Laurent
