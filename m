Received: from eggs.gnu.org ([2001:4830:134:3::10]:60915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC03j-0001KO-IR
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC03f-0003KC-8V
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:20:39 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:55568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC03f-0003Je-0g
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:20:35 -0500
Received: by mail-wr0-x241.google.com with SMTP id l8so11150311wre.12
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 01:20:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4fcd39ca-7e73-01b2-e9bc-1c690c9d5dec@vivier.eu>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-4-git-send-email-peter.maydell@linaro.org>
	<4fcd39ca-7e73-01b2-e9bc-1c690c9d5dec@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 09:20:13 +0000
Message-ID: <CAFEAcA_ATV-L=HUDwDt0AUqdpFvDiH1emzs7k7+YfmR1YC1K-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] linux-user/sparc: Put address for data
 faults where linux-user expects it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On 7 November 2017 at 08:28, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 06/11/2017 =C3=A0 19:33, Peter Maydell a =C3=A9crit :
>> In the user-mode-only version of sparc_cpu_handle_mmu_fault(),
>> we must save the fault address for a data fault into the CPU
>> state's mmu registers, because the code in linux-user/main.c
>> expects to find it there in order to populate the si_addr
>> field of the guest siginfo.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/sparc/mmu_helper.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
>> index 126ea5e..d5b6c1e 100644
>> --- a/target/sparc/mmu_helper.c
>> +++ b/target/sparc/mmu_helper.c
>> @@ -30,10 +30,18 @@
>>  int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
>>                                 int mmu_idx)
>>  {
>> +    SPARCCPU *cpu =3D SPARC_CPU(cs);
>> +    CPUSPARCState *env =3D &cpu->env;
>> +
>>      if (rw & 2) {
>>          cs->exception_index =3D TT_TFAULT;
>>      } else {
>>          cs->exception_index =3D TT_DFAULT;
>> +#ifdef TARGET_SPARC64
>> +        env->dmmu.mmuregs[4] =3D address;
>> +#else
>> +        env->mmuregs[4] =3D address;
>> +#endif
>>      }
>>      return 1;
>>  }
>>
>
> The softmmu version of sparc_cpu_handle_mmu_fault() also updates
> mmuregs[3]. Is it needed for this one (for ucontext)?

Nothing in linux-user/ reads mmuregs[3], so I assume not.

thanks
-- PMM
