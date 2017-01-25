Received: from eggs.gnu.org ([2001:4830:134:3::10]:51787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWLP4-0006np-OA
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWLP0-0005aD-7K
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:06:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWLOz-0005ZZ-Vp
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:06:10 -0500
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071719.4572.92155.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db455af4-4d66-d81f-4f4f-1ad47100dffe@redhat.com>
Date: Wed, 25 Jan 2017 12:06:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170124071719.4572.92155.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 04/14] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
> This patch adds check to break cpu loop when icount expires without
> setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
> available translated blocks and all instructions were executed.
> In icount replay mode unnecessary tb_find will be called (which may
> cause an exception) and execution will be non-deterministic.
>=20
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  cpu-exec.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 79a2167..e603da4 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -582,9 +582,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, =
TranslationBlock *tb,
>                  cpu_exec_nocache(cpu, insns_left, *last_tb, false);
>                  align_clocks(sc, cpu);
>              }
> -            cpu->exception_index =3D EXCP_INTERRUPT;
> -            *last_tb =3D NULL;
> -            cpu_loop_exit(cpu);
>          }
>          break;
>  #endif
> @@ -638,6 +635,18 @@ int cpu_exec(CPUState *cpu)
> =20
>              for(;;) {
>                  cpu_handle_interrupt(cpu, &last_tb);
> +                /* icount has expired, we need to break the execution =
loop.
> +                   This check is needed before tb_find to make executi=
on
> +                   deterministic - tb_find may cause an exception
> +                   while translating the code from non-mapped page. */
> +                if (use_icount && ((cpu->icount_extra =3D=3D 0
> +                                    && cpu->icount_decr.u16.low =3D=3D=
 0)
> +                                || (int32_t)cpu->icount_decr.u32 < 0))=
 {
> +                    if (cpu->exception_index =3D=3D -1) {
> +                        cpu->exception_index =3D EXCP_INTERRUPT;
> +                    }
> +                    cpu_loop_exit(cpu);
> +                }

Can this can be placed in cpu_handle_interrupt itself?  Also, can the
cpu->exception_index !=3D -1 case happen?

We really should add assertions on cpu->exception_index, maybe after
cpu_handle_exception and cc->cpu_exec_interrupt returns true.  Without
some idea of the invariants, I'm not competent enough to review this patc=
h.

Paolo

>                  tb =3D tb_find(cpu, last_tb, tb_exit);
>                  cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
>                  /* Try to align the host and virtual clocks
>=20
