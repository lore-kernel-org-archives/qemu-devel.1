Received: from eggs.gnu.org ([2001:4830:134:3::10]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6iq-00056x-8p
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6io-0005f8-1V
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:09:48 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP6im-0005bS-1i
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:09:44 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so1728399otr.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:09:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113165247.4806-12-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-12-sameo@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:09:22 +0000
Message-ID: <CAFEAcA_9JNW0bVcSVVgiAm8E-=FA0Vi9+XyrnO5oE95HdyZepw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/13] target: arm: Define TCG dependent
 functions when TCG is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> do_interrupt, do_unaligned_access, do_transaction_failed and debug_excp
> are only relevant in the TCG context, so we should not define them
> when TCG is disabled.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> ---
>  target/arm/cpu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 60411f6bfe..fb2e5d430e 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1444,7 +1444,7 @@ static void arm_v7m_class_init(ObjectClass *oc, voi=
d *data)
>  {
>      CPUClass *cc =3D CPU_CLASS(oc);
>
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>      cc->do_interrupt =3D arm_v7m_cpu_do_interrupt;
>  #endif
>
> @@ -2061,9 +2061,14 @@ static void arm_cpu_class_init(ObjectClass *oc, vo=
id *data)
>  #ifdef CONFIG_USER_ONLY
>      cc->handle_mmu_fault =3D arm_cpu_handle_mmu_fault;
>  #else
> +
> +#ifdef CONFIG_TCG
>      cc->do_interrupt =3D arm_cpu_do_interrupt;

As noted on an earlier patch, this breaks KVM injection of
interrupts into the guest.

>      cc->do_unaligned_access =3D arm_cpu_do_unaligned_access;
>      cc->do_transaction_failed =3D arm_cpu_do_transaction_failed;
> +    cc->debug_excp_handler =3D arm_debug_excp_handler;
> +#endif

thanks
-- PMM
