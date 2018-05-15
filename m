Received: from eggs.gnu.org ([2001:4830:134:3::10]:47557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIcO6-0007ie-GH
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIcNw-0007l5-OO
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:01:18 -0400
Date: Tue, 15 May 2018 18:01:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180515180104.646cba0c.cohuck@redhat.com>
In-Reply-To: <d2030a0c-6ab6-a470-f7d7-0926a7ff2b28@linux.ibm.com>
References: <20180509154910.23578-1-cohuck@redhat.com>
	<20180509154910.23578-2-cohuck@redhat.com>
	<d2030a0c-6ab6-a470-f7d7-0926a7ff2b28@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] vfio-ccw: forward halt/clear to
 device if supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 11 May 2018 11:53:52 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 09/05/2018 17:49, Cornelia Huck wrote:
> > The initial version of vfio-ccw did not support forwarding of the
> > halt or clear functions to the device, and we had to emulate them
> > instead.
> >
> > For versions of the vfio-ccw kernel implementation that indeed do
> > support halt/clear (by indicating them in the fctl of the scsw in
> > the io_region), we can simply start making use of it. If the kernel
> > does not support handling halt/clear, fall back to emulation.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   hw/s390x/css.c         | 32 ++++++++++++++++++++++++++++----
> >   hw/vfio/ccw.c          | 11 +++++++++--
> >   include/hw/s390x/css.h | 10 +++++++---
> >   3 files changed, 44 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index 301bf1772f..b6727d0607 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -1180,6 +1180,16 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
> >   
> >   }
> >   
> > +static IOInstEnding sch_handle_clear_func_passthrough(SubchDev *sch)
> > +{
> > +    return s390_ccw_cmd_request(sch);
> > +}
> > +
> > +static IOInstEnding sch_handle_halt_func_passthrough(SubchDev *sch)
> > +{
> > +    return s390_ccw_cmd_request(sch);
> > +}
> > +
> >   static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
> >   {
> >   
> > @@ -1233,13 +1243,27 @@ IOInstEnding do_subchannel_work_virtual(SubchDev *sch)
> >   IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
> >   {
> >       SCSW *s = &sch->curr_status.scsw;
> > +    static bool no_halt_clear;
> >   
> > +    /* if the kernel does not support halt/clear, fall back to emulation */
> >       if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
> > -        /* TODO: Clear handling */
> > -        sch_handle_clear_func(sch);
> > +        if (no_halt_clear) {
> > +            sch_handle_clear_func(sch);
> > +        } else {
> > +            if (sch_handle_clear_func_passthrough(sch) == IOINST_OPNOTSUPP) {
> > +                no_halt_clear = true;
> > +                sch_handle_halt_func(sch);
> > +            }
> > +        }
> >       } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
> > -        /* TODO: Halt handling */
> > -        sch_handle_halt_func(sch);
> > +        if (no_halt_clear) {
> > +            sch_handle_halt_func(sch);
> > +        } else {
> > +            if (sch_handle_halt_func_passthrough(sch) == IOINST_OPNOTSUPP) {
> > +                no_halt_clear = true;
> > +                sch_handle_halt_func(sch);
> > +            }
> > +        }
> >       } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
> >           return sch_handle_start_func_passthrough(sch);
> >       }
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index e67392c5f9..247901ae41 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -60,6 +60,7 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
> >   
> >       memset(region, 0, sizeof(*region));
> >   
> > +    /* orb is only valid for ssch, but does not hurt for other functions */
> >       memcpy(region->orb_area, &sch->orb, sizeof(ORB));
> >       memcpy(region->scsw_area, &sch->curr_status.scsw, sizeof(SCSW));
> >   
> > @@ -70,8 +71,12 @@ again:
> >           if (errno == EAGAIN) {
> >               goto again;
> >           }
> > -        error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
> > -        ret = -errno;
> > +        /* handle not supported operations like halt/clear on older kernels */
> > +        if (ret != -EOPNOTSUPP) {
> > +            error_report("vfio-ccw: write I/O region failed with errno=%d",
> > +                         errno);
> > +            ret = -errno;
> > +        }
> >       } else {
> >           ret = region->ret_code;
> >       }
> > @@ -83,6 +88,8 @@ again:
> >       case -ENODEV:
> >       case -EACCES:
> >           return IOINST_CC_NOT_OPERATIONAL;
> > +    case -EOPNOTSUPP:
> > +        return IOINST_OPNOTSUPP;
> >       case -EFAULT:
> >       default:
> >           sch_gen_unit_exception(sch);
> > diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> > index 35facb47d2..e33f26882b 100644
> > --- a/include/hw/s390x/css.h
> > +++ b/include/hw/s390x/css.h
> > @@ -100,9 +100,11 @@ typedef struct CcwDataStream {
> >   } CcwDataStream;
> >   
> >   /*
> > - * IO instructions conclude according to this. Currently we have only
> > - * cc codes. Valid values are 0, 1, 2, 3 and the generic semantic for
> > + * IO instructions conclude according to this. One class of values are
> > + * cc codes: Valid values are 0, 1, 2, 3 and the generic semantic for
> >    * IO instructions is described briefly. For more details consult the PoP.
> > + * Additionally, other endings may occur due to internal processing errors
> > + * like lack of support for an operation.
> >    */
> >   typedef enum IOInstEnding {
> >       /* produced expected result */
> > @@ -112,7 +114,9 @@ typedef enum IOInstEnding {
> >       /* inst. ineffective because busy with previously initiated function */
> >       IOINST_CC_BUSY = 2,
> >       /* inst. ineffective because not operational */
> > -    IOINST_CC_NOT_OPERATIONAL = 3
> > +    IOINST_CC_NOT_OPERATIONAL = 3,
> > +    /* internal: operation not supported */
> > +    IOINST_OPNOTSUPP = 4
> >   } IOInstEnding;
> >   
> >   typedef struct SubchDev SubchDev;  
> 
> 
> Couldn't we introduce ABI versioning ?

Can you elaborate what you're referring to?

If you mean checking capabilities of the kernel or so: If we can avoid
that and just try (and stop if it does not work), I'd prefer that (no
dependencies).

The IOINST_OPNOTSUPP is a bit ugly, but I did not see a more elegant
way to pass 'not supported' up to the caller.
