Received: from eggs.gnu.org ([2001:4830:134:3::10]:40197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Dgq-0005kT-BQ
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Dgm-0004R0-Tq
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:21:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:45190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d7Dgm-0004Qw-HJ
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:20:56 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sun, 7 May 2017 04:20:51 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391FFBCB@shsmsx102.ccr.corp.intel.com>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-6-git-send-email-wei.w.wang@intel.com>
	<20170413194732-mutt-send-email-mst@kernel.org>
	<590190C8.6030609@intel.com>
	<20170506011928-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170506011928-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 5/5] virtio-balloon:
 VIRTIO_BALLOON_F_MISC_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>

On 05/06/2017 06:21 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 27, 2017 at 02:33:44PM +0800, Wei Wang wrote:
> > On 04/14/2017 01:08 AM, Michael S. Tsirkin wrote:
> > > On Thu, Apr 13, 2017 at 05:35:08PM +0800, Wei Wang wrote:
> > > > Add a new vq, miscq, to handle miscellaneous requests between the
> > > > device and the driver.
> > > >
> > > > This patch implemnts the
> VIRTIO_BALLOON_MISCQ_INQUIRE_UNUSED_PAGES
> > > implements
> > >
> > > > request sent from the device.
> > > Commands are sent from host and handled on guest.
> > > In fact how is this so different from stats?
> > > How about reusing the stats vq then? You can use one buffer for
> > > stats and one buffer for commands.
> > >
> >
> > The meaning of the two vqs is a little different. statq is used for
> > reporting statistics, while miscq is intended to be used to handle
> > miscellaneous requests from the guest or host
>=20
> misc just means "anything goes". If you want it to mean "commands" name i=
t so.

Ok, will change it.

> > (I think it can
> > also be used the other way around in the future when other new
> > features are added which need the guest to send requests and the host
> > to provide responses).
> >
> > I would prefer to have them separate, because:
> > If we plan to combine them, we need to put the previous statq related
> > implementation under miscq with a new command (I think we can't
> > combine them without using commands to distinguish the two features).
>=20
> Right.

> > In this way, an old driver won't work with a new QEMU or a new driver
> > won't work with an old QEMU. Would this be considered as an issue
> > here?
>=20
> Compatibility is and should always be handled using feature flags.  There=
's a
> feature flag for this, isn't it?

The negotiation of the existing feature flag, VIRTIO_BALLOON_F_STATS_VQ
only indicates the support of the old statq implementation. To move the sta=
tq
implementation under cmdq, I think we would need a new feature flag for the
new statq implementation:
#define VIRTIO_BALLOON_F_CMDQ_STATS      5

What do you think?

Best,
Wei
