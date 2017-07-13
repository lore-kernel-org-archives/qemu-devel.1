Received: from eggs.gnu.org ([2001:4830:134:3::10]:44934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVcBB-0001ME-Qn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVcB8-0000bA-Mp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:21:09 -0400
Received: from 18.mo7.mail-out.ovh.net ([188.165.56.163]:44664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dVcB8-0000b2-G9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:21:06 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id F3CF8623B9
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 13:21:04 +0200 (CEST)
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
	<87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
	<b54ec156-725d-d954-1d05-ade845caa2a2@kaod.org>
	<878tjsbwj4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<5fa5cb00-ee28-0ba4-2084-b0a43b8429f1@kaod.org>
	<8760ewbt38.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a1a877d2-b24a-c4dc-c672-e0019e21fd20@kaod.org>
	<87wp7caaqa.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6aedc1da-743d-43a6-77de-ab7821a4e13d@kaod.org>
Date: Thu, 13 Jul 2017 13:20:55 +0200
MIME-Version: 1.0
In-Reply-To: <87wp7caaqa.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC] spapr: ignore interrupts
 during reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: alex.bennee@linaro.org, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net

On 07/13/2017 12:32 PM, Nikunj A Dadhania wrote:
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
>> On 07/13/2017 11:10 AM, Nikunj A Dadhania wrote:
>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>
>>>> On 07/13/2017 09:55 AM, Nikunj A Dadhania wrote:
>>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>>
>>>>>>>> How about the following, we do not report work until MSR_EE is d=
isabled:
>>>>>>>
>>>>>>> With this fix, I could test the XIVE<->XICS transitions at reboot=
=20
>>>>>>> under TCG. However, the second boot is very slow for some reason.=
=20
>>>>>>
>>>>>> hmm, I am not sure this is related but I just got :=20
>>>>>
>>>>> Havent seen in my setup after around 10 reboot cycles, I was using =
2
>>>>> cores pseries setup. Lets give it some more testing. When did this
>>>>> happen, during boot ?
>>>>
>>>> yes.=20
>>>>
>>>> I could not reproduce either :/ but I am keeping the patch. qemu run=
s
>>>> with :
>>>>
>>>> -m 2G -M pseries -accel tcg,thread=3Dmulti -cpu POWER9 -smp cores=3D=
4,maxcpus=3D8 -realtime mlock=3Doff -kernel ./vmlinux-4.12.0+ -initrd ./i=
nitrd.img-4.12.0+ -append 'console=3Dhvc0 dyndbg=3D"file arch/powerpc/sys=
dev/xive/* +p"' -nographic -nodefaults -serial mon:stdio -snapshot  -d gu=
est_errors,unimp -no-shutdown
>>>>
>>>
>>> With 4 cores I am seeing hangs occasionally, although I havent seen a
>>> crash. But seems to be similar problem that you had seen.
>>
>> The results are good with 4 and 8 cores and so you can add my Tested-b=
y:
>=20
> Did you try my last patch?

Yes. I am using this one.

Thanks,

C.=20

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 783bf98..07e405f 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8536,7 +8536,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
             (env->spr[SPR_LPCR] & LPCR_P7_PECE1)) {
-            return true;
+            return msr_ee ? true : false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK)) &&
             (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
@@ -8693,7 +8693,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
             (env->spr[SPR_LPCR] & LPCR_P8_PECE3)) {
-            return true;
+            return msr_ee ? true : false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK)) &&
             (env->spr[SPR_LPCR] & LPCR_P8_PECE4)) {
@@ -8876,7 +8876,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         /* Decrementer Exception */
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
             (env->spr[SPR_LPCR] & LPCR_DEE)) {
-            return true;
+            return msr_ee ? true : false;
         }
         /* Machine Check or Hypervisor Maintenance Exception */
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK |
