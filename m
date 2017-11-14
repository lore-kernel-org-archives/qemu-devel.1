Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEcsW-00055L-9o
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEcsQ-0003zs-HF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:11:56 -0500
Date: Tue, 14 Nov 2017 16:11:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171114161138.6e9822c6.cohuck@redhat.com>
In-Reply-To: <1509033294-4945-5-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1509033294-4945-5-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/5] s390x/cpumodel: enable AP facilities for
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, david@redhat.com, qemu-devel@nongnu.org

On Thu, 26 Oct 2017 11:54:53 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Sets up the following STFLE bits to enable the specified AP
> facilities for the guest VM:
> 	* STFLE.12: Enables the AP Query Configuration Information
>                     facility. The AP bus running in the guest uses
>                     the information returned from this instruction
>                     to configure AP adapters and domains for the
>                     guest machine.
> 	* STFLE.15: Enables the AP Special Command facility. The AP
>                     bus running in the guest sets the T bit in
>                     register 0 for the PQAP(TAPQ) instruction when
>                     scanning for AP devices if this facility is
>                     installed.
> 
> These facilities are required in order for the AP bus running on
> the KVM guest to function properly.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  target/s390x/cpu_features.c     |    2 ++
>  target/s390x/cpu_features_def.h |    2 ++
>  target/s390x/gen-features.c     |    4 ++++
>  3 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 31a4676..63f002c 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -36,8 +36,10 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status facility"),
>      FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE facility"),
>      FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, "Configuration-topology facility"),
> +    FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Query Adjunct Processor Configuration facility"),
>      FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range facility"),
>      FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing key-setting facility"),
> +    FEAT_INIT("apsc", S390_FEAT_TYPE_STFL, 15, "Adjunct Processor Special Command facility"),

Are there any interdependencies for those feature bits?

>      FEAT_INIT("etf2", S390_FEAT_TYPE_STFL, 16, "Extended-translation facility 2"),
>      FEAT_INIT("msa-base", S390_FEAT_TYPE_STFL, 17, "Message-security-assist facility (excluding subfunctions)"),
>      FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL, 18, "Long-displacement facility"),
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index 4b6d4e9..4e2589f 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -27,8 +27,10 @@ typedef enum {
>      S390_FEAT_SENSE_RUNNING_STATUS,
>      S390_FEAT_CONDITIONAL_SSKE,
>      S390_FEAT_CONFIGURATION_TOPOLOGY,
> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>      S390_FEAT_IPTE_RANGE,
>      S390_FEAT_NONQ_KEY_SETTING,
> +    S390_FEAT_AP_SPECIAL_CMD,
>      S390_FEAT_EXTENDED_TRANSLATION_2,
>      S390_FEAT_MSA,
>      S390_FEAT_LONG_DISPLACEMENT,
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 68e6c31..42914cf 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -425,6 +425,10 @@ static uint16_t full_GEN11_GA1[] = {
>      S390_FEAT_IPTE_RANGE,
>      S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
>      S390_FEAT_GROUP_MSA_EXT_4,
> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
> +    S390_FEAT_AP_SPECIAL_CMD,

As discussed for the kernel patch, this needs some thought. Do these
features need to be enabled conditionally?

> +    /* FIXME when GISA support is available
> +    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,*/

Looking forward to seeing some gisa patches :)

>  };
>  
>  #define full_GEN11_GA2 EmptyFeat
