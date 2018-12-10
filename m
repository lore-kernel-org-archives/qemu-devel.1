Received: from eggs.gnu.org ([2001:4830:134:3::10]:53784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gWMZr-0003oF-HM
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gWMZn-00036E-2g
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:30:31 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:42725
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1gWMZm-00034w-Mb
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:30:26 -0500
References: <20181207155911.12710-1-peter.maydell@linaro.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <c2f3400e-84d9-d380-3259-7e3231ff12f6@adacore.com>
Date: Mon, 10 Dec 2018 15:30:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181207155911.12710-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, patches@linaro.org

Hi Peter,

Thanks for that patch!

I'm seeing the same kind of issue when I run 8 qemu in parallel but it do=
esn't
seem to be fixed by this patch. Is it supposed to fix the issue when we a=
re
doing a reset_request through a MMIO device?

It happens (rarely) with this kind of guest code:

exit:
   write to the register to reset the device
loop:
   branch loop

The code after the reset is executed.. can't we exit the loop directly wi=
th
cpu_loop_exit after cpu_exit?

Thanks,
Fred

Le 12/7/18 =C3=A0 4:59 PM, Peter Maydell a =C3=A9crit=C2=A0:
> We use cpu_stop_current() to ensure the current CPU has stopped
> from places like qemu_system_reset_request(). Unfortunately its
> current implementation has a race. It calls qemu_cpu_stop(),
> which sets cpu->stopped to true even though the CPU hasn't
> actually stopped yet. The main thread will look at the flags
> set by qemu_system_reset_request() and call pause_all_vcpus().
> pause_all_vcpus() waits for every cpu to have cpu->stopped true,
> so it can continue (and we will start the system reset operation)
> before the vcpu thread has got back to its top level loop.
>=20
> Instead, just set cpu->stop and call cpu_exit(). This will
> cause the vcpu to exit back to the top level loop, and there
> (as part of the wait_io_event code) it will call qemu_cpu_stop().
>=20
> This fixes bugs where the reset request appeared to be ignored
> or the CPU misbehaved because the reset operation started
> to change vcpu state while the vcpu thread was still using it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We discussed this a little while back:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00154.html
> and Jaap reported a bug which I suspect of being the same thing:
> https://lists.gnu.org/archive/html/qemu-discuss/2018-10/msg00014.html
>=20
> Annoyingly I have lost the test case that demonstrated this
> race, but I analysed it at the time and this should definitely
> fix it. I have opted not to try to address any of the other
> possible cleanup here (eg vm_stop() has a potential similar
> race if called from a vcpu thread I suspect), since it gets
> pretty tangled.
>=20
> Jaap: could you test whether this patch fixes the issue you
> were seeing, please?
> ---
>   cpus.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index 0ddeeefc14f..b09b7027126 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2100,7 +2100,8 @@ void qemu_init_vcpu(CPUState *cpu)
>   void cpu_stop_current(void)
>   {
>       if (current_cpu) {
> -        qemu_cpu_stop(current_cpu, true);
> +        current_cpu->stop =3D true;
> +        cpu_exit(current_cpu);
>       }
>   }
>  =20
>=20
