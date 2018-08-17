Received: from eggs.gnu.org ([2001:4830:134:3::10]:57049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqedt-0000Ju-2t
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqedp-0005mP-4L
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqedo-0005m0-SJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:18:13 -0400
Date: Fri, 17 Aug 2018 10:18:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817131810.GA15372@localhost.localdomain>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] kvm: Add support to
 KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, robert.hu@intel.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

Thanks for the patch, comments below:

On Fri, Aug 10, 2018 at 10:06:28PM +0800, Robert Hoo wrote:
> Add kvm_get_supported_feature_msrs() to get supported MSR feature index list.
> Add kvm_arch_get_supported_msr_feature() to get each MSR features value.
> 
> kvm_get_supported_feature_msrs() is called in kvm_arch_init().
> kvm_arch_get_supported_msr_feature() is called by
> x86_cpu_get_supported_feature_word().
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  include/sysemu/kvm.h |  2 ++
>  target/i386/kvm.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 0b64b8e..97d8d9d 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -463,6 +463,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
>  
>  uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
>                                        uint32_t index, int reg);
> +uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
> +
>  
>  void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9313602..70d8606 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -107,6 +107,7 @@ static int has_pit_state2;
>  static bool has_msr_mcg_ext_ctl;
>  
>  static struct kvm_cpuid2 *cpuid_cache;
> +static struct kvm_msr_list *kvm_feature_msrs;

I was going to suggest moving this to KVMState, but KVMState is a
arch-independent struct.  I guess we'll have to live with this by
now.

>  
>  int kvm_has_pit_state2(void)
>  {
> @@ -420,6 +421,41 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>      return ret;
>  }
>  
> +uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
> +{
> +    struct {
> +        struct kvm_msrs info;
> +        struct kvm_msr_entry entries[1];
> +    } msr_data;
> +    uint32_t ret;
> +
> +    /*Check if the requested feature MSR is supported*/
> +    int i;
> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> +        if (index == kvm_feature_msrs->indices[i]) {
> +            break;
> +        }
> +    }

We are duplicating the logic that's already inside KVM (checking
the list of supported MSRs and returning an error).  Can't we
make this simpler and just remove this check?  If the MSR is not
supported, KVM_GET_MSRS would just return 0.

> +    if (i >= kvm_feature_msrs->nmsrs) {
> +        fprintf(stderr, "Requested MSR (index= %d) is not supported.\n", index);

This error message is meaningless for QEMU users.  Do we really
need to print it?

> +        return 0;

Returning 0 for MSRs that are not supported is probably OK, but
we need to see this function being used, to be sure (I didn't
look at all the patches in this series yet).

> +    }
> +
> +    msr_data.info.nmsrs = 1;
> +    msr_data.entries[0].index = index;
> +
> +    ret = kvm_ioctl(s, KVM_GET_MSRS, &msr_data);
> +
> +    if (ret != 1) {
> +        fprintf(stderr, "KVM get MSR (index=0x%x) feature failed, %s\n",
> +            index, strerror(-ret));
> +        exit(1);

I'm not a fan of APIs that write to stdout/stderr or exit(),
unless they are clearly just initialization functions that should
never fail in normal circumstances.

But if you call KVM_GET_MSRS for all MSRs at
kvm_get_supported_feature_msrs() below, this function would never
need to report an error.

We are already going through the trouble of allocating
kvm_feature_msrs in kvm_get_supported_feature_msrs() anyway.

> +    }
> +
> +    return msr_data.entries[0].data;
> +}
> +
> +
>  typedef struct HWPoisonPage {
>      ram_addr_t ram_addr;
>      QLIST_ENTRY(HWPoisonPage) list;
> @@ -1238,7 +1274,45 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>          env->mp_state = KVM_MP_STATE_INIT_RECEIVED;
>      }
>  }

Nit: please add an extra newline between functions.

> +static int kvm_get_supported_feature_msrs(KVMState *s)
> +{
> +    static int kvm_supported_feature_msrs;
> +    int ret = 0;
> +
> +    if (kvm_supported_feature_msrs == 0) {

Do you really need the kvm_supported_feature_msrs variable?  You
could just check if kvm_feature_msrs is NULL.

I also suggest doing this:

    if (already initialized) {
       return 0;
    }

    /* regular initialization code here */

to reduce one indentation level.


> +        struct kvm_msr_list msr_list;
> +
> +        kvm_supported_feature_msrs++;
> +
> +        msr_list.nmsrs = 0;
> +        ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
> +        if (ret < 0 && ret != -E2BIG) {
> +            return ret;

What if the host KVM version doesn't support
KVM_GET_MSR_FEATURE_INDEX_LIST?

> +        }
> +
> +        assert(msr_list.nmsrs > 0);
> +        kvm_feature_msrs = (struct kvm_msr_list *) \
> +            g_malloc0(sizeof(msr_list) +
> +                     msr_list.nmsrs * sizeof(msr_list.indices[0]));
> +        if (kvm_feature_msrs == NULL) {

g_malloc0() never returns NULL on failure.  See
https://developer.gnome.org/glib/2.56/glib-Memory-Allocation.html#glib-Memory-Allocation.description

> +            fprintf(stderr, "Failed to allocate space for KVM Feature MSRs"
> +                "which has %d MSRs\n", msr_list.nmsrs);
> +            return -1;
> +        }
> +
> +        kvm_feature_msrs->nmsrs = msr_list.nmsrs;
> +        ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, kvm_feature_msrs);
>  
> +        if (ret < 0) {  /*ioctl failure*/

Small nit: the "ioctl failure" comment seems unnecessary, I would
just remove it.

> +            fprintf(stderr, "Fetch KVM feature MSRs failed: %s\n",
> +                strerror(-ret));
> +            g_free(kvm_feature_msrs);
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}

Same as above: please add an extra newline between functions.

>  static int kvm_get_supported_msrs(KVMState *s)
>  {
>      static int kvm_supported_msrs;
> @@ -1400,6 +1474,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          return ret;
>      }
>  
> +    ret = kvm_get_supported_feature_msrs(s);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>      uname(&utsname);
>      lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
>  
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
