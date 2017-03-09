Received: from eggs.gnu.org ([2001:4830:134:3::10]:60408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm3pP-0001WL-6N
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm3pM-0001bO-2Z
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:34:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cm3pL-0001au-TG
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:34:20 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1395781254
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 19:34:20 +0000 (UTC)
Date: Thu, 9 Mar 2017 19:34:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170309193415.GN2480@work-vm>
References: <20170309193117.24885-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309193117.24885-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] kvm: Print MSR information if
 KVM_SET_MSRS failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> When a KVM_SET_MSRS ioctl() fails, it is difficult to find out
> which MSR caused the problem. Print an error message for
> debugging, before we trigger the (ret == cpu->kvm_msr_buf->nmsrs)
> assert.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/kvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 887a81268f..3a874e4717 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1807,6 +1807,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>          return ret;
>      }
>  
> +    if (ret < cpu->kvm_msr_buf->nmsrs) {
> +        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
> +        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
> +                     (uint32_t)e->index, (uint64_t)e->data);
> +    }
> +

Yes, I'd thought about doing the same; had you considered adding it on the get
as well?

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

>      assert(ret == cpu->kvm_msr_buf->nmsrs);
>      return 0;
>  }
> -- 
> 2.11.0.259.g40922b1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
