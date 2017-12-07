Received: from eggs.gnu.org ([2001:4830:134:3::10]:34678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMzFr-0004mv-I0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMzFo-0004kt-Fl
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:42:35 -0500
Date: Thu, 7 Dec 2017 17:42:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171207174224.779baf34.cohuck@redhat.com>
In-Reply-To: <89a78374-25fe-76c5-3a96-deaa1ff6b391@linux.vnet.ibm.com>
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
	<e2e2ae84-e04a-df4f-50bb-328768a5464e@redhat.com>
	<20171207125901.47be0af1.cohuck@redhat.com>
	<87df13b9-c494-c8b4-49cf-b7ef4640d05a@linux.vnet.ibm.com>
	<20171207135756.1f84ed41.cohuck@redhat.com>
	<89a78374-25fe-76c5-3a96-deaa1ff6b391@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 7 Dec 2017 17:35:26 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 12/07/2017 01:57 PM, Cornelia Huck wrote:
> > On Thu, 7 Dec 2017 13:38:22 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> On 12/07/2017 12:59 PM, Cornelia Huck wrote:  
> >>> On Thu, 7 Dec 2017 07:33:19 +0100
> >>> Thomas Huth <thuth@redhat.com> wrote:
> >>>     
> >>>> On 08.11.2017 17:54, Halil Pasic wrote:    
> >>>     
> >>>>> +static ccw_cb_t get_ccw_cb(CcwTestDevOpMode op_mode)
> >>>>> +{
> >>>>> +    switch (op_mode) {
> >>>>> +    case OP_MODE_FIB:
> >>>>> +        return ccw_testdev_ccw_cb_mode_fib;
> >>>>> +    case OP_MODE_NOP:
> >>>>> +    default:
> >>>>> +        return ccw_testdev_ccw_cb_mode_nop;      
> >>>>
> >>>> Do we really want to use "nop" for unknown modes? Or should there rather
> >>>> be a ccw_testdev_ccw_cb_mode_error instead, too?    
> >>>
> >>> I like the idea of an error mode.    
> >>
> >> What would be the benefit of the error mode? The idea is that
> >> the tester in the guest has a certain set of tests implemented
> >> each requiring certain behavior from the device. This behavior
> >> is represented by the mode.
> >>
> >> If the device does not support the mode, the set of tests can't
> >> be executed meaningfully. The only option is either ignore them
> >> (and preferably report them as ignored), or fail them (not soo
> >> good in my opinion).  
> > 
> > Failing it sounds superior to me: You really want to know if something
> > does not work as expected.
> >   
> 
> When doing unit tests it's usual to differentiate between:
> * success, which ideally should give you guarantees about the unit
> not misbehaving in production if client code respects the contract
> * failure, which ideally should pretty much narrow down what
> went wrong
> * ignored, either due to user explicitly disabled a test, or
> a precondition for executing the was not met.
> 
> If you think traffic light its green, red and yellow respectively.
> 
> For instance qemu-iotests also skips tests where the environment
> does not provide a preconditions necessary to execute it.
> 
> Of course a quality gate for a release should really be the suite
> executed successfully (green), and not some tests were skipped.
> 
> A quality gate for let's day sending a series to the list could
> also be defined less rigorous. 
> 
> >>
> >> The in guest tester should simply iterate over it test sets
> >> and try to select the mode the test set (or suite in other
> >> terminology) requires. If selecting the mode fails, than
> >> means you are working with an old ccw-testdev.
> >>  
> >>>
> >>> Related: Should the device have a mechanism to report the supported
> >>> modes?
> >>>     
> >>
> >> I don't see the value. See above. I think the set mode operation
> >> reporting failure is sufficient.
> >>
> >> But if you have something in mind, please do tell. I'm open.  
> > 
> > If we keep guest/host in lockstep, we probably don't need this. But if
> > not, self-reporting looks like a reasonable feature as it gives more
> > flexibility.
> >   
> I would prefer adding this should the need arise instead of
> speculatively. Would that be fine for you.
> 
> BTW if interface stability is a concern maybe making the device
> experimental (at least for a while) is a good idea.

Well, if we used qtests, we would be fine without an error state, as
both sides have the same features.
