Received: from eggs.gnu.org ([2001:4830:134:3::10]:52634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNF0G-0002HY-FZ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNF0D-0003Ck-A4
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:31:32 -0500
Date: Fri, 8 Dec 2017 10:31:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171208103122.0ef44941.cohuck@redhat.com>
In-Reply-To: <20171207153141.15523-2-david@redhat.com>
References: <20171207153141.15523-1-david@redhat.com>
	<20171207153141.15523-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 1/5] s390x/kvm: factor out
 build_channel_report_mcic() into cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Thu,  7 Dec 2017 16:31:37 +0100
David Hildenbrand <david@redhat.com> wrote:

> We'll need it later on in two places. Refactor it to just indicate the
> validity bits. While at it, introduce a define for the used CR14 bit (we'll
> also need later on).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 22 ++++++++++++++++++++++
>  target/s390x/kvm.c | 25 ++-----------------------
>  2 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 9cfbbbac04..f29f4ccd8b 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -351,6 +351,9 @@ extern const struct VMStateDescription vmstate_s390_cpu;
>  #define CR0_CPU_TIMER_SC        0x0000000000000400ULL
>  #define CR0_SERVICE_SC          0x0000000000000200ULL
>  
> +/* Control register 14 bits */
> +#define CR14_CHANNEL_REPORT_SC  0x0000000010000000ULL
> +
>  /* MMU */
>  #define MMU_PRIMARY_IDX         0
>  #define MMU_SECONDARY_IDX       1
> @@ -674,6 +677,25 @@ struct sysib_322 {
>  #define MCIC_VB_CT 0x0000000000020000ULL
>  #define MCIC_VB_CC 0x0000000000010000ULL
>  
> +static inline uint64_t s390_build_validity_mcic(void)
> +{
> +    uint64_t mcic;
> +
> +    /* Indicate all validity bits (no damage) only. Other bits have to be
> +     * added by the caller. (storage errors, subclasses and subclass modifiers)
> +     */

Looks good. I prefer the classic comment style (empty first line),
though.

> +    mcic = MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC_VB_FP |
> +           MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_VB_PR |
> +           MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
> +    if (s390_has_feat(S390_FEAT_VECTOR)) {
> +        mcic |= MCIC_VB_VR;
> +    }
> +    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
> +        mcic |= MCIC_VB_GS;
> +    }
> +    return mcic;
> +}
> +
>  
>  /* cpu.c */
>  int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 97c45d5537..9b8b59f2a2 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1852,33 +1852,12 @@ void kvm_s390_io_interrupt(uint16_t subchannel_id,
>      kvm_s390_floating_interrupt(&irq);
>  }
>  
> -static uint64_t build_channel_report_mcic(void)
> -{
> -    uint64_t mcic;
> -
> -    /* subclass: indicate channel report pending */
> -    mcic = MCIC_SC_CP |
> -    /* subclass modifiers: none */
> -    /* storage errors: none */
> -    /* validity bits: no damage */
> -        MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC_VB_FP |
> -        MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_VB_PR |
> -        MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
> -    if (s390_has_feat(S390_FEAT_VECTOR)) {
> -        mcic |= MCIC_VB_VR;
> -    }
> -    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
> -        mcic |= MCIC_VB_GS;
> -    }
> -    return mcic;
> -}
> -
>  void kvm_s390_crw_mchk(void)
>  {
>      struct kvm_s390_irq irq = {
>          .type = KVM_S390_MCHK,
> -        .u.mchk.cr14 = 1 << 28,
> -        .u.mchk.mcic = build_channel_report_mcic(),
> +        .u.mchk.cr14 = CR14_CHANNEL_REPORT_SC,
> +        .u.mchk.mcic = s390_build_validity_mcic() | MCIC_SC_CP,
>      };
>      kvm_s390_floating_interrupt(&irq);
>  }
