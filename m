Received: from eggs.gnu.org ([2001:4830:134:3::10]:54098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gRGUG-0003tb-ET
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gRGUF-0004jg-DF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:59:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gRGUF-0004j0-51
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:59:39 -0500
Date: Mon, 26 Nov 2018 12:59:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181126125931.GH15869@stefanha-x1.localdomain>
References: <20181106143213.536d3311@w520.home>
	<0857657C-BEFF-4B65-A8A0-004CCE361FDB@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <0857657C-BEFF-4B65-A8A0-004CCE361FDB@nutanix.com>
Subject: Re: [Qemu-devel] KVM Forum VFIO BoF summary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, Changpeng Liu <changpeng.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "Xue, Ken" <Ken.Xue@amd.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, James R Harris <james.r.harris@intel.com>, "benjamin.walker@intel.com" <benjamin.walker@intel.com>, Alexander Graf <agraf@suse.de>


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:09:53PM +0000, Felipe Franciosi wrote:
> Hi Alex,
>=20
> I'm also terribly sorry for the delay in responding to this. I'm only now=
 having the time resources to come back to this topic and figure out a way =
forward with my proposal. Please see my notes below (quoting only the relev=
ant sections).
>=20
> > On Nov 6, 2018, at 9:32 PM, Alex Williamson <alex.williamson@redhat.com=
> wrote:
> >=20
> > There were mostly two main threads of discussion, the first was Filipe's
> > discussion of a socket interface making use of the VFIO ABI to
> > implement a userspace device model.  For a VM use case, QEMU would be
> > modified to use a socket for the VFIO ABI, including shared memory for
> > DMA.  Ideally this would be transparent for much of the QEMU vfio code
> > outside of setup.  Effectively this becomes a userspace implementation
> > of mdev as this could already be done using mdev, but it requires a
> > vendor driver to expose the userspace interface and likely a longer
> > round trip through the kernel and back to userspace. Either path
> > allows device models in userspace that can be open or proprietary, but
> > this new proposal eliminates the vendor kernel driver component.  Of
> > course non-upstream kernel mdev vendor drivers do taint the host
> > kernel, so they at least leave a breadcrumb.
>=20
> Spot on. This can be done today via mdev, but it would unnecessarily invo=
lve the kernel in the setup of devices. Also, since vfio is the only existi=
ng bus driver for mdev, it would make little sense to implement an mdev "ph=
ysical" driver (which wouldn't have a physical backing device) just to talk=
 a vfio-like abi back to userspace.
>=20
> This "vfio-user" proposal is a perfect fit for Qemu. I think the correct =
design is to slightly rearchitect the vfio implementation in Qemu to allow =
for userspace backends through unix sockets, very much like vhost-user does=
 it for virtio devices today.
>=20
> As a matter of fact, with something like this in place, I think the Qemu =
code could potentially be simplified by moving some of the existing vhost-u=
ser offloading code underneath it.
>=20
> > I believe Filipe
> > mentioned a conversation after the BoF with Alex Graf who had a related
> > concern about using the socket approach to use this as a non-GPL
> > backdoor for device models in QEMU and a suggested approach was a GPL
> > handshake via the socket interface.
>=20
> Not exactly. The GPL-violating concerns came from Paolo and Stefan (cc'd)=
=2E Alex Graf (cc'd) came up with a solution for the concern which involves=
 adding a copyrighted "poem" to the protocol handshake. Qemu would then gra=
nt the copyright for GPL applications, hence limiting who can use the proto=
col.
>=20
> Vendors can obviously bypass this by using a GPL proxy application that t=
alks to Qemu, but then uses a separate mechanism (possibly another unix soc=
ket) to talk to other non-GPL applications. Vendors which distribute Qemu c=
an possibly also bypass this by modifying the protocol not to include the c=
opyrighted messages. Using either legal loophole approach, however, can lea=
d to a lot of public point and shame.
>=20
> The point I would like to discuss more widely (before going forwards with=
 code) is whether vendors can actually make use of a GPL-only protocol. I u=
nderstand the community desire of gathering efforts into GPL software, Qemu=
 code and Virtio. A non-GPL implementation means that maybe some vendors ca=
nnot use this.
>=20
> I envision this protocol being used by userspace applications which _need=
_ to emulate a device outside Qemu for performance reasons, not license rea=
sons (eg. a separate process can efficiently poll VQs from multiple VMs fro=
m a single core). Applications that already do that today, albeit open-sour=
ce, are not GPL (eg. OVS, DPDK, SPDK).
>=20
> This is why I'd like to hear more from Paolo and Stefan on why making thi=
s non-GPL is so bad. It is already possible today (via mdev), and similar a=
pproaches already exist for a large number of device implementations via vh=
ost-user. Additionally, I would also like to hear from willing vendors that=
 feel they could _only_ benefit from this if it does not enforce GPL.
>=20
> Finally, I want to clarify I am not opposing making this GPL-only. I just=
 want to make sure the effort is justifiable (ie. there is reason for this =
to enforce GPL peer applications given the existing vhost-user and mdev alt=
ernatives) and not in vain (ie. there are GPL use cases for this out there).

Device emulation is the core of what GPL QEMU does.  Mechanisms for
out-of-tree device emulation get rejected because they are likely to be
misused by parties who do not wish to contribute to QEMU.

That would result in the QEMU community maintaining infrastructure for
third parties who ship code of questionable quality and profit from it.
That's not healthy for the QEMU community and there's no incentive to
allow it.

A bit more about specifics you mentioned:

vhost-user is an exception for vhost devices.  They are based on the
open VIRTIO specification.  QEMU has in-tree implementations of these
devices so users can fall back to them if they need to request support
(otherwise it's impossible to support users with third-party devices).

Generic out-of-tree PCI device emulation is way too big a loophole.  The
QEMU community cannot support users who run arbitrary third-party PCI
devices.

The fact that there are ways to get around this by writing software mdev
devices doesn't mean it makes sense for QEMU to open a loophole itself.

Stefan

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb++4zAAoJEJykq7OBq3PIx20IAJ1Rv0vzVIhoklHubQ5nhSdU
benlHGq+XPHFyJovNgzIS/QIebkleGgpKNMuLWiOmHMpwxaW75JF+D0qvAVAMCJ0
1bovuQMfcehdoHrYZE6C2ov9ydpiq+Mff/pdnvuTrf38mH6tQw9gkhRf7qn6Umzh
RX29ZRsqfzb1Fx61vg5SqJGbRsI36VC+ndd9eBanEQ2Jrw6g2Fin+ivSX3dE2Q2E
z/40yltJbTY6sqfioy+tzafCLbb+ioJ2/l96/3QNLUxJPPiBt1eg2FnvH+mu0yLy
/BWaDRVd/Nvl/HfxAqyCdyX0bovFYuSKWKXZYQ9Y27Tbp3XunqxzeoyYAcnKmCA=
=Bsfv
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
