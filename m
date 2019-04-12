Received: from eggs.gnu.org ([209.51.188.92]:59477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hF41q-0000YE-PI
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hF41p-0005Ov-OU
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:48:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hF41p-0005Nm-Dw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:48:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id c207so5748618pfc.7
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:48:08 -0700 (PDT)
Date: Fri, 12 Apr 2019 14:48:06 -0700 (PDT)
In-Reply-To: <CAKmqyKOSujRkv+JkgmP79FHVPZabg0QTki3c+BeFMTZpMFSYxA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-fe62b897-1d18-47aa-8dc1-ab08cad65092@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Do not allow sfence.vma from
 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: fintelia@gmail.com, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu

I actually missed this.  I just added it to for-next on 
github.com/palmer-dabbelt.

Thanks for the ping!

On Fri, 12 Apr 2019 14:23:42 PDT (-0700), alistair23@gmail.com wrote:
> On Fri, Apr 12, 2019 at 2:15 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>>
>> Just to double check, nothing further on this is need from me, right? It is set to be merged onto the master branch once the 4.0 release is out?
>
> Thanks for checking!
>
> Yep you don't need to do anything, Palmer will merge it in the next
> RISC-V PR after 4.0.
>
> Alistair
>
>>
>> Jonathan
>>
>> On Wed, Apr 3, 2019 at 7:11 PM Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Mon, Apr 1, 2019 at 1:39 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>>> >
>>> > The 'sfence.vma' instruction is privileged, and should only ever be allowed
>>> > when executing in supervisor mode or higher.
>>> >
>>> > Jonathan
>>> >
>>> > Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
>>>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Alistair
>>>
>>> > ---
>>> >  target/riscv/op_helper.c | 7 ++++---
>>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>>> > index b7dc18a41e..644d0fb35f 100644
>>> > --- a/target/riscv/op_helper.c
>>> > +++ b/target/riscv/op_helper.c
>>> > @@ -145,9 +145,10 @@ void helper_tlb_flush(CPURISCVState *env)
>>> >  {
>>> >      RISCVCPU *cpu = riscv_env_get_cpu(env);
>>> >      CPUState *cs = CPU(cpu);
>>> > -    if (env->priv == PRV_S &&
>>> > -        env->priv_ver >= PRIV_VERSION_1_10_0 &&
>>> > -        get_field(env->mstatus, MSTATUS_TVM)) {
>>> > +    if (!(env->priv >= PRV_S) ||
>>> > +        (env->priv == PRV_S &&
>>> > +         env->priv_ver >= PRIV_VERSION_1_10_0 &&
>>> > +         get_field(env->mstatus, MSTATUS_TVM))) {
>>> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>>> >      } else {
>>> >          tlb_flush(cs);
>>> > --
>>> > 2.20.1
