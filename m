Received: from eggs.gnu.org ([2001:4830:134:3::10]:47500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clina-0001h9-3e
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clinV-0000OH-6G
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:07:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clinU-0000MB-Uf
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:07:01 -0500
Date: Wed, 8 Mar 2017 18:06:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308210655.GN4694@thinpad.lan.raisama.net>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900634659.27090.2157657994637303677.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148900634659.27090.2157657994637303677.stgit@brijesh-build-machine>
Subject: Re: [Qemu-devel] [RFC PATCH v4 07/20] kvm: add memory encryption
 api support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com

On Wed, Mar 08, 2017 at 03:52:26PM -0500, Brijesh Singh wrote:
> Add high level API's to provide guest memory encryption support.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  include/sysemu/kvm.h |    7 +++++++
>  kvm-all.c            |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  kvm-stub.c           |   31 ++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 24281fc..6f88a06 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -227,6 +227,13 @@ int kvm_init_vcpu(CPUState *cpu);
>  int kvm_cpu_exec(CPUState *cpu);
>  int kvm_destroy_vcpu(CPUState *cpu);
>  
> +bool kvm_memcrypt_enabled(void);
> +void *kvm_memcrypt_get_handle(void);
> +void kvm_memcrypt_set_debug_ops(MemoryRegion *mr);
> +int kvm_memcrypt_create_launch_context(void);
> +int kvm_memcrypt_release_launch_context(void);
> +int kvm_memcrypt_encrypt_launch_data(uint8_t *ptr, uint64_t len);

Please document what the return value of those functions mean.

[...]
> +int kvm_memcrypt_create_launch_context(void)
> +{
> +    if (kvm_state->create_launch_context) {
> +        return kvm_state->create_launch_context(kvm_state->ehandle);
> +    }
> +
> +    return 1;

I suggest returning -ENOTSUP if not implemented.

> +}
> +
> +int kvm_memcrypt_release_launch_context(void)
> +{
> +    if (kvm_state->release_launch_context) {
> +        return kvm_state->release_launch_context(kvm_state->ehandle);
> +    }
> +
> +    return 1;
> +}
> +
> +int kvm_memcrypt_encrypt_launch_data(uint8_t *dst, uint64_t len)
> +{
> +    if (kvm_state->encrypt_launch_data) {
> +        return kvm_state->encrypt_launch_data(kvm_state->ehandle, dst, len);
> +    }
> +
> +    return 1;
> +}
> +
> +void kvm_memcrypt_set_debug_ops(MemoryRegion *mr)
> +{
> +    if (kvm_state->memcrypt_debug_ops) {
> +        return kvm_state->memcrypt_debug_ops(kvm_state->ehandle, mr);
> +    }
> +}
> +
> +void *kvm_memcrypt_get_handle(void)
> +{
> +    return kvm_state->ehandle;
> +}
> +
>  int kvm_get_max_memslots(void)
>  {
>      KVMState *s = KVM_STATE(current_machine->accelerator);
> diff --git a/kvm-stub.c b/kvm-stub.c
> index ef0c734..20920aa 100644
> --- a/kvm-stub.c
> +++ b/kvm-stub.c
> @@ -105,6 +105,37 @@ int kvm_on_sigbus(int code, void *addr)
>      return 1;
>  }
>  
> +bool kvm_memcrypt_enabled(void)
> +{
> +    return false;
> +}
> +
> +void *kvm_memcrypt_get_handle(void)
> +{
> +    return NULL;
> +}
> +
> +void kvm_memcrypt_set_debug_ops(MemoryRegion *mr)
> +{
> +    return;
> +}
> +
> +int kvm_memcrypt_create_launch_context(void)
> +{
> +    return 1;
> +}
> +
> +int kvm_memcrypt_release_launch_context(void)
> +{
> +    return 1;
> +}
> +
> +int kvm_memcrypt_encrypt_launch_data(uint8_t *ptr, uint64_t len)
> +{
> +    return 1;
> +}
> +
> +
>  #ifndef CONFIG_USER_ONLY
>  int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>  {
> 

-- 
Eduardo
