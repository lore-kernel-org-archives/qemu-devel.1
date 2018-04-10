Received: from eggs.gnu.org ([2001:4830:134:3::10]:45872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f5i0B-0002yb-P2
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f5i07-0005Fq-Oi
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:23:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1f5i07-0005F8-Hk
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 21:23:11 -0400
Date: Tue, 10 Apr 2018 11:22:55 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180410112255.7485f2a7@umbus.fritz.box>
In-Reply-To: <20180409185747.GL2449@work-vm>
References: <bb088a1ba2e344273db32402f7c9fae4@linux.vnet.ibm.com>
	<20180404080600.GA10540@xz-mi>
	<0a48a834f08d064eaa3eb4ef1b41235f@linux.vnet.ibm.com>
	<20180409185747.GL2449@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/_Llf4q674EbD=in10+rNMCp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com

--Sig_/_Llf4q674EbD=in10+rNMCp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Apr 2018 19:57:47 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > On 2018-04-04 13:36, Peter Xu wrote: =20
> > > On Wed, Apr 04, 2018 at 11:55:14AM +0530, Balamuruhan S wrote:
[snip]
> > > > > - postcopy: that'll let you start the destination VM even without
> > > > >   transferring all the RAMs before hand =20
> > > >=20
> > > > I am seeing issue in postcopy migration between POWER8(16M) ->
> > > > POWER9(1G)
> > > > where the hugepage size is different. I am trying to enable it but
> > > > host
> > > > start
> > > > address have to be aligned with 1G page size in
> > > > ram_block_discard_range(),
> > > > which I am debugging further to fix it. =20
> > >=20
> > > I thought the huge page size needs to be matched on both side
> > > currently for postcopy but I'm not sure. =20
> >=20
> > you are right! it should be matched, but we need to support
> > POWER8(16M) -> POWER9(1G)
> >  =20
> > > CC Dave (though I think Dave's still on PTO). =20
>=20
> There's two problems there:
>   a) Postcopy with really big huge pages is a problem, because it takes
>      a long time to send the whole 1G page over the network and the vCPU
>      is paused during that time;  for example on a 10Gbps link, it takes
>      about 1 second to send a 1G page, so that's a silly time to keep
>      the vCPU paused.
>=20
>   b) Mismatched pagesizes are a problem on postcopy; we require that the
>      whole of a hostpage is sent continuously, so that it can be
>      atomically placed in memory, the source knows to do this based on
>      the page sizes that it sees.  There are some other cases as well=20
>      (e.g. discards have to be page aligned.)

I'm not entirely clear on what mismatched means here.  Mismatched
between where and where?  I *think* the relevant thing is a mismatch
between host backing page size on source and destination, but I'm not
certain.

> Both of the problems are theoretically fixable; but neither case is
> easy.
> (b) could be fixed by sending the hugepage size back to the source,
> so that it knows to perform alignments on a larger boundary to it's
> own RAM blocks.

Sounds feasible, but like something that will take some thought and
time upstream.

> (a) is a much much harder problem; one *idea* would be a major
> reorganisation of the kernels hugepage + userfault code to somehow
> allow them to temporarily present as normal pages rather than a
> hugepage.

Yeah... for Power specifically, I think doing that would be really
hard, verging on impossible, because of the way the MMU is
virtualized.  Well.. it's probably not too bad for a native POWER9
guest (using the radix MMU), but the issue here is for POWER8 compat
guests which use the hash MMU.

> Does P9 really not have a hugepage that's smaller than 1G?

It does (2M), but we can't use it in this situation.  As hinted above,
POWER9 has two very different MMU modes, hash and radix.  In hash mode
(which is similar to POWER8 and earlier CPUs) the hugepage sizes are
16M and 16G, in radix mode (more like x86) they are 2M and 1G.

POWER9 hosts always run in radix mode.  Or at least, we only support
running them in radix mode.  We support both radix mode and hash mode
guests, the latter including all POWER8 compat mode guests.

The next complication is because the way the hash virtualization works,
any page used by the guest must be HPA-contiguous, not just
GPA-contiguous.  Which means that any pagesize used by the guest must
be smaller or equal than the host pagesizes used to back the guest.
We (sort of) cope with that by only advertising the 16M pagesize to the
guest if all guest RAM is backed by >=3D 16M pages.

But that advertisement only happens at guest boot.  So if we migrate a
guest from POWER8, backed by 16M pages to POWER9 backed by 2M pages,
the guest still thinks it can use 16M pages and jams up.  (I'm in the
middle of upstream work to make the failure mode less horrible).

So, the only way to run a POWER8 compat mode guest with access to 16M
pages on a POWER9 radix mode host is using 1G hugepages on the host
side.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/_Llf4q674EbD=in10+rNMCp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrMEe8ACgkQbDjKyiDZ
s5Kabg//U3P8hmU94XicuXPL16mxKnQYyVG4kDkbt2AQPXLwWVLw4GJOPgL5uTAR
LCw/pLODKxKMXeN587fIk3CUYlplcumY/lZel4YxFcUZMGE836jkes8EtCWGdh1K
aoPfAVUiP4W9qJjl6pAzKS2jB2bsReSm/o5Czg7TEJo/BMDGCDdGAbfa1JPbvqkD
PfRBrLAcs5zbfB4l59wN7ud/OAo3YEwKSrqLa4gDKUDXfMEPWfBTTXgCFCQNhBj9
BE3Wz4cthRukoUjKhvw6Tzr89VSY9reFizFqK+s6IQw+RTNnaLqoiQRAIpgOyGkY
wGB0wWz2nAs8AU1Wzy3h0DADwhtD8wokRu4/uBAKSKjPc08jId3j6/bCMGFBzQc/
uGEfZ9ffdLlyf6aGWnxnfhaps3ldLZfxVXNThVGq4QaLFMPdOC4jmuLs6jCoiORS
p+FnDD4YnEqZgEGylnYaBMr2WKVtc7uwv+pzkkBTftccq+5C0ujXJYy1+2/RJ/a+
xezBQzYpLqnjBagldEzAXFGMISmdfpbhqgQ3DxtN5D+R0yELv8VIy53hhD6qUqXu
sbAaqa6wxw+g1RnCcXH3sKsmprLXtEvy8ksJWJL/zuBN+JYhZh1HXJd05sKtpNOv
noT/xFoYSMuhToAsRPxi6EcnPNO31DEQzp9/ouDme8HBRjkpdx8=
=opZU
-----END PGP SIGNATURE-----

--Sig_/_Llf4q674EbD=in10+rNMCp--
