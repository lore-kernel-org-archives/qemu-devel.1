Received: from eggs.gnu.org ([2001:4830:134:3::10]:47952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dxEx6-0002ws-3Z
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dxEx1-0004g8-5T
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:12:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dxEx0-0004fN-SS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:12:43 -0400
Date: Wed, 27 Sep 2017 19:12:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170927190724-mutt-send-email-mst@kernel.org>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Relph, Richard" <Richard.Relph@amd.com>

On Wed, Sep 27, 2017 at 08:39:24AM -0500, Brijesh Singh wrote:
> Hi Michael,
> 
> 
> On 09/26/2017 09:36 AM, Michael S. Tsirkin wrote:
> 
> ...
> 
> > > 8. libvirt launches the guest with "-S"
> > > 9. While creating the SEV guest qemu does the following
> > >   i) create encryption context using GO's DH, session-info and guest policy
> > >      (LAUNCH_START)
> > >   ii) encrypts the guest bios (LAUNCH_UPDATE_DATA)
> > >   iii) calls LAUNCH_MEASUREMENT to get the encrypted bios measurement
> > 
> > This part troubles me. This seems to mean that the guest being launched
> > must know what the measurement of the bios is going to be.  This means
> > that the cloud provider can not update the bios without breaking guests.
> > Also, while in practice you typically can run an old bios image on a new
> > qemu instance, this is not really tested so would be very hard to
> > support properly in QEMU.
> > 
> > 
> 
> 
> The guest itself does not need to know the measurement of the bios --
> the SEV launch flow empowers the GO to validate the bootstrap code (bios)
> before GO can provide a confidential information to the guest. Please note
> that the validating of the measurement flow is optional. GO can ask cloud
> provider to ignore the measurement all together and boot the SEV guest.

As the OS runs on top of the bios, it does not seem prudent to boot the
SEV guest without a way to verify that the bios is safe to use.
Linux generally trusts the firmware it runs on. Are you looking for
examples of how a malicious firmware can leak info out of the guest?

> The measurement flow can be useful when GO decides to provide a custom
> bios and want to know that his bios is used for booting the guest. In this
> case, since the guest owner knows the initial contents of the guest at boot,
> he can request the measurement from the cloud provider and compare it with
> what the guest owner expects.

I agree the measurement works for this, but If that's the only case, I'd
say it's not all that interesting since most people will use a standard
bios.

I do think something needs to vaidate the bios though, and I do not
think naively measuring the hash of the full bios is a way to do this
that we can support well long term.

> 
> 
> > And this looks like a fundamental problem with the hash based
> > measurement that's in hardware. So below I suggest that we layer
> > some software on top to rely on the hash as little as possible.
> > 
> > 
> > 
> > > 10. By some interface we must propagate the measurement all the way to GO
> > >    before libvirt starts the guest.
> > > 11. GO verifies the measurement and if measurement matches then it may
> > >   give a secret blob -- which must be injected into the guest before
> > >   libvirt starts the VM. If verification failed, GO will request cloud
> > >   provider to destroy the VM.
> > > 12. After secret blob is injected into guest, we call LAUNCH_FINISH
> > >    to destory the encryption context.
> > > 13. libvirt issues "continue" command to resume the guest boot.
> > > 
> > > Please note that the measurement value is protected with transport
> > > encryption key (TIK) and it changes on each run. Similarly the secret blob
> > > provided by GO does not need to be protected using libvirt/qemu APIs. The
> > > secret is protected by TIK. From qemu and libvirt point of view these are
> > > blobs and must be passed as-is to the SEV FW.
> > 
> > So here's an alternative idea for starting guests:
> > 
> > How about building a minimal shim firmware that
> > runs on a single CPU and uses no hardware at all,
> > it just contains the secret blob.
> > 
> > That firmware just immediately stops and signals
> > hypervisor that it is ready to be run in the cloud.
> > 
> > Have user generate and start this shim firmware as a guest in a private
> > setup, then export it out using SEND_* commands.
> > 
> > Then instead of asking to launch guest, you ask provider
> > to load it with RECEIVE_* commands.
> > 
> > Unlike bios the shim firmware
> > can hopefully be static so supporting it across qemu
> > versions should be easy.
> > 
> > The shim firmware then loads bios from qemu, verifies
> > it in any way it sees fit (e.g. it could check a signature, version, etc:
> > it is not limited to a hardware hash anymore).
> > It then jumps to the bios.
> > 
> > 
> > While not exactly the same, there is some similarity
> > here with how people solved the issues around secureboot -
> > by using a shim.
> > 
