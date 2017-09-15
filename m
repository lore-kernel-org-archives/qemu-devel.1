Received: from eggs.gnu.org ([2001:4830:134:3::10]:60947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Np-0006im-IV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Nl-0001Oi-1e
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:50:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0Nk-0001OT-Kw
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:50:48 -0400
Date: Fri, 15 Sep 2017 20:50:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170915235039.GA21016@localhost.localdomain>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170830225225.27925-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830225225.27925-5-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] mips: call cpu_mips_realize_env()
 from mips_cpu_realizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Marcel Apfelbaum <marcel@redhat.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 07:52:22PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: James Hogan <james.hogan@imgtec.com>
> ---
>  target/mips/cpu.c       | 3 +++
>  target/mips/translate.c | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 68bf423e9d..e3ef835599 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -123,6 +123,7 @@ static void mips_cpu_disas_set_info(CPUState *s, di=
sassemble_info *info) {
>  static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs =3D CPU(dev);
> +    MIPSCPU *cpu =3D MIPS_CPU(dev);
>      MIPSCPUClass *mcc =3D MIPS_CPU_GET_CLASS(dev);
>      Error *local_err =3D NULL;
> =20
> @@ -132,6 +133,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
> =20
> +    cpu_mips_realize_env(&cpu->env);
> +

This changes the order between cpu_mips_realize_env() and
cpu_exec_initfn(), but cpu_exec_initfn() don't have anything that
depends on cpu_mips_realize_env() being called first.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>      cpu_reset(cs);
>      qemu_init_vcpu(cs);
> =20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 5fc7979ac5..94c38e8755 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20535,7 +20535,6 @@ MIPSCPU *cpu_mips_init(const char *cpu_model)
>      cpu =3D MIPS_CPU(object_new(TYPE_MIPS_CPU));
>      env =3D &cpu->env;
>      env->cpu_model =3D def;
> -    cpu_mips_realize_env(env);
> =20
>      object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
> =20
> --=20
> 2.14.1
>=20
>=20

--=20
Eduardo
