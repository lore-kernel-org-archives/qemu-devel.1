Received: from eggs.gnu.org ([2001:4830:134:3::10]:58973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fbMKn-0000j3-Qj
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fbMKk-0000th-Kf
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:43:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fbMKk-0000rE-Fz
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:43:18 -0400
Date: Fri, 6 Jul 2018 09:43:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180706084313.GB28022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
	<20180704194327.GJ914@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180704194327.GJ914@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] i386: Add support to get/set/migrate MSR
 (33H)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Jingqi Liu <jingqi.liu@intel.com>, pbonzini@redhat.com, wei.w.wang@intel.com, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Wed, Jul 04, 2018 at 04:43:27PM -0300, Eduardo Habkost wrote:
> On Wed, Jul 04, 2018 at 09:21:06PM +0800, Jingqi Liu wrote:
> > The MSR (33H) controls support for #AC exception
> > for split locked accesses. When bit 29 of the MSR (33H)
> > is set, the processor causes an #AC exception to
> > be issued instead of suppressing LOCK on bus
> > (during split lock access).
> > 
> > Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> [...]
> > diff --git a/target/i386/machine.c b/target/i386/machine.c
> > index 4d98d36..c82dc0d 100644
> > --- a/target/i386/machine.c
> > +++ b/target/i386/machine.c
> > @@ -935,6 +935,25 @@ static const VMStateDescription vmstate_msr_virt_ssbd = {
> >      }
> >  };
> >  
> > +static bool split_lock_ctrl_needed(void *opaque)
> > +{
> > +    X86CPU *cpu = opaque;
> > +    CPUX86State *env = &cpu->env;
> > +
> > +    return env->split_lock_ctrl != 0;
> > +}
> 
> Based on the Linux patch at [1], guests may try to detect the
> feature by writing to the MSR unconditionally.
> 
> If this happens, KVM needs to provide a mechanism to
> enable/disable the MSR emulation.  Otherwise users will end up
> with VMs that can't be migrated to older hosts even if they are
> using older machine-types.

Is there really no CPUID flag that can be used to detect the feature ?
Unconditionally probing for existance of arbitrary MSRs seems to be
just re-inventing CPUID feature detection, but worse because as you
say we need to now invent a way to control existance of individual
MSRs too :-(

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
