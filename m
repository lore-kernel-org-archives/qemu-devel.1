Received: from eggs.gnu.org ([2001:4830:134:3::10]:58848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb0tL-0005lV-60
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb0tG-0002Jr-7o
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:12:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cb0tG-0002IE-2s
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:12:42 -0500
Date: Tue, 7 Feb 2017 16:12:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170207081233.GZ5151@pxdev.xzpeter.org>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-17-git-send-email-peterx@redhat.com>
	<7d0891fb-62f2-28f3-0f04-99c136d3bed8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d0891fb-62f2-28f3-0f04-99c136d3bed8@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 16/18] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Feb 07, 2017 at 02:16:15PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> >Before this one we only invalidate context cache when we receive conte=
xt
> >entry invalidations. However it's possible that the invalidation also
> >contains a domain switch (only if cache-mode is enabled for vIOMMU). I=
n
> >that case we need to notify all the registered components about the ne=
w
> >mapping.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> >  hw/i386/intel_iommu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index 0a42c01..363227d 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -1115,6 +1115,16 @@ static void vtd_context_device_invalidate(Intel=
IOMMUState *s,
> >                  trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(dev=
fn_it),
> >                                               VTD_PCI_FUNC(devfn_it))=
;
> >                  vtd_as->context_cache_entry.context_cache_gen =3D 0;
> >+                /*
> >+                 * So a device is moving out of (or moving into) a
> >+                 * domain, a replay() suites here to notify all the
> >+                 * IOMMU_NOTIFIER_MAP registers about this change.
> >+                 * This won't bring bad even if we have no such
> >+                 * notifier registered - the IOMMU notification
> >+                 * framework will skip MAP notifications if that
> >+                 * happened.
> >+                 */
> >+                memory_region_iommu_replay_all(&vtd_as->iommu);
> >              }
> >          }
> >      }
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
>=20
> We may consider to squash this into patch 18.

I can do it. Thanks,

-- peterx
