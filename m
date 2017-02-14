Received: from eggs.gnu.org ([2001:4830:134:3::10]:49603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdagT-0003Np-KQ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdagQ-0008J5-KV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:50:09 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdagQ-0008IB-EL
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:50:06 -0500
Received: by mail-wm0-x22a.google.com with SMTP id c85so14439326wmi.1
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 02:50:06 -0800 (PST)
References: <20170213121017.12907-1-alex.bennee@linaro.org>
	<20170213121017.12907-13-alex.bennee@linaro.org>
	<0d990570-8318-7bba-c10c-cfe0387fdd1b@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <0d990570-8318-7bba-c10c-cfe0387fdd1b@twiddle.net>
Date: Tue, 14 Feb 2017 10:50:24 +0000
Message-ID: <87h93xujv3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Richard Henderson <rth@twiddle.net> writes:

> On 02/13/2017 11:10 PM, Alex Bennée wrote:
>> @@ -239,9 +240,16 @@ static void cpu_exec_step(CPUState *cpu)
<snip>
>> +                } else if (r == EXCP_ATOMIC) {
>> +                    qemu_mutex_unlock_iothread();
>> +                    cpu_exec_step_atomic(cpu);
>> +                    qemu_mutex_lock_iothread();
> ...
>> +            case EXCP_ATOMIC:
>> +                qemu_mutex_unlock_iothread();
>> +                cpu_exec_step_atomic(cpu);
>> +                qemu_mutex_lock_iothread();
>
>
> I just noticed this, but if you have to do a v13, it might be best to
> move these locks inside cpu_exec_step_atomic, as with tcg_cpu_exec.
> Otherwise leave it for later.

Will that work given cpu_exec_step_atomic() is common between linux-user
and system emulation?

--
Alex Bennée
