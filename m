Received: from eggs.gnu.org ([2001:4830:134:3::10]:36657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVI0x-0000We-Di
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVI0s-0004it-DN
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVI0s-0004hm-6q
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:49:10 -0400
Date: Wed, 12 Jul 2017 15:49:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712154903.12ae15f9@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499864265-144136-2-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-2-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] s390x/kvm: Rework cmma management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>

On Wed, 12 Jul 2017 14:57:35 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.vnet.ibm.com>
> 
> Let's keep track of cmma enablement and move the mem_path check into
> the actual enablement. This now also warns users that do not use
> cpu-models about disabled cmma when using huge pages.
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu.h |  1 +
>  target/s390x/kvm.c | 26 +++++++++++++++++---------
>  2 files changed, 18 insertions(+), 9 deletions(-)

> @@ -177,6 +179,11 @@ int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit)
>      return kvm_vm_ioctl(s, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
> +int kvm_s390_cmma_active(void)
> +{
> +    return active_cmma;
> +}

This is rather "has cmma ever been enabled"...

> +
>  static bool kvm_s390_cmma_available(void)
>  {
>      static bool initialized, value;
> @@ -197,7 +204,7 @@ void kvm_s390_cmma_reset(void)
>          .attr = KVM_S390_VM_MEM_CLR_CMMA,
>      };
>  
> -    if (mem_path || !kvm_s390_cmma_available()) {
> +    if (!kvm_s390_cmma_active()) {
>          return;
>      }

...as you don't clear it on reset, right?

Confused me a bit at first, but

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
