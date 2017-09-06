Received: from eggs.gnu.org ([2001:4830:134:3::10]:53508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpc83-0003Z3-Nc
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpc7y-0005ok-SO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpc7y-0005lL-Iz
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:20:30 -0400
Date: Wed, 6 Sep 2017 17:20:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906172023.19a283a0.cohuck@redhat.com>
In-Reply-To: <abc65014-f9fa-4cea-7f49-3e97e3845a3c@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<abc65014-f9fa-4cea-7f49-3e97e3845a3c@linux.vnet.ibm.com>
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

On Wed, 6 Sep 2017 16:24:13 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/06/2017 03:18 PM, Cornelia Huck wrote:
> > On Tue,  5 Sep 2017 13:16:45 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> Add a fake device meant for testing the correctness of our css emulation.
> >>
> >> What we currently have is writing a Fibonacci sequence of uint32_t to the
> >> device via ccw write. The write is going to fail if it ain't a Fibonacci
> >> and indicate a device exception in scsw together with the proper residual
> >> count.
> >>
> >> Of course lot's of invalid inputs (besides basic data processing) can be
> >> tested with that as well.
> >>
> >> Usage:
> >> 1) fire up a qemu with something like -device ccw-tester,devno=fe.0.0001
> >>    on the command line
> >> 2) exercise the device from the guest
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> ---
> >>
> >> It may not make sense to merge this work in the current form, as it is
> >> solely for test purposes.
> >> ---
> >>  hw/s390x/Makefile.objs |   1 +
> >>  hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 180 insertions(+)
> >>  create mode 100644 hw/s390x/ccw-tester.c  
> > 
> > The main problem here is that you want to exercise a middle layer (the
> > css code) and need to write boilerplate code on both host and guest
> > side in order to be able to do so.
> >   
> 
> Nod.
> 
> > In general, a device that accepts arbitrary channel programs looks
> > useful for testing purposes. I would split out processing of expected
> > responses out, though, so that it can be more easily reused for
> > different use cases.
> >   
> 
> I'm not sure what do you mean here. Could you clarify please?

Maybe doing things like logging received ccws and responses etc. and
and then comparing against an expected outcome. You should be able to
write test cases for different sets of things to be tested. I know this
is awfully vague :)

> 
> > (I dimly recall other test devices...)
> >   
> 
> What's on your mind? How do these relate to our problem? Can you
> give me some pointers?

I was thinking of precedent for test devices... but as said, I only
recall this very dimly.

> 
> > For the guest tester: Can that be done via the qtest infrastructure
> > somehow?
> >   
> 
> Well, for now I have the out-of-tree Linux kernel module provided in the
> cover letter of the series (you did not comment on that one yet).

Yes, I saw that, but have not yet looked at it. If there is a way to do
it without too many extra parts, I'd prefer that.

> 
> I think for building trust regarding my IDA implementation it should be
> able to do the job. Don't you agree?

There's nothing wrong with your test. But we really should try to move
to some kind of unified testing that is hopefully self-contained so
that interested people can just play with it within the context of qemu.

> 
> Just a couple of hours ago Janosch (cc-ing Janosch) came to my office,
> and told be that he is working on CCW-tests for zonk (a minimal kernel
> for testing -- internal tool AFAIR).
> 
> By qtest you mean libqtest/libqos? I'm not familiar with that and have no
> idea what do we have for s390x. I see on libqos-s390x file in test/libqos
> for starters.

Yes, that was what I was thinking about. Integrating into what is
already there is what we should aim for.

[For things that are done via kvm, kvm unit tests are good. But I think
we can do css tests completely within qemu.]
