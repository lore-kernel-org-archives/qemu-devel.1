Received: from eggs.gnu.org ([2001:4830:134:3::10]:56487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe6J9-0001DR-Mp
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 18:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe6J6-0006gk-Hc
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 18:12:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fe6J6-0006fW-AV
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 18:12:56 -0400
Date: Fri, 13 Jul 2018 19:12:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713221252.GO914@localhost.localdomain>
References: <1531416567-13558-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531416567-13558-1-git-send-email-viktor.prutyanov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] dump: add kernel_gs_base to QEMU CPU
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rkagan@virtuozzo.com, rth@twiddle.net

On Thu, Jul 12, 2018 at 08:29:27PM +0300, Viktor Prutyanov wrote:
> This patch adds field with content of KERNEL_GS_BASE MSR to QEMU note i=
n
> ELF dump.
>=20
> On Windows, if all vCPUs are running usermode tasks at the time the dum=
p is
> created, this can be helpful in the discovery of guest system structure=
s
> during conversion ELF dump to MEMORY.DMP dump.
>=20
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> ---
>  v2: keep version 1 in QEMUCPUState and document the extension procedur=
e
>=20
>  target/i386/arch_dump.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 35b55fc..cc8750f 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -258,6 +258,12 @@ struct QEMUCPUState {
>      QEMUCPUSegment cs, ds, es, fs, gs, ss;
>      QEMUCPUSegment ldt, tr, gdt, idt;
>      uint64_t cr[5];
> +    /*
> +     * Fields below are optional and are being added at the end withou=
t
> +     * changing the version. External tools may identify their presenc=
e
> +     * by checking 'size' field.
> +     */
> +    uint64_t kernel_gs_base;
>  };
> =20
>  typedef struct QEMUCPUState QEMUCPUState;
> @@ -315,6 +321,8 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX=
86State *env)
>      s->cr[2] =3D env->cr[2];
>      s->cr[3] =3D env->cr[3];
>      s->cr[4] =3D env->cr[4];
> +
> +    s->kernel_gs_base =3D env->kernelgsbase;

This breaks i386-softmmu:

/home/travis/build/ehabkost/qemu/target/i386/arch_dump.c: In function =E2=
=80=98qemu_get_cpustate=E2=80=99:
/home/travis/build/ehabkost/qemu/target/i386/arch_dump.c:325:28: error: =E2=
=80=98CPUX86State=E2=80=99 has no member named =E2=80=98kernelgsbase=E2=80=
=99
     s->kernel_gs_base =3D env->kernelgsbase;
                            ^
make[1]: *** [target/i386/arch_dump.o] Error 1
make: *** [subdir-i386-softmmu] Error 2
make: *** Waiting for unfinished jobs....

--=20
Eduardo
