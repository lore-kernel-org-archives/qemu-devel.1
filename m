Received: from eggs.gnu.org ([209.51.188.92]:42710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hCQR7-00056K-QA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hCQR5-0005Mm-SB
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:07:21 -0400
Received: from mail-bgr052101132083.outbound.protection.outlook.com
	([52.101.132.83]:45188
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hCQR2-0005Dz-5a
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:07:18 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 5 Apr 2019 15:07:02 +0000
Message-ID: <20190405150659.GC20411@rkaganb.sw.ru>
References: <20190329141832.22882-1-vkuznets@redhat.com>
	<20190329141832.22882-5-vkuznets@redhat.com>
In-Reply-To: <20190329141832.22882-5-vkuznets@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D5CFCB168A2E1A41A9F5002F8CD97B23@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/8] i386/kvm: implement 'hv-all'
 pass-through mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>

On Fri, Mar 29, 2019 at 03:18:28PM +0100, Vitaly Kuznetsov wrote:
> In many case we just want to give Windows guests all currently supported
> Hyper-V enlightenments and that's where this new mode may come handy. We
> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.

The only one out of those "many cases" I can think of is when you've
developed a new hyperv feature in the kernel and you want to test it
with a version of QEMU that's not aware of it.  Are there any others?

>=20
> hv_cpuid_check_and_set() is modified to also set cpu->hyperv_* flags as
> we may want to check them later (and we actually do for hv_runtime,
> hv_synic,...).
>=20
> 'hv-all' is a development only feature, a migration blocker is added to
> prevent issues while migrating between hosts with different feature sets.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  docs/hyperv.txt   |  10 ++++
>  target/i386/cpu.c |   1 +
>  target/i386/cpu.h |   1 +
>  target/i386/kvm.c | 148 +++++++++++++++++++++++++++++++++++++---------
>  4 files changed, 132 insertions(+), 28 deletions(-)
>=20
> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> index 397f2517b8..d1299aba81 100644
> --- a/docs/hyperv.txt
> +++ b/docs/hyperv.txt
> @@ -174,6 +174,16 @@ without the feature to find out if enabling it is be=
neficial.
>  Requires: hv-vapic
> =20
> =20
> +4. Development features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +In some cases (e.g. during development) it may make sense to use QEMU in
> +'pass-through' mode and give Windows guests all enlightenments currently
> +supported by KVM. This pass-through mode is enabled by "hv-all" CPU flag=
.
> +Note: enabling this flag effectively prevents migration as supported fea=
tures
> +may differ between target and destination.

I find 'hv-passthrough' a more adequate name for this.

> +Note: "hv-all" doesn't include 'hv-evmcs', it needs to be enabled explic=
itly.

This is extremely confusing, when some features are more equal than
others.  I think it'd make more sense instead to support filtering out
some features, like in "hv-passthrough,hv-evmcs=3Doff".

Thanks,
Roman.

> +
> +
>  4. Useful links
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Hyper-V Top Level Functional specification and other information:
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d6bb57d210..4e01ad076e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5785,6 +5785,7 @@ static Property x86_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
>      DEFINE_PROP_BOOL("hv-evmcs", X86CPU, hyperv_evmcs, false),
>      DEFINE_PROP_BOOL("hv-ipi", X86CPU, hyperv_ipi, false),
> +    DEFINE_PROP_BOOL("hv-all", X86CPU, hyperv_all, false),
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>      DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 83fb522554..9cd3a8bc2f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1396,6 +1396,7 @@ struct X86CPU {
>      bool hyperv_tlbflush;
>      bool hyperv_evmcs;
>      bool hyperv_ipi;
> +    bool hyperv_all;
>      bool check_cpuid;
>      bool enforce_cpuid;
>      bool expose_kvm;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 63031358ae..af45241adb 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -656,7 +656,8 @@ static bool hyperv_enabled(X86CPU *cpu)
>              cpu->hyperv_stimer ||
>              cpu->hyperv_reenlightenment ||
>              cpu->hyperv_tlbflush ||
> -            cpu->hyperv_ipi);
> +            cpu->hyperv_ipi ||
> +            cpu->hyperv_all);
>  }
> =20
>  static int kvm_arch_set_tsc_khz(CPUState *cs)
> @@ -1004,14 +1005,15 @@ static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpu=
id, int fw, uint32_t *r)
>  }
> =20
>  static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid=
,
> -                                  const char *name, bool flag)
> +                                  const char *name, bool *flag)
>  {
>      X86CPU *cpu =3D X86_CPU(cs);
>      CPUX86State *env =3D &cpu->env;
>      uint32_t r, fw, bits;;
>      int i, j;
> +    bool present;
> =20
> -    if (!flag) {
> +    if (!*flag && !cpu->hyperv_all) {
>          return 0;
>      }
> =20
> @@ -1020,6 +1022,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, str=
uct kvm_cpuid2 *cpuid,
>              continue;
>          }
> =20
> +        present =3D true;
>          for (j =3D 0; j < ARRAY_SIZE(kvm_hyperv_properties[i].flags); j+=
+) {
>              fw =3D kvm_hyperv_properties[i].flags[j].fw;
>              bits =3D kvm_hyperv_properties[i].flags[j].bits;
> @@ -1029,17 +1032,26 @@ static int hv_cpuid_check_and_set(CPUState *cs, s=
truct kvm_cpuid2 *cpuid,
>              }
> =20
>              if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) !=3D bits) =
{
> -                fprintf(stderr,
> -                        "Hyper-V %s (requested by '%s' cpu flag) "
> -                        "is not supported by kernel\n",
> -                        kvm_hyperv_properties[i].desc,
> -                        kvm_hyperv_properties[i].name);
> -                return 1;
> +                if (*flag) {
> +                    fprintf(stderr,
> +                            "Hyper-V %s (requested by '%s' cpu flag) "
> +                            "is not supported by kernel\n",
> +                            kvm_hyperv_properties[i].desc,
> +                            kvm_hyperv_properties[i].name);
> +                    return 1;
> +                } else {
> +                    present =3D false;
> +                    break;
> +                }
>              }
> =20
>              env->features[fw] |=3D bits;
>          }
> =20
> +        if (cpu->hyperv_all && present) {
> +            *flag =3D true;
> +        }
> +
>          return 0;
>      }
> =20
> @@ -1047,6 +1059,43 @@ static int hv_cpuid_check_and_set(CPUState *cs, st=
ruct kvm_cpuid2 *cpuid,
>      return 1;
>  }
> =20
> +static int hv_report_missing_dep(X86CPU *cpu, const char *name,
> +                                 const char *dep_name)
> +{
> +    int i, j, nprops =3D sizeof(kvm_hyperv_properties);
> +
> +    for (i =3D 0; i < nprops; i++) {
> +        if (!strcmp(kvm_hyperv_properties[i].name, name)) {
> +            break;
> +        }
> +    }
> +    for (j =3D 0; j < nprops; j++) {
> +        if (!strcmp(kvm_hyperv_properties[j].name, dep_name)) {
> +            break;
> +        }
> +    }
> +
> +    /*
> +     * Internal error: either feature or its dependency is not in
> +     * kvm_hyperv_properties!
> +     */
> +    if (i =3D=3D nprops || j =3D=3D nprops) {
> +        return 1;
> +    }
> +
> +    if (cpu->hyperv_all) {
> +        fprintf(stderr, "Hyper-V %s (requested by 'hv-all' cpu flag) "
> +                "requires %s (is not supported by kernel)\n",
> +                kvm_hyperv_properties[i].desc, kvm_hyperv_properties[j].=
desc);
> +    } else {
> +        fprintf(stderr, "Hyper-V %s (requested by '%s' cpu flag) "
> +                "requires %s ('%s')\n", kvm_hyperv_properties[i].desc,
> +                name, kvm_hyperv_properties[j].desc, dep_name);
> +    }
> +
> +    return 1;
> +}
> +
>  /*
>   * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid=
_ent in
>   * case of success, errno < 0 in case of failure and 0 when no Hyper-V
> @@ -1086,32 +1135,54 @@ static int hyperv_handle_properties(CPUState *cs,
>          cpuid =3D get_supported_hv_cpuid_legacy(cs);
>      }
> =20
> +    if (cpu->hyperv_all) {
> +        memcpy(cpuid_ent, &cpuid->entries[0],
> +               cpuid->nent * sizeof(cpuid->entries[0]));
> +
> +        c =3D cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
> +        if (c) {
> +            env->features[FEAT_HYPERV_EAX] =3D c->eax;
> +            env->features[FEAT_HYPERV_EBX] =3D c->ebx;
> +            env->features[FEAT_HYPERV_EDX] =3D c->eax;
> +        }
> +        c =3D cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
> +        if (c) {
> +            env->features[FEAT_HV_RECOMM_EAX] =3D c->eax;
> +
> +            /* hv-spinlocks may have been overriden */
> +            if (cpu->hyperv_spinlock_attempts !=3D HYPERV_SPINLOCK_NEVER=
_RETRY) {
> +                c->ebx =3D cpu->hyperv_spinlock_attempts;
> +            }
> +        }
> +        c =3D cpuid_find_entry(cpuid, HV_CPUID_NESTED_FEATURES, 0);
> +        if (c) {
> +            env->features[FEAT_HV_NESTED_EAX] =3D c->eax;
> +        }
> +    }
> +
>      /* Features */
>      r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-relaxed",
> -                                cpu->hyperv_relaxed_timing);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-vapic", cpu->hyperv_vap=
ic);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-time", cpu->hyperv_time=
);
> +                                &cpu->hyperv_relaxed_timing);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-vapic", &cpu->hyperv_va=
pic);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-time", &cpu->hyperv_tim=
e);
>      r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-frequencies",
> -                                cpu->hyperv_frequencies);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-crash", cpu->hyperv_cra=
sh);
> +                                &cpu->hyperv_frequencies);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-crash", &cpu->hyperv_cr=
ash);
>      r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-reenlightenment",
> -                                cpu->hyperv_reenlightenment);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-reset", cpu->hyperv_res=
et);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-vpindex", cpu->hyperv_v=
pindex);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-runtime", cpu->hyperv_r=
untime);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-synic", cpu->hyperv_syn=
ic);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-stimer", cpu->hyperv_st=
imer);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-tlbflush", cpu->hyperv_=
tlbflush);
> -    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-ipi", cpu->hyperv_ipi);
> +                                &cpu->hyperv_reenlightenment);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-reset", &cpu->hyperv_re=
set);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-vpindex", &cpu->hyperv_=
vpindex);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-runtime", &cpu->hyperv_=
runtime);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-synic", &cpu->hyperv_sy=
nic);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-stimer", &cpu->hyperv_s=
timer);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-tlbflush",
> +                                &cpu->hyperv_tlbflush);
> +    r |=3D hv_cpuid_check_and_set(cs, cpuid, "hv-ipi", &cpu->hyperv_ipi)=
;
> =20
>      /* Dependencies */
>      if (cpu->hyperv_synic && !cpu->hyperv_synic_kvm_only &&
> -        !cpu->hyperv_vpindex) {
> -        fprintf(stderr, "Hyper-V SynIC "
> -                "(requested by 'hv-synic' cpu flag) "
> -                "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
> -        r |=3D 1;
> -    }
> +        !cpu->hyperv_vpindex)
> +        r |=3D hv_report_missing_dep(cpu, "hv-synic", "hv-vpindex");
> =20
>      /* Not exposed by KVM but needed to make CPU hotplug in Windows work=
 */
