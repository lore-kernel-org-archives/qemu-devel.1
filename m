Received: from eggs.gnu.org ([2001:4830:134:3::10]:52509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSmwp-0003Ge-6x
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSmwo-0000Kw-AZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:14:39 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dSmwo-0000KN-3a
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:14:38 -0400
Received: by mail-wm0-x22e.google.com with SMTP id f67so118198023wmh.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 09:14:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8737aaeuu5.fsf@linaro.org>
References: <8737aaeuu5.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Jul 2017 17:14:14 +0100
Message-ID: <CAFEAcA8ZHz4vyBrHV6Vi7227h+_NafgV1oBY0g9sV7zU_8my0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, maciej.borzecki@open-rnd.pl

On 5 July 2017 at 17:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> An interesting bug was reported on #qemu today. It was bisected to
> 8d04fb55 (drop global lock for TCG) and only occurred when QEMU was run
> with taskset -c 0. Originally the fingers where pointed at mttcg but it
> occurs in both single and multi-threaded modes.
>
> I think the problem is qemu_system_reset_request() is certainly racy
> when resetting a running CPU. AFAICT:
>
>   - Guest resets board, writing to some hw address (e.g.
>     arm_sysctl_write)
>   - This triggers qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET)
>   - We exit iowrite and drop the BQL
>   - vl.c schedules qemu_system_reset->qemu_devices_reset...arm_cpu_reset
>   - we start writing new values to CPU env while still in TCG code
>   - CHAOS!
>
> The general solution for this is to ensure these sort of tasks are done
> with safe work in the CPUs context when we know nothing else is running.
> It seems this is probably best done by modifying
> qemu_system_reset_request to queue work up on current_cpu and execute it
> as safe work - I don't think the vl.c thread should ever be messing
> about with calling cpu_reset directly.

My first thought is that qemu_system_reset() should absolutely
stop every CPU (or other runnable thing like a DMA agent) in the
system. The semantics are basically "like a power cycle", so
that should include a complete stop of the world. (Is this
what vm_stop() does? Dunno...)

thanks
-- PMM
