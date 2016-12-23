Received: from eggs.gnu.org ([2001:4830:134:3::10]:54661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cKGUo-0003w0-72
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 22:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cKGUl-0006su-2V
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 22:26:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cKGUk-0006sU-Pp
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 22:26:10 -0500
Date: Fri, 23 Dec 2016 11:26:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161223032601.GC26435@pxdev.xzpeter.org>
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
	<b2b1424c-1bd0-00ea-8d14-f935b8901629@redhat.com>
	<20161222110412.GB26435@pxdev.xzpeter.org>
	<6798718b-3949-032f-0e5f-fa6b2e2d83fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6798718b-3949-032f-0e5f-fa6b2e2d83fb@redhat.com>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, david@gibson.dropbear.id.au

On Thu, Dec 22, 2016 at 07:34:10PM +0800, Jason Wang wrote:
>=20
>=20
> On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 19:04, Peter Xu wrote:
> >On Thu, Dec 22, 2016 at 05:52:58PM +0800, Jason Wang wrote:
> >>
> >>On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 17:48, Peter Xu wrote:
> >>>  /* Handle Translation Enable/Disable */
> >>>  static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >>>  {
> >>>+    if (s->dmar_enabled =3D=3D en) {
> >>>+        return;
> >>>+    }
> >>>+
> >>>      VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"))=
;
> >>>      if (en) {
> >>>@@ -1196,6 +1237,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState=
 *s, bool en)
> >>>          /* Ok - report back to driver */
> >>>          vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0)=
;
> >>>      }
> >>>+
> >>>+    vtd_switch_address_space_all(s, en);
> >>>  }
> >>We may need something like notifier here to tell e.g vhost to stop de=
vice
> >>IOTLB. (Since it's likely this series were applied after device IOTLB
> >>patches)
> >Yes, I missed vhost case.
> >
> >To notify vhost, IMO we should be able to use memory listeners just
> >like how vfio devices do (please refer to vfio_memory_listener).
>=20
> Just for switching? This seems an overkill since we don't depends on it=
 for
> all other things. Guest should setup correct mappings by explicitly not=
ify
> device IOTLB. A quick glance at ATS spec, for enabling and disabling, l=
ooks
> like it was done through enable bit of ASTctl instead of here.
>=20
> So we are probably ok here :)

So we need a more general way to notify ATS about this, right? (e.g.,
for future devices that support ATS as well, not only vhost)

>=20
> >However, I think the bigger issue is we still don't have a dynamic way
> >to turn vhost DMAR on/off, right?
>=20
> The API was ready for this, just issue another set_feature ioctl withou=
t
> IOMMU_PLATFORM. (But unfortunately, vhost need a small patch to make th=
is
> work).

That'll be nice. :)

>=20
> >
> >If so, we may need to re-touch all the parts to enable the dynamic
> >switching of DMA remapping - QEMU vhost, kernel vhost, and virtio on
> >the guest side... I start to doubt whether that effort will worth it
> >due to this single change, especially if this feature (dynamic on/off
> >DMA remapping) won't be used by most VMs (i.e., Linux should only turn
> >VT-d on when kernel detects it, and should never turn it off in
> >anyway).
>=20
> For vhost part, the changes should be very minor, probably just:
>=20
> - a patch to make sure vhost can disable device IOTLB during feature se=
t
> - properly handling enabling bit of ATSctl in qemu (probably through an
> notifier)

Do you think I should provide another patch for the domain switch
notification (along with this one)? Or I can just postpone this patch
until DMAR series merged (after all this patch is not an urgent one).

>=20
> >
> >(However I do think this is an improvement to current VT-d though)
> >
> >Thanks,
> >
> >-- peterx
> >
>=20
> +1. We should try to emulate exactly what hardware does to avoid breaki=
ng
> all kinds of guest or userspace drivers.

Yes. Thanks,

-- peterx
