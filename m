Received: from eggs.gnu.org ([2001:4830:134:3::10]:49166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMyGb-0006M0-CQ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMyGP-0004sD-VA
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:43:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMyGL-0004iy-LI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:43:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id q26so5335563wmf.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:43:25 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-45-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-45-cota@braap.org>
Date: Wed, 14 Nov 2018 16:43:22 +0000
Message-ID: <87sh03d2z9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 44/48] cpus: lockstep execution support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
<snip>
>
>  void cpu_interrupt(CPUState *cpu, int mask);
> diff --git a/cpus.c b/cpus.c
> index 3efe89354d..a446632a5c 100644
> --- a/cpus.c
> +++ b/cpus.c
<snip>
> +
> +static void cpu_lockstep_init(CPUState *cpu)
> +{
> +    if (!lockstep_enabled) {
> +        return;
> +    }
> +    qemu_mutex_lock(&lockstep_lock);
> +    /*
> +     * HACK: avoid racing with a wakeup, which would miss the addition
> +     * of this CPU; just wait until no wakeup is ongoing.
> +     */
> +    while (unlikely(lockstep_ongoing_wakeup)) {
> +        qemu_mutex_unlock(&lockstep_lock);
> +        sched_yield();

This breaks Windows builds. I suspect if we do want to this sort of
functionality we'll need to expose a utility function in
oslib-posix/oslib-win32


--
Alex Benn=C3=A9e
