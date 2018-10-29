Received: from eggs.gnu.org ([2001:4830:134:3::10]:50424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHDhn-0001LL-RZ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHDhi-0004TW-Ah
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:00:07 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHDhg-0004SI-Mg
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:00:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id c10-v6so4429419pgq.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:59:59 -0700 (PDT)
Date: Mon, 29 Oct 2018 12:59:56 -0700 (PDT)
In-Reply-To: <CAKmqyKPthXEC6fGf5cut_GqrJ6f76tzeqGo6A=Bj=3f+dKW9zw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-7dab1695-5c50-481a-9b71-ff31fc0f4bd7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/riscv/pmp.c: pmpcfg_csr_read
 returns bogus value on RV64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: dayeol@berkeley.edu, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu

On Sat, 27 Oct 2018 01:42:02 PDT (-0700), alistair23@gmail.com wrote:
> On Fri, Oct 26, 2018 at 7:14 PM Dayeol Lee <dayeol@berkeley.edu> wrote:
>>
>> Hi,
>>
>> I submitted the patch, but just found this has been already fixed by
>> Michael Clark
>> and pushed to riscv/riscv-qemu https://github.com/riscv/riscv-qemu/pull/166
>> but not in the upstream.
>>
>> Do we still need this patch?
>
> Yeah, this patch is still needed as it fixes the problem in mainline.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair

Thanks.  I added this to for-master, I'll include it with this week's PR.

>
>>
>> Thanks,
>>
>> Dayeol
>>
>> On Fri, Oct 26, 2018 at 11:04 AM Dayeol Lee <dayeol@berkeley.edu> wrote:
>>
>> > pmp_read_cfg() returns 8-bit value, which is combined together to form a
>> > single pmpcfg CSR.
>> > The default promotion rules will result in an integer here ("i*8" is
>> > integer, which
>> > flows through) resulting in a 32-bit signed value on most hosts.
>> > That's bogus on RV64I, with the high bits of the CSR being wrong.
>> >
>> > Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
>> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> > ---
>> >  target/riscv/pmp.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
>> > index c828950..3d3906a 100644
>> > --- a/target/riscv/pmp.c
>> > +++ b/target/riscv/pmp.c
>> > @@ -330,7 +330,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env,
>> > uint32_t reg_index)
>> >  {
>> >      int i;
>> >      target_ulong cfg_val = 0;
>> > -    uint8_t val = 0;
>> > +    target_ulong val = 0;
>> >
>> >      if(sizeof(target_ulong) == 8)
>> >          reg_index /= 2;
>> > --
>> > 2.7.4
>> >
>> >
