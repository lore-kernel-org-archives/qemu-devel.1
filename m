Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D0C5AD43
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AE120757
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AE120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xes-inc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEaCG-0002CJ-M8
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 11:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vfazio@xes-inc.com>) id 1jEaBM-0001Q7-0i
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vfazio@xes-inc.com>) id 1jEaBD-0007Hx-Ls
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:00:31 -0400
Received: from xes-mad.com ([162.248.234.2]:20005 helo=mail.xes-mad.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vfazio@xes-inc.com>)
 id 1jEaBD-0006zz-FU; Wed, 18 Mar 2020 11:00:23 -0400
Received: from [10.52.16.140] (vfazio1.xes-mad.com [10.52.16.140])
 by mail.xes-mad.com (Postfix) with ESMTP id 2206D20296;
 Wed, 18 Mar 2020 10:00:20 -0500 (CDT)
Subject: Re: [PATCH 1/1] target/ppc: fix ELFv2 signal handler endianness
To: David Gibson <david@gibson.dropbear.id.au>,
 Vincent Fazio <vfazio@gmail.com>
References: <20200315155202.13107-1-vfazio@xes-inc.com>
 <346e47c8-4a80-860c-ec55-e38d2021d63d@vivier.eu>
 <CAOrEah5Fq7Kp9wF_4Vtb4Qfcdm0gtwin_5b_ft7h7my+RnTOWA@mail.gmail.com>
 <20200316022107.GA2013@umbus.fritz.box>
From: Vincent Fazio <vfazio@xes-inc.com>
Message-ID: <0a4f5e07-3934-ea6b-4fe1-9fc3ec4c8d85@xes-inc.com>
Date: Wed, 18 Mar 2020 10:00:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316022107.GA2013@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 162.248.234.2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David, Laurent,

On 3/15/20 9:21 PM, David Gibson wrote:
> On Sun, Mar 15, 2020 at 07:29:04PM -0500, Vincent Fazio wrote:
>> Laurent,
>>
>> On Sun, Mar 15, 2020 at 1:10 PM Laurent Vivier <laurent@vivier.eu> wro=
te:
>>> Le 15/03/2020 =E0 16:52, Vincent Fazio a =E9crit :
>>>> From: Vincent Fazio <vfazio@gmail.com>
>>>>
>>>> In ELFv2, function pointers are entry points and are in host endiann=
ess.
>>> "host endianness" is misleading here. "target endianness" is better.
> Yeah, the trouble here is that I think the ELF spec will use "host"
> and "target" in a quite different sense than qemu.
>
I'll be simplifying the wording in the message to just mention the=20
problematic cross-endian scenario
>> I do want to clarify here. In a mixed endian scenario (my test case
>> was an x86 host and e5500 PPC BE target), the function pointers are in
>> host endianness (little endian) so that the virtual address can be
>> dereferenced by the host for the target instructions to be
>> translated.
> This can't be right.  The ELF is operating entirely within the guest,
> and has no concept of a host (in the qemu sense).  Therefore it's
> impossible for it to specify anything as "host endian" (again in the
> qemu sense).
>
> It *is* possible that it's little endian explicitly (in which case
> we'd need a conditional swap that's different from the one we have
> now).
>
> But even that seems pretty odd.  AFAICT that target_sigaction
> structure is copied verbatim from guest memory when the guest makes
> the sigaction() syscall.  Are we expecting a BE process to put LE
> parameters into a syscall structure?  That seems unlikely.
>
> I really think you need to put some instrumentation in the sigaction()
> call that comes before this, to see exactly what the guest process is
> supplying there.
>
> And then we maybe need to look at your guest side libc and/or a native
> e5500 BE kernel to see what it expects in that structure.
As we discussed in the other thread, I missed the endian swap done as=20
part of get_user in do_sigaction. So while my initial determination for=20
the root cause of the problem was wrong, the fix is still the same (drop=20
the `tswapl` call). The commit message will be updated.
>>>> Previously, the signal handler would be swapped if the target CPU wa=
s a
>>>> different endianness than the host. This would cause a SIGSEGV when
>>>> attempting to translate the opcode pointed to by the swapped address=
.
>>> This is correct.
>>>
>>>>   Thread 1 "qemu-ppc64" received signal SIGSEGV, Segmentation fault.
>>>>   0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/=
include/qemu/bswap.h:351
>>>>   351        __builtin_memcpy(&r, ptr, sizeof(r));
>>>>
>>>>   #0  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at q=
emu/include/qemu/bswap.h:351
>>>>   #1  0x00000000600a92fe in ldl_be_p (ptr=3D0x4c2c061000000000) at q=
emu/include/qemu/bswap.h:449
>>>>   #2  0x00000000600c0790 in translator_ldl_swap at qemu/include/exec=
/translator.h:201
>>>>   #3  0x000000006011c1ab in ppc_tr_translate_insn at qemu/target/ppc=
/translate.c:7856
>>>>   #4  0x000000006005ae70 in translator_loop at qemu/accel/tcg/transl=
ator.c:102
>>>>
>>>> Now, no swap is performed and execution continues properly.
>>>>
>>>> Signed-off-by: Vincent Fazio <vfazio@gmail.com>
>>>> ---
>>>>   linux-user/ppc/signal.c | 10 +++++++---
>>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
>>>> index 5b82af6cb6..c7f6455170 100644
>>>> --- a/linux-user/ppc/signal.c
>>>> +++ b/linux-user/ppc/signal.c
>>>> @@ -567,9 +567,13 @@ void setup_rt_frame(int sig, struct target_siga=
ction *ka,
>>>>           env->nip =3D tswapl(handler->entry);
>>>>           env->gpr[2] =3D tswapl(handler->toc);
>>>>       } else {
>>>> -        /* ELFv2 PPC64 function pointers are entry points, but R12
>>>> -         * must also be set */
>>>> -        env->nip =3D tswapl((target_ulong) ka->_sa_handler);
>>>> +        /*
>>>> +         * ELFv2 PPC64 function pointers are entry points and are i=
n host
>>>> +         * endianness so should not to be swapped.
>>> "target endianness"
>>>
>>>> +         *
>>>> +         * Note: R12 must also be set.
>>>> +         */
>>>> +        env->nip =3D (target_ulong) ka->_sa_handler;
>>> The cast is not needed: nip and _sa_handler are abi_ulong.
>> I'll drop this in v2
>>
>>>>           env->gpr[12] =3D env->nip;
>>>>       }
>>>>   #else
>>>>
>>> If you repost with the fix I've reported above you can add my:
>>>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>>
>> I'll hold off on reposting until the endianness wording is figured out=
.
I'll be submitting v2 shortly, but it will have a different commit=20
message to better reflect the issue.
>>> Thanks,
>>> Laurent
>> Thanks,
>> -Vincent
>>
--=20
Vincent Fazio
Embedded Software Engineer - Linux
Extreme Engineering Solutions, Inc
http://www.xes-inc.com


