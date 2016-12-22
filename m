Received: from eggs.gnu.org ([2001:4830:134:3::10]:40175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cK1Ad-0003fs-VG
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cK1Aa-00054W-J3
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:04:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cK1Aa-00054C-Cl
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:04:20 -0500
Date: Thu, 22 Dec 2016 19:04:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161222110412.GB26435@pxdev.xzpeter.org>
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
	<b2b1424c-1bd0-00ea-8d14-f935b8901629@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2b1424c-1bd0-00ea-8d14-f935b8901629@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: allow dynamic switch of
 IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

On Thu, Dec 22, 2016 at 05:52:58PM +0800, Jason Wang wrote:
>=20
>=20
> On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 17:48, Peter Xu wrote:
> >  /* Handle Translation Enable/Disable */
> >  static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >  {
> >+    if (s->dmar_enabled =3D=3D en) {
> >+        return;
> >+    }
> >+
> >      VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
> >      if (en) {
> >@@ -1196,6 +1237,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *=
s, bool en)
> >          /* Ok - report back to driver */
> >          vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
> >      }
> >+
> >+    vtd_switch_address_space_all(s, en);
> >  }
>=20
> We may need something like notifier here to tell e.g vhost to stop devi=
ce
> IOTLB. (Since it's likely this series were applied after device IOTLB
> patches)

Yes, I missed vhost case.

To notify vhost, IMO we should be able to use memory listeners just
like how vfio devices do (please refer to vfio_memory_listener).
However, I think the bigger issue is we still don't have a dynamic way
to turn vhost DMAR on/off, right?

If so, we may need to re-touch all the parts to enable the dynamic
switching of DMA remapping - QEMU vhost, kernel vhost, and virtio on
the guest side... I start to doubt whether that effort will worth it
due to this single change, especially if this feature (dynamic on/off
DMA remapping) won't be used by most VMs (i.e., Linux should only turn
VT-d on when kernel detects it, and should never turn it off in
anyway).

(However I do think this is an improvement to current VT-d though)

Thanks,

-- peterx
