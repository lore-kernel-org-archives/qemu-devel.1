Received: from eggs.gnu.org ([2001:4830:134:3::10]:34371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG4S1-0004X9-HD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG4Ry-0006vk-9d
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:22:49 -0400
Date: Tue, 8 May 2018 17:22:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508172239.31c84932.cohuck@redhat.com>
In-Reply-To: <e18c6c5b-5036-fb0c-b861-5b55786cd6ba@linux.ibm.com>
References: <20180507155130.21085-1-cohuck@redhat.com>
	<2a6f6a2a-ddaf-27ae-de04-581dcc67fdd0@linux.ibm.com>
	<20180508155551.7cea014f.cohuck@redhat.com>
	<e18c6c5b-5036-fb0c-b861-5b55786cd6ba@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] s390x: reset handling for ccw devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 8 May 2018 16:24:08 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/08/2018 03:55 PM, Cornelia Huck wrote:
> > On Tue, 8 May 2018 15:29:50 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> >> In particular the the pim, the lpm and the pam set in css_reset_sch
> >> seems to suit only devices that use the virtual chp. That
> >> is it ain't suits any CCWDevice instance.  
> > 
> > Yes, we need to revisit this code and split out what makes sense and
> > what doesn't. For now, we only have virtual devices and vfio-ccw, so
> > we're fine. It even might make sense to keep them separate in the
> > future, as having a virtual device and one only mirroring some state in
> > QEMU sound like they want to be handled differently.
> >   
> 
> I agree. The last sentence probably means that resetting the in QEMU
> state may not be sufficient.

We currently have vfio-ccw's reset handler calling into the kernel and
triggering an disable/enable. What's missing is resetting QEMU's
internal state (or rather, syncing it up with the hardware state).
Needs some thinking.

> Another to me somewhat strange thing I noticed is this disabled_cb
> used by virtio. It's is I guess the way it it is (specified in
> the OASIS spec and everything), but I don't really understand how
> this aligns with what the PoP says about MSCH. I mean AFAIU
> MSCH does not trigger any communication between the channel subsystem
> and the CU and or the device. I read the PoP as nothing is supposed
> to change expect the things specified where MSCH is described. I guess
> it is just another strange thing we have to live with -- for historical
> reasons.

OTOH, I'd expect to have to setup things again if I disabled and
afterwards enabled a subchannel again. We should be able to overwrite
any old state after doing that. This was the best way to get virtio to
start with a clean slate again -- we don't want virtio reset to clean
the revision.
