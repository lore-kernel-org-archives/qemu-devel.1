Received: from eggs.gnu.org ([2001:4830:134:3::10]:56858)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cpxT8-0008QW-2K
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cpxT3-0002th-0P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:35:30 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47551 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cpxT2-0002tG-Nh
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:35:24 -0400
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
	<819af057-3777-dffc-4670-895b8265fd01@kamp.de>
	<d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
	<32e1e781-f0b0-ac67-a5ce-74ccc64071a0@kamp.de>
	<20170320024649.GA18938@lemon.lan>
	<37879546-cf6e-01fa-adc6-c777e14eab0e@redhat.com>
	<20170320114926.GB17020@lemon.lan>
	<b3bf1d26-7caa-1d0d-c8a1-02f4c80e51e4@kamp.de>
	<fc755658-8d1d-db71-1f4d-2e18f5c3c4b2@kamp.de>
	<ff4b36e6-cf69-5b32-77b7-285adf4aaca0@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <4aa3e0fc-1176-af7d-bef9-2b881a984605@kamp.de>
Date: Mon, 20 Mar 2017 14:35:22 +0100
MIME-Version: 1.0
In-Reply-To: <ff4b36e6-cf69-5b32-77b7-285adf4aaca0@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Am 20.03.2017 um 14:23 schrieb Paolo Bonzini:
>
> On 20/03/2017 14:13, Peter Lieven wrote:
>> Am 20.03.2017 um 13:47 schrieb Peter Lieven:
>>> Am 20.03.2017 um 12:49 schrieb Fam Zheng:
>>>> On Mon, 03/20 12:21, Paolo Bonzini wrote:
>>>>> On 20/03/2017 03:46, Fam Zheng wrote:
>>>>>> On Fri, 03/17 12:20, Peter Lieven wrote:
>>>>>>> Am 17.03.2017 um 12:16 schrieb Paolo Bonzini:
>>>>>>>> On 17/03/2017 12:11, Peter Lieven wrote:
>>>>>>>>>>> like VMDK or QCOW2 shouldn't we trust the information from the l2 tables in the VMDK or QCOW2?
>>>>>>>>>> It provides additional information, for example it works better with
>>>>>>>>>> prealloc=metadata.
>>>>>>>>> Okay, understood. Can you imagine of a away to conditionally avoid this second callout? In my case we have an additional
>>>>>>>>> lseek for each cluster. For a 20GB file this are approx. 327k calls to lseek. And if the file has no preallocated metadata
>>>>>>>>> it will likely not improve anything. And even if the metadata is prealloced what is the allocation status of the clusters?
>>>>>>>> If the metadata is preallocated, cluster will (or should) show up as
>>>>>>>> zero, speeding up the copy.
>>>>>>> Okay, in this case the second call out to *file will not happen. It only happens if the metadata says it contains data.
>>>>>>> So where does it actually help?
>>>>>>>
>>>>>>> The condition is: (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) && (ret & BDRV_BLOCK_OFFSET_VALID))
>>>>>>>
>>>>>>> So from my view it can only have any effect if the metadata returns BDRV_BLOCK_DATA, but the protocol driver returns
>>>>>>> BDRV_BLOCK_ZERO.
>>>>>>>
>>>>>>> This can only happen if I partially write to a cluster, or am I wrong here?
>>>>>> I think you have a point. The metadata should have said BDRV_BLOCK_ZERO if
>>>>>> protocol would say BDRV_BLOCK_ZERO - there is no reason the format driver cannot
>>>>>> know.
>>>>> That's true of qcow2, but many formats (including raw :)) don't know
>>>>> about BDRV_BLOCK_ZERO.
>>>> Raw is a little special, it could have forwarded the call to *file in its
>>>> BlockDriver callback. Most formats with metadata stores zero/nonzero information
>>>> in L1/L2 tables. For qcow2 and VMDK I think it's okay to just trust meta data on
>>>> zero/nonzero.
>>>>
>>>> Fam
>>> BTW, the extra check was added in
>>>
>>>
>>> commit 5daa74a6ebce7543aaad178c4061dc087bb4c705
>>> Author: Paolo Bonzini <pbonzini@redhat.com>
>>> Date:   Wed Sep 4 19:00:38 2013 +0200
>>>
>>>     block: look for zero blocks in bs->file
>>>    
>>>     Reviewed-by: Eric Blake <eblake@redhat.com>
>>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>>
>>> It was introduced while introducing bdv_get_block_status. I don't know what the real
>>>
>>> issue was that was addressed with this patch?
>> Is it possible that this optimization was added especially for RAW? I was believing that
>> raw would forward the get_block_status call to bs->file, but it looks it doesn't.
>> If this one here was for RAW would it be an option to move this callout to the raw-format driver
>> and remove it from the generic code?
> It was meant for both raw and qcow2.

Okay, but as Fam mentioned qcow2 Metadata should know that a cluster is zero. Do you remember
what the issue was?

Peter
