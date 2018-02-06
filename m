Received: from eggs.gnu.org ([2001:4830:134:3::10]:60096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eizbw-0001Rm-7g
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eizbq-000825-HH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:32:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eizbq-00081P-9U
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:32:14 -0500
Date: Tue, 6 Feb 2018 09:31:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180206093158.GE4942@stefanha-x1.localdomain>
References: <20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
	<5A70606F.3030307@intel.com>
	<20180201190712-mutt-send-email-mst@kernel.org>
	<5A7462DC.1020904@intel.com>
	<20180205162549.GH28241@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73942B586@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73942B586@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 01:28:25AM +0000, Wang, Wei W wrote:
> On Tuesday, February 6, 2018 12:26 AM, Stefan Hajnoczi wrote:
> > On Fri, Feb 02, 2018 at 09:08:44PM +0800, Wei Wang wrote:
> > > On 02/02/2018 01:08 AM, Michael S. Tsirkin wrote:
> > > > On Tue, Jan 30, 2018 at 08:09:19PM +0800, Wei Wang wrote:
> > > > > Issues:
> > > > > Suppose we have both the vhost and virtio-net set up, and vhost
> > > > > pmd <-> virtio-net pmd communication works well. Now, vhost pmd
> > > > > exits (virtio-net pmd is still there). Some time later, we re-run
> > > > > vhost pmd, the vhost pmd doesn't know the virtqueue addresses of
> > > > > the virtio-net pmd, unless the virtio-net pmd reloads to start the
> > > > > 2nd phase of the vhost-user protocol. So the second run of the vh=
ost
> > pmd won't work.
> > > > >
> > > > > Any thoughts?
> > > > >
> > > > > Best,
> > > > > Wei
> > > > So vhost in qemu must resend all configuration on reconnect.
> > > > Does this address the issues?
> > > >
> > >
> > > Yes, but the issues are
> > > 1) there is no reconnecting when a pmd exits (the socket connection
> > > seems still on at the device layer);
> >=20
> > This is how real hardware works too.  If the driver suddenly stops runn=
ing
> > then the device remains operational.  When the driver is started again =
it
> > resets the device and initializes it.
> >=20
> > > 2) If we find a way to break the QEMU layer socket connection when pmd
> > > exits and get it reconnect, virtio-net device still won't send all the
> > > configure when reconnecting, because socket connecting only triggers
> > > phase 1 of vhost-user negotiation (i.e. vhost_user_init). Phase 2 is
> > > triggered after the driver loads (i.e. vhost_net_start). If the
> > > virtio-net pmd doesn't reload, there are no phase 2 messages (like
> > > virtqueue addresses which are allocated by the pmd). I think we need
> > > to think more about this before moving forward.
> >=20
> > Marc-Andr=E9: How does vhost-user reconnect work when the master goes
> > away and a new master comes online?  Wei found that the QEMU slave
> > implementation only does partial vhost-user initialization upon reconne=
ct, so
> > the new master doesn't get the virtqueue address and related informatio=
n.
> > Is this a QEMU bug?
>=20
> Actually we are discussing the slave (vhost is the slave, right?) going a=
way. When a slave exits and some moment later a new slave runs, the master =
(virtio-net) won't send the virtqueue addresses to the new vhost slave.

Yes, apologies for the typo.  s/QEMU slave/QEMU master/

Yesterday I asked Marc-Andr=E9 for help on IRC and we found the code path
where the QEMU master performs phase 2 negotiation upon reconnect.  It's
not obvious but the qmp_set_link() calls in net_vhost_user_event() will
do it.

I'm going to try to reproduce the issue you're seeing now.  Will let you
know what I find.

Stefan

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeXYNAAoJEJykq7OBq3PIfioH/RadBnn9KpPi9QrWFy6gPdZq
ANQ93gstZbiHGi0MiRoUlcYHlH1IRki9BdP6w7CuRqX8HZD9JBt1Z1LhWXoikv90
FX7UxOr2gN/ePwnzc9IGMaOV9eBHuKmY8FwqWD+FZBK5FPHvHPu56sM9/BMl0E+M
zut1tlxxTpHVG0P1WOjQ16bH0OooGGyblQQWsZIWIFEBDbvjS3T41rElxNHl8pRo
nU1HrnfOtccfrJ6z4jNG1UCloRGhHz/qopkWQPwIw9dhslCtjLZq42ZeQqcZCC+1
TgIOXGWHY5MPJqVdl7flPGQEVWhiG9YaVV1vLhwmOBqdJZLABCcvGBk7Ku5KgPs=
=hoJi
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
