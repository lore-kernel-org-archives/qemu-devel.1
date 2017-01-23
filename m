Received: from eggs.gnu.org ([2001:4830:134:3::10]:54170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVV3g-0006Tk-AY
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVV3c-0000ZH-Bv
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:12:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVV3c-0000ZC-3Y
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:12:36 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
	<c7265d9c-54e9-f4a2-003d-85c4416c1651@redhat.com>
	<20170123025449.GE26526@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fcdd4b74-9ad0-d9d4-31f4-3129d4a11233@redhat.com>
Date: Mon, 23 Jan 2017 11:12:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170123025449.GE26526@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 15/20] intel_iommu: provide its own
 replay() callback
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



On 2017=E5=B9=B401=E6=9C=8823=E6=97=A5 10:54, Peter Xu wrote:
>>>>> +            trace_vtd_page_walk_skip_read(iova, iova_next);
>>>>> +            skipped_local++;
>>>>> +            goto next;
>>>>> +        }
>>>>> +
>>>>> +        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
>>>>> +            trace_vtd_page_walk_skip_reserve(iova, iova_next);
>>>>> +            skipped_local++;
>>>>> +            goto next;
>>>>> +        }
>>>>> +
>>>>> +        /* Permissions are stacked with parents' */
>>>>> +        read_cur =3D read && (slpte & VTD_SL_R);
>>>>> +        write_cur =3D write && (slpte & VTD_SL_W);
>>>>> +
>>>>> +        /*
>>>>> +         * As long as we have either read/write permission, this i=
s
>>>>> +         * a valid entry. The rule works for both page or page tab=
les.
>>>>> +         */
>>>>> +        entry_valid =3D read_cur | write_cur;
>>>>> +
>>>>> +        if (vtd_is_last_slpte(slpte, level)) {
>>>>> +            entry.target_as =3D &address_space_memory;
>>>>> +            entry.iova =3D iova & subpage_mask;
>>>>> +            /*
>>>>> +             * This might be meaningless addr if (!read_cur &&
>>>>> +             * !write_cur), but after all this field will be
>>>>> +             * meaningless in that case, so let's share the code t=
o
>>>>> +             * generate the IOTLBs no matter it's an MAP or UNMAP
>>>>> +             */
>>>>> +            entry.translated_addr =3D vtd_get_slpte_addr(slpte);
>>>>> +            entry.addr_mask =3D ~subpage_mask;
>>>>> +            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
>>>>> +            if (!entry_valid && !notify_unmap) {
>>>>> +                trace_vtd_page_walk_skip_perm(iova, iova_next);
>>>>> +                skipped_local++;
>>>>> +                goto next;
>>>>> +            }
>>>> Under which case should we care about unmap here (better with a comm=
ent I
>>>> think)?
>>> When PSIs are for invalidation, rather than newly mapped entries. In
>>> that case, notify_unmap will be true, and here we need to notify
>>> IOMMU_NONE to do the cache flush or unmap.
>>>
>>> (this page walk is not only for replaying, it is for cache flushing a=
s
>>>   well)
>>>
>>> Do you have suggestion on the comments?
>> I think then we'd better move this to patch 18 which will use notify_u=
nmap.
> Do you mean to add some more comment on patch 18?
>

I mean move the unmap_nofity and its comment to patch 18 (real user).=20
But if you want to keep it in the patch, I'm also fine.

Thanks
