Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVTrL-0002lX-VC
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVTrH-0000DC-4Z
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:55:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVTrG-0000Cy-VW
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:55:47 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
	<490bbb84-213b-1b2a-5a1b-fa42a5c6a359@redhat.com>
	<20170122090425.GB26526@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1dd223d1-dc02-bddc-02ea-78d267dd40a4@redhat.com>
Date: Mon, 23 Jan 2017 09:55:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170122090425.GB26526@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 18/20] intel_iommu: enable vfio
 devices
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



On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 17:04, Peter Xu wrote:
> On Sun, Jan 22, 2017 at 04:08:04PM +0800, Jason Wang wrote:
>
> [...]
>
>>> +static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>>> +                                           uint16_t domain_id, hwadd=
r addr,
>>> +                                           uint8_t am)
>>> +{
>>> +    IntelIOMMUNotifierNode *node;
>>> +    VTDContextEntry ce;
>>> +    int ret;
>>> +
>>> +    QLIST_FOREACH(node, &(s->notifiers_list), next) {
>>> +        VTDAddressSpace *vtd_as =3D node->vtd_as;
>>> +        ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus)=
,
>>> +                                       vtd_as->devfn, &ce);
>>> +        if (!ret && domain_id =3D=3D VTD_CONTEXT_ENTRY_DID(ce.hi)) {
>>> +            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZ=
E,
>>> +                          vtd_page_invalidate_notify_hook,
>>> +                          (void *)&vtd_as->iommu, true);
>> Why not simply trigger the notifier here? (or is this vfio required?)
> Because we may only want to notify part of the region - we are with
> mask here, but not exact size.
>
> Consider this: guest (with caching mode) maps 12K memory (4K*3 pages),
> the mask will be extended to 16K in the guest. In that case, we need
> to explicitly go over the page entry to know that the 4th page should
> not be notified.

I see. Then it was required by vfio only, I think we can add a fast path=20
for !CM in this case by triggering the notifier directly.

Another possible issue is, consider (with CM) a 16K contiguous iova with=20
the last page has already been mapped. In this case, if we want to map=20
first three pages, when handling IOTLB invalidation, am would be 16K,=20
then the last page will be mapped twice. Can this lead some issue?

Thanks
