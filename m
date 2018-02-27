Received: from eggs.gnu.org ([2001:4830:134:3::10]:35883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqjQv-0001Vj-0m
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eqjQr-0004Ei-UV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:52:57 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
Date: Tue, 27 Feb 2018 18:52:39 +0100
MIME-Version: 1.0
In-Reply-To: <1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

>      vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
>      if (!vfio_group) {
>          goto out_err;
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.=
h
> index 11def14..35a6d04 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>  #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>  #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>  #define KVM_S390_VM_CPU_FEAT_KSS	13
> +#define KVM_S390_VM_CPU_FEAT_AP		14
>  struct kvm_s390_vm_cpu_feat {
>  	__u64 feat[16];
>  };
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index a5619f2..65b91bd 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -36,8 +36,10 @@ static const S390FeatDef s390_features[] =3D {
>      FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status fac=
ility"),
>      FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE faci=
lity"),
>      FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, "Configuration-topology=
 facility"),
> +    FEAT_INIT("qci", S390_FEAT_TYPE_STFL, 12, "Query AP Configuration =
facility"),
>      FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range facility")=
,
>      FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing key-set=
ting facility"),
> +    FEAT_INIT("apft", S390_FEAT_TYPE_STFL, 15, "Adjunct Processor Faci=
lities Test facility"),
>      FEAT_INIT("etf2", S390_FEAT_TYPE_STFL, 16, "Extended-translation f=
acility 2"),
>      FEAT_INIT("msa-base", S390_FEAT_TYPE_STFL, 17, "Message-security-a=
ssist facility (excluding subfunctions)"),
>      FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL, 18, "Long-displacement fac=
ility"),
> @@ -125,6 +127,7 @@ static const S390FeatDef s390_features[] =3D {
> =20
>      FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement facil=
ity 2"),
>      FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, "Collaborative-memory-man=
agement facility"),
> +    FEAT_INIT("ap", S390_FEAT_TYPE_MISC, 1, "AP facilities installed")=
,

How exactly is this feature communicated to the guest? How does KVM
sense support for it?

IOW: is this really a CPU model feature?

> =20
>      FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (=
32 bit in general registers)"),
>      FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load =
(64 bit in parameter list)"),
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_feature=
s_def.h
> index 7c5915c..8998b65 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -27,8 +27,10 @@ typedef enum {
>      S390_FEAT_SENSE_RUNNING_STATUS,
>      S390_FEAT_CONDITIONAL_SSKE,
>      S390_FEAT_CONFIGURATION_TOPOLOGY,
> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>      S390_FEAT_IPTE_RANGE,
>      S390_FEAT_NONQ_KEY_SETTING,
> +    S390_FEAT_AP_FACILITIES_TEST,
>      S390_FEAT_EXTENDED_TRANSLATION_2,
>      S390_FEAT_MSA,
>      S390_FEAT_LONG_DISPLACEMENT,
> @@ -118,6 +120,7 @@ typedef enum {
>      /* Misc */
>      S390_FEAT_DAT_ENH_2,
>      S390_FEAT_CMM,
> +    S390_FEAT_AP,
> =20
>      /* PLO */
>      S390_FEAT_PLO_CL,
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 1d5f0da..35f91ea 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -770,6 +770,8 @@ static void check_consistency(const S390CPUModel *m=
odel)
>          { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
>          { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
>          { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
> +        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
> +        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
>      };
>      int i;
> =20
> @@ -900,6 +902,16 @@ void s390_realize_cpu_model(CPUState *cs, Error **=
errp)
>      cpu->model->cpu_id_format =3D max_model->cpu_id_format;
>      cpu->model->cpu_ver =3D max_model->cpu_ver;
> =20
> +    /*
> +     * If the AP facilities are not installed on the guest, then it ma=
kes
> +     * no sense to enable the QCI or APFT facilities because they are =
only
> +     * needed by AP facilities.
> +     */
> +    if (!test_bit(S390_FEAT_AP, cpu->model->features)) {
> +        clear_bit(S390_FEAT_AP_QUERY_CONFIG_INFO, cpu->model->features=
);
> +        clear_bit(S390_FEAT_AP_FACILITIES_TEST, cpu->model->features);
> +    }

Please don't silently disable things. Instead

a) Add consistency checks (check_consistency())
b) Mask the bits out in the KVM CPU model sensing part
  (kvm_s390_get_host_cpu_model()) - which you already have :)

> +
>      check_consistency(cpu->model);
>      check_compatibility(max_model, cpu->model, errp);
>      if (*errp) {
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 0cdbc15..2d01b52 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] =3D {
>      S390_FEAT_ADAPTER_INT_SUPPRESSION,
>      S390_FEAT_EDAT_2,
>      S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
> +    S390_FEAT_AP,
> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
> +    S390_FEAT_AP_FACILITIES_TEST,
>  };

Please keep the order as defined in target/s390x/cpu_features_def.h

> =20
>  static uint16_t full_GEN12_GA2[] =3D {
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index e13c890..ae20ed8 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2105,6 +2105,7 @@ static int kvm_to_feat[][2] =3D {
>      { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
>      { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
>      { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
> +    { KVM_S390_VM_CPU_FEAT_AP, S390_FEAT_AP},

Nothing speaks against the STFL bits, want to learn more about the
S390_FEAT_AP feature :)


--=20

Thanks,

David / dhildenb
