Received: from eggs.gnu.org ([2001:4830:134:3::10]:34759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm3un-0003F0-OY
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm3uk-0003yc-JM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:39:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm3uk-0003y9-D3
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:39:54 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36CC780F95
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 19:39:54 +0000 (UTC)
Date: Thu, 9 Mar 2017 16:39:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170309193949.GY4694@thinpad.lan.raisama.net>
References: <20170309193117.24885-1-ehabkost@redhat.com>
	<20170309193415.GN2480@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309193415.GN2480@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Mar 09, 2017 at 07:34:15PM +0000, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > When a KVM_SET_MSRS ioctl() fails, it is difficult to find out
> > which MSR caused the problem. Print an error message for
> > debugging, before we trigger the (ret == cpu->kvm_msr_buf->nmsrs)
> > assert.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/kvm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 887a81268f..3a874e4717 100644
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
> 
> Yes, I'd thought about doing the same;

Actually, I forgot to add:

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

as it was your idea. :)


>                                        had you considered adding it on the get
> as well?

I don't remember hitting the kvm_get_msrs() assert(), so I didn't
consider doing it.

But it looks useful, I will submit a separate patch.

> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

> 
> Dave
> 
> >      assert(ret == cpu->kvm_msr_buf->nmsrs);
> >      return 0;
> >  }
> > -- 
> > 2.11.0.259.g40922b1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Eduardo
