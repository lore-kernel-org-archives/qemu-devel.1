Received: from eggs.gnu.org ([2001:4830:134:3::10]:58032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgAdM-0004VG-4I
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgAdK-0004Eu-QM
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dgAdK-0004Ee-Gz
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:09:50 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4bcf16a4-274e-e364-bdb6-7c3d4137f193@redhat.com>
Date: Fri, 11 Aug 2017 16:09:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/5] target/s390x: move a couple of
 functions to cpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 09:46, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h | 88 +++++++-----------------------------------------------
>  2 files changed, 90 insertions(+), 78 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index dadd383..81165e8 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -392,6 +392,86 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
[...]
> +int s390_assign_subch_ioeventfd(EventNotifier *notifier,
> +                                              uint32_t sch_id, int vq,
> +                                              bool assign)

Indentation looks weird.

[....]
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 1ab88ad..a9acef6 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -421,25 +421,8 @@ static inline int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
[...]
> +int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
> +void s390_cmma_reset(void);
> +int s390_cpu_restart(S390CPU *cpu);
> +int s390_get_memslot_count(KVMState *s);
>  void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
>                         uint32_t io_int_parm, uint32_t io_int_word);
>  void s390_crw_mchk(void);
> -
> -static inline int s390_assign_subch_ioeventfd(EventNotifier *notifier,
> +int s390_assign_subch_ioeventfd(EventNotifier *notifier,
>                                                uint32_t sch_id, int vq,
> -                                              bool assign)

... and that's likely the reason ;-) Indentation now looks wrong here, too.

> -{
> -    if (kvm_enabled()) {
> -        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
> -    } else {
> -        return 0;
> -    }
> -}
> -
> -static inline void s390_crypto_reset(void)
> -{
> -    if (kvm_enabled()) {
> -        kvm_s390_crypto_reset();
> -    }
> -}
> -
> -static inline bool s390_get_squash_mcss(void)
> -{
> -    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-squash-mcss",
> -                                 NULL)) {
> -        return true;
> -    }
> -
> -    return false;
> -}
> +                                              bool assign);
> +void s390_crypto_reset(void);
> +bool s390_get_squash_mcss(void);
>  
>  /* machine check interruption code */
>  
> 

Apart from the white space nits, looks fine, so when you've fixed them:

Reviewed-by: Thomas Huth <thuth@redhat.com>
