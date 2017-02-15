Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ce7WQ-0001gO-C9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ce7WN-00080n-94
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:53:58 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ce7WN-00080N-3Y
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:53:55 -0500
Received: by mail-pg0-x241.google.com with SMTP id v184so12134883pgv.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 13:53:54 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
	<20170213121017.12907-13-alex.bennee@linaro.org>
	<0d990570-8318-7bba-c10c-cfe0387fdd1b@twiddle.net>
	<87h93xujv3.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f6ab9967-6b88-4c49-fdc9-4203cbda3e7d@twiddle.net>
Date: Thu, 16 Feb 2017 08:53:41 +1100
MIME-Version: 1.0
In-Reply-To: <87h93xujv3.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 12/24] tcg: handle EXCP_ATOMIC
 exception for system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: mttcg@greensocs.com, peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, serge.fdrv@gmail.com, pbonzini@redhat.com, bobby.prani@gmail.com, bamvor.zhangjian@linaro.org, fred.konrad@greensocs.com

On 02/14/2017 09:50 PM, Alex Bennée wrote:
>
> Richard Henderson <rth@twiddle.net> writes:
>
>> On 02/13/2017 11:10 PM, Alex Bennée wrote:
>>> @@ -239,9 +240,16 @@ static void cpu_exec_step(CPUState *cpu)
> <snip>
>>> +                } else if (r == EXCP_ATOMIC) {
>>> +                    qemu_mutex_unlock_iothread();
>>> +                    cpu_exec_step_atomic(cpu);
>>> +                    qemu_mutex_lock_iothread();
>> ...
>>> +            case EXCP_ATOMIC:
>>> +                qemu_mutex_unlock_iothread();
>>> +                cpu_exec_step_atomic(cpu);
>>> +                qemu_mutex_lock_iothread();
>>
>>
>> I just noticed this, but if you have to do a v13, it might be best to
>> move these locks inside cpu_exec_step_atomic, as with tcg_cpu_exec.
>> Otherwise leave it for later.
>
> Will that work given cpu_exec_step_atomic() is common between linux-user
> and system emulation?

Ug.  No, you're right.


r~
