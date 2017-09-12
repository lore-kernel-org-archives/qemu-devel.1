Received: from eggs.gnu.org ([2001:4830:134:3::10]:58685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drloN-0000qK-Vc
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drloI-0005Jb-0x
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:05:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drloH-0005Ih-Rt
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:05:05 -0400
Date: Tue, 12 Sep 2017 16:05:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170912160501.78b2ca81.cohuck@redhat.com>
In-Reply-To: <90381836-c1ee-2d0b-86a5-117c2a86a74f@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-4-pasic@linux.vnet.ibm.com>
	<20170911114841.408b5988.cohuck@redhat.com>
	<90381836-c1ee-2d0b-86a5-117c2a86a74f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] s390x/css: remove dubious error
 handling branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 11 Sep 2017 15:08:52 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/11/2017 11:48 AM, Cornelia Huck wrote:
> > On Fri,  8 Sep 2017 17:24:45 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> The case in question actually never happens. Let us get rid of the dead
> >> code.  
> > 
> > I had tried to be complete in my initial implementation. With the
> > current implementation, it can never happen, yes. We can easily
> > resurrect it from git history should we need it in the future.
> >   
> 
> I've tried to understand the branch but I failed. Weather the subchannel
> is busy or not should be already decided, and if the device is busy
> that is probably supposed to be indicated via device status (word 2 bit 3).
> 
> So I wrote dubious because I could not figure it out. But unused
> is certainly nicer.
> 
> I think shall the need emerge the preferred way of handling would
> be to use the custom handling (-EIO) branch.

What this is trying to do is deferred cc 1 handling. On a real system,
a ssch may return with cc 0 to indicate that the channel program has
been accepted; but when the channel subsystem actually tries to execute
it, a status is already pending. Basically, it's a race condition:
Therefore the 'deferred' cc 1.

Maybe I should have called this 'deferred subchannel busy'... but
anyway, this cannot happen in our current implementation.
