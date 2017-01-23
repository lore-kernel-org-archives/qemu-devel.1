Received: from eggs.gnu.org ([2001:4830:134:3::10]:46060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVbsb-0002Ot-GO
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVbsa-0006O3-8d
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:29:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVbsa-0006NR-33
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:29:40 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-20-git-send-email-peterx@redhat.com>
	<e1b09efe-0201-a746-9aa9-62f798a222f9@redhat.com>
	<20170122090958.GC26526@pxdev.xzpeter.org>
	<33026fc1-3649-0d33-2bf1-6260daedfe03@redhat.com>
	<20170123073020.GI26526@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9900f41e-8ac7-2567-353f-371d41364263@redhat.com>
Date: Mon, 23 Jan 2017 18:29:32 +0800
MIME-Version: 1.0
In-Reply-To: <20170123073020.GI26526@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8823=E6=97=A5 15:30, Peter Xu wrote:
> On Mon, Jan 23, 2017 at 09:57:23AM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 17:09, Peter Xu wrote:
>>> On Sun, Jan 22, 2017 at 04:13:32PM +0800, Jason Wang wrote:
>>>> On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
>>>>> Previous replay works for domain switch only if the original domain=
 does
>>>>> not have mapped pages. For example, if we switch domain from A to B=
, it
>>>>> will only work if A has no existing mapping. If there is, then ther=
e's
>>>>> problem - current replay didn't make sure the old mappings are clea=
red
>>>>> before replaying the new one.
>>>> I'm not quite sure this is needed. I thought the only thing we need =
to do is
>>>> stop DMA of device during the moving? Or is there an example that wi=
ll cause
>>>> trouble?
>>> I think this patch is essential.
>>>
>>> Example:
>>>
>>> - device D1 moved to domain A, domain A has no mapping
>>> - map page P1 in domain A, so D1 will have a mapping of page P1
>>> - create domain B with mapping P2
>>> - move D1 from domain A to domain B
>>>
>>> Here if we don't unmap existing pages in domain A (P1),
>> I thought driver should do this work instead of device, because only d=
river
>> knows whether or not iova is still needed?
> Do you mean "device driver" above?
>
> I don't know whether I understood the question above, but the problem
> should be there no matter which one is managing iova?
>
> Thanks,
>
> -- peterx

Yes, I misread the code, this is in fact triggered by guest.

Thanks
