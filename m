Received: from eggs.gnu.org ([2001:4830:134:3::10]:48448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWJNV-0005uL-OQ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWJNS-0001VM-CP
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:05:33 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWJNS-0001Sv-2c
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:05:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so9984712wra.6
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 03:05:28 -0800 (PST)
References: <20181207155911.12710-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181207155911.12710-1-peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 11:05:26 +0000
Message-ID: <87wooh1w21.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> We use cpu_stop_current() to ensure the current CPU has stopped
> from places like qemu_system_reset_request(). Unfortunately its
> current implementation has a race. It calls qemu_cpu_stop(),
> which sets cpu->stopped to true even though the CPU hasn't
> actually stopped yet. The main thread will look at the flags
> set by qemu_system_reset_request() and call pause_all_vcpus().
> pause_all_vcpus() waits for every cpu to have cpu->stopped true,
> so it can continue (and we will start the system reset operation)
> before the vcpu thread has got back to its top level loop.
>
> Instead, just set cpu->stop and call cpu_exit(). This will
> cause the vcpu to exit back to the top level loop, and there
> (as part of the wait_io_event code) it will call qemu_cpu_stop().
>
> This fixes bugs where the reset request appeared to be ignored
> or the CPU misbehaved because the reset operation started
> to change vcpu state while the vcpu thread was still using it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We discussed this a little while back:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00154.html
> and Jaap reported a bug which I suspect of being the same thing:
> https://lists.gnu.org/archive/html/qemu-discuss/2018-10/msg00014.html
>
> Annoyingly I have lost the test case that demonstrated this
> race, but I analysed it at the time and this should definitely
> fix it. I have opted not to try to address any of the other
> possible cleanup here (eg vm_stop() has a potential similar
> race if called from a vcpu thread I suspect), since it gets
> pretty tangled.
>
> Jaap: could you test whether this patch fixes the issue you
> were seeing, please?
> ---
>  cpus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 0ddeeefc14f..b09b7027126 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2100,7 +2100,8 @@ void qemu_init_vcpu(CPUState *cpu)
>  void cpu_stop_current(void)
>  {
>      if (current_cpu) {
> -        qemu_cpu_stop(current_cpu, true);
> +        current_cpu->stop =3D true;
> +        cpu_exit(current_cpu);

Should the FIXME in vm_stop also be fixed?

        /*
         * FIXME: should not return to device code in case
         * vm_stop() has been requested.
         */
        cpu_stop_current();
        return 0;


>      }
>  }


--
Alex Benn=C3=A9e
