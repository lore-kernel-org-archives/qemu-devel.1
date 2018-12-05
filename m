Received: from eggs.gnu.org ([2001:4830:134:3::10]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUMTo-0001Sc-Sv
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUMTj-000224-Uy
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:00:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gUMTj-00021X-MU
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 20:59:55 -0500
Date: Tue, 4 Dec 2018 20:59:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181204205541-mutt-send-email-mst@kernel.org>
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
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

On Wed, Dec 05, 2018 at 09:30:19AM +0800, Jason Wang wrote:
>=20
> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
> > Hi,
> >=20
> > I'm wondering how the current implementation works when logging dirty
> > pages during migration from vhost-net (in kernel) when used vIOMMU.
> >=20
> > I understand how vhost-net logs GPAs when not using vIOMMU. But when
> > we use vhost with vIOMMU, then shouldn't vhost-net need to log the
> > translated address (GPA) instead of the address written in the
> > descriptor (IOVA) ? The current implementation looks like vhost-net
> > just logs IOVA without translation in vhost_get_vq_desc() in
> > drivers/vhost/net.c. It seems like QEMU doesn't do any further
> > translation of the dirty log when syncing.
> >=20
> > I might be missing something. Could somebody shed some light on this?
>=20
>=20
> Good catch. It looks like a bug to me. Want to post a patch for this?

This isn't going to be a quick fix: IOTLB UAPI is translating
IOVA values directly to uaddr.

So to fix it, we need to change IOVA messages to translate to GPA
so GPA can be logged.

for existing userspace We can try reverse translation uaddr->gpa as a
hack for logging but that translation was never guaranteed to be unique.

Jason I think you'll have to work on it given the complexity.

> Thanks
>=20
>=20
> >=20
> > Thanks,
> > Jintack
> >=20
> >=20
