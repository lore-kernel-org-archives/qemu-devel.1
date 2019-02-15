Received: from eggs.gnu.org ([209.51.188.92]:41705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gufRw-00035J-BT
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gufRt-0006Dr-8u
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:30:47 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:42047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gufRr-0005nE-8j
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:30:43 -0500
Received: from player699.ha.ovh.net (unknown [10.109.159.152])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 167BFF3B4A
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 16:30:34 +0100 (CET)
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-9-clg@kaod.org>
	<20190212060227.GO1884@umbus.fritz.box>
	<8adeacf3681e03343d64fac82b73505ffa122bfd.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a6e5ece9-67aa-e8e2-0f07-08dc4a85afd0@kaod.org>
Date: Fri, 15 Feb 2019 16:30:29 +0100
MIME-Version: 1.0
In-Reply-To: <8adeacf3681e03343d64fac82b73505ffa122bfd.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/19] target/ppc: Fix nip on power
 management instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/13/19 1:04 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2019-02-12 at 17:02 +1100, David Gibson wrote:
>> On Mon, Jan 28, 2019 at 10:46:14AM +0100, C=C3=A9dric Le Goater wrote:
>>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>
>>> Those instructions currently raise an exception from within
>>> the helper. This tends to result in a bogus nip value in
>>> the env context (typically the beginning of the TB). Such
>>> a helper needs a gen_update_nip() first.
>>>
>>> This fixes it with a different approach which is to throw
>>> the exception from translate.c instead of the helper using
>>> gen_exception_nip() which does the right thing.
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>>  target/ppc/excp_helper.c |  1 -
>>>  target/ppc/translate.c   | 12 ++++++++----
>>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>>> index 751d759fcc1d..8407e0ade938 100644
>>> --- a/target/ppc/excp_helper.c
>>> +++ b/target/ppc/excp_helper.c
>>> @@ -958,7 +958,6 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_i=
nsn_t insn)
>>>       * but this doesn't seem to be a problem.
>>>       */
>>>      env->msr |=3D (1ull << MSR_EE);
>>> -    raise_exception(env, EXCP_HLT);
>>>  }
>>>  #endif /* defined(TARGET_PPC64) */
>>> =20
>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>> index 7d40a1fbe6bd..55281a8975e0 100644
>>> --- a/target/ppc/translate.c
>>> +++ b/target/ppc/translate.c
>>> @@ -3571,7 +3571,8 @@ static void gen_doze(DisasContext *ctx)
>>>      t =3D tcg_const_i32(PPC_PM_DOZE);
>>>      gen_helper_pminsn(cpu_env, t);
>>>      tcg_temp_free_i32(t);
>>> -    gen_stop_exception(ctx);
>>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>
>> IIUC this also changes from EXCP_STOP to EXCP_HLT, is that intentional=
?
>=20
> Off the top of my head, it might be to break out of the outer exec
> loop, but I don't remember off hand.

yes and POWERPC_EXCP_STOP is only used under linux-user, which is the=20
wrong value to exit from the cpu exec loop.

I think this is correct.

C.=20
=20

>>>  #endif /* defined(CONFIG_USER_ONLY) */
>>>  }
>>> =20
>>> @@ -3586,7 +3587,8 @@ static void gen_nap(DisasContext *ctx)
>>>      t =3D tcg_const_i32(PPC_PM_NAP);
>>>      gen_helper_pminsn(cpu_env, t);
>>>      tcg_temp_free_i32(t);
>>> -    gen_stop_exception(ctx);
>>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>  #endif /* defined(CONFIG_USER_ONLY) */
>>>  }
>>> =20
>>> @@ -3606,7 +3608,8 @@ static void gen_sleep(DisasContext *ctx)
>>>      t =3D tcg_const_i32(PPC_PM_SLEEP);
>>>      gen_helper_pminsn(cpu_env, t);
>>>      tcg_temp_free_i32(t);
>>> -    gen_stop_exception(ctx);
>>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>  #endif /* defined(CONFIG_USER_ONLY) */
>>>  }
>>> =20
>>> @@ -3621,7 +3624,8 @@ static void gen_rvwinkle(DisasContext *ctx)
>>>      t =3D tcg_const_i32(PPC_PM_RVWINKLE);
>>>      gen_helper_pminsn(cpu_env, t);
>>>      tcg_temp_free_i32(t);
>>> -    gen_stop_exception(ctx);
>>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>  #endif /* defined(CONFIG_USER_ONLY) */
>>>  }
>>>  #endif /* #if defined(TARGET_PPC64) */
>=20