>      env->features[FEAT_HYPERV_EDX] |=3D HV_CPU_DYNAMIC_PARTITIONING_AVAI=
LABLE;
> @@ -1121,6 +1192,12 @@ static int hyperv_handle_properties(CPUState *cs,
>          goto free;
>      }
> =20
> +    if (cpu->hyperv_all) {
> +        /* We already copied all feature words from KVM as is */
> +        r =3D cpuid->nent;
> +        goto free;
> +    }
> +
>      c =3D &cpuid_ent[cpuid_i++];
>      c->function =3D HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
>      if (!cpu->hyperv_vendor_id) {
> @@ -1192,11 +1269,26 @@ free:
>      return r;
>  }
> =20
> +static Error *hv_all_mig_blocker;
> +
>  static int hyperv_init_vcpu(X86CPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> +    Error *local_err =3D NULL;
>      int ret;
> =20
> +    if (cpu->hyperv_all && hv_all_mig_blocker =3D=3D NULL) {
> +        error_setg(&hv_all_mig_blocker,
> +                   "'hv-all' CPU flag prevents migration, use explicit s=
et of "
> +                   "hv-* flags instead");
> +        ret =3D migrate_add_blocker(hv_all_mig_blocker, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_free(hv_all_mig_blocker);
> +            return ret;
> +        }
> +    }
> +
>      if (cpu->hyperv_vpindex && !hv_vpindex_settable) {
>          /*
>           * the kernel doesn't support setting vp_index; assert that its =
value
