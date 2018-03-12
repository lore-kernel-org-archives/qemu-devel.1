Received: from eggs.gnu.org ([2001:4830:134:3::10]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evPYg-0008Ah-4F
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evPYM-0000UX-KK
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:40:18 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:39589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1evPYM-0000T3-5b
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:39:58 -0400
Received: by mail-wm0-x236.google.com with SMTP id i3so16972446wmi.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 08:39:58 -0700 (PDT)
Date: Mon, 12 Mar 2018 15:39:54 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180312153954.GA24440@stefanha-x1.localdomain>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20180228072558.7434-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 03:25:50PM +0800, Haozhong Zhang wrote:
> QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
> live migration. If the backend is on the persistent memory, QEMU needs
> to take proper operations to ensure its writes persistent on the
> persistent memory. Otherwise, a host power failure may result in the
> loss the guest data on the persistent memory.
>=20
> This v3 patch series is based on Marcel's patch "mem: add share
> parameter to memory-backend-ram" [1] because of the changes in patch 1.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html
>=20
> Previous versions can be found at
> v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html
>=20
> Changes in v4:
>  * (Patch 2) Fix compilation errors found by patchew.
>=20
> Changes in v3:
>  * (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
>    PMEM writes in it, so we don't need the _common function.
>  * (Patch 6) Expose qemu_get_buffer_common so we can remove the
>    unnecessary qemu_get_buffer_to_pmem wrapper.
>  * (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
>    PMEM writes in it, so we can remove the unnecessary
>    xbzrle_decode_buffer_{common, to_pmem}.
>  * Move libpmem stubs to stubs/pmem.c and fix the compilation failures
>    of test-{xbzrle,vmstate}.c.
>=20
> Changes in v2:
>  * (Patch 1) Use a flags parameter in file ram allocation functions.
>  * (Patch 2) Add a new option 'pmem' to hostmem-file.
>  * (Patch 3) Use libpmem to operate on the persistent memory, rather
>    than re-implementing those operations in QEMU.
>  * (Patch 5-8) Consider the write persistence in the migration path.
>=20
> Haozhong Zhang (8):
>   [1/8] memory, exec: switch file ram allocation functions to 'flags' par=
ameters
>   [2/8] hostmem-file: add the 'pmem' option
>   [3/8] configure: add libpmem support
>   [4/8] mem/nvdimm: ensure write persistence to PMEM in label emulation
>   [5/8] migration/ram: ensure write persistence on loading zero pages to =
PMEM
>   [6/8] migration/ram: ensure write persistence on loading normal pages t=
o PMEM
>   [7/8] migration/ram: ensure write persistence on loading compressed pag=
es to PMEM
>   [8/8] migration/ram: ensure write persistence on loading xbzrle pages t=
o PMEM
>=20
>  backends/hostmem-file.c             | 27 +++++++++++++++++++-
>  configure                           | 35 ++++++++++++++++++++++++++
>  docs/nvdimm.txt                     | 14 +++++++++++
>  exec.c                              | 20 ++++++++++++---
>  hw/mem/nvdimm.c                     |  9 ++++++-
>  include/exec/memory.h               | 12 +++++++--
>  include/exec/ram_addr.h             | 28 +++++++++++++++++++--
>  include/migration/qemu-file-types.h |  2 ++
>  include/qemu/pmem.h                 | 27 ++++++++++++++++++++
>  memory.c                            |  8 +++---
>  migration/qemu-file.c               | 29 ++++++++++++++--------
>  migration/ram.c                     | 49 +++++++++++++++++++++++++++----=
------
>  migration/ram.h                     |  2 +-
>  migration/rdma.c                    |  2 +-
>  migration/xbzrle.c                  |  8 ++++--
>  migration/xbzrle.h                  |  3 ++-
>  numa.c                              |  2 +-
>  qemu-options.hx                     |  9 ++++++-
>  stubs/Makefile.objs                 |  1 +
>  stubs/pmem.c                        | 37 ++++++++++++++++++++++++++++
>  tests/Makefile.include              |  4 +--
>  tests/test-xbzrle.c                 |  4 +--
>  22 files changed, 285 insertions(+), 47 deletions(-)
>  create mode 100644 include/qemu/pmem.h
>  create mode 100644 stubs/pmem.c

A few thoughts:

1. Can you use pmem_is_pmem() to auto-detect the pmem=3Don|off value?

2. The migration/ram code is invasive.  Is it really necessary to
   persist data each time pages are loaded from a migration stream?  It
   seems simpler to migrate as normal and call pmem_persist() just once
   after RAM has been migrated but before the migration completes.

3. This is independent of this patch series and can be done later.
   NVDIMM seems incompatible with post-copy live migration.  It would be
   good to have a postcopy_add_blocker() API so that a nice error
   message is printed if post-copy live migration is attempted.

The code itself seems fine though:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJapp9KAAoJEJykq7OBq3PI+HAH+NKkEoy6jBSHrIs0vPXH/T2d
PgbhUod2F88ByXkiULHIcjMpZEnmoeimrX3TQcjzORAZVGXzaNkySFqsEjJZUeMR
658/z1JQXtaMM1eBfmQGItxDWT6KBxzpA2jOn/Ad+By4a5ELJQrmk9CRLGfe//eB
SxrB8TucLMhJpkVrlURFUxWQgMgXrk9V6wyNDHeDrP2Kdhq3VruuChq6oX4d4X+a
enAhzCBz5YO+UgIavFkTdihLXk0bH4wnAyHYzv67YbW+vuMfxI9ZqeG2DBz+Z1ZK
mYvWz1BY9oFnLplMrpp09Fx+IMP2XXFtreZVNO4OYMB9Cx8RGWSiM7lrC4qV3w==
=9Dtw
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
