Received: from eggs.gnu.org ([2001:4830:134:3::10]:53196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=875e259b5=Paul.Durrant@citrix.com>)
	id 1gWO7D-0005FY-7R
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=875e259b5=Paul.Durrant@citrix.com>)
	id 1gWO7A-0005qm-3g
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:09:03 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 10 Dec 2018 16:07:04 +0000
Message-ID: <f6ab0bd96c9e41d493f683602ccc242f@AMSPEX02CL03.citrite.net>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-15-git-send-email-paul.durrant@citrix.com>
	<20181207182054.GM18875@perard.uk.xensource.com>
In-Reply-To: <20181207182054.GM18875@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 14/18] xen: add implementations of
 xen-block connect and disconnect functions...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 07 December 2018 18:21
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>;
> Kevin Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH v2 14/18] xen: add implementations of xen-block
> connect and disconnect functions...
>=20
> On Thu, Dec 06, 2018 at 03:08:40PM +0000, Paul Durrant wrote:
> > ...and wire in the dataplane.
> >
> > This patch adds the remaining code to make the xen-block XenDevice
> > functional. The parameters that a block frontend expects to find are
> > populated in the backend xenstore area, and the 'ring-ref' and
> > 'event-channel' values specified in the frontend xenstore area are
> > mapped/bound and used to set up the dataplane.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> With this patch, we should be able to have QEMU instantiate a new
> backend for a guest, right ? (via command line or QMP)
>=20
> I've tried, and that doesn't work, the xenstore path for the frontend is
> wrong. In the qemu trace, I have:
>     xs_node_create /local/domain/0/backend/xen-disk/23/268572709
> Which is probably fine, even if not described in xenstore-paths.markdown.
>     xs_node_create /local/domain/23/device/xen-disk/268572709
> Which is not, instead of "xen-disk", we should have "vbd".
>=20
> I know that this is fixed in "xen: automatically create
> XenBlockDevice-s", but at least the "vbd" type couldn't be added in this
> patch, or maybe a previous one.
>=20
>=20
> Another issue seems to be error handling. I've done a very simple test,
> I've added '-device xen-disk,vdev=3Dd536p37,id=3Dmydisk' to the command
> line (which is obvious wrong), and QEMU abort with:
>     qemu-system-i386: hw/block/xen-block.c:174: xen_block_realize:
> Assertion `conf->blk' failed.
> But I've pointed out the error in the code below.
>=20
>=20
> And just for fun, adding then removing a xen-disk via QMP. Adding works
> fine (once I've fixed the frontend name). I've run the following with
> ./scripts/qmp/qmp-shell:
> blockdev-add driver=3Dfile  filename=3D/root/vm/disk/testing-disk.qcow2 n=
ode-
> name=3Demptyfile
> blockdev-add driver=3Dqcow2 node-name=3Demptyqcow2 file=3Demptyfile
> device_add driver=3Dxen-disk vdev=3Dxvdn id=3Dfromqmp drive=3Demptyqcow2
>=20
> But, then, remove doesn't work, running "device_del id=3Dfromqmp" doesn't
> do anything. I guess we can try to fix that later if you don't find
> what's missing.

The missing piece is a hotplug controller 'unplug' or 'unplug_request' meth=
od implementation. I think the 'right' thing to do is implement 'unplug_req=
uest' and mimic the behaviour of libxl... i.e. set 'online' to 0 and 'state=
' to closing (i.e. 5) under transaction lock. This means that any connected=
 frontend should go through a clean disconnect and then the device will get=
 removed.
To that end I'm going to need to add transaction support to my helper funct=
ions (in patch #4) and then add in the unplug_request implementation in thi=
s patch.

  Paul
