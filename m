Received: from eggs.gnu.org ([2001:4830:134:3::10]:40190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOL8S-0001yn-Hr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOL8R-0004ek-BQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:48:48 -0400
Date: Thu, 31 May 2018 11:48:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180531104838.GC27838@stefanha-x1.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
	<d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
	<20180510082659.GC1296@stefanha-x1.localdomain>
	<20180511172531.GB5016@localhost.localdomain>
	<20180514134846.GD5182@stefanha-x1.localdomain>
	<20180530144450.GB5973@stefanha-x1.localdomain>
	<20180530160719.GD4311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <20180530160719.GD4311@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, He Junyan <junyan.he@intel.com>, Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org, qemu block <qemu-block@nongnu.org>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 06:07:19PM +0200, Kevin Wolf wrote:
> Am 30.05.2018 um 16:44 hat Stefan Hajnoczi geschrieben:
> > On Mon, May 14, 2018 at 02:48:47PM +0100, Stefan Hajnoczi wrote:
> > > On Fri, May 11, 2018 at 07:25:31PM +0200, Kevin Wolf wrote:
> > > > Am 10.05.2018 um 10:26 hat Stefan Hajnoczi geschrieben:
> > > > > On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> > > > > > On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> > > > > > > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> > > > > > >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> > > > > > >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> > > > > > >> I think it makes sense to invest some effort into such inter=
faces, but
> > > > > > >> be prepared for a long journey.
> > > > > > >=20
> > > > > > > I like the suggestion but it needs to be followed up with a c=
oncrete
> > > > > > > design that is feasible and fair for Junyan and others to imp=
lement.
> > > > > > > Otherwise the "long journey" is really just a way of rejectin=
g this
> > > > > > > feature.
> >=20
> > The discussion on NVDIMM via the block layer has runs its course.  It
> > would be a big project and I don't think it's fair to ask Junyan to
> > implement it.
> >=20
> > My understanding is this patch series doesn't modify the qcow2 on-disk
> > file format.  Rather, it just uses existing qcow2 mechanisms and extends
> > live migration to identify the NVDIMM state state region to share the
> > clusters.
> >=20
> > Since this feature does not involve qcow2 format changes and is just an
> > optimization (dirty blocks still need to be allocated), it can be
> > removed from QEMU in the future if a better alternative becomes
> > available.
> >=20
> > Junyan: Can you rebase the series and send a new revision?
> >=20
> > Kevin and Max: Does this sound alright?
>=20
> Do patches exist? I've never seen any, so I thought this was just the
> early design stage.

Sorry for the confusion, the earlier patch series was here:

  https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04530.html

> I suspect that while it wouldn't change the qcow2 on-disk format in a
> way that the qcow2 spec would have to be change, it does need to change
> the VMState format that is stored as a blob within the qcow2 file.
> At least, you need to store which other snapshot it is based upon so
> that you can actually resume a VM from the incremental state.
>=20
> Once you modify the VMState format/the migration stream, removing it
> from QEMU again later means that you can't load your old snapshots any
> more. Doing that, even with the two-release deprecation period, would be
> quite nasty.
>=20
> But you're right, depending on how the feature is implemented, it might
> not be a thing that affects qcow2 much, but one that the migration
> maintainers need to have a look at. I kind of suspect that it would
> actually touch both parts to a degree that it would need approval from
> both sides.

VMState wire format changes are minimal.  The only issue is that the
previous snapshot's nvdimm vmstate can start at an arbitrary offset in
the qcow2 cluster.  We can find a solution to the misalignment problem
(I think Junyan's patch series adds padding).

The approach references existing clusters in the previous snapshot's
vmstate area and only allocates new clusters for dirty NVDIMM regions.
In the non-qcow2 case we fall back to writing the entire NVDIMM
contents.

So instead of:

  write(qcow2_bs, all_vmstate_data); /* duplicates nvdimm contents :( */

do:

  write(bs, vmstate_data_upto_nvdimm);
  if (is_qcow2(bs)) {
      snapshot_clone_vmstate_range(bs, previous_snapshot,
                                   offset_to_nvdimm_vmstate);
      overwrite_nvdimm_dirty_blocks(bs, nvdimm);
  } else {
      write(bs, nvdimm_vmstate_data);
  }
  write(bs, vmstate_data_after_nvdimm);

Stefan

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD9MGAAoJEJykq7OBq3PI4J4IALTMv71zMrVFXmnv15BOOERz
Lnau2dSUYRf9pvG1gX1Qr4+i5MoXdunD1iPuVgl8zjegmd9xieuflpNgz+WD1t2Z
xVrBeHByhMDQg3kxI0S3mvZ20J1m6UqTckKIAvW/bIQsspxVO9JinkH5tb7GyWNk
8z5llMtpym2MC7UBNgFyHiX+sQfu8tF4IgzwjJqJxWd8H0ZWhpV3HwfkeuOO91FM
cy8DtpZDjRq9KigSSJb/mYYPN6Uua3EZYZBwC8v1GtiB9puiEXJxVaTw5PEn6Ma7
SCgsEAjsUIwLaSX9qOK7EvA4SxqU6d/IUPNstb6L3z3JwEmofmBKzPVNmLVvdAc=
=e/4G
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
