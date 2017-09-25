Received: from eggs.gnu.org ([2001:4830:134:3::10]:35168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOu-0003J5-U1
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOq-0003z2-Ux
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dwaOq-0003xw-Ml
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PKsTpJ100417
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d733ccr8b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:40 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 14:54:39 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170921110625.9500-1-alex.bennee@linaro.org>
References: <20170921110625.9500-1-alex.bennee@linaro.org>
Date: Mon, 25 Sep 2017 15:53:02 -0500
Message-Id: <150637278211.26688.15280770501463365931@sif>
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
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <bonzini@gnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Jones <rjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Quoting Alex Benn=C3=A9e (2017-09-21 06:06:25)
> The mmio path (see exec.c:prepare_mmio_access) already protects itself
> against recursive locking and it makes sense to do the same for
> io_readx/writex. Otherwise any helper running in the BQL context will
> assert when it attempts to write to device memory as in the case of
> the bug report.
> =

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> CC: Richard Jones <rjones@redhat.com>
> CC: Paolo Bonzini <bonzini@gnu.org>

FYI: this patch has been tagged for stable 2.10.1, but is not yet
upstream. Patch freeze for 2.10.1 is September 27th.

> ---
>  accel/tcg/cputlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e72415a882..bcbcc4db6c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -765,7 +765,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
> =

>      cpu->mem_io_vaddr =3D addr;
> =

> -    if (mr->global_locking) {
> +    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>          qemu_mutex_lock_iothread();
>          locked =3D true;
>      }
> @@ -800,7 +800,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntr=
y *iotlbentry,
>      cpu->mem_io_vaddr =3D addr;
>      cpu->mem_io_pc =3D retaddr;
> =

> -    if (mr->global_locking) {
> +    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>          qemu_mutex_lock_iothread();
>          locked =3D true;
>      }
> -- =

> 2.14.1
> =

>=20
