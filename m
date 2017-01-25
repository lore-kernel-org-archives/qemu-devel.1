Received: from eggs.gnu.org ([2001:4830:134:3::10]:45985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWEzp-00046p-LW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWEzl-0007Sz-Hw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:15:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cWEzl-0007Sh-BL
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:15:41 -0500
Date: Wed, 25 Jan 2017 12:15:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170125041534.GC5151@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-20-git-send-email-peterx@redhat.com>
	<cddf837c-24ca-b6f2-67cf-256e6b1e0bec@redhat.com>
	<20170124073152.GA16400@pxdev.xzpeter.org>
	<662d5e53-0e62-741f-ba71-32630b91ffd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <662d5e53-0e62-741f-ba71-32630b91ffd4@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 19/20] intel_iommu: unmap existing
 pages before replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Wed, Jan 25, 2017 at 11:11:30AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 15:31, Peter Xu wrote:
> >On Mon, Jan 23, 2017 at 06:40:12PM +0800, Jason Wang wrote:
> >>On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
> >>>  static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
> >>>  {
> >>>      memory_region_notify_one((IOMMUNotifier *)private, entry);
> >>>@@ -2711,13 +2768,16 @@ static void vtd_iommu_replay(MemoryRegion *m=
r, IOMMUNotifier *n)
> >>>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=
=3D 0) {
> >>>          /*
> >>>-         * Scanned a valid context entry, walk over the pages and
> >>>-         * notify when needed.
> >>>+         * Scanned a valid context entry, we first make sure to rem=
ove
> >>>+         * all existing mappings in old domain, by sending UNMAP to
> >>>+         * all the notifiers. Then, we walk over the pages and noti=
fy
> >>>+         * with existing mapped new entries in the new domain.
> >>>           */
> >>A question is what if the context cache was invalidated but the devic=
e were
> >>not moved to a new domain. Then the code here does not do anything I
> >>believe?
> >Yes, it'll unmap all the stuffs and remap them all. I think that's my
> >intention, and can we really avoid this?
> >
> >>I think we should move vtd_address_space_unmap() in the context
> >>entry invalidation processing.
> >IMHO we need this "whole umap" thing not only for context entry
> >invalidation, but all the places that need this replay, no? For
> >example, when we receive domain flush.
> >
> >Thanks,
> >
> >-- peterx
> >
>=20
> Consider the case that we move device from domain A to no domain. Looks=
 like
> current code did nothing since it can not get a valid context entry dur=
ing
> replay?

Right. I should do the "whole region unmap" thing even without a valid
context entry. Will fix it in next post. Thanks,

-- peterx
