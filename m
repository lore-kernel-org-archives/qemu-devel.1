Received: from eggs.gnu.org ([2001:4830:134:3::10]:59291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj918-0007qg-LF
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj914-0000Tf-RG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:30:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj914-0000SB-HB
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:30:22 -0500
Date: Wed, 1 Mar 2017 20:30:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301202044-mutt-send-email-mst@kernel.org>
References: <20170301163104.GJ10160@redhat.com>
	<20170301185414-mutt-send-email-mst@kernel.org>
	<1d155a66-8806-8792-b82d-4bebabcd4971@linux.vnet.ibm.com>
	<20170301191459-mutt-send-email-mst@kernel.org>
	<4022b3c9-56c3-7cea-928c-9e0e7d070d90@linux.vnet.ibm.com>
	<20170301173823.GO10160@redhat.com>
	<20170301194704-mutt-send-email-mst@kernel.org>
	<20170301180602.GH2429@work-vm>
	<20170301200804-mutt-send-email-mst@kernel.org>
	<20170301181801.GI2429@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301181801.GI2429@work-vm>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "SERBAN, CRISTINA" <cs1731@att.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 06:18:01PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Wed, Mar 01, 2017 at 06:06:02PM +0000, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Wed, Mar 01, 2017 at 05:38:23PM +0000, Daniel P. Berrange wrote:
> > > > > On Wed, Mar 01, 2017 at 12:25:46PM -0500, Stefan Berger wrote:
> > > > > > On 03/01/2017 12:16 PM, Michael S. Tsirkin wrote:
> > > > > > > On Wed, Mar 01, 2017 at 12:12:34PM -0500, Stefan Berger wrote:
> > > > > > > > On 03/01/2017 12:02 PM, Michael S. Tsirkin wrote:
> > > > > > > > > On Wed, Mar 01, 2017 at 04:31:04PM +0000, Daniel P. Berrange wrote:
> > > > > > > > > > On Wed, Mar 01, 2017 at 06:22:45PM +0200, Michael S. Tsirkin wrote:
> > > > > > > > > > > On Wed, Mar 01, 2017 at 09:50:38AM -0500, Stefan Berger wrote:
> > > > > > > > > > > > I had already proposed a linked-in version before I went to the out-of-process
> > > > > > > > > > > > design. Anthony's concerns back then were related to the code not being trusted
> > > > > > > > > > > > and a segfault in the code could bring down all of QEMU. That we have test
> > > > > > > > > > > > suites running over it didn't work as an argument. Some of the test suite are
> > > > > > > > > > > > private, though.
> > > > > > > > > > > Given how bad the alternative is maybe we should go back to that one.
> > > > > > > > > > > Same argument can be made for any device and we aren't making
> > > > > > > > > > > them out of process right now.
> > > > > > > > > > > 
> > > > > > > > > > > IIMO it's less the in-process question (modularization
> > > > > > > > > > > of QEMU has been on the agenda since years and I don't
> > > > > > > > > > > think anyone is against it) it's more a code control/community question.
> > > > > > > > > > I rather disagree. Modularization of QEMU has seen few results
> > > > > > > > > > because it is generally a hard problem to solve when you have a
> > > > > > > > > > complex pre-existing codebase.  I don't think code control has
> > > > > > > > > > been a factor in this - as long as QEMU can clearly define its
> > > > > > > > > > ABI/API between core & the modular pieces, it doesn't matter
> > > > > > > > > > who owns the module. We've seen this with vhost-user which is
> > > > > > > > > > essentially outsourcing network device backend impls to a 3rd
> > > > > > > > > > party project.
> > > > > > > > > And it was done precisely for community reasons.  dpdk/VPP community is
> > > > > > > > > quite large and fell funded but they just can't all grok QEMU.  They
> > > > > > > > > work for hardware vendors and do baremetal things.  With the split we
> > > > > > > > > can focus on virtualization and they can focus on moving packets around.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > QEMU's defined the vhost-user ABI/API and delegated
> > > > > > > > > > impl to something else.
> > > > > > > > > The vhost ABI isn't easy to maintain at all though. So I would not
> > > > > > > > > commit to that lightly without a good reason.
> > > > > > > > > 
> > > > > > > > > It will be way more painful if the ABI is dictated by a 3rd party
> > > > > > > > > library.
> > > > > > > > Who should define it?
> > > > > > > > 
> > > > > > > No one. Put it in same source tree with QEMU and forget ABI stability
> > > > > > > issues.
> > > > > > 
> > > > > > You mean put the code implementing TPM 1.2 and/or TPM 2 into the QEMU tree?
> > > > > > These are multiple thousands of lines of code each and we'll break them
> > > > > > apart into logical chunks and review them?
> > > > > 
> > > > > No, lets not make that mistake again - we only just got rid of the
> > > > > libcacard smartcard library code from QEMU git. 
> > > > > 
> > > > > Regards,
> > > > > Daniel
> > > > 
> > > > I don't mean that as an external library. As an integral part of QEMU
> > > > adhering to our coding style etc - why not?
> > > > 
> > > > I don't know what are the other options.  How is depending on an ABI
> > > > with a utility with no other users and not packaged by most distros
> > > > good? You are calling out to a CUSE device but who's reviewing that
> > > > code?
> > > > 
> > > > vl.c weights in a 4500 lines of code. several thousand lines is
> > > > not small but not unmanageable.
> > > 
> > > 
> > > That's 4500 lines of fairly generic code; not like the TPM where the number
> > > of people who really understand the details of it is pretty slim.
> > > 
> > > It's better on most counts to have it as a separate process.
> > > 
> > > Dave
> > 
> > Separate process we start and stop automatically I don't mind. A
> > separate tree with a distinct coding style where no one will ever even
> > look at it? Not so much.
> 
> That code is used elsewhere anyway,

Who uses it? Who packages it? Fedora doesn't ...

> so asking them to change the coding style
> isn't very nice.
> Even if they change the coding style it doesn't mean you're suddenly going to
> understand how a TPM works in detail and be able to review it.

I did in the past but I didn't kept abreast of the recent developments.

> Anyway, having it in a separate process locked down by SELinux means that even
> if it does go horribly wrong it won't break qemu.
> 
> Dave

Since qemu does blocking ioctls on it and doesn't validate results
too much it sure can break QEMU - anything from DOS to random
code execution. That's why we want to keep it in tree and
start it ourselves - I don't want CVEs claiming not validating
some parameter we get from it is a remote code execution.
It should be just a library that yes, we can keep out of
process for extra security but no, we can't just out random
stuff in there and never care.


> > > > Anyway, it all boils down to lack of reviewers. I know I am not merging
> > > > the current implementation because I could not figure out what do qemu
> > > > bits do without looking at the implementation. I don't want to jump
> > > > between so many trees and coding styles. bios/qemu/linux/dpdk are
> > > > painful enough to manage. If some other maintainer volunteers, or if
> > > > Peter wants to merge it directly from Stefan, I won't object.
> > > > 
> > > > > -- 
> > > > > |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> > > > > |: http://libvirt.org              -o-             http://virt-manager.org :|
> > > > > |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
