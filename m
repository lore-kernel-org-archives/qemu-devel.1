Received: from eggs.gnu.org ([2001:4830:134:3::10]:51687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVEA2-0006LW-Oj
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVE9z-00074g-MF
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:10:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVE9z-000745-Gh
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:10:03 -0500
Date: Sun, 22 Jan 2017 17:09:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170122090958.GC26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-20-git-send-email-peterx@redhat.com>
	<e1b09efe-0201-a746-9aa9-62f798a222f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1b09efe-0201-a746-9aa9-62f798a222f9@redhat.com>
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
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Sun, Jan 22, 2017 at 04:13:32PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
> >Previous replay works for domain switch only if the original domain do=
es
> >not have mapped pages. For example, if we switch domain from A to B, i=
t
> >will only work if A has no existing mapping. If there is, then there's
> >problem - current replay didn't make sure the old mappings are cleared
> >before replaying the new one.
>=20
> I'm not quite sure this is needed. I thought the only thing we need to =
do is
> stop DMA of device during the moving? Or is there an example that will =
cause
> trouble?

I think this patch is essential.

Example:

- device D1 moved to domain A, domain A has no mapping
- map page P1 in domain A, so D1 will have a mapping of page P1
- create domain B with mapping P2
- move D1 from domain A to domain B

Here if we don't unmap existing pages in domain A (P1), after the
switch, we'll have D1 with both P1/P2 mapped, while domain B actually
only has P2. That's unaligned mapping, and it should be wrong.

If you (or anyone) think this is a bug as well for patch 18, I can
just squash both 19/20 into patch 18.

Thanks,

-- peterx
