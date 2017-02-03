Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZfO5-0008Vx-Cs
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZfNz-00054d-Qi
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:02:57 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cZfNz-00054X-Il
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:02:51 -0500
Received: by mail-wm0-x22a.google.com with SMTP id 196so15483672wmm.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:02:51 -0800 (PST)
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-21-alex.bennee@linaro.org>
	<CAFEAcA82=VUZF5DHBe+bEu0GBeM-Yg50TRkSHmDsgdAJ_YdgBw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA82=VUZF5DHBe+bEu0GBeM-Yg50TRkSHmDsgdAJ_YdgBw@mail.gmail.com>
Date: Fri, 03 Feb 2017 15:02:54 +0000
Message-ID: <87poizfhb5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 20/25] target-arm/powerctl: defer cpu
 reset work to CPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 1 February 2017 at 15:05, Alex Bennée <alex.bennee@linaro.org> wrote:
>> When switching a new vCPU on we want to complete a bunch of the setup
>> work before we start scheduling the vCPU thread. To do this cleanly we
>> defer vCPU setup to async work which will run the vCPUs execution
>> context as the thread is woken up. The scheduling of the work will kick
>> the vCPU awake.
>>
>> This avoids potential races in MTTCG system emulation.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>
> Can we now have races between arm_set_cpu_on() and
> arm_set_cpu_off() ? It's not clear to me what prevents that.
>
> With this change our PSCI CPU_ON is no longer effectively
> atomic, which means we need to think about the races
> between PSCI CPU_ON and CPU_OFF, and the fact that the
> core might be in what the PSCI spec section 6.6
> calls an ON_PENDING state (ie CPU_ON has been called
> for it but it hasn't actually booted yet).

Would it be enough to also queue the set_cpu_off work?

The queue itself is safe to add to so you'll end up with a series of
on/off deferred work that will eventually unwind itself when the CPU
thread runs.

>
> thanks
> -- PMM


--
Alex Bennée
