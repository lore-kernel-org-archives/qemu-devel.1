Received: from eggs.gnu.org ([2001:4830:134:3::10]:57686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d14e5-0000GW-3i
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d14e0-0007Of-5p
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d14dz-0007No-TY
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:28:40 -0400
Date: Thu, 20 Apr 2017 13:28:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170420052826.GC26087@pxdev.xzpeter.org>
References: <1492426712-12230-1-git-send-email-peterx@redhat.com>
	<1492426712-12230-8-git-send-email-peterx@redhat.com>
	<1c5c9278-92b1-6f56-b251-53bf60c7f4e8@redhat.com>
	<20170418035033.GH16703@pxdev.xzpeter.org>
	<18bd8627-bdca-b9e8-8d4e-c4aa0689d4aa@redhat.com>
	<20170418042109.GA22226@pxdev.xzpeter.org>
	<a9ec14d0-3c43-a66a-afdb-13f644857004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9ec14d0-3c43-a66a-afdb-13f644857004@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] intel_iommu: support passthrough (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Lan Tianyu <tianyu.lan@intel.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S.Tsirkin" <mst@redhat.com>

On Thu, Apr 20, 2017 at 01:18:28PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B404=E6=9C=8818=E6=97=A5 12:21, Peter Xu wrote:
> >On Tue, Apr 18, 2017 at 12:00:13PM +0800, Jason Wang wrote:
> >>
> >>On 2017=E5=B9=B404=E6=9C=8818=E6=97=A5 11:50, Peter Xu wrote:
> >>>On Tue, Apr 18, 2017 at 11:23:35AM +0800, Jason Wang wrote:
> >>>>On 2017=E5=B9=B404=E6=9C=8817=E6=97=A5 18:58, Peter Xu wrote:
> >>>[...]
> >>>
> >>>>>+static void vtd_switch_address_space(VTDAddressSpace *as)
> >>>>>+{
> >>>>>+    bool use_iommu;
> >>>>>+
> >>>>>+    assert(as);
> >>>>>+
> >>>>>+    use_iommu =3D as->iommu_state->dmar_enabled;
> >>>>>+    if (use_iommu) {
> >>>>>+        /* Further checks per-device configuration */
> >>>>>+        use_iommu &=3D !vtd_dev_pt_enabled(as);
> >>>>>+    }
> >>>>Looks like you can use as->iommu_state->dmar_enabled &&
> >>>>!vtd_dev_pt_enabled(as)
> >>>vtd_dev_pt_enalbed() needs to read the guest memory (starting from
> >>>reading root entry), which is slightly slow. I was trying to avoid
> >>>unecessary reads.
> >>>
> >>>[...]
> >>I think compiler won't go to vtd_dev_pt_enabled() if dmar_enabled is =
false.
> >You are right. I'll switch.
> >
> >>>>>@@ -991,6 +1058,18 @@ static void vtd_do_iommu_translate(VTDAddres=
sSpace *vtd_as, PCIBus *bus,
> >>>>>          cc_entry->context_cache_gen =3D s->context_cache_gen;
> >>>>>      }
> >>>>>+    /*
> >>>>>+     * We don't need to translate for pass-through context entrie=
s.
> >>>>>+     * Also, let's ignore IOTLB caching as well for PT devices.
> >>>>>+     */
> >>>>>+    if (vtd_ce_get_type(&ce) =3D=3D VTD_CONTEXT_TT_PASS_THROUGH) =
{
> >>>>>+        entry->translated_addr =3D entry->iova;
> >>>>>+        entry->addr_mask =3D VTD_PAGE_SIZE - 1;
> >>>>>+        entry->perm =3D IOMMU_RW;
> >>>>>+        trace_vtd_translate_pt(source_id, entry->iova);
> >>>>>+        return;
> >>>>>+    }
> >>>>Several questions here:
> >>>>
> >>>>1) Is this just for vhost?
> >>>No. When caching mode is not enabled, all passthroughed devices shou=
ld
> >>>be using this path.
> >>Ok, then it looks better to switch the address space if we've found i=
t was
> >>PT?
> >Do you mean to switch in that if() above? Then when invalidate context
> >entry, we switch back if needed?
>=20
> Yes.

Sure. Do you mind if I put this into another standalone patch? I see
it an enhancement that can be separated from current one. Thanks,

--=20
Peter Xu
