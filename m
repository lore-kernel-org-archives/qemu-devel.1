Received: from eggs.gnu.org ([2001:4830:134:3::10]:47510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g85Lt-00076z-2N
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g85Lp-0007Uf-2E
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1g85Lo-0007Te-R0
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:15:40 -0400
Date: Thu, 4 Oct 2018 10:15:31 -0500
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181004151531.e4kv63u3qukjaxhk@kamzik.brq.redhat.com>
References: <cover.1537868529.git.manish.jaggi@cavium.com>
	<2a127056e5c1a1edb4a5d8e093bc67467685e0ac.1537868529.git.manish.jaggi@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a127056e5c1a1edb4a5d8e093bc67467685e0ac.1537868529.git.manish.jaggi@cavium.com>
Subject: Re: [Qemu-devel] [RFC] [PATCH 3/3] arm: Skip invariant register
 restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjaggi@caviumnetworks.com
Cc: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>

On Thu, Sep 27, 2018 at 01:13:54AM +0000, mjaggi@caviumnetworks.com wrote:
> From: Manish Jaggi <manish.jaggi@cavium.com>
> 
> Invariant registers will be skipped from being restored from
> guests' context on migrated host.
> 
> Signed-off-by: Manish Jaggi <manish.jaggi@cavium.com>
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 65f867d..2d89600 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -451,6 +451,9 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
>          default:
>              abort();
>          }
> +        if (skip_invariant && kvm_arm_is_invariant(&r)) {
> +            continue;
> +        }
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
>          if (ret) {
>              /* We might fail for "unknown register" and also for
> -- 
> 1.8.3.1
> 
>

I think we should compare the invariants we're going to skip restoring
with their saved state and output messages when they don't match to the
migration log. That way when things go wrong we have a clue as to why.

Thanks,
drew
