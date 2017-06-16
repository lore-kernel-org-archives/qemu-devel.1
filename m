Received: from eggs.gnu.org ([2001:4830:134:3::10]:58448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLsyP-0003Qa-Os
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLsyK-0007fk-Rv
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLsyK-0007ep-I0
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:15:40 -0400
Date: Fri, 16 Jun 2017 18:15:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170616181040-mutt-send-email-mst@kernel.org>
References: <9f196d71-f06b-7520-ca03-e94bf3b5a986@redhat.com>
	<593FB550.6090903@intel.com>
	<26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
	<b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
	<59422E91.7080407@intel.com>
	<20170616061949-mutt-send-email-mst@kernel.org>
	<40a12829-6e84-e63e-ac47-6f09cc85c3cc@redhat.com>
	<5943AE93.7020502@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5943AE93.7020502@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v1] virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Fri, Jun 16, 2017 at 06:10:27PM +0800, Wei Wang wrote:
> On 06/16/2017 04:57 PM, Jason Wang wrote:
> >=20
> >=20
> > On 2017=E5=B9=B406=E6=9C=8816=E6=97=A5 11:22, Michael S. Tsirkin wrot=
e:
> > > > I think the issues can be solved by VIRTIO_F_MAX_CHAIN_SIZE.
> > > >=20
> > > > For now, how about splitting it into two series of patches:
> > > > 1) enable 1024 tx queue size for vhost-user, to let the users of
> > > > vhost-user
> > > > to easily use 1024 queue size.
> > > Fine with me. 1) will get property from user but override it on
> > > !vhost-user. Do we need a protocol flag? It seems prudent but we ge=
t
> > > back to cross-version migration issues that are still pending solut=
ion.
> What do you have in mind about the protocol flag?

Merely this: older clients might be confused if they get
a s/g with 1024 entries.

> Btw, I just tested the patch of 1), and it works fine with migration fr=
om
> the
> patched to non-patched version of QEMU. I'll send it out. Please have a
> check.
>=20
>=20
> > > Marc Andre, what's the status of that work?
> > >=20
> > > > 2) enable VIRTIO_F_MAX_CHAIN_SIZE,  to enhance robustness.
> > > Rather, to support it for more backends.
> >=20
> > Ok, if we want to support different values of max chain size in the
> > future. It would be problematic for migration of cross backends,
> > consider the case when migrating from 2048 (vhost-user) to 1024
> > (qemu/vhost-kernel).
> >=20
>=20
> I think that wouldn't be a problem. If there is a possibility to change=
 the
> backend resulting in a change of config.max_change_size, a configuratio=
n
> change notification can be injected to the guest, then guest will read =
and
> get the new value.
>=20
> Best,
> Wei

This might not be supportable by all guests. E.g. some requests might
already be in the queue. I'm not against reconfiguring devices across
migration but I think it's a big project. As a 1st step I would focus on
keeping configuration consistent across migrations.

--=20
MST
