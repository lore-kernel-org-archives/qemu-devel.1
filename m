Received: from eggs.gnu.org ([2001:4830:134:3::10]:54169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFyqS-0003NV-V2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFyqN-0006DE-WA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:23:40 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFyqN-0006Cx-NM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:23:35 -0400
Received: by mail-wr0-x242.google.com with SMTP id a12-v6so638491wrn.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 02:23:35 -0700 (PDT)
Date: Tue, 8 May 2018 10:23:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508092331.GA19710@stefanha-x1.localdomain>
References: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] RFC: Optimize nvdimm kind memory for
 snapshot.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@intel.com
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, rth@twiddle.net


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 04:33:43PM +0800, junyan.he@intel.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> The nvdimm size is huge, sometimes it is more than 256G or even more.
> This is a huge burden for snapshot saving. One snapshot point with
> nvdimm may occupy more than 50G disk space even with compression
> enabled.
> We need to introduce dependent snapshot manner to solve this problem.

What is the status of this patch series?

Kevin and Juan: Review is needed from the qcow2 and migration maintainers.

This patch series adds a function to clone qcow2 snapshots (sharing
clusters via the refcount) and then uses it to snapshot NVDIMM contents
incrementally during savevm.  This way only dirty NVDIMM clusters need
to be written into the qcow2 file, saving a lot of space and time.  The
drawback is that dirty memory logging needs to be enabled while the
guest is running.

The approach makes sense to me and could be used for other migration
state beyond NVDIMM in the future.  I think it's worth iterating this
patch series and merging it.

It was difficult for me to understand some of the English.  Do you have
a colleague who can review the English and suggest how to rephrase the
text?

I didn't found the "snapshot dependency" name unclear.  I suggest
calling the new API .bdrv_snapshot_clone().  This makes it clear that a
new snapshot is created based on an existing one.

New APIs are missing doc comments.  Please document the functions,
arguments, and the return values - especially for extern functions
(those declared in header files).

> The first snapshot point should always be saved completely, and enable
> dirty log trace after saving for nvdimm memory region. The later snapshot
> point should add the reference to previous snapshot's nvdimm data and
> just saving dirty pages. This can save a lot of disk and time if the
> snapshot operations are triggered frequently.
> We add save_snapshot_dependency functions to QCOW2 file system firstly, t=
he
> later snapshot will add reference to previous dependent snapshot's data
> cluster. There is an alignment problem here, the dependent data should
> always be cluster aligned. We need to add some padding data when saving
> the snapshot to make it always cluster aligned.
> The logic between nvdimm and ram for snapshot saving is a little confused
> now, we need to exclude nvdimm kind memory region from ram list and the
> dirty log tracing setting is also not very clear. Maybe we can separate t=
he
> snapshot saving from the migration logic later to make code clean.
> In theory, this kind of manner can apply to any kind of memory. But becau=
se
> it need to turn dirty log trace on, the performance may decline. So we ju=
st
> enable it for nvdimm kind memory firstly.
>=20
> Signed-off-by: Junyan He <junyan.he@intel.com>
> ---
> Makefile.target              |    1 +
> block/qcow2-snapshot.c       |  154 ++++++++++++++++++++++
> block/qcow2.c                |    2 +
> block/qcow2.h                |    7 +
> block/snapshot.c             |   45 +++++++
> exec.c                       |    7 +
> hw/ppc/spapr.c               |    2 +-
> hw/s390x/s390-stattrib.c     |    2 +-
> include/block/block_int.h    |    9 ++
> include/block/snapshot.h     |    7 +
> include/exec/memory.h        |    9 ++
> include/exec/ram_addr.h      |    2 +
> include/migration/misc.h     |    4 +
> include/migration/register.h |    2 +-
> include/migration/snapshot.h |    3 +
> memory.c                     |   18 ++-
> migration/block.c            |    2 +-
> migration/nvdimm.c           | 1033 +++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> migration/qemu-file.c        |   61 +++++++++
> migration/qemu-file.h        |   14 ++
> migration/ram.c              |   19 ++-
> migration/savevm.c           |   62 ++++++++-
> vl.c                         |    1 +
> 23 files changed, 1452 insertions(+), 14 deletions(-)
>=20

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8WyTAAoJEJykq7OBq3PIGgoH/3zzLWVnNcWmJo4QfAgCoq9R
fpERQ/2REIlfhgUdJAEKtKvesyyIF6UbsyewELNkDyzfulsBPGlbivUtJ9MwpwK1
+l1AwLPbcFv/KpKs8WDYggvszmdnHFCygIBV4bNtUIuzKGvKbIj0PqNB7qoKqMx/
QWDlIaQFXatO4JMDDg51cL4DCoytDEl/ZP8y8Hv6S3QCflesGDqwHj/R0sisvALC
MOVQJ3QqhnjnobAFRamDaXd5/1Re3YazQAlrZC08to3VEEVi6agQ2WhSUhGmCjqV
05LP1KslB69mrnsVgPGXn6tGhDIgunxtcya6BpbYV3ZJU+MIiygwNCGkWOqJaa0=
=Qn7h
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
