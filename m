Received: from eggs.gnu.org ([2001:4830:134:3::10]:44733)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1copnX-0003ev-Hg
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1copnU-0001gB-Sb
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:11:55 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:40606 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1copnU-0001fL-JU
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:11:52 -0400
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <819af057-3777-dffc-4670-895b8265fd01@kamp.de>
Date: Fri, 17 Mar 2017 12:11:49 +0100
MIME-Version: 1.0
In-Reply-To: <82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
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

Am 17.03.2017 um 11:59 schrieb Paolo Bonzini:
>
> On 17/03/2017 11:45, Peter Lieven wrote:
>> Hi,
>>
>>
>> I tried to debug why qemu-img convert with a VMDK source laying on a tmpfs is horrible slow.
>>
>> For some reason a lseek on a tmpfs is slow. Strictly speaking the lseek in find_allocation in file-posix.c
>>
>> is slow.
>>
>>
>> When qemu-img convert iterates over all sectors of a VMDK file to check their allocation status it ends
>>
>> up checking allocation status of all allocated sectors due to the following condition in bdrv_co_get_block_status:
>>
>>
>>     if (*file && *file != bs &&
>>         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
>>         (ret & BDRV_BLOCK_OFFSET_VALID)) {
>>         BlockDriverState *file2;
>>         int file_pnum;
>>         ret2 = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
>>                                         *pnum, &file_pnum, &file2);
>>         if (ret2 >= 0) {
>>             /* Ignore errors.  This is just providing extra information, it
>>              * is useful but not necessary.
>>              */
>>             if (!file_pnum) {
>>                 /* !file_pnum indicates an offset at or beyond the EOF; it is
>>                  * perfectly valid for the format block driver to point to such
>>                  * offsets, so catch it and mark everything as zero */
>>                 ret |= BDRV_BLOCK_ZERO;
>>             } else {
>>                 /* Limit request to the range reported by the protocol driver */
>>                 *pnum = file_pnum;
>>                 ret |= (ret2 & BDRV_BLOCK_ZERO);
>>             }
>>         }
>>     }
>>
>>
>> Does anybody remember for what circumstances this case this was added? In case of an container format
>>
>> like VMDK or QCOW2 shouldn't we trust the information from the l2 tables in the VMDK or QCOW2?
> It provides additional information, for example it works better with
> prealloc=metadata.

Okay, understood. Can you imagine of a away to conditionally avoid this second callout? In my case we have an additional
lseek for each cluster. For a 20GB file this are approx. 327k calls to lseek. And if the file has no preallocated metadata
it will likely not improve anything. And even if the metadata is prealloced what is the allocation status of the clusters?

Peter
