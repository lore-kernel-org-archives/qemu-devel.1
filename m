Received: from eggs.gnu.org ([2001:4830:134:3::10]:45721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNg9w-00020q-7f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNg9q-0006sS-GH
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:03:36 -0400
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-3-eblake@redhat.com>
	<20180528105232.GD4580@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1ae14fa-6305-603e-02ab-e8565095f5e3@redhat.com>
Date: Tue, 29 May 2018 10:03:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180528105232.GD4580@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] qcow: Switch get_cluster_offset to be
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:qcow" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 05/28/2018 05:52 AM, Kevin Wolf wrote:
> Am 25.04.2018 um 20:32 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Make the change for the internal helper function
>> get_cluster_offset(), by changing n_start and n_end to by byte
>> offsets rather than sector indices within the cluster being
>> allocated.
>>
>> A later patch will then switch the qcow driver as a whole over
>> to byte-based operation.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/qcow.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>

>> +                    for (i = 0; i < s->cluster_size; i += BDRV_SECTOR_SIZE) {
>>                           if (i < n_start || i >= n_end) {
>> -                            memset(s->cluster_data, 0x00, 512);
>> +                            memset(s->cluster_data, 0x00, BDRV_SECTOR_SIZE);
>>                               if (qcrypto_block_encrypt(s->crypto,
>> -                                                      (start_sect + i) *
>> -                                                      BDRV_SECTOR_SIZE,
>> +                                                      start_offset + i,
>>                                                         s->cluster_data,
>>                                                         BDRV_SECTOR_SIZE,
>>                                                         NULL) < 0) {
> 
> This code is still working in blocks of BDRV_SECTOR_SIZE here - which
> you do need to keep at least partially because that's the block size
> that qcrypto_block_encrypt() works with. qcrypto_block_qcow_encrypt()
> even asserts it.
> 
> However, this means that even though n_start and n_end are byte-based
> now, the code only works correctly with encrypted images if they are
> multiples of BDRV_SECTOR_SIZE. This is currently true and we could
> assert it, but it would kind of defeat the purpose of the patch.

But in patch 5, I intentionally kept bs->bl.request_alignment at 512, so 
I'd rather just assert that n_start and n_end are properly aligned than 
to worry about rounding issues.

> 
> I suppose you could make unaligned n_start/n_end work if you round down
> n_start and round up n_end to the next sector boundary for the
> comparison with i. For unaligned requests, we would then write a bit
> more than is actually necessary, but I think that's okay because we're
> initialising a previously unallocated cluster, so we don't overwrite
> valid data.

The point is that we never have unaligned requests to qcow1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
