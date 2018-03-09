Received: from eggs.gnu.org ([2001:4830:134:3::10]:55223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euOxy-0005KU-E0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euOxx-0007hk-E2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:50:14 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:41314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euOxx-0007hK-3N
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:50:13 -0500
Received: by mail-ot0-x235.google.com with SMTP id w38so9877983ota.8
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 12:50:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f02255ad-f0f9-9e7e-8ae7-6c588e41126a@redhat.com>
References: <1520626818-93348-1-git-send-email-mjc@sifive.com>
	<f02255ad-f0f9-9e7e-8ae7-6c588e41126a@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 09:50:11 +1300
Message-ID: <CAHNT7NuBc0S9GY1pbdv3tzCBeOY2Q6MtfPOR2asnwT03QJXpVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix isa string logic bug,
 use popcount to count bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>

On Sat, Mar 10, 2018 at 9:33 AM, Eric Blake <eblake@redhat.com> wrote:

> [resend, this time with proper cc's]
>
> On 03/09/2018 02:20 PM, Michael Clark wrote:
>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>> ---
>>   target/riscv/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 4851890..f0d6d1d 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -391,7 +391,7 @@ static const TypeInfo riscv_cpu_type_info = {
>>   char *riscv_isa_string(RISCVCPU *cpu)
>>   {
>>       int i;
>> -    size_t maxlen = 5 + ctz32(cpu->env.misa);
>> +    size_t maxlen = 5 + __builtin_popcountll(cpu->env.misa);
>>       char *isa_string = g_new0(char, maxlen);
>>       snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
>>       for (i = 0; i < sizeof(riscv_exts); i++) {
>>
>
> I'd rather you used ctpop64() from host-utils.h, so we have a centralized
> place to change things just once in case we have to tweak the use of
> __builtin_popcount when targetting a different compiler.


Okay. I'll revise the patch...
