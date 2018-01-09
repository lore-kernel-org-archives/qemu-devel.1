Received: from eggs.gnu.org ([2001:4830:134:3::10]:49950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYzzd-0003EZ-Q9
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYzza-0008LF-GO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:55:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eYzza-0008Ko-8B
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:55:26 -0500
Date: Tue, 9 Jan 2018 19:55:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180109195517.GD2708@work-vm>
References: <EC8A4E314CF1574AB62C80421BD9833933FEE069@SHSMSX104.ccr.corp.intel.com>
	<20180109153538.GC1197@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180109153538.GC1197@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Some question about savem/qcow2 incremental
 snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "He, Junyan" <junyan.he@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Mon, Dec 25, 2017 at 07:54:00AM +0000, He, Junyan wrote:
> > I am now focusing on snapshot optimization for Intel NVDimm kind memo=
ry. Different from the normal memory, the NVDimm may be 128G, 256G or eve=
n more for just one guest, and its speed is slower than the normal memory=
. So sometimes it may take several minutes to complete just one snapshot =
saving. Even with compression enabled, the=A0snapshot point may consume m=
ore than 30G disk space. We decide to add incremental kind snapshot savin=
g to resolve this. Just store difference between snapshot points to save =
time and disk space.
> > But the current snapshot/save_vm framework seems not to support this.
> > We need to add snapshot dependency and extra operations when we LOAD =
and DELETE the snapshot point.
> > Is that possible to modify the savevm framework and add some incremen=
tal snapshot support to QCOW2 format?
>=20
> It sounds like you'd like to save incremental guest RAM snapshots based
> on the contents of earlier snapshots.  QEMU has no way of doing this at
> the moment.
>=20
> In order to do this QEMU needs to keep dirty memory logging enabled at
> all times so it knows which pages have been written since the last
> snapshot.  This will affect guest performance.

Keeping the dirty logging going is something that COLO does, to send
incremental snapshots to the secondary.   As you say, it does slow
things down and you have to be able to keep the state between the
migration runs.

> Certain guest operations like rebooting or zeroing memory will defeat
> the incremental guest RAM snapshot feature.  It's worth thinking about
> these cases to make sure this feature would be worth it in real use
> cases.

But those probably wouldn't upset an NVDimm?

> What you're proposing isn't specific to NVDIMM.  Regular RAM use cases
> also benefit from incremental snapshots because less disk space is
> required for the savevm data.
>=20
> Some questions about your use case:
>=20
> 1. Does the guest have -device nvdimm?
>=20
> 2. Is the qcow2 file on NVDIMM?
>=20
> Stefan

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
