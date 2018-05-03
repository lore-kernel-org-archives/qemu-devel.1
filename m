Received: from eggs.gnu.org ([2001:4830:134:3::10]:56090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fEARS-00032Z-9J
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fEARO-0006EN-AV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:22:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fEARO-0006E8-46
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:22:18 -0400
References: <AADFC41AFE54684AB9EE6CBC0274A5D19113B5D2@SHSMSX101.ccr.corp.intel.com>
	<20180427072810.GB13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
	<20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
	<20180503060442.GB2378@xz-mi>
	<547a97a1-0ac0-21b2-af00-036b795b06cc@redhat.com>
	<20180503072828.GA29580@xz-mi>
	<8cbed1d0-1f4e-db6d-bd83-1042f724827a@redhat.com>
	<20180503075302.GC29580@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f933ba4d-a025-7c94-69c6-d21f408eb729@redhat.com>
Date: Thu, 3 May 2018 17:22:03 +0800
MIME-Version: 1.0
In-Reply-To: <20180503075302.GC29580@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, "Tian, Kevin" <kevin.tian@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>



On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:53, Peter Xu wrote:
> On Thu, May 03, 2018 at 03:43:35PM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:28, Peter Xu wrote:
>>> On Thu, May 03, 2018 at 03:20:11PM +0800, Jason Wang wrote:
>>>> On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 14:04, Peter Xu wrote:
>>>>> IMHO the guest can't really detect this, but it'll found that the
>>>>> device is not working functionally if it's doing something like wha=
t
>>>>> Jason has mentioned.
>>>>>
>>>>> Actually now I have had an idea if we really want to live well even
>>>>> with Jason's example: maybe we'll need to identify PSI/DSI.  For DS=
I,
>>>>> we don't remap for mapped pages; for PSI, we unmap and remap the
>>>>> mapped pages.  That'll complicate the stuff a bit, but it should
>>>>> satisfy all the people.
>>>>>
>>>>> Thanks,
>>>> So it looks like there will be still unnecessary unamps.
>>> Could I ask what do you mean by "unecessary unmaps"?
>> It's for "for PSI, we unmap and remap the mapped pages". So for the fi=
rst
>> "unmap" how do you know it was really necessary without knowing the st=
ate of
>> current shadow page table?
> I don't.  Could I just unmap it anyway?  Say, now the guest _modified_
> the PTE already.  Yes I think it's following the spec, but it is
> really _unsafe_.  We can know that from what it has done already.
> Then I really think a unmap+map would be good enough for us...  After
> all that behavior can cause DMA error even on real hardwares.  It can
> never tell.

I mean for following case:

1) guest maps A1 (iova) to XXX
2) guest maps A2 (A1 + 4K) (iova) to YYY
3) guest maps A3 (A1 + 8K) (iova) to ZZZ
4) guest unmaps A2 and A2, for reducing the number of PSIs, it can=20
invalidate A1 with a range of 2M

If this is allowed by spec, looks like A1 will be unmaped and mapped.

Thanks

>
>>>> How about record the mappings in the tree too?
>>> As I mentioned, for L1 guest (e.g., DPDK applications running in L1)
>>> it'll be fine.  But I'm just afraid we will have other use cases, lik=
e
>>> the L2 guests. That might need tons of the mapping entries in the
>>> worst case scenario.
>>>
>> Yes, but that's the price of shadow page tables.
> So that's why I would like to propose this mergable interval tree.  It
> might greatly reduce the price if we can reach a consensus on how we
> should treat those strange-behaved guest OSs.  Thanks,
>
