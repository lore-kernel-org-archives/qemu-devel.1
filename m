Received: from eggs.gnu.org ([2001:4830:134:3::10]:53564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWBqZ-0006Ki-VQ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWBqW-0001jt-PK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:30:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWBqW-0001ix-JY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:30:44 -0400
Date: Fri, 22 Jun 2018 05:30:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180622052717-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
	<20180612144743-mutt-send-email-mst@kernel.org>
	<5718de66-74c9-1362-a87b-2eba02475b48@redhat.com>
	<c29a5ac9-cfb5-0a19-f28c-30d41bd5efcf@intel.com>
	<ce4da2b0-88fd-c79b-0567-fe564bb34922@redhat.com>
	<20180621211359-mutt-send-email-mst@kernel.org>
	<CADGSJ216itm89dUuK_vOfuBsBq5bq4485GqMKjB1JXFD_PLZxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADGSJ216itm89dUuK_vOfuBsBq5bq4485GqMKjB1JXFD_PLZxA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siwei Liu <loseweigh@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, qemu-devel@nongnu.org

On Thu, Jun 21, 2018 at 06:07:18PM -0700, Siwei Liu wrote:
> On Thu, Jun 21, 2018 at 11:14 AM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > On Wed, Jun 13, 2018 at 01:40:59PM +0800, Jason Wang wrote:
> >>
> >>
> >> On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 12:24, Samudrala, Sridhar wro=
te:
> >> > On 6/12/2018 7:38 PM, Jason Wang wrote:
> >> > >
> >> > >
> >> > > On 2018=E5=B9=B406=E6=9C=8812=E6=97=A5 19:54, Michael S. Tsirkin=
 wrote:
> >> > > > On Wed, Jun 06, 2018 at 10:29:03AM +0800, Jason Wang wrote:
> >> > > > >
> >> > > > > On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 20:33, Michael S. Tsi=
rkin wrote:
> >> > > > > > I don't think this is sufficient.
> >> > > > > >
> >> > > > > > If both primary and standby devices are present, a
> >> > > > > > legacy guest without
> >> > > > > > support for the feature might see two devices with same ma=
c and get
> >> > > > > > confused.
> >> > > > > >
> >> > > > > > I think that we should only make primary visible after
> >> > > > > > guest acked the
> >> > > > > > backup feature bit.
> >> > > > > I think we want exactly the reverse? E.g fail the
> >> > > > > negotiation when guest
> >> > > > > does not ack backup feature.
> >> > > > >
> >> > > > > Otherwise legacy guest won't even have the chance to see
> >> > > > > primary device in
> >> > > > > the guest.
> >> > > > That's by design.
> >> > >
> >> > > So management needs to know the capability of guest to set the
> >> > > backup feature. This looks a chicken or egg problem to me.
> >> >
> >> > I don't think so. If the tenant requests 'accelerated datapath fea=
ture',
> >> > the management
> >> > will set 'standby' feature bit on virtio-net interface and if the =
guest
> >> > virtio-net driver
> >> > supports this feature, then the tenant VM will get that capability=
 via a
> >> > hot-plugged
> >> > primary device.
> >>
> >> Ok, I thought exactly the reverse because of the commit title is "en=
able
> >> virtio_net to act as a standby for a passthru device". But re-read t=
he
> >> commit log content, I understand the case a little bit. Btw, VF is n=
ot
> >> necessarily faster than virtio-net, especially consider virtio-net m=
ay have
> >> a lot of queues.
> >
> > Don't do that then, right?
>=20
> I don't understand. Where did the standby feature come to imply the
> "accelerated datapath" thing?
> Isn't failover/standby a generic high
> availblity term, rather than marry it to the concept of device model
> specifics? Do we expect scsi to work exactly the same way with
> "accelerated datapath"?

That's not what I said.
The semantics are that the primary is always used if present in
preference to standby.
Jason said virtio net is sometimes preferable.
If that's the case don't make it a standby.

More advanced use-cases do exist and e.g. Alexander Duyck
suggested using a switch-dev. failover isn't it though.

--=20
MST
