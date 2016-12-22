Received: from eggs.gnu.org ([2001:4830:134:3::10]:54582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cK03h-0005ac-CM
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cK03e-00051T-BX
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:53:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cK03e-000511-5O
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:53:06 -0500
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b2b1424c-1bd0-00ea-8d14-f935b8901629@redhat.com>
Date: Thu, 22 Dec 2016 17:52:58 +0800
MIME-Version: 1.0
In-Reply-To: <1482400096-23078-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au



On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 17:48, Peter Xu wrote:
>   /* Handle Translation Enable/Disable */
>   static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>   {
> +    if (s->dmar_enabled =3D=3D en) {
> +        return;
> +    }
> +
>       VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
>  =20
>       if (en) {
> @@ -1196,6 +1237,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s=
, bool en)
>           /* Ok - report back to driver */
>           vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
>       }
> +
> +    vtd_switch_address_space_all(s, en);
>   }

We may need something like notifier here to tell e.g vhost to stop=20
device IOTLB. (Since it's likely this series were applied after device=20
IOTLB patches)
