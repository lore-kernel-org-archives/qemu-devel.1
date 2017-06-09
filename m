Received: from eggs.gnu.org ([2001:4830:134:3::10]:54035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9nh-0000Pz-0a
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9nd-0001G5-S6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:37:25 -0400
Received: from ozlabs.org ([103.22.144.67]:42487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dJ9nd-0001FC-72
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:37:21 -0400
Date: Fri, 9 Jun 2017 12:37:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609023712.GH26521@umbus.fritz.box>
References: <1496404254-17429-3-git-send-email-peterx@redhat.com>
	<20170602194523-mutt-send-email-mst@kernel.org>
	<20170605030725.GF4056@pxdev.xzpeter.org>
	<f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
	<20170606234705.GG13397@umbus.fritz.box>
	<20170607034443.GA7983@pxdev.xzpeter.org>
	<20170607160445-mutt-send-email-mst@kernel.org>
	<20170608061150.GA3628@pxdev.xzpeter.org>
	<20170608215918-mutt-send-email-mst@kernel.org>
	<20170609015847.GG3628@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
In-Reply-To: <20170609015847.GG3628@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 09:58:47AM +0800, Peter Xu wrote:
> On Thu, Jun 08, 2017 at 09:59:50PM +0300, Michael S. Tsirkin wrote:
> > On Thu, Jun 08, 2017 at 02:11:50PM +0800, Peter Xu wrote:
> > > On Wed, Jun 07, 2017 at 04:07:20PM +0300, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 07, 2017 at 11:44:43AM +0800, Peter Xu wrote:
> > > > > On Wed, Jun 07, 2017 at 09:47:05AM +1000, David Gibson wrote:
> > > > > > On Tue, Jun 06, 2017 at 04:34:30PM +0200, Paolo Bonzini wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 05/06/2017 05:07, Peter Xu wrote:
> > > > > > > > I don't sure whether it'll be a good interface for IOTLB. A=
FAIU at
> > > > > > > > least for VT-d, the IOMMU translation is page aligned which=
 is defined
> > > > > > > > by spec, so it makes sense that (again at least for VT-d) h=
ere we'd
> > > > > > > > better just use page_mask/addr_mask.
> > > > > > > >=20
> > > > > > > > That's also how I know about IOMMU in general - I assume it=
 do the
> > > > > > > > translations always with page masks (never arbitary length)=
, though
> > > > > > > > page size can differ from platfrom to platform, that's why =
here the
> > > > > > > > IOTLB interface used addr_mask, then it works for all platf=
orms. I
> > > > > > > > don't know whether I'm 100% correct here though.
> > > > > > > >=20
> > > > > > > > Maybe David/Paolo/... would comment as well?
> > > > > > >=20
> > > > > > > I would ask David.  There are PowerPC MMUs that allow fast lo=
okup of
> > > > > > > arbitrarily-sized windows (not necessarily power of two),
> > > > > >=20
> > > > > > Uh.. I'm not sure what you mean here.  You might be thinking of=
 the
> > > > > > BATs which really old (32-bit) PowerPC MMUs had - those allow
> > > > > > arbitrary large block translations, but they do have to be a po=
wer of
> > > > > > two.
> > > > > >=20
> > > > > > > so maybe the
> > > > > > > IOMMUs can do the same.
> > > > > >=20
> > > > > > The only Power IOMMU I know about uses a fixed, power-of-two pa=
ge size
> > > > > > per DMA window.
> > > > >=20
> > > > > If so, I would still be inclined to keep using masks for QEMU IOT=
LB.
> > > > > Then, my first two patches should still stand.
> > > > >=20
> > > > > I am just afraid that not using masks will diverge the emulation =
=66rom
> > > > > real hardware and brings trouble one day.
> > > > >=20
> > > > > For vhost IOTLB interface, it does not need to be strictly aligne=
d to
> > > > > QEMU IOMMU IOTLB definition, and that's how it's working now (cur=
rent
> > > > > vhost iotlb allows arbitary length, and I think it's good). So im=
ho we
> > > > > don't really need to worry about the performance - after all, we =
can
> > > > > do everything customized for vhost, just like what patch 3 did (y=
eah,
> > > > > it can be better...).
> > > > >=20
> > > > > Thanks,
> > > >=20
> > > > Pre-faults is also something that does not happen on real hardware.
> > > > And it's about security so a bigger issue.
> > > >=20
> > > > If I had to choose between that and using non-power-of-2 in
> > > > the API, I'd go for non-power-of-2. Let backends that can only
> > > > support power of 2 split it up to multiple transactions.
> > >=20
> > > The problem is that when I was fixing the problem that vhost had with
> > > PT (a764040, "exec: abstract address_space_do_translate()"), I did
> > > broke the IOTLB translation a bit (it was using page masks). IMHO we
> > > need to fix it first for correctness (patch 1/2).
> > >=20
> > > For patch 3, if we can have Jason's patch to allow dynamic
> > > iommu_platform switching, that'll be the best, then I can rewrite
> > > patch 3 with the switching logic rather than caching anything. But
> > > IMHO that can be separated from patch 1/2 if you like.
> > >=20
> > > Or do you have better suggestion on how should we fix it?
> > >=20
> > > Thanks,
> >=20
> > Can we drop masks completely and replace with length? I think we
> > should do that instead of trying to fix masks.
>=20
> Do you mean to modify IOMMUTLBEntry.addr_mask into length?
>=20
> Again, I am not sure this is good... At least we need to get ack from
> David since spapr should be the initial user of it, and possibly also
> Alex since vfio should be assuming that (IIUC both in QEMU and kernel)
> addr_mask is page masks rather than arbirary length.

So, I don't see that using size instead of mask would be a particular
problem for spapr.  However, I also don't see any advantage to
switching.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOgnYAAoJEGw4ysog2bOSJXwQAJJstMQs3ECkzs/Ma+PHpS3M
bp9aOwwWfoFiMssIkCBDqAGIWEPd30POMxS5TkoGNNU1pf4VGr8q8XPvkTR6C/5J
68OweacWBYLdRMWjp3JhQgNxWxo7x3ojfVVGkHgrMALW+04klMMGazEBcks+vRor
wyk+VF6EjtEGHjc4PY1UZr8IDjhkcG9gWkI83YsBF7f3C3RSQvTjNPyVo17CNxhP
ZxKkXowx/DkqsKHYVg9m4sxEhvyJzE+g10ovx+rkbv8TwMBlI867dTbF3/JqRT8O
94Ftcz3sfeIj2QpGTm/XoaTLGf1vMQXk8JzdQ66Jz6N8BdQoWbGLkaIbjFCpqJpL
o3EEsQFDL6LAVpvIg8FMCKM9ddVsnm8TAgfgx+jr+/8fugdko0t9erTzXZJ5BQc3
pnJ4BooNsFOaCQqcJIyBWaEArk0RF5tFMCg3oloCQKpX7/8BSJKA2i7NGafZcgya
aoPVJwxuBdWIX1c7/hO1XU2ZDm3rMWcs0LZDI3wKEhNpOr0TnUw0zo9nUK22S6Zp
9BTIiCQhWXH4YlkeFQ5Y+fdNPLdQYUxEl2upU7EXbgpGtkxqWyxTpVWKK9j94zOu
6wTh8CnRhYj1mLoyz8IjPiG4UBK1CFSMCDVE9BLRvM7N1r33/s8QWRwKisJDG0Ko
V4QRIgERsBWEbs8f46/D
=TU22
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
