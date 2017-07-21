Received: from eggs.gnu.org ([2001:4830:134:3::10]:37469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dYSOs-0007fD-BT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dYSOo-0008N7-DM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:31:02 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dYSOo-0008LE-4H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:30:58 -0400
Received: by mail-it0-x243.google.com with SMTP id v127so3305343itd.2
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 00:30:56 -0700 (PDT)
References: <20170721041952.45950-1-aik@ozlabs.ru>
	<b3ed544c-a576-7a74-b7b0-8067873cf11e@amsat.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c7cc6429-fe77-2b47-d08b-f4266524407e@ozlabs.ru>
Date: Fri, 21 Jul 2017 17:30:49 +1000
MIME-Version: 1.0
In-Reply-To: <b3ed544c-a576-7a74-b7b0-8067873cf11e@amsat.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu] Revert "elf-loader: warn about
 invalid endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Paul Burton <paul.burton@imgtec.com>, Alistair Francis <alistair.francis@xilinx.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

On 21/07/17 16:48, Philippe Mathieu-Daudé wrote:
> Hi Alexey,
> 
> On 07/21/2017 01:19 AM, Alexey Kardashevskiy wrote:
>> This reverts c8e1158cf611 "elf-loader: warn about invalid endianness"
>> as it produces a useless message every time an LE kernel image is
>> passed via -kernel on a ppc64-pseries machine. The pseries machine
>> already checks for ELF_LOAD_WRONG_ENDIAN and tries with big_endian=0.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   hw/core/loader.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index c17ace0a2e..e5e8cbb638 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -480,7 +480,6 @@ int load_elf_ram(const char *filename,
>>       }
>>         if (target_data_order != e_ident[EI_DATA]) {
>> -        fprintf(stderr, "%s: wrong endianness\n", filename);
>>           ret = ELF_LOAD_WRONG_ENDIAN;
>>           goto fail;
>>       }
>>
> 
> I submitted this patch because I spent some time debugging while QEMU was
> failing silently using a MIPS kernel image which used to work, after
> realizing I was in an incorrect build_dir using qemu-system-mipsel to load
> a big endian image and felt stupid [1]. This dumb error can happen to other
> people so I added this warning here.

Been there too. This is why we try loading images twice in pseries.

> I was not aware of the ELF_LOAD_WRONG_ENDIAN related code, and at least the
> MIPS arch is not using it.
> As I can see in MAINTAINERS, sPAPR is "Supported" meaning "Someone is
> actually paid to look after this", while there is no such paid person for
> the MIPS part.
> It seems each arch had a different way to load images and hw/core/loader.c
> was an effort to merge common code but mostly "Supported" arch are using it.

afaict MIPS calls load_elf() in 4 places, each checks for the return value
and already prints the message, how come that that message is not enough?
What would probably make sense here is if MIPS also printed the return code
from load_elf() but in any case it is easily visible from gdb.


> While your revert does fixes your sPAPR warning issue, looking at the
> problem roots I think the correct fix is to improve the MIPS port and
> eventually the less loved archs to unify the loader.c calls and avoid such
> problems.
> I don't object reverting this patch for 2.10 and improve the loader.c usage
> during 2.11 cycle, I only wonder if this is another corporate/hobbyist> conflict of interest with corporate crushing on hobbyist instead of

Come on mate...


> helping, motivating contribution improving common code usage.
> 
> Cc'ed MIPS and loader.c maintainers (both "Maintained" and not "Supported").
> 
> Phil.
> 
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05926.html


-- 
Alexey
