Received: from eggs.gnu.org ([2001:4830:134:3::10]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7dy-0007Ke-Bf
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7dv-0002gq-8O
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj7dv-0002gG-09
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:02:23 -0500
Date: Wed, 1 Mar 2017 19:02:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301185414-mutt-send-email-mst@kernel.org>
References: <5761C092.5070702@linux.vnet.ibm.com>
	<20160616080520.GA2249@work-vm> <20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
	<CAJ+F1C+h7iyCSxE6p91NtEoTZSLtLBuF53=6yuWH+n-tBdV5=A@mail.gmail.com>
	<05b271a3-4bf9-729b-d662-c9886951f26d@linux.vnet.ibm.com>
	<20170301181146-mutt-send-email-mst@kernel.org>
	<20170301163104.GJ10160@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301163104.GJ10160@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 04:31:04PM +0000, Daniel P. Berrange wrote:
> On Wed, Mar 01, 2017 at 06:22:45PM +0200, Michael S. Tsirkin wrote:
> > On Wed, Mar 01, 2017 at 09:50:38AM -0500, Stefan Berger wrote:
> > > I had already proposed a linked-in version before I went to the out-of-process
> > > design. Anthony's concerns back then were related to the code not being trusted
> > > and a segfault in the code could bring down all of QEMU. That we have test
> > > suites running over it didn't work as an argument. Some of the test suite are
> > > private, though.
> > 
> > Given how bad the alternative is maybe we should go back to that one.
> > Same argument can be made for any device and we aren't making
> > them out of process right now.
> > 
> > IIMO it's less the in-process question (modularization
> > of QEMU has been on the agenda since years and I don't
> > think anyone is against it) it's more a code control/community question.
> 
> I rather disagree. Modularization of QEMU has seen few results
> because it is generally a hard problem to solve when you have a
> complex pre-existing codebase.  I don't think code control has
> been a factor in this - as long as QEMU can clearly define its
> ABI/API between core & the modular pieces, it doesn't matter
> who owns the module. We've seen this with vhost-user which is
> essentially outsourcing network device backend impls to a 3rd
> party project.

And it was done precisely for community reasons.  dpdk/VPP community is
quite large and fell funded but they just can't all grok QEMU.  They
work for hardware vendors and do baremetal things.  With the split we
can focus on virtualization and they can focus on moving packets around.


> QEMU's defined the vhost-user ABI/API and delegated
> impl to something else.

The vhost ABI isn't easy to maintain at all though. So I would not
commit to that lightly without a good reason.

It will be way more painful if the ABI is dictated by a 3rd party
library.

> With the vTPM stuff here, we've not got a pre-existing feature
> we need to deal with, so the biggest blocker wrt modularization does
> not exist. Given that I think having the vTPM impl modularized is
> highly desirable, as long as we can define a sane ABI/API between
> QEMU and the external piece.  So I think anthony's point about not
> putting a vTPM impl in-process is still valid, and since Stefan's
> already done much of the work to achieve a modular design we should
> not go back to an in-process design now.

Fine by me. But with the given project I'm inclined to say
- let's keep it in tree so we don't get to maintain an ABI
- CUSE seems like a wrong interface - not portable, too
  hard to setup ...

> > It doesn't look like userspace swtpm bits have a large community of
> > developers around it, and the only user appears to be QEMU, so depending
> > on that externally does not make sense, we should just have them
> > in-tree. This way we don't need to worry about versioning etc.
> 
> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
