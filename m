Received: from eggs.gnu.org ([2001:4830:134:3::10]:44691)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cpH20-0005dU-Nk
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 12:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cpH1v-0007pK-PA
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 12:16:40 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:39275 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cpH1v-0007og-Fb
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 12:16:35 -0400
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
	<819af057-3777-dffc-4670-895b8265fd01@kamp.de>
	<d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
	<20170317112446.GH13125@lemon.lan>
	<d60bca20-c76b-696f-06d6-766d2d42ed77@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <1a6e1309-7824-c57f-54ce-be9e9466df10@kamp.de>
Date: Sat, 18 Mar 2017 17:16:30 +0100
MIME-Version: 1.0
In-Reply-To: <d60bca20-c76b-696f-06d6-766d2d42ed77@redhat.com>
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

Am 17.03.2017 um 15:51 schrieb Paolo Bonzini:
>
> On 17/03/2017 12:24, Fam Zheng wrote:
>> On Fri, 03/17 12:16, Paolo Bonzini wrote:
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
>> I think from qemu-img convert's perspective, it doesn't care about the *file
>> status if the metadata already speaks, because, like you said, the data shows up
>> as zeroes.
> That's already the case: *file is only examined if the metadata  says
> BDRV_BLOCK_DATA=1, BDRV_BLOCK_ZERO=0.

Maybe Fam meant in qemu-img this info is not that necessary because it will skip zeroes inside
a datablock anyway. I don't know why the lseek is soo slow, but the optimization could be to identify
the case where this extra info of the *file containing zeroes is really useful and then only call out for
it in those cases.

Peter

>
> Paolo
