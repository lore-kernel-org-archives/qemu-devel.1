Received: from eggs.gnu.org ([2001:4830:134:3::10]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0Qvv-0007bN-Nz
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0Qvq-0006X9-Nu
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d0Qvq-0006Wt-If
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:04:26 -0400
Date: Tue, 18 Apr 2017 12:04:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170418110421.GE2205@work-vm>
References: <20170405190024.27581-1-dgilbert@redhat.com>
	<20170405190024.27581-2-dgilbert@redhat.com>
	<20170413150121.GW32646@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413150121.GW32646@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH 1/3] migration/i386: Remove old
 non-softfloat 64bit FP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, quintela@redhat.com

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Wed, Apr 05, 2017 at 08:00:22PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Long long ago, we used to support storing the x86 FP registers in
> > a 64bit format.
> > 
> > Then c31da136a0bf8caad70c348f5ffc283206e9c7fc in v0.14-rc0 removed
> > the last support for writing that in the migration format.
> > Even before that, it was only used if you had softfloat disabled
> >  (i.e. !USE_X86LDOUBLE) so in practice use of it in even earlier
> > qemu is unlikely for most users.
> > 
> > Kill it off, it's complicated, and possibly broken.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> I love the sound of obsolete code being deleted...
> 
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> But:
> 
> [...]
> > @@ -356,6 +256,10 @@ static int cpu_post_load(void *opaque, int version_id)
> >          return -EINVAL;
> >      }
> >  
> > +    if (env->fpregs_format_vmstate) {
> > +        error_report("Unsupported old non-softfloat CPU state");
> > +        return -EINVAL;
> > +    }
> 
> Is this equivalent to using VMSTATE_UINT16_EQUAL, but with a
> better and more verbose error message?

I think it probably is, yes.

Dave

> >      /*
> >       * Real mode guest segments register DPL should be zero.
> >       * Older KVM version were setting it wrongly.
> > @@ -943,7 +847,8 @@ VMStateDescription vmstate_x86_cpu = {
> >          VMSTATE_UINT16(env.fpus_vmstate, X86CPU),
> >          VMSTATE_UINT16(env.fptag_vmstate, X86CPU),
> >          VMSTATE_UINT16(env.fpregs_format_vmstate, X86CPU),
> > -        VMSTATE_FP_REGS(env.fpregs, X86CPU, 8),
> > +
> > +        VMSTATE_STRUCT_ARRAY(env.fpregs, X86CPU, 8, 0, vmstate_fpreg, FPReg),
> >  
> >          VMSTATE_SEGMENT_ARRAY(env.segs, X86CPU, 6),
> >          VMSTATE_SEGMENT(env.ldt, X86CPU),
> > -- 
> > 2.9.3
> > 
> 
> -- 
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
