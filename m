Received: from eggs.gnu.org ([2001:4830:134:3::10]:33226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT2E6-00062U-0Q
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT2E2-0007BD-6k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:01:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cT2E2-0007B5-1k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:01:10 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-14-git-send-email-peterx@redhat.com>
	<7a8c721d-8a12-9727-feae-58103942fd55@redhat.com>
	<20170116075043.GE30108@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ae7765c7-7101-357e-3e7f-8ca94d8ad5b5@redhat.com>
Date: Mon, 16 Jan 2017 16:01:00 +0800
MIME-Version: 1.0
In-Reply-To: <20170116075043.GE30108@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 13/14] intel_iommu: allow dynamic
 switch of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com



On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 15:50, Peter Xu wrote:
> On Mon, Jan 16, 2017 at 02:20:31PM +0800, Jason Wang wrote:
>
> [...]
>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index fd75112..2596f11 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -1343,9 +1343,49 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUSt=
ate *s)
>>>       vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
>>>   }
>>> +static void vtd_switch_address_space(VTDAddressSpace *as, bool iommu=
_enabled)
>> Looks like you can check s->dmar_enabled here?
> Yes, we need to check old state in case we don't need a switch at all.
> Actually I checked it...
>

I mean is there a chance that iommu_enabled( better name should be=20
dmar_enabled) is not equal to s->dmar_enabled? Looks not.

vtd_handle_gcmd_te() did:

     ...
     if (en) {
         s->dmar_enabled =3D true;
         /* Ok - report back to driver */
         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_TES);
     } else {
         s->dmar_enabled =3D false;
     ...

You can vtd_switch_address_space_all(s, en) after this which will call=20
this function. And another caller like you've pointed out has already=20
call this through s->dmar_enabled. So en here is always s->dmar_enalbed?

Thanks
