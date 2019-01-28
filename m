Received: from eggs.gnu.org ([209.51.188.92]:43614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9kZ-0001yD-Mb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9kX-0000nz-Jb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:07 -0500
Date: Mon, 28 Jan 2019 17:26:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128162652.GI5756@localhost.localdomain>
References: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
	<20190128153750.GE5756@localhost.localdomain>
	<20190128161257.GC3437@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190128161257.GC3437@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qmp: Deprecate query-nodes
 option of query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, nsoffer@redhat.com, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

Am 28.01.2019 um 17:12 hat Daniel P. Berrang=E9 geschrieben:
> On Mon, Jan 28, 2019 at 04:37:50PM +0100, Kevin Wolf wrote:
> > Am 28.01.2019 um 16:15 hat Anton Kuchin geschrieben:
> > > This option is broken since a6baa60807 in v2.9 and returns mostly
> > > zeroes instead of real stats because actual querring of BlockStats
> > > that resides in blk is missing.
> > >=20
> > > And it makes no sense because with this option BlockDriverState-s
> > > are iterated but BlockAcctStats belong to BlockBackend and not BDS
> > > since 7f0e9da6f13 in v2.5
> > >=20
> > > Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> >=20
> > Isn't query-nodes the only way to get wr_highest_offset for the proto=
col
> > layer? oVirt depends on this, as far as I know.
>=20
> Libvirt just invokes 'query-blockstats' with no arguments, so is not
> relying on 'query-nodes' working. Given that libvirt doesn't use it,
> it doesn't seem like this is relevant for oVirt unless they were
> using QMP passthrough from libvirt. That this has been broken
> since v2.9 though rather suggests oVirt doesn't use it.

It's not broken at all. The type of the return value is just a bit messy
because we mix statistics from the device with statistics from the
nodes. query-nodes=3Dtrue can't return device statistics, but the
respective fields aren't optional in the schema either, so it just puts
0 there. This is ugly, but if you know which information you can use, it
works fine, so cleaning it up was never considered to have a good
justification for breaking compatibility.

In any case, wr_highest_offset is part of the node statistics and it
contains the correct value for each node.

Kevin
