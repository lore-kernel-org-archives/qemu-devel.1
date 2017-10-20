Received: from eggs.gnu.org ([2001:4830:134:3::10]:44897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e5MX7-0000wS-29
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e5MX3-00041J-Tt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:55:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:13212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1e5MX3-0003zs-Iw
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:55:29 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Fri, 20 Oct 2017 01:55:20 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5D86A7@SHSMSX103.ccr.corp.intel.com>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-2-git-send-email-changpeng.liu@intel.com>
	<20171019183638-mutt-send-email-mst@kernel.org>
	<42aa8736-bc23-d66d-27de-dbaf83ea2f99@redhat.com>
	<20171019204305-mutt-send-email-mst@kernel.org>
	<e2c13ada-aa4b-1bbd-b2ba-3dcf247b6f57@redhat.com>
	<20171020032138-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171020032138-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, October 20, 2017 8:28 AM
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Liu, Changpeng <changpeng.liu@intel.com>; qemu-devel@nongnu.org;
> stefanha@gmail.com; marcandre.lureau@redhat.com; felipe@nutanix.com; Harr=
is,
> James R <james.r.harris@intel.com>
> Subject: Re: [PATCH v4 1/4] vhost-user: add new vhost user messages to su=
pport
> virtio config space
>=20
> On Thu, Oct 19, 2017 at 11:04:48PM +0200, Paolo Bonzini wrote:
> > On 19/10/2017 19:43, Michael S. Tsirkin wrote:
> > > On Thu, Oct 19, 2017 at 05:43:18PM +0200, Paolo Bonzini wrote:
> > >> On 19/10/2017 17:39, Michael S. Tsirkin wrote:
> > >>>> Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages
> which can be
> > >>>> used for live migration of vhost user devices, also vhost user dev=
ices
> > >>>> can benefit from the messages to get/set virtio config space from/=
to the
> > >>>> I/O target. For the purpose to support virtio config space change,
> > >>>> VHOST_USER_SET_CONFIG_FD message is added as the event notifier
> > >>>> in case virtio config space change in the I/O target.
> > >>>>
> > >>>> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > >>> I don't much like it that config is getting passed through.
> > >>>
> > >>> IMO this makes managing things harder not easier.
> > >>>
> > >>> How about specific messages about specific parts of
> > >>> config space that you want to get from the backend?
> > >>
> > >> In the case of virtio-blk that would be all of it.  Do you have a ca=
se
> > >> in mind where some part of the configuration space is owned by QEMU?
> > >>
> > >> Paolo
> > >
> > > Yes. seg_max
> >
> > The seg_max limit is established by whoever reads buffers from the vrin=
g
> > and passes them down to the lower layer.  For vhost-blk that's the
> > device server, not QEMU.
> >
> > Paolo
>=20
> Good point. How about num_queues though?
num_queues  is part of virtio_blk config, vhost-user slave can set it,=20
and Qemu driver can rewrite it if user want less IO queues.
>=20
> Also why is there SET_CONFIG? Does not look like blk uses it.
Only one possible usage when disable write cache to vhost-user slave device=
.
>=20
> And I wonder how do we do it for other devices.
>=20
> E.g. for net there's a bit in the middle of the
> config field that deals with migration.
Well, I'm okay to make those messages only valid for virtio block device, b=
ecause it's enough
for virtio block to be started with vhost-user slave target.
>=20
>=20
> --
> MST
