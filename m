Received: from eggs.gnu.org ([2001:4830:134:3::10]:36212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbq6-0005wK-12
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbq4-0003JO-SG
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:15:37 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZbq4-0003Ia-IH
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:15:36 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v77so22765600wmv.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:15:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-21-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-21-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:15:14 +0000
Message-ID: <CAFEAcA82=VUZF5DHBe+bEu0GBeM-Yg50TRkSHmDsgdAJ_YdgBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> When switching a new vCPU on we want to complete a bunch of the setup
> work before we start scheduling the vCPU thread. To do this cleanly we
> defer vCPU setup to async work which will run the vCPUs execution
> context as the thread is woken up. The scheduling of the work will kick
> the vCPU awake.
>
> This avoids potential races in MTTCG system emulation.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Can we now have races between arm_set_cpu_on() and
arm_set_cpu_off() ? It's not clear to me what prevents that.

With this change our PSCI CPU_ON is no longer effectively
atomic, which means we need to think about the races
between PSCI CPU_ON and CPU_OFF, and the fact that the
core might be in what the PSCI spec section 6.6
calls an ON_PENDING state (ie CPU_ON has been called
for it but it hasn't actually booted yet).

thanks
-- PMM
