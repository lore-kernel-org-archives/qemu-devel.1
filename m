Received: from eggs.gnu.org ([2001:4830:134:3::10]:37388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLz1X-0007tJ-70
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLz1W-0001S3-2y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:47:55 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fLz1V-0001Rs-ST
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:47:54 -0400
Received: by mail-wm0-x241.google.com with SMTP id t11-v6so9392563wmt.0
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:47:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <625fe1a3-fe18-6216-eeb2-393f90817bff@amsat.org>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-16-git-send-email-mjc@sifive.com>
	<625fe1a3-fe18-6216-eeb2-393f90817bff@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 May 2018 15:47:22 -0700
Message-ID: <CAKmqyKNGpOf1Sxrv9f2e9A_XP=JC0REgpwjzZfnsF7kePey0Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 15/30] RISC-V: Add hartid and \n to
 interrupt logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Michael Clark <mjc@sifive.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, patches@groups.riscv.org

On Wed, May 23, 2018 at 5:33 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Michael,
>
> On 05/22/2018 09:15 PM, Michael Clark wrote:
>> Add carriage return that was erroneously removed
>> when converting to qemu_log. Change hard coded
>> core number to the actual hartid.
>
> I think it makes more sens to move this patch before your 6/30 "Move
> non-ops from op_helper to cpu_helper".
>
>>
>> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Alistair Francis <Alistair.Francis@wdc.com>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
>> ---
>>  target/riscv/cpu_helper.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index bc15e19022cc..69592c037042 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -446,11 +446,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>      if (RISCV_DEBUG_INTERRUPT) {
>>          int log_cause =3D cs->exception_index & RISCV_EXCP_INT_MASK;
>>          if (cs->exception_index & RISCV_EXCP_INT_FLAG) {
>> -            qemu_log_mask(LOG_TRACE, "core   0: trap %s, epc 0x" TARGET=
_FMT_lx,
>> -                riscv_intr_names[log_cause], env->pc);
>> +            qemu_log_mask(LOG_TRACE, "core "
>> +                TARGET_FMT_ld ": trap %s, epc 0x" TARGET_FMT_lx "\n",
>> +                env->mhartid, riscv_intr_names[log_cause], env->pc);
>>          } else {
>> -            qemu_log_mask(LOG_TRACE, "core   0: intr %s, epc 0x" TARGET=
_FMT_lx,
>> -                riscv_excp_names[log_cause], env->pc);
>> +            qemu_log_mask(LOG_TRACE, "core "
>> +                TARGET_FMT_ld ": intr %s, epc 0x" TARGET_FMT_lx "\n",
>> +                env->mhartid, riscv_excp_names[log_cause], env->pc);
>>          }
>>      }
>>
>> @@ -512,8 +514,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>
>>          if (hasbadaddr) {
>>              if (RISCV_DEBUG_INTERRUPT) {
>> -                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
>> -                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->ba=
daddr);
>> +                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badad=
dr 0x"
>> +                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
>>              }
>>              env->sbadaddr =3D env->badaddr;
>>          } else {
>> @@ -537,8 +539,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>
>>          if (hasbadaddr) {
>>              if (RISCV_DEBUG_INTERRUPT) {
>> -                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
>> -                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->ba=
daddr);
>> +                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badad=
dr 0x"
>> +                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
>>              }
>>              env->mbadaddr =3D env->badaddr;
>>          } else {
>>
>
