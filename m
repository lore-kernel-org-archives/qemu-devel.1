Received: from eggs.gnu.org ([2001:4830:134:3::10]:54950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@kernel.org>) id 1dRzxg-00053s-C3
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@kernel.org>) id 1dRzxf-0005lY-HU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:56:16 -0400
Date: Mon, 3 Jul 2017 13:56:04 +0200
From: Cornelia Huck <cohuck@kernel.org>
Message-ID: <20170703135604.311ad10d@dhcp-192-215.str.redhat.com>
In-Reply-To: <fee6eaa0-8132-b3ce-bb3e-0a716eb72064@de.ibm.com>
References: <20170703085107.16547-1-haoqf@linux.vnet.ibm.com>
	<20170703085107.16547-2-haoqf@linux.vnet.ibm.com>
	<fee6eaa0-8132-b3ce-bb3e-0a716eb72064@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio-scsi-ccw: use ioeventfd even
 when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, zyimin@linux.vnet.ibm.com, famz@redhat.com, peterx@redhat.com, stefanha@redhat.com

On Mon, 3 Jul 2017 12:20:03 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/03/2017 10:51 AM, QingFeng Hao wrote:
>
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index a3d00196f4..c37f9c3b9e 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -2220,6 +2220,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
> >          .addr = sch,
> >          .len = 8,
> >      };
> > +    if (!kvm_enabled()) {
> > +        return 0;
> > +    }  
> 
> thinking more about it. wouldnt it be better to do something like this instead
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 058ddad..cc47831 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -1240,7 +1240,11 @@ static inline int s390_assign_subch_ioeventfd(EventNotifier *notifier,
>                                                uint32_t sch_id, int vq,
>                                                bool assign)
>  {
> -    return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
> +    if (kvm_enabled()) {
> +        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
> +    } else {
> +        return 0;
> +    }
>  }
>  
>  static inline void s390_crypto_reset(void)

Agreed.

> 
> 
> FWIW, it seems that we (s390) do not have a functional equivalent function as commit
> 8c56c1a592b5092d91da8d8943c17777d6462a6f ("memory: emulate ioeventfd") , so we will
> not use the iothreads. 

Should not be a problem, I think. We may want to cook up an equivalent,
though.

> 
> 
> >      if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
> >          return -ENOSYS;
> >      }
> >   
> 
> 
