Received: from eggs.gnu.org ([209.51.188.92]:42119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtzBV-0008W2-45
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtz15-0004bk-DQ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:12:17 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtz14-0004aH-Ti
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:12:15 -0500
Received: by mail-pg1-x541.google.com with SMTP id r11so1513242pgp.6
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 10:12:14 -0800 (PST)
Date: Wed, 13 Feb 2019 10:12:12 -0800 (PST)
In-Reply-To: <CAKmqyKNPpRKYJunZLQrbNE9LmXLKkMcGUdghe3Ry6kO=R9TQLw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-eb63042f-42db-4a31-96b5-e13a0e1d2363@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix pmpcfg register indexing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: luke.r.nels@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, lukenels@pm.me, mjc@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>, xi.wang@gmail.com

On Fri, 08 Feb 2019 10:57:17 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Jan 30, 2019 at 2:20 PM Luke Nelson <luke.r.nels@gmail.com> wrote:
>>
>> pmpcfg_csr_{read,write} do not correctly handle accesses to PMP
>> configurations 8 through 15 (CSR pmpcfg2) on RV64.
>>
>> The current code computes the pmpcfg index using:
>>
>>   (reg_index * sizeof(target_ulong))
>>
>> This is incorrect on RV64.  For example, when reg_index is 2 (i.e.,
>> pmpcfg2), the computed configuration index will be 16-23, which
>> should be 8-15.
>>
>> A correct way is to use (reg_index * 4) instead, which works for
>> both RV32 and RV64.
>>
>> Cc: Xi Wang <xi.wang@gmail.com>
>> Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
>
> Good catch!
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Ya, thanks -- that's a somewhat embarrassing bug, as someone else just fixed 
one on the line below :).  I'll target this for my next PR.

>
> Alistair
>
>> ---
>>  target/riscv/pmp.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
>> index 15a5366616..a1bee56c86 100644
>> --- a/target/riscv/pmp.c
>> +++ b/target/riscv/pmp.c
>> @@ -311,9 +311,8 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
>>      }
>>
>>      for (i = 0; i < sizeof(target_ulong); i++) {
>> -        cfg_val = (val >> 8 * i)  & 0xff;
>> -        pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
>> -            cfg_val);
>> +        cfg_val = (val >> (i * 8)) & 0xff;
>> +        pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
>>      }
>>  }
>>
>> @@ -328,7 +327,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
>>      target_ulong val = 0;
>>
>>      for (i = 0; i < sizeof(target_ulong); i++) {
>> -        val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
>> +        val = pmp_read_cfg(env, (reg_index * 4) + i);
>>          cfg_val |= (val << (i * 8));
>>      }
>>
>> --
>> 2.19.1
>>
>>
