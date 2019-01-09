Received: from eggs.gnu.org ([209.51.188.92]:56542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghAcA-0007ce-Lz
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 04:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghAc9-0001Fh-27
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 04:57:34 -0500
Date: Wed, 9 Jan 2019 10:57:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190109105716.2b1d06d2.cohuck@redhat.com>
In-Reply-To: <20190108183609.235a8eb8@oc2783563651>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<20181212153426.2ca5a481.cohuck@redhat.com>
	<f38c791b-3aad-46a8-79e7-9adb74ba4726@linux.ibm.com>
	<20190108183609.235a8eb8@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 00/15] s390: vfio-ccw dasd ipl
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

On Tue, 8 Jan 2019 18:36:09 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 8 Jan 2019 11:37:56 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
> > On 12/12/18 9:34 AM, Cornelia Huck wrote:
> > ...  
> > >>
> > >> NOTE: It has been a while, but I've finally chased down my infamous "reset bug".
> > >> On subsystem reset (I see this right after host ipl) we sometimes end up getting
> > >> an unexpected unit check status from a dasd device. This causes the first start
> > >> subchannel instruction to fail due to the pending unit check status. My solution
> > >> to this problem, as advised by the kernel folks, is to simply retry my ssch
> > >> instructions before declaring failure when unexpected unit checks happen. In the
> > >> event of a persistent error, after two retries we'll give up and print some
> > >> useful error info for the user.  
> > > 
> > > So, is that a status we only see because the vfio-ccw driver keeps the
> > > subchannel enabled (as by the other recent thread)?
> > > 
> > > Is there any value in distinguishing different unit checks, or is retry
> > > the best strategy in any case?
> > >   
> > The status presents on device reset. So when the host kernel IPLs this status will be 
> > present. The very first attempt to use the device (SSCH, other instructions perhaps?) will 
> > cause this status to be presented. Sometimes the host kernel must "get there first" and 
> > clear the status. And other times the guest (by way of Qemu bios) gets there first.
> > 
> > The kernel handles unexpected unit checks by simply retrying a low number of times before 
> > giving up. Given that bios code is a constant frequency code path, and the kernel has 
> > already set this precedent, I feel safe with this decision and don't see a ton of value in 
> > doing much more. If we find a case that requires more handling we can take a look at it.

Yeah, my thinking was "should we check for this particular unit check
so we don't ignore other problems"? But if the kernel simply retries,
let's just do that in the bios as well.

> I agree, doing elaborate CIO error handling here does not seem like a
> particularly good idea.
> 
> Something remotely related -- let me play crazy for a moment: let's say
> we pass-through two DASD's to a single guest, one as the IPL disk and
> one just so. If I'm not mistaken, the guest is guaranteed to get this
> special after reset unit check (let's say freshly constructed VM),
> unless there is another OS messing with the same DASD maybe, at least
> for the 'just son DASD'. I would even guess that the condition in
> question is indicated even for the IPL-DASD (if we thing guest1).

My thinking is that the guest needs to be able to deal with this unit
check if it gets it, and chances are good that it already does the
right thing if the OS has been running on non-KVM as well. We probably
can neglect any differences between IPL and non-IPL, as the unit check
is simply something that the guest *might* see.

> 
> But ccw-passthrough won't get perfect anyway. So I think we can ignore
> this side effect of the reset, unless  a need arises not to.
> 
> Regards,
> Halil
> 
> 
