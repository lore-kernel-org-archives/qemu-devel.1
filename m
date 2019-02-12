Received: from eggs.gnu.org ([209.51.188.92]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtd0J-0006G6-V6
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtd0F-0008F9-Uj
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:41:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtd0F-0005RP-KY
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:41:55 -0500
Date: Tue, 12 Feb 2019 13:40:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212133718-mutt-send-email-mst@kernel.org>
References: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
	<078dfb4d-2467-6a2c-1964-a463839e8183@redhat.com>
	<7dafec67-e6dd-ad0a-db11-f71076ada26c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dafec67-e6dd-ad0a-db11-f71076ada26c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Is IOThread for virtio-net a good idea?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org

On Tue, Feb 12, 2019 at 03:00:55PM +0800, Jason Wang wrote:
>=20
> On 2019/2/12 =E4=B8=8B=E5=8D=882:48, Jason Wang wrote:
> >=20
> > On 2019/2/11 =E4=B8=8B=E5=8D=889:40, Anton Kuchin wrote:
> > > As far as I can see currently IOThread offloading is used only for
> > > block devices and all others are emulated by main thread.
> > >=20
> > > I expect that network devices can also benefit from processing in
> > > separate thread but I couldn't find any recent work in this
> > > direction. I'm going to implement a PoC but I want to ask if you
> > > know any previous attempts and do you know why it can be a total
> > > waste of time. Are there fundamental obstacles that prevent network
> > > emulation handling in IOThread?
> > >=20
> >=20
> > I think there're no obstacles.
> >=20
> > The only question is whether or not you need to support legacy
> > networking backends. If the answer is yes, you need to convert them n=
ot
> > to assume context of Main Loop. But I don't think it's worth to suppo=
rt
> > them. We should focus on high speed solution like linking dpdk.
> >=20
> > Another issue is the virtio implementation. Dpdk has virtio library
> > which is pretty optimized, we should consider to use it. But last tim=
e I
> > check the code, it was tightly coupled with AF_UNIX transport of
> > vhost-user. We may want to decouple it out of dpdk. Of course we can =
do
> > it our own as well. (Yes I know there's a vhost-user implementation, =
but
> > it was not optimized for performance).
> >=20
> > I do have some prototype that is based on vhost-scsi-dataplane with a
> > TAP backend. I can send it to you if you wish.
> >=20
>=20
> Note, what I did is a vhost implementation inside IOThread. It doesn't =
use
> qemu memory core (which is slow for e.g 10Mpps) but vhost memory table.
>=20
> Thanks

If you are going to all these lengths duplicating dpdk I would at least
make it out of process to qemu to improve security.
As an excercise, maybe start by generalizing pxe test to support vhost
user bridge. That would already be a win.


As for IOTLB, I advicated VTD support in vhost for a while.  VTD page
table parsing isn't a lot of code at all if you put invalidations in
userspace.  We ended up with the message-passing instead for portability
but we can go back for sure.



>=20
> > Thanks
> >=20
> >=20
