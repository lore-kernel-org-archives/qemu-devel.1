Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUwcJ-0002sk-50
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUwcF-0006t3-Qx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUwcF-0006su-HQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C96980481
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:58:18 +0000 (UTC)
Date: Tue, 11 Jul 2017 15:58:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170711145813.GX17792@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yuPXOSZRpyw7iEV"
Content-Disposition: inline
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] Introduce "-object iothread-group"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--6yuPXOSZRpyw7iEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 03:20:22PM +0800, Fam Zheng wrote:
> Last time we've looked at "-object iothread,spawns=3DN" but it was a bit =
abusive.
> A dedicated "iothread-group" class is cleaner from the interface point of=
 view.
> This series does that.
>=20
> It has the same set of poll parameters as the existing "iothread" object,=
 plus
> a "size" option to specify how many threads to start. Using iothread-group
> doesn't require the user to explicitly create the contained IOThreads. The
> IOThreads are created by the group object.
>=20
> Internally, IOThreads share one AioContext.  This is to make it easier to=
 adapt
> this to the current data plane code (see the last patch). But it is an
> implementation detail, and will change depending on the block layer multi=
queue
> needs.
>=20
> TODO:
>=20
> - qmp_query_iothread_groups, in addition to proper QOM @child property fr=
om
>   IOThreadGroup to its IOThread instances.
> - Add virtio-scsi.
> - Variant of iothread_stop_all().
>=20
> Fam Zheng (5):
>   aio: Wrap poll parameters into AioContextPollParams
>   iothread: Don't error on windows
>   iothread: Extract iothread_start
>   Introduce iothread-group
>   virtio-blk: Add iothread-group property
>=20
>  Makefile.objs                   |   2 +-
>  hw/block/dataplane/virtio-blk.c |  18 ++--
>  hw/block/virtio-blk.c           |   6 ++
>  include/block/aio.h             |  18 ++--
>  include/hw/virtio/virtio-blk.h  |   2 +
>  include/sysemu/iothread.h       |  35 ++++++-
>  iothread-group.c                | 210 ++++++++++++++++++++++++++++++++++=
++++++
>  iothread.c                      |  97 +++++++++----------
>  util/aio-posix.c                |  10 +-
>  util/aio-win32.c                |   8 +-
>  10 files changed, 328 insertions(+), 78 deletions(-)
>  create mode 100644 iothread-group.c

I reviewed QOM "foo[*]" array syntax but it's very limited.  Basically
all it does it append the new property to foo[0], foo[1], ... (i.e. it
allocates an index).  AFAICT there is no way to specify an array
property and really arrays are just individual properties.

Daniel Berrange has a patch for non-scalar properties:
"[PATCH v14 15/21] qom: support non-scalar properties with -object"
https://patchwork.kernel.org/patch/9358503/

I think the challenge with existing "[*]" or pre-allocated "foo[0]",
"foo[1]", ... is that they don't support variable-sized arrays via QAPI.
With that missing piece solved it would be possible to say:

  -device virtio-blk-pci,iothread.0=3Diothread0,iothread.1=3Diothread1

Or maybe:

  -device virtio-blk-pci,iothread[0]=3Diothread0,iothread[1]=3Diothread1

When the virtio-blk-pci object is realized it can loop over iothread[*]
properties to set them up (if necessary).

Your current RFC series uses a single AioContext in IOThreadGroup.  I
think something similar can be achieved with an iothread property:

  -object iothread,id=3Diothread1,share-event-loop-with=3Diothread0

The reason I am suggesting this approach is to keep IOThread as the
first-class object.  Existing QMP APIs continue to apply to all objects.
We avoid introducing an ad-hoc group object just for IOThread.

Stefan

--6yuPXOSZRpyw7iEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZOeFAAoJEJykq7OBq3PIyhAH/AkaELgR/LAV1R2r0bWUpxDZ
TSTZPheU8/GE5s8AYm/GR6vetqQHb8TeiP5yG/jo+JD4LDLRh1PQxzKa5yCRrboK
jOswgmjtQ+FRfkrrUXSPUvCapRwOiOXR/xBsc00LASvbQTPReNIr/PX3lVM4aCWw
ANTxf1CDoGU4jG7PYhgQfgYaldc0exHteBqbJMCUy0/exn9gGVrnRpXOn5zyh8R9
x9AfRkrGHSlGH6DuOzkoY6yDJqpLN03n8SFw6jWoP32s47aCEt/KLz2I562Y+MAt
Hd99uwy+a1juBMYmKuR/xm3lvyaCuiQc6F6/oo8pXUPB5C2vP/4aqTPfMFzTslo=
=cFG+
-----END PGP SIGNATURE-----

--6yuPXOSZRpyw7iEV--
