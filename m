Received: from eggs.gnu.org ([2001:4830:134:3::10]:35674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr6X3-0006S0-Kv
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 14:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr6X2-0007xf-Rn
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 14:00:33 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<333a9b48-d30d-03b9-83e4-52a24b2128f3@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ddecc45a-0199-8e83-0575-1227ac1ca02c@ilande.co.uk>
Date: Sun, 10 Sep 2017 19:00:13 +0100
MIME-Version: 1.0
In-Reply-To: <333a9b48-d30d-03b9-83e4-52a24b2128f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] ppc: change CPUPPCState access_type
 from int to uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru

On 10/09/17 17:30, Laurent Vivier wrote:

> On 10/09/2017 16:37, Mark Cave-Ayland wrote:
>> This change was suggested by Alexey in advance of a subsequent commit which
>> adds access_type into vmstate_ppc_cpu.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/cpu.h     |    4 ++--
>>  target/ppc/machine.c |    4 +++-
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 12f0949..59d1656 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1010,8 +1010,8 @@ struct CPUPPCState {
>>      /* Next instruction pointer */
>>      target_ulong nip;
>>  
>> -    int access_type; /* when a memory exception occurs, the access
>> -                        type is stored here */
>> +    uint8_t access_type; /* when a memory exception occurs, the access
>> +                            type is stored here */
> 
> I think this breaks TCG as we have:
> 
> target/ppc/translate.c:
> 
>      82 void ppc_translate_init(void)
> ...
>     191 
>     192     cpu_access_type = tcg_global_mem_new_i32(cpu_env,
>     193                                              offsetof(CPUPPCState, access_type), "access_type");
>     194 
>     195     done_init = 1;
>     196 }
> 
> it expects an int32_t (or int).

Indeed, yes. I'm really surprised this didn't break compilation or
anything at runtime...

Having a further look I can't see any implementations for
tcg_global_mem_new_u8() or tcg_gen_movi_u8() so changing this isn't a
straightforward type swap.

Alexey, do you still think this is required?


ATB,

Mark.
