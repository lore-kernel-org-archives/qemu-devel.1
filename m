Received: from eggs.gnu.org ([2001:4830:134:3::10]:60905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZKkk-0002Hn-IE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZKkj-0003In-K1
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:05:30 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eZKkj-0003I8-7W
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:05:29 -0500
Received: by mail-wr0-x241.google.com with SMTP id w50so9017688wrc.11
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 10:05:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ec848ee7-85e7-de79-bb58-60ad12d33256@redhat.com>
References: <20180110064706.49777-1-lepton@google.com>
	<ec848ee7-85e7-de79-bb58-60ad12d33256@redhat.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Wed, 10 Jan 2018 10:05:26 -0800
Message-ID: <CAOvqHj5Q6Rv-OGc9B7-QMZw4BpOXkpkxK_r4HjQndtEy2zHiqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/i386: hax: Move
 hax_setup_qemu_emulator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, rth@twiddle.net, ehabkost@redhat.com

Thanks. Then it seems I should put this piece of code in a common
function first and then update this CL.

On Wed, Jan 10, 2018 at 5:27 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/01/2018 07:47, Tao Wu wrote:
>> hax_setup_qemu_emulator reference env->efer which is updated in
>> hax_get_msrs, so it has to be called after hax_get_msrs. This fix
>> the bug that sometimes dump_state show 32 bits regs even in 64 bits
>> mode.
>>
>> Signed-off-by: Tao Wu <lepton@google.com>
>> ---
>>  target/i386/hax-all.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>> index 3ce6950296..a933bd462d 100644
>> --- a/target/i386/hax-all.c
>> +++ b/target/i386/hax-all.c
>> @@ -887,9 +887,6 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
>>              return -1;
>>          }
>>      }
>> -    if (!set) {
>> -        hax_setup_qemu_emulator(env);
>> -    }
>>      return 0;
>>  }
>>
>> @@ -1070,6 +1067,7 @@ static int hax_arch_get_registers(CPUArchState *env)
>>          return ret;
>>      }
>>
>> +    hax_setup_qemu_emulator(env);
>>      return 0;
>>  }
>>
>>
>
> Queued, thanks.
>
> Please look into sharing the similar code in target/i386/kvm.c
> (kvm_get_sregs), since the HAX code has some bugs (for example,
> HF_CPL_MASK should be SS.DPL, not CS.DPL).
>
> Paolo
