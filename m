Received: from eggs.gnu.org ([2001:4830:134:3::10]:46802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUaWB-000169-Ux
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUaW8-00075T-S3
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:50:20 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUaW8-00074R-IV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:50:16 -0500
Received: by mail-wm0-x236.google.com with SMTP id r126so40307196wmr.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:50:16 -0800 (PST)
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-6-alex.bennee@linaro.org>
	<878tq6r03a.fsf@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <878tq6r03a.fsf@gmail.com>
Date: Fri, 20 Jan 2017 14:50:13 +0000
Message-ID: <87pojheqfu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 05/27] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Pranith Kumar <bobby.prani@gmail.com> writes:

> Alex Bennée writes:
>
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> We know there will be cases where MTTCG won't work until additional work
>> is done in the front/back ends to support. It will however be useful to
>> be able to turn it on.
>>
>> As a result MTTCG will default to off unless the combination is
>> supported. However the user can turn it on for the sake of testing.
>>
>
> <snip>
>
>>  static TimersState timers_state;
>> +bool mttcg_enabled;
>> +
>> +/*
>> + * We default to false if we know other options have been enabled
>> + * which are currently incompatible with MTTCG. Otherwise when each
>> + * guest (target) has been updated to support:
>> + *   - atomic instructions
>> + *   - memory ordering primitives (barriers)
>> + * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
>> + *
>> + * Once a guest architecture has been converted to the new primitives
>> + * there are two remaining limitations to check.
>> + *
>> + * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
>> + * - The host must have a stronger memory order than the guest
>> + *
>> + * It may be possible in future to support strong guests on weak hosts
>> + * but that will require tagging all load/stores in a guest with their
>> + * implicit memory order requirements which would likely slow things
>> + * down a lot.
>> + */
>> +
>> +static bool check_tcg_memory_orders_compatible(void)
>> +{
>> +#if defined(TCG_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
>> +    return (TCG_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
>
> I am not sure this is what we intended. If the guest is weaker than the host,
> we can still run the guest if we translate the guest barriers. With the above,
> a strong host cannot run a weaker host.

I think this is confusing because of QEMU's overload of the term target.
TCG_TARGET_DEFAULT_MO is the memory order of the host. So if there is
any expected memory order on the guest side (TCG_DEFAULT_MO) that isn't
met by the host then we fail. In ARMs case TCG_DEFAULT_MO is 0 so it
will always pass.

> I think what we want is to disallow weak hosts from running stronger guests,
> since we do not enforce the implicit ordering semantics of the guest as of
> now.  In that case you can filter them out using the following:
>
> TCG_DEFAULT_MO | (TCG_DEFAULT_MO ^ ~TCG_TARGET_DEFAULT_MO) == TCG_MO_ALL
>
> We want our guest execution to prevent all possible re-ordering. The first
> term above is the host memory order. If the host is SC, we do not need to
> check anything else. If not, the second term tells us the difference in
> ordering between the guest and the host. It gives the kind of barriers
> which will be translated from guest to host. Both these together should cover
> all the cases for the memory order to be compatible.
>
> Thoughts?

That's the wrong way round. TCG_DEFAULT_MO is the guest memory order.
Maybe I should rename them to be explicitly:

TCG_GUEST_DEFAULT_MO
TCG_HOST_DEFAULT_MO

But that introduces another terminology into the TCG code.

>
> Thanks,


--
Alex Bennée
