Received: from eggs.gnu.org ([2001:4830:134:3::10]:59031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edbBb-0004RI-FS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edbBa-0003QQ-FT
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:26:51 -0500
Date: Mon, 22 Jan 2018 12:26:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180122122637.GE31621@stefanha-x1.localdomain>
References: <20180116060901.17413-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <20180116060901.17413-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/9] block: Add VFIO based driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 02:08:52PM +0800, Fam Zheng wrote:
> v6: Fix the cleaning up around nvme_init() and write cache setup in
>     nvme_file_open(). [Stefan]
>     Add Stefan's rev-by to the doc patch.
>     Rebase on to Paolo's coroutine series for q->free_req_queue:
>=20
> Based-on: 20180115220822.10156-1-pbonzini@redhat.com
> ([PATCH 0/4] coroutine-lock: polymorphic CoQueue)
>=20
> v5: Add Stefan's rev-bys.
>     Add Paolo's sob line.
>     Address Stefan's, Alex's and Eric's comments, including:
>     - Add PCI Bar MMIO offset/size parameter to VFIO utility API. [Alex]
>     - Fix various lock and memory leakings. [Stefan]
>     - Improve documentation. [Stefan]
>     - Add one missing "Since 2.12" in QAPI schema. [Eric]
>     - Fix locking of BDRVNVMeState->inflight. [Stefan]
>     - Add one missing endianness conversion for cmd.nsid. [Stefan]
>     - Use bdrv_get_aio_context() instead of qemu_get_current_aio_context(=
).
>     - When init, issue "Set Features" command to enable/disable volatile =
write
>       cache according to "flags & BDRV_O_NOCACHE".
>=20
> v4: - Rebase, address Stefan's comments.
>     - Add QAPI and doc patches.
>=20
> v3: Rebase, small tweaks/fixes and add locks to provide basic thread safe=
ty
>     (basic because it is not really tested).
>=20
> v2:
>     - Implement "split vfio addr space" appraoch. [Paolo]
>     - Add back 'device reset' in nvme_close(). [Paolo]
>     - Better variable namings. [Stefan]
>     - "Reuse" macro definitions from NVMe emulation code.
>     - Rebase onto current master which has polling by default and update
>       performance results accordingly.
>     - Update MAINTAINERS.
>     - Specify namespace in URI.
>     - The sporadical I/O error from v1 "disappeared" in this version.
>     - Tests one: qemu-img bench, fio, bonnie++ and installation of
>       ubuntu/fedora/rhel on QEMU emulated nvme and a Intel P3700 card.
>=20
> Fam Zheng (9):
>   stubs: Add stubs for ram block API
>   util: Introduce vfio helpers
>   block: Add VFIO based NVMe driver
>   block: Introduce buf register API
>   block/nvme: Implement .bdrv_(un)register_buf
>   qemu-img: Map bench buffer
>   block: Move NVMe constants to a separate header
>   docs: Add section for NVMe VFIO driver
>   qapi: Add NVMe driver options to the schema
>=20
>  MAINTAINERS                    |    6 +
>  block/Makefile.objs            |    1 +
>  block/block-backend.c          |   10 +
>  block/io.c                     |   24 +
>  block/nvme.c                   | 1199 ++++++++++++++++++++++++++++++++++=
++++++
>  block/trace-events             |   21 +
>  docs/qemu-block-drivers.texi   |   37 ++
>  hw/block/nvme.h                |  698 +----------------------
>  include/block/block.h          |   11 +-
>  include/block/block_int.h      |    9 +
>  include/block/nvme.h           |  700 +++++++++++++++++++++++
>  include/qemu/vfio-helpers.h    |   33 ++
>  include/sysemu/block-backend.h |    3 +
>  qapi/block-core.json           |   17 +-
>  qemu-img.c                     |    9 +-
>  stubs/Makefile.objs            |    1 +
>  stubs/ram-block.c              |   16 +
>  util/Makefile.objs             |    1 +
>  util/trace-events              |   11 +
>  util/vfio-helpers.c            |  726 ++++++++++++++++++++++++
>  20 files changed, 2833 insertions(+), 700 deletions(-)
>  create mode 100644 block/nvme.c
>  create mode 100644 include/block/nvme.h
>  create mode 100644 include/qemu/vfio-helpers.h
>  create mode 100644 stubs/ram-block.c
>  create mode 100644 util/vfio-helpers.c
>=20
> --=20
> 2.14.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaZdh9AAoJEJykq7OBq3PIqvEH/iG5ukLmU9CjMKVmvaeRH4Sf
NxnK4Kr15q6J+RtBdAkjqleN4EF1StPMug4Nb1MiSIbpgD0aiZPTfNrCi+oBHFb7
cppBLf7BACbYhxAfJMCOOBqh2QC7+85cTPJOgI4yBK3hJVkTX1sePpjj8h8xPrMl
c7Wb/7Oh4bppWU7LVRm7FVyB7epUCjPwxS9wNm/gSZmr5FUY+8j2N1N5yqEoi377
zSwAoLTtJbXNu0gPo6sYt/Az5qf9VMZruNGnurnOJihbZ5+POrp3lszkW/JRtT4C
W5yIcgswrYNSQSj6przoWqvei3k+TVW7sMvWvdPCe/WPCe6pyImpFVjzDOA0oDU=
=WUTJ
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
