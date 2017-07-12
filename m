Received: from eggs.gnu.org ([2001:4830:134:3::10]:55905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJkw-0007QE-Lf
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJkr-0001Hn-Nw
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:40:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVJkr-0001Fu-Cv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:40:45 -0400
Date: Wed, 12 Jul 2017 17:40:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712174040.5241897d@dhcp-192-215.str.redhat.com>
In-Reply-To: <c70ce5b2-cbf0-e0c0-0697-8ffac5446dea@redhat.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-11-git-send-email-borntraeger@de.ibm.com>
	<c70ce5b2-cbf0-e0c0-0697-8ffac5446dea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/11] s390x/sic: realize SIC handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Fei Li <sherrylf@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Wed, 12 Jul 2017 15:40:02 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 12.07.2017 14:57, Christian Borntraeger wrote:
> > From: Fei Li <sherrylf@linux.vnet.ibm.com>
> > 
> > Currently, we do nothing for the SIC instruction, but we need to
> > implement it properly. Let's add proper handling in the backend code.
> > 
> > Co-authored-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> > Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> > Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  hw/s390x/css.c         | 26 ++++++++++++++++++++++++++
> >  hw/s390x/trace-events  |  1 +
> >  include/hw/s390x/css.h |  2 ++
> >  target/s390x/kvm.c     | 16 +++++++++++++++-
> >  4 files changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index 1fcbc84..7b82176 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -521,6 +521,32 @@ void css_conditional_io_interrupt(SubchDev *sch)
> >      }
> >  }
> >  
> > +int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode)
> > +{
> > +    S390FLICState *fs = s390_get_flic();
> > +    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
> > +    int r;
> > +
> > +    if (env->psw.mask & PSW_MASK_PSTATE) {
> > +        r = -PGM_PRIVILEGED;
> > +        goto out;  
> 
> Why not simply:
> 
>            return -PGM_PRIVILEGED;
> 
> ?
> 
> Same for the other goto below ... and then you also do not need the "r"
> variable anymore.

I'm slightly in favour of the single exit style.

> 
> > +    }
> > +
> > +    trace_css_do_sic(mode, isc);
> > +    switch (mode) {
> > +    case SIC_IRQ_MODE_ALL:
> > +    case SIC_IRQ_MODE_SINGLE:
> > +        break;
> > +    default:
> > +        r = -PGM_OPERAND;
> > +        goto out;
> > +    }
> > +
> > +    r = fsc->modify_ais_mode(fs, isc, mode) ? -PGM_OPERATION : 0;
> > +out:
> > +    return r;
> > +}
> > +
> >  void css_adapter_interrupt(uint8_t isc)
> >  {
> >      uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;

(...)

> > diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> > index e028960..5ee6d52 100644
> > --- a/include/hw/s390x/css.h
> > +++ b/include/hw/s390x/css.h
> > @@ -12,6 +12,7 @@
> >  #ifndef CSS_H
> >  #define CSS_H
> >  
> > +#include "cpu.h"  
> 
> Not sure, but it's a little bit strange that the channel sub-system now
> depends on the CPU ... maybe the check for problem state should rather
> be done in kvm.c instead?

This would mean that tcg would need to duplicate those checks should we
want to wire it up in the future. (FWIW, the sclp backend code in
hw/s390x/sclp.c also does the respective checks, probably for exactly
that reason.)

> Or should css_do_sic() rather reside in s390-pci-inst.c or in ioinst.c
> instead?

s390-pci-inst.c is only a good choice if we are sure that sic will be
applicable for pci only even in the future - and I don't think we can
be. (The ais stuff is tied to the adapter, who knows which adapter
types may arrive in the future...)

I/O interrupt injection is currently triggered from the css code (where
it belongs IMO), so I think the code should stay where it is now.
