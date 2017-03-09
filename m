Received: from eggs.gnu.org ([2001:4830:134:3::10]:44878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm4dn-0003Y7-7x
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 15:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm4dk-0004N9-5G
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 15:26:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm4dj-0004N0-Vs
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 15:26:24 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1C5BC05681D
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 20:26:23 +0000 (UTC)
Date: Thu, 9 Mar 2017 17:26:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170309202620.GZ4694@thinpad.lan.raisama.net>
References: <20170309194634.28457-1-ehabkost@redhat.com>
	<20170309200759.GP2480@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309200759.GP2480@work-vm>
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2] kvm: Print MSR information if
 KVM_{GET, SET}_MSRS failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Mar 09, 2017 at 08:08:00PM +0000, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > When a KVM_{GET,SET}_MSRS ioctl() fails, it is difficult to find
> > out which MSR caused the problem. Print an error message for
> > debugging, before we trigger the (ret == cpu->kvm_msr_buf->nmsrs)
> > assert.
> > 
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Thanks!
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> I'd actually suggest it for 2.9; it's only added debug output.

I think I agree. The patch is reasonably safe because we would be
already hitting the assert() if (ret < cpu->kvm_msr_buf->nmsrs)
anyway.

Paolo, do you want to queue it for 2.9?

> 
> Dave
> 
> > ---
> > Changes v1 -> v2:
> > * Print error message on KVM_GET_MSRS too
> >   * Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  target/i386/kvm.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 887a81268f..705e971a63 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -1807,6 +1807,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
> >          return ret;
> >      }
> >  
> > +    if (ret < cpu->kvm_msr_buf->nmsrs) {
> > +        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
> > +        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
> > +                     (uint32_t)e->index, (uint64_t)e->data);
> > +    }
> > +
> >      assert(ret == cpu->kvm_msr_buf->nmsrs);
> >      return 0;
> >  }
> > @@ -2172,6 +2178,12 @@ static int kvm_get_msrs(X86CPU *cpu)
> >          return ret;
> >      }
> >  
> > +    if (ret < cpu->kvm_msr_buf->nmsrs) {
> > +        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
> > +        error_report("error: failed to get MSR 0x%" PRIx32,
> > +                     (uint32_t)e->index);
> > +    }
> > +
> >      assert(ret == cpu->kvm_msr_buf->nmsrs);
> >      /*
> >       * MTRR masks: Each mask consists of 5 parts
> > -- 
> > 2.11.0.259.g40922b1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Eduardo
