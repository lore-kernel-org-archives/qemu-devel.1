Received: from eggs.gnu.org ([2001:4830:134:3::10]:43168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdJYM-0008GG-Pd
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdJYI-0007IJ-Q0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:32:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cdJYI-0007Hg-IW
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:32:34 -0500
Date: Mon, 13 Feb 2017 11:32:32 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170213163232.GN27752@localhost.localdomain>
References: <1478566785-4002-1-git-send-email-ashish.mittal@veritas.com>
	<1478566785-4002-3-git-send-email-ashish.mittal@veritas.com>
	<20161108204413.GA6353@localhost.localdomain>
	<CAAo6VWMyTjV1Fn8-BSex7Fx8OcEcuEyK2rQJ6L=wZZXDiB5A4w@mail.gmail.com>
	<20170213133725.GA10361@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213133725.GA10361@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: ashish mittal <ashmit602@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>

On Mon, Feb 13, 2017 at 01:37:25PM +0000, Stefan Hajnoczi wrote:
> On Tue, Feb 07, 2017 at 03:12:36PM -0800, ashish mittal wrote:
> > On Tue, Nov 8, 2016 at 12:44 PM, Jeff Cody <jcody@redhat.com> wrote:
> > > On Mon, Nov 07, 2016 at 04:59:45PM -0800, Ashish Mittal wrote:
> > >> These changes use a vxhs test server that is a part of the following
> > >> repository:
> > >> https://github.com/MittalAshish/libqnio.git
> > >>
> > >> Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
> > >> ---
> > >> v6 changelog:
> > >> (1) Added iotests for VxHS block device.
> > >>
> > >>  tests/qemu-iotests/common        |  6 ++++++
> > >>  tests/qemu-iotests/common.config | 13 +++++++++++++
> > >>  tests/qemu-iotests/common.filter |  1 +
> > >>  tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
> > >>  4 files changed, 39 insertions(+)
> > >>
> > >> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> > >> index d60ea2c..41430d8 100644
> > >> --- a/tests/qemu-iotests/common
> > >> +++ b/tests/qemu-iotests/common
> > >
> > > When using raw format, I was able to run the test successfully for all
> > > supported test cases (26 of them).
> > >
> > > With qcow2, they fail - but not the fault of this patch, I think; but
> > > rather, the fault of the test server.  Can qnio_server be modified so that
> > > it does not work on just raw files?
> > >
> > >
> > 
> > VxHS supports and uses only the raw format.
> 
> That's like saying only ext4 guest file systems are supported on VxHS
> and not ZFS.  The VxHS driver should not care what file system is used,
> it just does block I/O without interpreting the data.
> 
> It must be possible to use any format on top of the VxHS protocol.
> After all, the image format drivers just do block I/O.  If there is a
> case where qcow2 on VxHS fails then it needs to be investigated.
> 
> The VxHS driver can't be merged until we at least understand the cause
> of the qcow2 test failures.
>

A quick run with the test server and a QEMU process showed an abort() in the
test server, so I just sent a pull req to libqnio to fix that.  

But playing with it in gdb right now with a test qcow2 file, I see that we
are waiting in aio_poll() forever for the test server to respond to a read
request, when using qcow2 format.  

As Stefan said, this doesn't really make any sense - why would VXHS behave
differently based on the file contents?

Jeff
