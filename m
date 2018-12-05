Received: from eggs.gnu.org ([2001:4830:134:3::10]:47853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUXIQ-0004By-5c
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUXIM-0000xR-Ts
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:32:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gUXIM-0000wp-KA
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:32:54 -0500
Date: Wed, 5 Dec 2018 08:32:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181205082228-mutt-send-email-mst@kernel.org>
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
	<20181204205541-mutt-send-email-mst@kernel.org>
	<fc1150b2-f71a-b527-cce1-9b33e0a11c6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc1150b2-f71a-b527-cce1-9b33e0a11c6a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Dec 05, 2018 at 11:02:11AM +0800, Jason Wang wrote:
>=20
> On 2018/12/5 =E4=B8=8A=E5=8D=889:59, Michael S. Tsirkin wrote:
> > On Wed, Dec 05, 2018 at 09:30:19AM +0800, Jason Wang wrote:
> > > On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
> > > > Hi,
> > > >=20
> > > > I'm wondering how the current implementation works when logging d=
irty
> > > > pages during migration from vhost-net (in kernel) when used vIOMM=
U.
> > > >=20
> > > > I understand how vhost-net logs GPAs when not using vIOMMU. But w=
hen
> > > > we use vhost with vIOMMU, then shouldn't vhost-net need to log th=
e
> > > > translated address (GPA) instead of the address written in the
> > > > descriptor (IOVA) ? The current implementation looks like vhost-n=
et
> > > > just logs IOVA without translation in vhost_get_vq_desc() in
> > > > drivers/vhost/net.c. It seems like QEMU doesn't do any further
> > > > translation of the dirty log when syncing.
> > > >=20
> > > > I might be missing something. Could somebody shed some light on t=
his?
> > >=20
> > > Good catch. It looks like a bug to me. Want to post a patch for thi=
s?
> > This isn't going to be a quick fix: IOTLB UAPI is translating
> > IOVA values directly to uaddr.
> >=20
> > So to fix it, we need to change IOVA messages to translate to GPA
> > so GPA can be logged.
> >=20
> > for existing userspace We can try reverse translation uaddr->gpa as a
> > hack for logging but that translation was never guaranteed to be uniq=
ue.
>=20
>=20
> We have memory table in vhost as well, so looks like we can do this in
> kernel as well without disturbing UAPI?
>=20
> Thanks

Let me try to rephrase.

Yes, as a temporary bugfix we can do the uaddr to gpa translations.
It is probably good enough for what QEMU does now.

However it can break some legal userspace, since it is possible to
have multiple UADDR mappings for a single GPA.
In that setup the vhost table would only have one of these
and it's possible that IOTLB would use another one.

And generally it's a better idea security-wise to make
iotlb talk in GPA terms. This way whoever sets the static
GPA-to-UADDR mappings controls security, and the dynamic
and more fragile iova mappings can not break QEMU security.

So we need a UAPI extension with a feature flag.

>=20
> >=20
> > Jason I think you'll have to work on it given the complexity.
> >=20
> > > Thanks
> > >=20
> > >=20
> > > > Thanks,
> > > > Jintack
> > > >=20
> > > >=20
