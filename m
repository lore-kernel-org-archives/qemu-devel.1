Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A2C47426
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE15F20657
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gouAcAjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE15F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdne-0004Dj-Io
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNdYe-0007A9-19
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNdYb-0004lh-NS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggNJT6EQGJY9GPCpsgo05So03SXNweoDLBFTAxm28SM=;
 b=gouAcAjXiMeJMssiSJyrJHF/KRhkvgB9sGSwJUdGeP8nc6z0q1dsyS/XZXliSQO9we8eud
 A9BCRKRvQh5Dl2dB3oTaKi9JqNhLKnE7tIdhukpOc/cJozc7ODggHZfGRedEseKd8vIVv1
 roVbLXVOlk1whnHTpA4x+HJADvWBKrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-ccUlt1ySMAqBPxjiB0CzJw-1; Wed, 30 Sep 2020 10:58:09 -0400
X-MC-Unique: ccUlt1ySMAqBPxjiB0CzJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A07E186DD35;
 Wed, 30 Sep 2020 14:58:07 +0000 (UTC)
Received: from localhost (ovpn-115-76.ams2.redhat.com [10.36.115.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0CBC5D9D3;
 Wed, 30 Sep 2020 14:57:52 +0000 (UTC)
Date: Wed, 30 Sep 2020 15:57:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200930145752.GB320669@stefanha-x1.localdomain>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
 <20200929085751.GA181609@stefanha-x1.localdomain>
 <20200929055110-mutt-send-email-mst@kernel.org>
 <20200929183824.GC191675@stefanha-x1.localdomain>
 <20200930034807-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200930034807-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lulu@redhat.com, tiwei.bie@intel.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, raphael.norwitz@nutanix.com, maxime.coquelin@redhat.com,
 kraxel@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 marcandre.lureau@redhat.com, Nikos Dragazis <ndragazis@arrikto.com>,
 changpeng.liu@intel.com, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 04:07:59AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 29, 2020 at 07:38:24PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Sep 29, 2020 at 06:04:34AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Sep 29, 2020 at 09:57:51AM +0100, Stefan Hajnoczi wrote:
> > > > On Tue, Sep 29, 2020 at 02:09:55AM -0400, Michael S. Tsirkin wrote:
> > > > > On Mon, Sep 28, 2020 at 10:25:37AM +0100, Stefan Hajnoczi wrote:
> > > > > > Why extend vhost-user with vDPA?
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > Reusing VIRTIO emulation code for vhost-user backends
> > > > > > -----------------------------------------------------
> > > > > > It is a common misconception that a vhost device is a VIRTIO de=
vice.
> > > > > > VIRTIO devices are defined in the VIRTIO specification and cons=
ist of a
> > > > > > configuration space, virtqueues, and a device lifecycle that in=
cludes
> > > > > > feature negotiation. A vhost device is a subset of the correspo=
nding
> > > > > > VIRTIO device. The exact subset depends on the device type, and=
 some
> > > > > > vhost devices are closer to the full functionality of their
> > > > > > corresponding VIRTIO device than others. The most well-known ex=
ample is
> > > > > > that vhost-net devices have rx/tx virtqueues and but lack the v=
irtio-net
> > > > > > control virtqueue. Also, the configuration space and device lif=
ecycle
> > > > > > are only partially available to vhost devices.
> > > > > >=20
> > > > > > This difference makes it impossible to use a VIRTIO device as a
> > > > > > vhost-user device and vice versa. There is an impedance mismatc=
h and
> > > > > > missing functionality. That's a shame because existing VIRTIO d=
evice
> > > > > > emulation code is mature and duplicating it to provide vhost-us=
er
> > > > > > backends creates additional work.
> > > > >=20
> > > > >=20
> > > > > The biggest issue facing vhost-user and absent in vdpa is
> > > > > backend disconnect handling. This is the reason control path
> > > > > is kept under QEMU control: we do not need any logic to
> > > > > restore control path data, and we can verify a new backend
> > > > > is consistent with old one.
> > > >=20
> > > > I don't think using vhost-user with vDPA changes that. The VMM stil=
l
> > > > needs to emulate a virtio-pci/ccw/mmio device that the guest interf=
aces
> > > > with. If the device backend goes offline it's possible to restore t=
hat
> > > > state upon reconnection. What have I missed?
> > >=20
> > > The need to maintain the state in a way that is robust
> > > against backend disconnects and can be restored.
> >=20
> > QEMU is only bypassed for virtqueue accesses. Everything else still
> > goes through the virtio-pci emulation in QEMU (VIRTIO configuration
> > space, status register). vDPA doesn't change this.
> >=20
> > Existing vhost-user messages can be kept if they are useful (e.g.
> > virtqueue state tracking). So I think the situation is no different tha=
n
> > with the existing vhost-user protocol.
> >=20
> > > > Regarding reconnection in general, it currently seems like a partia=
lly
> > > > solved problem in vhost-user. There is the "Inflight I/O tracking"
> > > > mechanism in the spec and some wording about reconnecting the socke=
t,
> > > > but in practice I wouldn't expect all device types, VMMs, or device
> > > > backends to actually support reconnection. This is an area where a
> > > > uniform solution would be very welcome too.
> > >=20
> > > I'm not aware of big issues. What are they?
> >=20
> > I think "Inflight I/O tracking" can only be used when request processin=
g
> > is idempotent? In other words, it can only be used when submitting the
> > same request multiple times is safe.
>=20
>=20
> Not inherently it just does not attempt to address this problem.
>=20
>=20
> Inflight tracking only tries to address issues on the guest side,
> that is, making sure the same buffer is used exactly once.
>=20
> > A silly example where this recovery mechanism cannot be used is if a
> > device has a persistent counter that is incremented by the request. The
> > guest can't be sure that the counter will be incremented exactly once.
> >=20
> > Another example: devices that support requests with compare-and-swap
> > semantics cannot use this mechanism. During recover the compare will
> > fail if the request was just completing when the backend crashed.
> >=20
> > Do I understand the limitations of this mechanism correctly? It doesn't
> > seem general and I doubt it can be applied to all existing device types=
.
>=20
> Device with any kind of atomicity guarantees will
> have to use some internal mechanism (e.g. log?) to ensure
> internal consistency, that is out of scope for tracking.

Rant warning, but probably useful to think about for future vhost-user
and vfio-user development... :)

IMO "Inflight I/O tracking" is best placed into libvhost-user instead of
the vhost-user protocol. Here is why:

QEMU's vhost-user code actually does nothing with the inflight data
except passing it back to the reconnected vhost-user device backend and
migrating it as an opaque blob.

The fact that it's opaque to QEMU is a warning sign. QEMU is simply a
mechanism for stashing a blob of data. Stashing data is generic
functionality and not specific to vhost-user devices. One could argue
it's convenient to have the inflight data available to QEMU for
reconnection, but as you said, device backends may still need to
maintain additional state.

It's not clear how the opaque inflight data is within the scope of
vhost-user but additional device backend data is outside the scope. This
is why I think "Inflight I/O tracking" shouldn't be part of the
protocol.

"Inflight I/O tracking" should be a utility API in libvhost-user instead
of a vhost-user protocol feature. That way the backend can stash any
additional data it needs along with the virtqueues. There needs to be
device state save/load support in the vhost-user protocol but eventually
we'll need that anyway because some backends are stateful.

> > > > There was discussion about recovering state in muser. The original =
idea
> > > > was for the muser kernel module to host state that persists across
> > > > device backend restart. That way the device backend can go away
> > > > temporarily and resume without guest intervention.
> > > >=20
> > > > Then when the vfio-user discussion started the idea morphed into si=
mply
> > > > keeping a tmpfs file for each device instance (no special muser.ko
> > > > support needed anymore). This allows the device backend to resume
> > > > without losing state. In practice a programming framework is needed=
 to
> > > > make this easy and safe to use but it boils down to a tmpfs mmap.
> > > >=20
> > > > > > If there was a way to reuse existing VIRTIO device emulation co=
de it
> > > > > > would be easier to move to a multi-process architecture in QEMU=
. Want to
> > > > > > run --netdev user,id=3Dnetdev0 --device virtio-net-pci,netdev=
=3Dnetdev0 in a
> > > > > > separate, sandboxed process? Easy, run it as a vhost-user-net d=
evice
> > > > > > instead of as virtio-net.
> > > > >=20
> > > > > Given vhost-user is using a socket, and given there's an elaborat=
e
> > > > > protocol due to need for backwards compatibility, it seems safer =
to
> > > > > have vhost-user interface in a separate process too.
> > > >=20
> > > > Right, with vhost-user only the virtqueue processing is done in the
> > > > device backend. The VMM still has to do the virtio transport emulat=
ion
> > > > (pci, ccw, mmio) and vhost-user connection lifecycle, which is comp=
lex.
> > >=20
> > > IIUC all vfio user does is add another protocol in the VMM,
> > > and move code out of VMM to backend.
> > >=20
> > > Architecturally I don't see why it's safer.
> >=20
> > It eliminates one layer of device emulation (virtio-pci). Fewer
> > registers to emulate means a smaller attack surface.
>=20
> Well it does not eliminate it as such, it moves it to the backend.
> Which in a variety of setups is actually a more sensitive
> place as the backend can do things like access host
> storage/network which VMM can be prevented from doing.
>=20
> > It's possible to take things further, maybe with the proposed ioregionf=
d
> > mechanism, where the VMM's KVM_RUN loop no longer handles MMIO/PIO
> > exits. A separate process can handle them. Maybe some platform devices
> > need CPU state access though.
> >=20
> > BTW I think the goal of removing as much emulation from the VMM as
> > possible is interesting.
> >=20
> > Did you have some other approach in mind to remove the PCI and
> > virtio-pci device from the VMM?
>=20
> Architecturally, I think we can have 3 processes:
>=20
>=20
> VMM -- guest device emulation -- host backend
>=20
>=20
> to me this looks like increasing our defence in depth strength,
> as opposed to just shifting things around ...

Cool idea.

Performance will be hard because there is separation between the guest
device emulation and the host backend.

There is also more communication code involved, which might make it hard
to change the guest device emulation <-> host backend interfaces.

These are the challenges I see but it would be awesome to run guest
device emulation in a tightly sandboxed environment that has almost no
syscalls available.

> > > Something like multi-process patches seems like a way to
> > > add defence in depth by having a process in the middle,
> > > outside both VMM and backend.
> >=20
> > There is no third process in mpqemu. The VMM uses a UNIX domain socket
> > to communicate directly with the device backend. There is a PCI "proxy"
> > device in the VMM that does this communication when the guest accesses
> > registers. The device backend has a PCI "remote" host controller that a
> > PCIDevice instance is plugged into and the UNIX domain socket protocol
> > commands are translated into PCIDevice operations.
>=20
> Yes, but does anything prevent us from further splitting the backend
> up to emulation part and host side part?

See above.

Stefan

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl90nO8ACgkQnKSrs4Gr
c8hp1QgAkipwc2LiCXJj2BchysVzW4yVGzY7k2lpqDPE1bRyKBAJEoW3I87EdMuV
BJwoylycU9qUdt9XjjjqZrw4JesGVmPtNvqYUjZN5CKehoCVRyHUWQKWNwWhzp7n
T1W1LGPdWw5JaRJR8x6oOdM5I5m1J7aX1CyUgmYcOUv0yqies48fZiDkQdFdU+Wc
HnsWpVI9gNlbVzPOsTKBJ8dA4L02rnke1KO+lQaPfj4dcmF7imUt3mExyAIuCl1b
PnLsDfPEnAkQfraYLXla1jed/ozqoxjRs9BSlazUNThTViqDtFEhMDniX/9GL6k0
6OH6+VHlBmy+Q4aHVb39ucLRLUq/5Q==
=kWAS
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--


