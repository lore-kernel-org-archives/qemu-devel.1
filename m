Received: from eggs.gnu.org ([2001:4830:134:3::10]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpvNd-0005xt-IE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpvNc-0001b7-PH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:21:41 -0400
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
	<819af057-3777-dffc-4670-895b8265fd01@kamp.de>
	<d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
	<32e1e781-f0b0-ac67-a5ce-74ccc64071a0@kamp.de>
	<20170320024649.GA18938@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37879546-cf6e-01fa-adc6-c777e14eab0e@redhat.com>
Date: Mon, 20 Mar 2017 12:21:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170320024649.GA18938@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] callout to *file in bdrv_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 20/03/2017 03:46, Fam Zheng wrote:
> On Fri, 03/17 12:20, Peter Lieven wrote:
>> Am 17.03.2017 um 12:16 schrieb Paolo Bonzini:
>>>
>>> On 17/03/2017 12:11, Peter Lieven wrote:
>>>>>> like VMDK or QCOW2 shouldn't we trust the information from the l2 tables in the VMDK or QCOW2?
>>>>> It provides additional information, for example it works better with
>>>>> prealloc=metadata.
>>>> Okay, understood. Can you imagine of a away to conditionally avoid this second callout? In my case we have an additional
>>>> lseek for each cluster. For a 20GB file this are approx. 327k calls to lseek. And if the file has no preallocated metadata
>>>> it will likely not improve anything. And even if the metadata is prealloced what is the allocation status of the clusters?
>>> If the metadata is preallocated, cluster will (or should) show up as
>>> zero, speeding up the copy.
>>
>> Okay, in this case the second call out to *file will not happen. It only happens if the metadata says it contains data.
>> So where does it actually help?
>>
>> The condition is: (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) && (ret & BDRV_BLOCK_OFFSET_VALID))
>>
>> So from my view it can only have any effect if the metadata returns BDRV_BLOCK_DATA, but the protocol driver returns
>> BDRV_BLOCK_ZERO.
>>
>> This can only happen if I partially write to a cluster, or am I wrong here?
> 
> I think you have a point. The metadata should have said BDRV_BLOCK_ZERO if
> protocol would say BDRV_BLOCK_ZERO - there is no reason the format driver cannot
> know.

That's true of qcow2, but many formats (including raw :)) don't know
about BDRV_BLOCK_ZERO.

Paolo
