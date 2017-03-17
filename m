Received: from eggs.gnu.org ([2001:4830:134:3::10]:46713)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1copvm-0006y6-2t
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1copvi-0005r4-Uj
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:20:26 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:42575 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1copvi-0005qV-KU
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:20:22 -0400
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
	<819af057-3777-dffc-4670-895b8265fd01@kamp.de>
	<d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <32e1e781-f0b0-ac67-a5ce-74ccc64071a0@kamp.de>
Date: Fri, 17 Mar 2017 12:20:18 +0100
MIME-Version: 1.0
In-Reply-To: <d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>

Am 17.03.2017 um 12:16 schrieb Paolo Bonzini:
>
> On 17/03/2017 12:11, Peter Lieven wrote:
>>>> like VMDK or QCOW2 shouldn't we trust the information from the l2 tables in the VMDK or QCOW2?
>>> It provides additional information, for example it works better with
>>> prealloc=metadata.
>> Okay, understood. Can you imagine of a away to conditionally avoid this second callout? In my case we have an additional
>> lseek for each cluster. For a 20GB file this are approx. 327k calls to lseek. And if the file has no preallocated metadata
>> it will likely not improve anything. And even if the metadata is prealloced what is the allocation status of the clusters?
> If the metadata is preallocated, cluster will (or should) show up as
> zero, speeding up the copy.

Okay, in this case the second call out to *file will not happen. It only happens if the metadata says it contains data.
So where does it actually help?

The condition is: (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) && (ret & BDRV_BLOCK_OFFSET_VALID))

So from my view it can only have any effect if the metadata returns BDRV_BLOCK_DATA, but the protocol driver returns
BDRV_BLOCK_ZERO.

This can only happen if I partially write to a cluster, or am I wrong here?

Peter
