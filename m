Received: from eggs.gnu.org ([2001:4830:134:3::10]:44256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTCIQ-0003zf-P9
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 15:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTCIP-0006Wo-0r
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 15:55:26 -0500
MIME-Version: 1.0
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-25-marcandre.lureau@redhat.com>
	<20181130124821.292bd5c9@redhat.com>
In-Reply-To: <20181130124821.292bd5c9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 2 Dec 2018 00:55:05 +0400
Message-ID: <CAJ+F1C+FRkVv-wHUpr5iFbZ84410dp1QH7m9bDqnf39QBXO1Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 24/28] arm: replace
 instance_post_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, QEMU <qemu-devel@nongnu.org>

Hi
On Fri, Nov 30, 2018 at 3:48 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 27 Nov 2018 13:27:57 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > Replace arm_cpu_post_init() instance callback by calling it from leaf
> > classes, to avoid potential the ordering issue with interfaces
> > post-init.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  target/arm/cpu.h   |  2 ++
> >  target/arm/cpu.c   | 15 ++++++++++++---
> >  target/arm/cpu64.c | 11 ++++++++++-
> >  3 files changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 2a73fed9a0..84fba2b24b 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -884,6 +884,8 @@ static inline ARMCPU *arm_env_get_cpu(CPUARMState *=
env)
> >      return container_of(env, ARMCPU, env);
> >  }
> >
> > +void arm_cpu_post_init(Object *obj);
> > +
> >  uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
> >
> >  #define ENV_GET_CPU(e) CPU(arm_env_get_cpu(e))
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 60411f6bfe..8a4aae7438 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -734,7 +734,7 @@ static Property arm_cpu_pmsav7_dregion_property =3D
> >  static Property arm_cpu_initsvtor_property =3D
> >              DEFINE_PROP_UINT32("init-svtor", ARMCPU, init_svtor, 0);
> >
> > -static void arm_cpu_post_init(Object *obj)
> > +void arm_cpu_post_init(Object *obj)
> >  {
> >      ARMCPU *cpu =3D ARM_CPU(obj);
> >
> > @@ -2094,6 +2094,7 @@ static void arm_host_initfn(Object *obj)
> >      ARMCPU *cpu =3D ARM_CPU(obj);
> >
> >      kvm_arm_set_cpu_features_from_host(cpu);
> > +    arm_cpu_post_init(ARM_CPU(obj));
> >  }
> >
> >  static const TypeInfo host_arm_cpu_type_info =3D {
> > @@ -2108,14 +2109,23 @@ static const TypeInfo host_arm_cpu_type_info =
=3D {
> >
> >  #endif
> >
> > +static void arm_cpu_instance_init(Object *obj)
> > +{
> > +    const ARMCPUInfo *info =3D object_class_get_class_data(object_get_=
class(obj));
> > +
> > +    info->initfn(obj);
> > +    arm_cpu_post_init(obj);
> > +}
> now imagine leaf cpu class call chain:
> before patch:
>    arm-cpu::initfn()
>    cortex-a8::initfn()
>       set feature AAA
>    device_post_init()
>      -> arm_cpu_post_init()
>           if (AAA)
>              do something
>
> after patch:
>    arm-cpu::initfn()
>       -> arm_cpu_post_init()
>             if (AAA)
>                do something  <--- won't happen anymore
>    cortex-a8::initfn()
>

Hmm? No, after the patch cortex-a8::initfn() is called before
arm_cpu_post_init().

> arm_cpu_post_init() helper has to go to leaf classes only

That's what the patch does, unless I am missing something.
arm_cpu_instance_init() is called on the leaf class, calling the
leaf-cpu init (cortex-8a::initfn() etc) before calling
arm_cpu_post_init()

>
> > +
> >  static void cpu_register(const ARMCPUInfo *info)
> >  {
> >      TypeInfo type_info =3D {
> >          .parent =3D TYPE_ARM_CPU,
> >          .instance_size =3D sizeof(ARMCPU),
> > -        .instance_init =3D info->initfn,
> > +        .instance_init =3D arm_cpu_instance_init,
> >          .class_size =3D sizeof(ARMCPUClass),
> >          .class_init =3D info->class_init,
> > +        .class_data =3D (void *)info,
> >      };
> >
> >      type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->name)=
;
> > @@ -2128,7 +2138,6 @@ static const TypeInfo arm_cpu_type_info =3D {
> >      .parent =3D TYPE_CPU,
> >      .instance_size =3D sizeof(ARMCPU),
> >      .instance_init =3D arm_cpu_initfn,
> > -    .instance_post_init =3D arm_cpu_post_init,
> >      .instance_finalize =3D arm_cpu_finalizefn,
> >      .abstract =3D true,
> >      .class_size =3D sizeof(ARMCPUClass),
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 873f059bf2..dbfc3ee490 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -447,14 +447,23 @@ static void aarch64_cpu_class_init(ObjectClass *o=
c, void *data)
> >      cc->gdb_arch_name =3D aarch64_gdb_arch_name;
> >  }
> >
> > +static void aarch64_cpu_instance_init(Object *obj)
> > +{
> > +    const ARMCPUInfo *info =3D object_class_get_class_data(object_get_=
class(obj));
> > +
> > +    info->initfn(obj);
> > +    arm_cpu_post_init(obj);
> > +}
> > +
> >  static void aarch64_cpu_register(const ARMCPUInfo *info)
> >  {
> >      TypeInfo type_info =3D {
> >          .parent =3D TYPE_AARCH64_CPU,
> >          .instance_size =3D sizeof(ARMCPU),
> > -        .instance_init =3D info->initfn,
> > +        .instance_init =3D aarch64_cpu_instance_init,
> >          .class_size =3D sizeof(ARMCPUClass),
> >          .class_init =3D info->class_init,
> > +        .class_data =3D (void *)info,
> >      };
> >
> >      type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->name)=
;
>
>


--=20
Marc-Andr=C3=A9 Lureau
