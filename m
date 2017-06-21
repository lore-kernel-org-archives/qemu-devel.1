Received: from eggs.gnu.org ([2001:4830:134:3::10]:46276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNc37-0005mc-1r
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNc33-0001ej-UP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:35:45 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 21 Jun 2017 09:35:38 +0000
Message-ID: <29402ff135ee4ce38e97d4f40a63f969@AMSPEX02CL03.citrite.net>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
	<20170620134756.9632-2-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1706201510490.12819@sstabellini-ThinkPad-X260>
	<20170621091743.qyhzt52t35y5oxek@dhcp-3-128.uk.xensource.com>
In-Reply-To: <20170621091743.qyhzt52t35y5oxek@dhcp-3-128.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/3] xen-disk: only advertize
 feature-persistent if grant copy is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roger Pau Monne <roger.pau@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin
	Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Roger Pau Monne
> Sent: 21 June 2017 10:18
> To: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.or=
g;
> qemu-devel@nongnu.org; qemu-block@nongnu.org; Anthony Perard
> <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>
> Subject: Re: [PATCH 1/3] xen-disk: only advertize feature-persistent if g=
rant
> copy is not available
>=20
> On Tue, Jun 20, 2017 at 03:19:33PM -0700, Stefano Stabellini wrote:
> > On Tue, 20 Jun 2017, Paul Durrant wrote:
> > > If grant copy is available then it will always be used in preference =
to
> > > persistent maps. In this case feature-persistent should not be advert=
ized
> > > to the frontend, otherwise it may needlessly copy data into persisten=
tly
> > > granted buffers.
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> >
> > CC'ing Roger.
> >
> > It is true that using feature-persistent together with grant copies is =
a
> > a very bad idea.
> >
> > But this change enstablishes an explicit preference of
> > feature_grant_copy over feature-persistent in the xen_disk backend. It
> > is not obvious to me that it should be the case.
> >
> > Why is feature_grant_copy (without feature-persistent) better than
> > feature-persistent (without feature_grant_copy)? Shouldn't we simply
> > avoid grant copies to copy data to persistent grants?
>=20
> When using persistent grants the frontend must always copy data from
> the buffer to the persistent grant, there's no way to avoid this.
>=20
> Using grant_copy we move the copy from the frontend to the backend,
> which means the CPU time of the copy is accounted to the backend. This
> is not ideal, but IMHO it's better than persistent grants because it
> avoids keeping a pool of mapped grants that consume memory and make
> the code more complex.
>=20
> Do you have some performance data showing the difference between
> persistent grants vs grant copy?
>=20

No, but I can get some :-)

For a little background... I've been trying to push throughput of fio runni=
ng in a debian stretch guest on my skull canyon NUC. When I started out, I =
was getting ~100MBbs. When I finished, with this patch, the IOThreads one, =
the multi-page ring one and a bit of hackery to turn off all the aio flushe=
s that seem to occur even if the image is opened with O_DIRECT, I was getti=
ng ~960Mbps... which is about line rate for the SSD in the in NUC.

So, I'll force use of persistent grants on and see what sort of throughput =
I get.

Cheers,

  Paul

> Roger.
