Received: from eggs.gnu.org ([2001:4830:134:3::10]:36624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT2ZX-0001XU-7S
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:23:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT2ZS-0003ok-BB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:23:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cT2ZS-0003ob-2c
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:23:18 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-12-git-send-email-peterx@redhat.com>
	<c5b536a1-1f7b-965d-04b6-4f6bde19733f@redhat.com>
	<20170116073116.GC30108@pxdev.xzpeter.org>
	<97339915-c8fb-cfd5-aa06-b795eab21428@redhat.com>
	<20170116075947.GF30108@pxdev.xzpeter.org>
	<c86d9658-ca21-dc63-3a99-5d86472f2dc0@redhat.com>
	<20170116080647.GH30108@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bfd13dce-9c70-e2a2-404e-ddc28da39cbf@redhat.com>
Date: Mon, 16 Jan 2017 16:23:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170116080647.GH30108@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 11/14] intel_iommu: provide its own
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
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 16:06, Peter Xu wrote:
> On Mon, Jan 16, 2017 at 04:03:22PM +0800, Jason Wang wrote:
>
> [...]
>
>>>>> Though I haven't tested with huge pages yet, but this patch should
>>>>> both solve above issue? I don't know whether you went over the page
>>>>> walk logic - it should both support huge page, and it will skip
>>>>> unmapped iova range (at least that's my goal to have this patch). I=
n
>>>>> that case, looks like this patch is solving the same problem? :)
>>>>> (though without introducing iova_iterate() interface)
>>>>>
>>>>> Please correct me if I misunderstood it.
>>>> Kind of :) I'm fine with this patch, but just want:
>>>>
>>>> - reuse most of the codes in the patch
>>>> - current memory_region_iommu_replay() logic
>>>>
>>>> So what I'm suggesting is a just slight change of API which can let =
caller
>>>> decide it need to do with each range of iova. So it could be reused =
for
>>>> other things except for replaying.
>>>>
>>>> But if you like to keep this patch as is, I don't object it.
>>> I see. Then I can understand your mean here. I had the same thought
>>> before, that's why I exposed the vtd_page_walk with a hook. If you
>>> check the page_walk function comment:
>>>
>>> /**
>>>   * vtd_page_walk - walk specific IOVA range, and call the hook
>>>   *
>>>   * @ce: context entry to walk upon
>>>   * @start: IOVA address to start the walk
>>>   * @end: IOVA range end address (start <=3D addr < end)
>>>   * @hook_fn: the hook that to be called for each detected area
>>>   * @private: private data for the hook function
>>>   */
>>>
>>> So I didn't implement the notification in page_walk at all - but in
>>> the hook_fn. If any caller that is interested in doing something else
>>> rather than the notification, we can just simply export the page walk
>>> interface and provide his/her own "hook_fn", then it'll be triggered
>>> for each valid page (no matter a huge/small one).
>>>
>>> If we can have a more general interface in the future - no matter
>>> whether we call it iova_iterate() or something else (I'll prefer the
>>> hooker way to do it, so maybe a common page walker with a hook
>>> function), we can do it simply (at least for Intel platform) based on
>>> this vtd_page_walk thing.
>>>
>>> Thanks,
>>>
>>> -- peterx
>> Yes but the problem is hook_fn is only visible inside intel iommu code=
.
> Right.
>
> Btw, do we have existing issue that can leverage this interface
> besides replay?
>
> -- peterx

Seems not, so I'm fine with current code, just want to show the=20
possibility for it to be reused in the future.

Thanks
