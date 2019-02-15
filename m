Received: from eggs.gnu.org ([209.51.188.92]:51234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gudus-0004DQ-Cd
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gudur-0000hz-Ee
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:52:34 -0500
References: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>
	<1550146494-21085-2-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8cc36b2c-0b35-3461-a09b-139c7f6eccad@redhat.com>
Date: Fri, 15 Feb 2019 14:52:21 +0100
MIME-Version: 1.0
In-Reply-To: <1550146494-21085-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

On 14.02.19 13:14, Pierre Morel wrote:
> A new CPU model facilities is introduced to support AP devices
> interruption interception for a KVM guest.

This sentence is confusing. At first I thought you would introduce a new
_fake_ facility.

"Let's add support for the AP-Queue interruption facility to the CPU model".

> 
> "APQI" for "AP-Queue Interruption" facility
> 
> The S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, CPU facility indicates
> whether the PQAP instruction with the AQIC command is available
> to the guest.
> This feature will be enabled only if the AP instructions are
> available on the linux host and AQIC facility is installed on
> the host.
> 
> This feature must be turned on from userspace to intercept AP
> instructions on the KVM guest. The QEMU command line to turn
> this feature on looks something like this:
> 
>     qemu-system-s390x ... -cpu xxx,apqi=on ...
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 1 +
>  target/s390x/cpu_features_def.h | 1 +
>  target/s390x/cpu_models.c       | 1 +
>  target/s390x/gen-features.c     | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 60cfeba..99bd382 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -84,6 +84,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facility"),
>      FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentation facility"),
>      FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
> +    FEAT_INIT("apqi", S390_FEAT_TYPE_STFL, 65, "AP-Queue interruption facility"),
>      FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
>      FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
>      FEAT_INIT("ais", S390_FEAT_TYPE_STFL, 72, "General-purpose-adapter-interruption-suppression facility"),
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index 5fc7e7b..3f22780 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -72,6 +72,7 @@ typedef enum {
>      S390_FEAT_SEMAPHORE_ASSIST,
>      S390_FEAT_TIME_SLICE_INSTRUMENTATION,
>      S390_FEAT_RUNTIME_INSTRUMENTATION,
> +    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
>      S390_FEAT_ZPCI,
>      S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
>      S390_FEAT_ADAPTER_INT_SUPPRESSION,
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7c253ff..6b5e94b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -788,6 +788,7 @@ static void check_consistency(const S390CPUModel *model)
>          { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
>          { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
>          { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
> +        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
>      };
>      int i;
>  
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 70015ea..b051221 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -448,6 +448,7 @@ static uint16_t full_GEN12_GA1[] = {
>      S390_FEAT_EDAT_2,
>      S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>      S390_FEAT_AP_QUERY_CONFIG_INFO,
> +    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
>      S390_FEAT_AP_FACILITIES_TEST,
>      S390_FEAT_AP,
>  };
> 

Looks good to me. In QEMU, we enable/indicate facilities only when all
required parts were implemented on the QEMU side.

Is there anything we have to do regarding
- migration support unlocked with this facility
- functional changes we have to implement?

Or is this really a "kernel does it all, migration not relevant" ?

-- 

Thanks,

David / dhildenb
