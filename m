Received: from eggs.gnu.org ([209.51.188.92]:53754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDPvh-0008Hd-Ix
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDPvf-0001v0-EP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:47:01 -0400
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-10-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9223e19f-878f-636e-2c48-6d9e47485a65@redhat.com>
Date: Mon, 8 Apr 2019 10:39:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/15] s390x/kvm: Report warnings with
 warn_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

On 08/04/2019 10.36, Markus Armbruster wrote:
> kvm_s390_mem_op() can fail in two ways: when !cap_mem_op, it returns
> -ENOSYS, and when kvm_vcpu_ioctl() fails, it returns -errno set by
> ioctl().  Its caller s390_cpu_virt_mem_rw() recovers from both
> failures.
> 
> kvm_s390_mem_op() prints "KVM_S390_MEM_OP failed" with error_printf()
> in the latter failure mode.  Since this is obviously a warning, use
> warn_report().
> 
> Perhaps the reporting should be left to the caller.  It could warn on
> failure other than -ENOSYS.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  target/s390x/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 19530fb94e..2c6e35b5aa 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -782,7 +782,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>  
>      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
>      if (ret < 0) {
> -        error_printf("KVM_S390_MEM_OP failed: %s\n", strerror(-ret));
> +        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
>      }
>      return ret;
>  }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
