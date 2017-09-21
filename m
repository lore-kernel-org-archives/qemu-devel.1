Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duzMk-0002UB-IP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duzMe-0007Ln-M4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:09:58 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:56279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duzMe-0007KW-FD
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:09:52 -0400
Received: by mail-wr0-x22f.google.com with SMTP id l39so4271973wrl.12
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 04:09:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170921110625.9500-1-alex.bennee@linaro.org>
References: <20170921110625.9500-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 12:09:30 +0100
Message-ID: <CAFEAcA_KYxQm-2wP02=FJcRUabBJC9LX1TiiJX8G9oDMkbxdpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/cputlb: avoid recursive BQL
 (fixes #1706296)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>, Paolo Bonzini <bonzini@gnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 21 September 2017 at 12:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> The mmio path (see exec.c:prepare_mmio_access) already protects itself
> against recursive locking and it makes sense to do the same for
> io_readx/writex. Otherwise any helper running in the BQL context will
> assert when it attempts to write to device memory as in the case of
> the bug report.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> CC: Richard Jones <rjones@redhat.com>
> CC: Paolo Bonzini <bonzini@gnu.org>

Seems worth:
Cc: qemu-stable@nongnu.org

> ---
>  accel/tcg/cputlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e72415a882..bcbcc4db6c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -765,7 +765,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
>
>      cpu->mem_io_vaddr =3D addr;
>
> -    if (mr->global_locking) {
> +    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>          qemu_mutex_lock_iothread();
>          locked =3D true;
>      }
> @@ -800,7 +800,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntr=
y *iotlbentry,
>      cpu->mem_io_vaddr =3D addr;
>      cpu->mem_io_pc =3D retaddr;
>
> -    if (mr->global_locking) {
> +    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>          qemu_mutex_lock_iothread();
>          locked =3D true;
>      }
> --
> 2.14.1

Seems to fix the similar problem that I ran into with my work-in-progress
v8M blxns/secure-return code.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
