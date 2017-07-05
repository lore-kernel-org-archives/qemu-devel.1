Received: from eggs.gnu.org ([2001:4830:134:3::10]:55190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSn3v-0005vF-MN
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSn3u-00043o-NW
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSn3u-00042U-H7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:21:58 -0400
References: <8737aaeuu5.fsf@linaro.org>
	<CAFEAcA8ZHz4vyBrHV6Vi7227h+_NafgV1oBY0g9sV7zU_8my0w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <672d2102-5a27-47b3-ef5b-f49d1e21d9f2@redhat.com>
Date: Wed, 5 Jul 2017 18:21:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZHz4vyBrHV6Vi7227h+_NafgV1oBY0g9sV7zU_8my0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu_system_reset_request() broken w.r.t BQL
 locking regime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, maciej.borzecki@open-rnd.pl



On 05/07/2017 18:14, Peter Maydell wrote:
>>   - Guest resets board, writing to some hw address (e.g.
>>     arm_sysctl_write)
>>   - This triggers qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET)
>>   - We exit iowrite and drop the BQL
>>   - vl.c schedules qemu_system_reset->qemu_devices_reset...arm_cpu_reset
>>   - we start writing new values to CPU env while still in TCG code
>>   - CHAOS!
>>
>> The general solution for this is to ensure these sort of tasks are done
>> with safe work in the CPUs context when we know nothing else is running.
>> It seems this is probably best done by modifying
>> qemu_system_reset_request to queue work up on current_cpu and execute it
>> as safe work - I don't think the vl.c thread should ever be messing
>> about with calling cpu_reset directly.
> My first thought is that qemu_system_reset() should absolutely
> stop every CPU (or other runnable thing like a DMA agent) in the
> system. The semantics are basically "like a power cycle", so
> that should include a complete stop of the world. (Is this
> what vm_stop() does? Dunno...)

I agree, it should do vm_stop() as the first thing and, if applicable,
vm_start() as the last thing, similar to e.g. savevm.

In fact, the above bug probably has existed forever in KVM.

Paolo
