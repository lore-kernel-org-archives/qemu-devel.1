Received: from eggs.gnu.org ([2001:4830:134:3::10]:53726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7M63-00055A-6V
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7M5z-0000et-SO
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:56:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60692
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1g7M5z-0000ee-Lh
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:56:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w92EsZeX134189
	for <qemu-devel@nongnu.org>; Tue, 2 Oct 2018 10:56:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mva2n2awh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 10:56:17 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 2 Oct 2018 15:56:15 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-3-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 2 Oct 2018 16:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180926225440.6204-3-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <abbf0fb8-783e-8c02-a252-8ab791cb8089@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 2/6] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 27/09/2018 00:54, Tony Krowiak wrote:
> A new CPU model feature and two new CPU model facilities are
> introduced to support AP devices for a KVM guest.
>=20
> CPU model features:
>=20
> 1. The S390_FEAT_AP CPU model feature indicates whether AP
>     instructions are available to the guest. This feature will
>     be enabled only if the AP instructions are available on the
>     linux host as determined by the availability of the
>     KVM_S390_VM_CRYPTO_ENABLE_APIE VM attribute which is exposed
>     by KVM only if the AP instructions are available on the
>     host.
>=20
>     This feature must be turned on from userspace to execute AP
>     instructions on the KVM guest. The QEMU command line to turn
>     this feature on looks something like this:
>=20
> 	qemu-system-s390x ... -cpu xxx,ap=3Don ...
>=20
>     This feature will be supported for zEC12 and newer CPU models.
>     The feature will not be supported for older models because
>     there are few older systems on which to test and the older
>     crypto cards will be going out of service in the relatively
>     near future.
>=20
> CPU model facilities:
>=20
> 1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates whether the
>     AP Query Configuration Information (QCI) facility is available
>     to the guest as determined by whether the facility is available
>     on the host. This feature will be exposed by KVM only if the
>     QCI facility is installed on the host.
>=20
> 2. The S390_FEAT_AP_FACILITY_TEST feature indicates whether the AP
>     Facility Test (APFT) facility is available to the guest as
>     determined by whether the facility is available on the host.
>     This feature will be exposed by KVM only if APFT is installed
>     on the host.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   target/s390x/cpu_features.c     | 3 +++
>   target/s390x/cpu_features_def.h | 3 +++
>   target/s390x/cpu_models.c       | 2 ++
>   target/s390x/gen-features.c     | 3 +++
>   target/s390x/kvm.c              | 5 +++++
>   5 files changed, 16 insertions(+)
>=20
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 172fb18df718..60cfeba48f4e 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -39,8 +39,10 @@ static const S390FeatDef s390_features[] =3D {
>       FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status fa=
cility"),
>       FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE fac=
ility"),
>       FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, "Configuration-topolog=
y facility"),
> +    FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Query AP Configuratio=
n Information facility"),
>       FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range facility"=
),
>       FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing key-se=
tting facility"),
> +    FEAT_INIT("apft", S390_FEAT_TYPE_STFL, 15, "AP Facilities Test fac=
ility"),
>       FEAT_INIT("etf2", S390_FEAT_TYPE_STFL, 16, "Extended-translation =
facility 2"),
>       FEAT_INIT("msa-base", S390_FEAT_TYPE_STFL, 17, "Message-security-=
assist facility (excluding subfunctions)"),
>       FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL, 18, "Long-displacement fa=
cility"),
> @@ -129,6 +131,7 @@ static const S390FeatDef s390_features[] =3D {
>=20
>       FEAT_INIT_MISC("dateh2", "DAT-enhancement facility 2"),
>       FEAT_INIT_MISC("cmm", "Collaborative-memory-management facility")=
,
> +    FEAT_INIT_MISC("ap", "AP instructions installed"),
>=20
>       FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load =
(32 bit in general registers)"),
>       FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load=
 (64 bit in parameter list)"),
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_feature=
s_def.h
> index ac2c947f30a8..5fc7e7bf0116 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -27,8 +27,10 @@ typedef enum {
>       S390_FEAT_SENSE_RUNNING_STATUS,
>       S390_FEAT_CONDITIONAL_SSKE,
>       S390_FEAT_CONFIGURATION_TOPOLOGY,
> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>       S390_FEAT_IPTE_RANGE,
>       S390_FEAT_NONQ_KEY_SETTING,
> +    S390_FEAT_AP_FACILITIES_TEST,
>       S390_FEAT_EXTENDED_TRANSLATION_2,
>       S390_FEAT_MSA,
>       S390_FEAT_LONG_DISPLACEMENT,
> @@ -119,6 +121,7 @@ typedef enum {
>       /* Misc */
>       S390_FEAT_DAT_ENH_2,
>       S390_FEAT_CMM,
> +    S390_FEAT_AP,
>=20
>       /* PLO */
>       S390_FEAT_PLO_CL,
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 265d25c937bb..7c253ff308c5 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -786,6 +786,8 @@ static void check_consistency(const S390CPUModel *m=
odel)
>           { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
>           { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
>           { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
> +        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
> +        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
>       };
>       int i;
>=20
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 384b61cd67b9..70015eaaf5df 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] =3D {
>       S390_FEAT_ADAPTER_INT_SUPPRESSION,
>       S390_FEAT_EDAT_2,
>       S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
> +    S390_FEAT_AP_FACILITIES_TEST,
> +    S390_FEAT_AP,
>   };
>=20
>   static uint16_t full_GEN12_GA2[] =3D {
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 348e8cc5467a..5277acd79a2c 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2291,6 +2291,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *m=
odel, Error **errp)
>           error_setg(errp, "KVM: host CPU model could not be identified=
");
>           return;
>       }
> +    /* for now, we can only provide the AP feature with HW support */
> +    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
> +        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
> +        set_bit(S390_FEAT_AP, model->features);
> +    }
>       /* strip of features that are not part of the maximum model */
>       bitmap_and(model->features, model->features, model->def->full_fea=
t,
>                  S390_FEAT_MAX);
>=20

Appart the last hunk (being moved as commented by david):

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
