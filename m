Received: from eggs.gnu.org ([209.51.188.92]:51469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1guaBf-0002GV-Ak
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1guaBc-0007P9-LM
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:53:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43086
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1guaBc-0007MI-Ge
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:53:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1F9opH3032542
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 04:53:33 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qns5t67na-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 04:53:33 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 15 Feb 2019 09:53:31 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>
	<1550146494-21085-2-git-send-email-pmorel@linux.ibm.com>
Date: Fri, 15 Feb 2019 10:53:24 +0100
MIME-Version: 1.0
In-Reply-To: <1550146494-21085-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <68ef1f07-75c2-5d40-1bf9-d6f1db1fa839@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390x/cpumodel: Set up CPU model for
 AQIC interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: akrowiak@linux.ibm.com, peter.maydell@linaro.org, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.ibm.com, eric.auger@redhat.com, qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On 14/02/2019 13:14, Pierre Morel wrote:
> A new CPU model facilities is introduced to support AP devices
> interruption interception for a KVM guest.
>=20
> "APQI" for "AP-Queue Interruption" facility
>=20
> The S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, CPU facility indicates
> whether the PQAP instruction with the AQIC command is available
> to the guest.
> This feature will be enabled only if the AP instructions are
> available on the linux host and AQIC facility is installed on
> the host.
>=20
> This feature must be turned on from userspace to intercept AP
> instructions on the KVM guest. The QEMU command line to turn
> this feature on looks something like this:
>=20
>      qemu-system-s390x ... -cpu xxx,apqi=3Don ...



Hi,

I suddenly have a very big doubt on this QEMU patch.

Older Linux advertise PQAP/AQIC feature (65)
Older Qemu mask it for the guest

Now if we set aqic =3D on in the new QEMU,
QEMU advertises feature (65)

The guest gets an OPERATION EXCEPTION even we advertised the feature 65.

This seems wrong to me, we should verify that the vfio_driver is loaded=20
in the host before starting the guest with something like:

kvm_vm_check_attr(kvm_state, KVM_S390_VM_ENABLE_AQIC)

Don't you think?

Regards,

Pierre



>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>   target/s390x/cpu_features.c     | 1 +
>   target/s390x/cpu_features_def.h | 1 +
>   target/s390x/cpu_models.c       | 1 +
>   target/s390x/gen-features.c     | 1 +
>   4 files changed, 4 insertions(+)
>=20
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 60cfeba..99bd382 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -84,6 +84,7 @@ static const S390FeatDef s390_features[] =3D {
>       FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist faci=
lity"),
>       FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumenta=
tion facility"),
>       FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumenta=
tion facility"),
> +    FEAT_INIT("apqi", S390_FEAT_TYPE_STFL, 65, "AP-Queue interruption =
facility"),
>       FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
>       FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapte=
r-event-notification facility"),
>       FEAT_INIT("ais", S390_FEAT_TYPE_STFL, 72, "General-purpose-adapte=
r-interruption-suppression facility"),
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_feature=
s_def.h
> index 5fc7e7b..3f22780 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -72,6 +72,7 @@ typedef enum {
>       S390_FEAT_SEMAPHORE_ASSIST,
>       S390_FEAT_TIME_SLICE_INSTRUMENTATION,
>       S390_FEAT_RUNTIME_INSTRUMENTATION,
> +    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
>       S390_FEAT_ZPCI,
>       S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
>       S390_FEAT_ADAPTER_INT_SUPPRESSION,
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7c253ff..6b5e94b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -788,6 +788,7 @@ static void check_consistency(const S390CPUModel *m=
odel)
>           { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
>           { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
>           { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
> +        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
>       };
>       int i;
>=20
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 70015ea..b051221 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -448,6 +448,7 @@ static uint16_t full_GEN12_GA1[] =3D {
>       S390_FEAT_EDAT_2,
>       S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>       S390_FEAT_AP_QUERY_CONFIG_INFO,
> +    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
>       S390_FEAT_AP_FACILITIES_TEST,
>       S390_FEAT_AP,
>   };
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
