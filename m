Received: from eggs.gnu.org ([2001:4830:134:3::10]:54728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euzQy-0002hy-OV
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 07:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euzQv-0003RW-M6
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 07:46:36 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euzQv-0003R2-Ek
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 07:46:33 -0400
Received: by mail-wr0-x244.google.com with SMTP id z12so12953176wrg.4
	for <qemu-devel@nongnu.org>; Sun, 11 Mar 2018 04:46:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1520629272-98060-1-git-send-email-mjc@sifive.com>
	<a407b0b4-17fc-e399-d0b1-c2eaf87a4836@amsat.org>
Message-ID: <fb92325c-db7f-d86e-af92-49ee36e097d3@amsat.org>
Date: Sun, 11 Mar 2018 12:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <a407b0b4-17fc-e399-d0b1-c2eaf87a4836@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] RISC-V: Fix riscv_isa_string,
 use popcount to count bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>

On 03/10/2018 10:25 PM, Philippe Mathieu-Daudé wrote:
> On 03/09/2018 10:01 PM, Michael Clark wrote:
>> Logic bug caused the string size calculation for the RISC-V
>> format ISA string to be small. This fix allows slack for rv128.
>>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>> ---
>>  target/riscv/cpu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 4851890..1456535 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -391,7 +391,7 @@ static const TypeInfo riscv_cpu_type_info = {
>>  char *riscv_isa_string(RISCVCPU *cpu)
>>  {
>>      int i;
>> -    size_t maxlen = 5 + ctz32(cpu->env.misa);
>> +    size_t maxlen = 8 + ctpop64(cpu->env.misa);
> 
> Can you document the magic 5/8?
> 
> This looks nice, but this seems to me too much optimization to save few
> bytes, using sizeof(riscv_exts) is overflow-free.
> 
> Maybe this is enough and self-explanatory:
> 
>        const size_t maxlen = sizeof("rv128") + sizeof(riscv_exts);

Oops:
         const size_t maxlen = sizeof("rv128") + sizeof(riscv_exts) + 1;

> 
>>      char *isa_string = g_new0(char, maxlen);
>>      snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
> 
> Also, if you keep the snprintf() return value, you can (naming it 'n')
> simplify (also easier to review):
> 
>>      for (i = 0; i < sizeof(riscv_exts); i++) {
>>
>         if (cpu->env.misa & RV(riscv_exts[i])) {
> -           isa_string[strlen(isa_string)] = riscv_exts[i] - 'A' + 'a';
> +           isa_string[n++] = tolower(riscv_exts[i]);
>         }
>     }
> 
> and simply use g_new() with:
> 
> +   isa_string[n] = '\0';
> 
>     return isa_string;
> }
> 
> Regards,
> 
> Phil.
> 
