Received: from eggs.gnu.org ([2001:4830:134:3::10]:34081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cbEJN-00023p-Tf
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cbEJK-0008Go-Ql
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:32:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cbEJK-0008GE-LC
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:32:30 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v17MSZoX087443
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 17:32:29 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28fm4gesc5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 17:32:29 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 7 Feb 2017 15:32:28 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <7c016bdc97ed45dc2eb5002db98efcee26c4d8bf.1486437689.git.sam.bobroff@au1.ibm.com>
References: <7c016bdc97ed45dc2eb5002db98efcee26c4d8bf.1486437689.git.sam.bobroff@au1.ibm.com>
Date: Tue, 07 Feb 2017 16:32:17 -0600
Message-Id: <148650673760.9348.14833769860829583835@loki>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target-ppc,
 tcg: fix usermode segfault with pthread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, laurent@vivier.eu, anibal.limon@linux.intel.com, david@gibson.dropbear.id.au, qemu-stable@nongnu.org

Quoting Sam Bobroff (2017-02-06 21:21:39)
> Programs run under qemu-ppc64 on an x86_64 host currently segfault
> if they use pthread_create() due to the adjustment made to the NIP in
> commit bd6fefe71cec5a0c7d2be4ac96307f25db56abf9.
> =

> This patch changes cpu_loop() to set the NIP back to the
> pre-incremented value before calling do_syscall(), which causes the
> correct address to be used for the new thread and corrects the fault.
> =

> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Cc'ing qemu-stable@nongnu.org

> ---
> =

> v2:
> =

> * Remove the NIP adjustment from the -TARGET_QEMU_ESIGRETURN case, it must
> break out with the same NIP as do_syscall().
> =

>  linux-user/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/linux-user/main.c b/linux-user/main.c
> index 30049581ef..4ea49f68be 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -1712,10 +1712,12 @@ void cpu_loop(CPUPPCState *env)
>               * in syscalls.
>               */
>              env->crf[0] &=3D ~0x1;
> +            env->nip +=3D 4;
>              ret =3D do_syscall(env, env->gpr[0], env->gpr[3], env->gpr[4=
],
>                               env->gpr[5], env->gpr[6], env->gpr[7],
>                               env->gpr[8], 0, 0);
>              if (ret =3D=3D -TARGET_ERESTARTSYS) {
> +                env->nip -=3D 4;
>                  break;
>              }
>              if (ret =3D=3D (target_ulong)(-TARGET_QEMU_ESIGRETURN)) {
> @@ -1723,7 +1725,6 @@ void cpu_loop(CPUPPCState *env)
>                     Avoid corrupting register state.  */
>                  break;
>              }
> -            env->nip +=3D 4;
>              if (ret > (target_ulong)(-515)) {
>                  env->crf[0] |=3D 0x1;
>                  ret =3D -ret;
> -- =

> 2.11.0
> =

>=20
