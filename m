Received: from eggs.gnu.org ([2001:4830:134:3::10]:38974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwpXN-0003UX-1H
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwpXI-0006W8-30
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:04:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwpXH-0006Vm-U3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:04:28 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-10-david@redhat.com>
	<d1e53b94-8545-5db0-d4e9-58b5ce5fef1f@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f1006d03-c175-f057-49ae-122d1fd1480c@redhat.com>
Date: Tue, 26 Sep 2017 15:04:23 +0200
MIME-Version: 1.0
In-Reply-To: <d1e53b94-8545-5db0-d4e9-58b5ce5fef1f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/27] target/s390x: factor out handling
 of WAIT PSW into handle_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>


>> +
>> +void handle_wait(S390CPU *cpu)
> 
> "handle_wait" is a very generic name ... could you maybe at least name
> this "s390x_handle_wait" or so?

sure, will do, thanks!

> 
>> +{
>> +    cpu_synchronize_state(CPU(cpu));
>> +    if (s390_cpu_halt(cpu) == 0) {
>> +#ifndef CONFIG_USER_ONLY
>> +        if (is_special_wait_psw(cpu->env.psw.addr)) {
>> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> +        } else {
>> +            qemu_system_guest_panicked(NULL);
>> +        }
>> +#endif
>> +    }
>> +}
[...]

>> -            cpu_synchronize_state(cs);
> 
> Maybe we should rather keep the cpu_synchronize_state() here instead of
> putting it in helper.c? No other function in helper.c seems to call that
> on its own yet...

Don't have a strong opinion on this, as long as it works :)

> 
>> -            if (s390_cpu_halt(cpu) == 0) {
>> -                if (is_special_wait_psw(cs)) {
>> -                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> -                } else {
>> -                    qemu_system_guest_panicked(NULL);
>> -                }
>> -            }
>> +            handle_wait(cpu);
>>              r = EXCP_HALTED;
>>              break;
>>          case ICPT_CPU_STOP:
>>
> 
>  Thomas
> 


-- 

Thanks,

David
