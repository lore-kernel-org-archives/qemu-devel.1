Received: from eggs.gnu.org ([2001:4830:134:3::10]:42337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9Oq-0006v3-BB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9Op-0006fa-6K
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:17:52 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb9Oo-0006bg-Vp
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:17:51 -0500
Received: by mail-wr0-x22c.google.com with SMTP id i10so42420090wrb.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 09:17:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <877f52x7sx.fsf@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
	<20170206153113.27729-21-alex.bennee@linaro.org>
	<CAFEAcA9YEo2+_9jc4V_aEds_tQV-f5pU+W49zUs1Ls0JOiQTLg@mail.gmail.com>
	<877f52x7sx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 17:17:29 +0000
Message-ID: <CAFEAcA86k-q+wG2e_tzD_0DcoywBCe39jb0nr1peC0j=1jkSPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 20/23] target-arm/powerctl: defer cpu
 reset work to CPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 7 February 2017 at 16:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>> I find this too hard to reason about :-(  We store the current
>> CPU state in not one but two CPU structure fields, and then
>> we check and manipulate it not by doing "take lock; access
>> and update; drop lock" but by doing successive atomic
>> operations on the various different flags. This seems unnecessarily
>> tricky, and the patch doesn't provide any documentation about
>> what's going on and what the constraints are to avoid races.
>
> I was trying to avoid changing the powered_off state to a new variable
> (maybe pcsi_power_state?) because it meant I didn't have to touch the
> kvm code that treated powered_off as a simple bool. However I can unify
> the state into one variable if you wish.

Changing it also makes migration compatibility awkward.
(Speaking of which, your new flag needs a migration subsection
and appropriate needed function to only transfer it if it's set.)

> As for locking do we have a handy per-CPU lock already or would it be
> enough to use the BQL for this? Although that may be problematic as the
> cpu_reset/on can come from two places (the initial realization and the
> runtime switching of power state.)

Nobody's going to put powering CPUs up and down in their critical
path, so I think the BQL would be fine.

>>> -    /* Start the new CPU at the requested address */
>>> -    cpu_set_pc(target_cpu_state, entry);
>>> +    /* To avoid racing with a CPU we are just kicking off we do the
>>> +     * final bit of preparation for the work in the target CPUs
>>> +     * context.
>>> +     */
>>> +    info =3D g_new(struct cpu_on_info, 1);
>>> +    info->entry =3D entry;
>>> +    info->context_id =3D context_id;
>>> +    info->target_el =3D target_el;
>>> +    info->target_aa64 =3D target_aa64;
>>>
>>> -    qemu_cpu_kick(target_cpu_state);
>>> +    async_run_on_cpu(target_cpu_state, arm_set_cpu_on_async_work,
>>> +                     RUN_ON_CPU_HOST_PTR(info));
>>>
>>>      /* We are good to go */
>>>      return QEMU_ARM_POWERCTL_RET_SUCCESS;
>>>  }
>>
>>> @@ -221,8 +284,9 @@ int arm_reset_cpu(uint64_t cpuid)
>>>          return QEMU_ARM_POWERCTL_IS_OFF;
>>>      }
>>>
>>> -    /* Reset the cpu */
>>> -    cpu_reset(target_cpu_state);
>>> +    /* Queue work to run under the target vCPUs context */
>>> +    async_run_on_cpu(target_cpu_state, arm_reset_cpu_async_work,
>>> +                     RUN_ON_CPU_NULL);
>>
>> The imx6 datasheet says that the RST bit in the SCR register
>> is set by the guest to trigger a reset, and then the bit
>> remains set until the reset has finished (at which point it
>> self-clears). At the moment the imx6_src.c code does this:
>>
>>         if (EXTRACT(change_mask, CORE0_RST)) {
>>             arm_reset_cpu(0);
>>             clear_bit(CORE0_RST_SHIFT, &current_value);
>>         }
>>
>> ie it assumes that arm_reset_cpu() is synchronous.
>
> Well for this case the imx6 could queue the "clear_bit" function as
> async work and then it will be correctly reported after the reset has
> occurred.

It could, but as of this patchset it doesn't...

thanks
-- PMM
