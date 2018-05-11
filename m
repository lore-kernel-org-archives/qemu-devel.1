Received: from eggs.gnu.org ([2001:4830:134:3::10]:48993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH1zw-0003zy-VX
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH1zs-0000jy-N9
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:57:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fH1zs-0000ji-Jk
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:57:44 -0400
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-7-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <334644f2-a945-03d9-8d2e-efb34fa3b449@redhat.com>
Date: Fri, 11 May 2018 08:57:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/9] target/s390x: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 11.05.2018 05:52, Richard Henderson wrote:
> Also do not dump both "fpu" and "vector" registers
> as the former overlaps the latter.
>=20
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/helper.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index e8548f340a..fd5791f134 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -327,21 +327,22 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, f=
printf_function cpu_fprintf,
>          }
>      }
> =20
> -    for (i =3D 0; i < 16; i++) {
> -        cpu_fprintf(f, "F%02d=3D%016" PRIx64, i, get_freg(env, i)->ll)=
;
> -        if ((i % 4) =3D=3D 3) {
> -            cpu_fprintf(f, "\n");
> +    if (flags & CPU_DUMP_FPU) {
> +        if (s390_has_feat(S390_FEAT_VECTOR)) {

CPU model should always be initialized at this point, so this check
actually returns the right thing.

Reviewed-by: David Hildenbrand <david@redhat.com>

> +            for (i =3D 0; i < 32; i++) {
> +                cpu_fprintf(f, "V%02d=3D%016" PRIx64 "%016" PRIx64 "%c=
",
> +                            i, env->vregs[i][0].ll, env->vregs[i][1].l=
l,
> +                            i % 2 ? '\n' : ' ');
> +            }
>          } else {
> -            cpu_fprintf(f, " ");
> +            for (i =3D 0; i < 16; i++) {
> +                cpu_fprintf(f, "F%02d=3D%016" PRIx64 "%c",
> +                            i, get_freg(env, i)->ll,
> +                            (i % 4) =3D=3D 3 ? '\n' : ' ');
> +            }
>          }
>      }
> =20
> -    for (i =3D 0; i < 32; i++) {
> -        cpu_fprintf(f, "V%02d=3D%016" PRIx64 "%016" PRIx64, i,
> -                    env->vregs[i][0].ll, env->vregs[i][1].ll);
> -        cpu_fprintf(f, (i % 2) ? "\n" : " ");
> -    }
> -
>  #ifndef CONFIG_USER_ONLY
>      for (i =3D 0; i < 16; i++) {
>          cpu_fprintf(f, "C%02d=3D%016" PRIx64, i, env->cregs[i]);
>=20


--=20

Thanks,

David / dhildenb
