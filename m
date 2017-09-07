Received: from eggs.gnu.org ([2001:4830:134:3::10]:55145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dprpr-0003zy-Az
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dprpl-00012m-6X
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dprpk-000127-U1
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:06:45 -0400
Date: Thu, 7 Sep 2017 10:06:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907100640.60de537a.cohuck@redhat.com>
In-Reply-To: <cafc4452-bdc5-546f-2ed0-4f1cb230f474@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<abc65014-f9fa-4cea-7f49-3e97e3845a3c@linux.vnet.ibm.com>
	<20170906172023.19a283a0.cohuck@redhat.com>
	<cafc4452-bdc5-546f-2ed0-4f1cb230f474@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On Wed, 6 Sep 2017 18:16:29 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/06/2017 05:20 PM, Cornelia Huck wrote:
> > On Wed, 6 Sep 2017 16:24:13 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> On 09/06/2017 03:18 PM, Cornelia Huck wrote:  
> >>> On Tue,  5 Sep 2017 13:16:45 +0200
> >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>>     
> >>>> Add a fake device meant for testing the correctness of our css emulation.
> >>>>
> >>>> What we currently have is writing a Fibonacci sequence of uint32_t to the
> >>>> device via ccw write. The write is going to fail if it ain't a Fibonacci
> >>>> and indicate a device exception in scsw together with the proper residual
> >>>> count.
> >>>>
> >>>> Of course lot's of invalid inputs (besides basic data processing) can be
> >>>> tested with that as well.
> >>>>
> >>>> Usage:
> >>>> 1) fire up a qemu with something like -device ccw-tester,devno=fe.0.0001
> >>>>    on the command line
> >>>> 2) exercise the device from the guest
> >>>>
> >>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>>> ---
> >>>>
> >>>> It may not make sense to merge this work in the current form, as it is
> >>>> solely for test purposes.
> >>>> ---
> >>>>  hw/s390x/Makefile.objs |   1 +
> >>>>  hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  2 files changed, 180 insertions(+)
> >>>>  create mode 100644 hw/s390x/ccw-tester.c    
> >>>
> >>> The main problem here is that you want to exercise a middle layer (the
> >>> css code) and need to write boilerplate code on both host and guest
> >>> side in order to be able to do so.
> >>>     
> >>
> >> Nod.
> >>  
> >>> In general, a device that accepts arbitrary channel programs looks
> >>> useful for testing purposes. I would split out processing of expected
> >>> responses out, though, so that it can be more easily reused for
> >>> different use cases.
> >>>     
> >>
> >> I'm not sure what do you mean here. Could you clarify please?  
> > 
> > Maybe doing things like logging received ccws and responses etc. and
> > and then comparing against an expected outcome. You should be able to
> > write test cases for different sets of things to be tested. I know this
> > is awfully vague :)  
> 
> Yes it does sound awfully vague :). In my case different tests are
> actually done in the kernel module implementing a driver for this
> device. I compare the expected outcome and the actual outcome there.
> This device is just a back-end lending itself to experimentation.

I think we want both guest-side and host-side checking. I think we
should aim for a guest-side checker that does not require a kernel
module (a simple guest makes it easier to run as an automated test.)

> >>> For the guest tester: Can that be done via the qtest infrastructure
> >>> somehow?
> >>>     
> >>
> >> Well, for now I have the out-of-tree Linux kernel module provided in the
> >> cover letter of the series (you did not comment on that one yet).  
> > 
> > Yes, I saw that, but have not yet looked at it. If there is a way to do
> > it without too many extra parts, I'd prefer that.
> >   
> 
> Well, I think the module is almost as economical with extra parts as it
> can get: it uses the kernel infrastructure and does not do a whole lot
> of things on top.

And that's also the problem: You drag the whole kernel infrastructure
along with it.

> 
> I think it's worth a look.

It certainly is, but you know how it is with resources...

> I hope it will also give answers to some
> of the implicit questions I see above. Yes, tests done in the driver
> are currently very few. Both with and without indirect data access
> we first let a device consume a Fibonacci sequence and verify that
> the IO has succeeded. Then we deliberately change an element in the
> sequence so it ain't the next Fibonacci number. And check for unit
> exception and proper residual count. With that we are sure that
> the data was properly consumed up until the given element. For IDA
> we the shorten the sequence so it does not contain the 'broken'
> element, and expect completion again. As you see this is a sufficient
> test for the good path for single CCW programs.
> 
> Extending to testing chaining (different concern), or responses
> to broken channel programs (e.g. ORB flags, bad addresses, tic
> rules) should be quite straightforward.

Yes, that all sounds very nice. We just disagree about the means :)

> 
> >>
> >> I think for building trust regarding my IDA implementation it should be
> >> able to do the job. Don't you agree?  
> > 
> > There's nothing wrong with your test. But we really should try to move
> > to some kind of unified testing that is hopefully self-contained so
> > that interested people can just play with it within the context of qemu.
> >   
> >>
> >> Just a couple of hours ago Janosch (cc-ing Janosch) came to my office,
> >> and told be that he is working on CCW-tests for zonk (a minimal kernel
> >> for testing -- internal tool AFAIR).
> >>
> >> By qtest you mean libqtest/libqos? I'm not familiar with that and have no
> >> idea what do we have for s390x. I see on libqos-s390x file in test/libqos
> >> for starters.  
> > 
> > Yes, that was what I was thinking about. Integrating into what is
> > already there is what we should aim for.
> > 
> > [For things that are done via kvm, kvm unit tests are good. But I think
> > we can do css tests completely within qemu.]
> >   
> 
> I agree fully, the point is somebody needs to make it happen. I would
> be very sad if forced to make it happen for the sake of this patch set.

You must have misunderstood me: This is not a requirement for this
patch set...

> 
> That said. I could not identify any required actions on this front (testing
> IDA) . If I made a mistake please point it out. I'm gonna try and speak
> with the folks here about our testing strategy. IMHO libqtest/libqos could
> very well be a part of it, but I can't tell anything for sure for now.

Yes, it would be great if we could get something that benefits
everyone. If we have tests that integrate into existing infrastructure,
it is more likely that they will actually be run :)

> 
> If somebody volunteers to transform what I have in this patch and the
> cover letter to something better integrated, it will make me more than
> happy.

Me too :)
