Received: from eggs.gnu.org ([2001:4830:134:3::10]:50567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1du2YE-0007fz-7c
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1du2Y5-0004OK-Lt
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1du2Y5-0004Mj-Fa
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:21:45 -0400
From: David Hildenbrand <david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-24-david@redhat.com>
	<651594b8-0d18-fd61-f0e9-287ad098306d@redhat.com>
Message-ID: <17cdabba-97ac-50b0-678d-e48ff903553e@redhat.com>
Date: Mon, 18 Sep 2017 22:21:41 +0200
MIME-Version: 1.0
In-Reply-To: <651594b8-0d18-fd61-f0e9-287ad098306d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 23/27] s390x/tcg: implement STOP and
 RESET interrupts for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 18.09.2017 22:00, David Hildenbrand wrote:
> 
>>  static void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
>> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
>> index ce8fda9d01..521dcc75f3 100644
>> --- a/target/s390x/sigp.c
>> +++ b/target/s390x/sigp.c
>> @@ -498,6 +498,7 @@ void do_stop_interrupt(CPUS390XState *env)
>>          s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>>      }
>>      env->sigp_order = 0;
>> +    env->pending_int &= ~INTERRUPT_STOP;
> 
> The *awesome* kvm-unit-tests (yes, the single sigp_stop() we do when
> shutting down) just found a missing cpu_loop_exit()
> 
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index ce8fda9d01..9aadc3ffdd 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -498,6 +498,11 @@ void do_stop_interrupt(CPUS390XState *env)
>          s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>      }
>      env->sigp_order = 0;
> +    env->pending_int &= ~INTERRUPT_STOP;
> +#ifdef CONFIG_TCG
> +    /* the CPU has been stopped, we must immediately go out of the loop */
> +    cpu_loop_exit(CPU(s390_env_get_cpu(env)));
> +#endif
>  }
> 

if (tcg_enabled()) of course ...


-- 

Thanks,

David
