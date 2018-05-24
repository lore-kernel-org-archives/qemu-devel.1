Received: from eggs.gnu.org ([2001:4830:134:3::10]:38610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLnZD-0003f4-6S
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLnZA-0005Cp-2t
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:55 -0400
Date: Thu, 24 May 2018 12:33:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180524123347.1c62288c.cohuck@redhat.com>
In-Reply-To: <8bb3b068-15d3-cb3e-724d-ca7589750175@linux.ibm.com>
References: <20180522221655.78979-1-pasic@linux.ibm.com>
	<20180522221655.78979-2-pasic@linux.ibm.com>
	<20180523113708.50b21a77.cohuck@redhat.com>
	<a3ab7dfd-4cc1-5632-1590-bce4a40f063e@linux.ibm.com>
	<20180523164640.225908a9.cohuck@redhat.com>
	<5de50b20-a331-78ea-a7f4-6fdd995ed083@linux.ibm.com>
	<20180523185957.41af37b2.cohuck@redhat.com>
	<d99ca544-de44-422f-8bcd-cc9b53fd047b@linux.ibm.com>
	<20180524091608.1c4e8b00.cohuck@redhat.com>
	<8bb3b068-15d3-cb3e-724d-ca7589750175@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/2] vfio-ccw: add force
 unlimited prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 24 May 2018 12:29:01 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/24/2018 09:16 AM, Cornelia Huck wrote:
> > On Wed, 23 May 2018 19:28:31 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> On 05/23/2018 06:59 PM, Cornelia Huck wrote:  
> >>> On Wed, 23 May 2018 18:23:44 +0200
> >>> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>>      
> >>>> On 05/23/2018 04:46 PM, Cornelia Huck wrote:  
> >>>>>>>> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> >>>>>>>> +        if (!(vcdev->force_orb_pfch)) {
> >>>>>>>> +            warn_report("vfio-ccw requires PFCH flag set");
> >>>>>>>> +            sch_gen_unit_exception(sch);
> >>>>>>>> +            css_inject_io_interrupt(sch);
> >>>>>>>> +            return IOINST_CC_EXPECTED;
> >>>>>>>> +        } else {
> >>>>>>>> +            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> >>>>>>>> +            WARN_ONCE(vcdev->warned_force_orb_pfch, "PFCH flag forced");  
> >>>>>>> This message should probably mention vfio-ccw as well as the subchannel
> >>>>>>> id?
> >>>>>>>            
> >>>>>> I was thinking about this. I think all it would make sense to have a common
> >>>>>> prefix for all reports coming form vfio-ccw (QEMU). But then I was like, that
> >>>>>> is a separate patch.
> >>>>>>
> >>>>>> Maybe something like:
> >>>>>> vfio-ccw (xx.xx.xxxx): specific message
> >>>>>>
> >>>>>> OTOH we don't seem to do that elsewhere (git grep -e 'warn\|error_report\|error_setg' -- hw/s390x/).
> >>>>>> AFAIR the error_setg captures context (like, src, line, func) but does not
> >>>>>> necessarily report it. Another question is if this should be extended to
> >>>>>> hw/s390x/s390-ccw.c
> >>>>>>
> >>>>>> What do you think?  
> >>>>> I'm not sure that makes sense, especially as not everything might
> >>>>> explicitly refer to a certain subchannel.
> >>>>>
> >>>>> Let's just add the subchannel id here? In this case, this is really a
> >>>>> useful piece of information (which device is showing this behaviour?)
> >>>>>         
> >>>>
> >>>> The same applies to  warn_report("vfio-ccw requires PFCH flag set") (that is,
> >>>> on which device (that has no force-orb-pfch=on specified)  is the guest issuing
> >>>> ORBs with the PFCH unset), or?
> >>>> Should I go for
> >>>> "vfio-ccw (xx.xx.xxxx): vfio-ccw requires PFCH flag set"
> >>>> and
> >>>> "vfio-ccw (xx.xx.xxxx): PFCH flag forced"
> >>>> or just for the second one, or some third option?  
> >>>
> >>> Yes, it makes sense for both.
> >>>
> >>> Related: Do we expect the guest driver to learn from its experience and
> >>> not try without pfch again? It is probably not very helpful if the logs
> >>> get filled with a lot of "vfio-ccw requires pfch" messages...
> >>>      
> >>
> >> Don't really know. Dong Jia is probably more qualified to answer that question.
> >> I don't expect the guest driver to do so. There are probably more intelligent
> >> strategies to deal with this, but the question is what do we gain in the end
> >> (linux guests are not affected). We should probably not overthink this.  
> > 
> > So, print both messages just once per device?
> >   
> 
> We can do that. I will morph warned_force_orb_pfch to warned_orb_pfch. That
> way we can get away with one boolean, as the both cases are mutually exclusive.

Sounds good!
