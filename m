Received: from eggs.gnu.org ([2001:4830:134:3::10]:53632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1frh2N-0005dd-Eb
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1frh1L-00077J-6f
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:02:48 -0400
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
	<63b51f2b-0521-411f-8129-cba35d0cfcea@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <e89ac78b-d1c9-4b00-ecc5-2f5a9a7618b0@virtuozzo.com>
Date: Mon, 20 Aug 2018 13:02:35 +0300
MIME-Version: 1.0
In-Reply-To: <63b51f2b-0521-411f-8129-cba35d0cfcea@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com, den@virtuozzo.com



On 17/8/2018 8:27 PM, Paolo Bonzini wrote:
> On 20/11/2017 17:50, Anton Nefedov wrote:
>> qmp query-blockstats provides stats info for write/read/flush ops.
>>
>> Patches 1-5 implement the similar for discard (unmap) command for scsi
>> and ide disks.
>> Discard stat "unmap_ops / unmap_bytes" is supposed to account the ops that
>> have completed without an error.
>>
>> However, discard operation is advisory. Specifically,
>>   - common block layer ignores ENOTSUP error code.
>>     That might be returned if the block driver does not support discard,
>>     or discard has been configured to be ignored.
>>   - format drivers such as qcow2 may ignore discard if they were configured
>>     to ignore that, or if the corresponding area is already marked unused
>>     (unallocated / zero clusters).
>>
>> And what is actually useful is the number of bytes actually discarded
>> down on the host filesystem.
>> To achieve that, driver-specific statistics has been added to blockstats
>> (patch 7).
>> With patch 6, file-posix driver accounts discard operations on its level too.
>>
>> query-blockstat result:
>>
>> (note the difference between blockdevice unmap and file discard stats. qcow2
>> sends a few ops down to the file as the clusters are actually unallocated
>> on qcow2 level)
>>
>> {"return": [
>> {"device": "drive-scsi0-0-0-0"
>>    "parent": {
>>      "stats": {
>>>       "unmap_operations": 0
>>>       "unmap_merged": 0
>>        "flush_total_time_ns": 0
>>        "wr_highest_offset": 8111718400
>>        [..]
>>        "invalid_wr_operations": 0
>>        "invalid_rd_operations": 0}
>>      "node-name": "#block047"
>>>     "driver_stats": {
>>>       "type": "file"
>>>       "data": {
>>>         "discard_bytes_ok": 1572864
>>>         "discard_nb_failed": 0
>>>         "discard_nb_ok": 5}}}
>>    "stats": {
>>>    "unmap_operations": 472
>>>    "unmap_merged": 0
>>      "flush_total_time_ns": 44530540
>>      "wr_highest_offset": 7106662400
>>      "wr_total_time_ns": 45518856
>>      "failed_wr_operations": 0
>>      "failed_rd_operations": 0
>>      "wr_merged": 0
>>      "wr_bytes": 889856
>>      "timed_stats": []
>>>     "failed_unmap_operations": 0
>>      "failed_flush_operations": 0
>>      "account_invalid": true
>>      "rd_total_time_ns": 3306264098
>>>     "invalid_unmap_operations": 0
>>      "flush_operations": 18
>>      "wr_operations": 120
>>>     "unmap_bytes": 12312014848
>>      "rd_merged": 0
>>      "rd_bytes": 137103360
>>>     "unmap_total_time_ns": 22664692
>>      "invalid_flush_operations": 0
>>      "account_failed": true
>>      "idle_time_ns": 437316567
>>      "rd_operations": 5636
>>      "invalid_wr_operations": 0
>>      "invalid_rd_operations": 0}
>>    "node-name": "#block128"}
>>
>>    {"device": "drive-ide0-0-0"
>>    [..]
>>
>> Anton Nefedov (7):
>>    qapi: add unmap to BlockDeviceStats
>>    ide: account UNMAP (TRIM) operations
>>    scsi: store unmap offset and nb_sectors in request struct
>>    scsi: move unmap error checking to the complete callback
>>    scsi: account unmap operations
>>    file-posix: account discard operations
>>    qapi: query-blockstat: add driver specific file-posix stats
>>
>>   qapi/block-core.json       | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>>   include/block/accounting.h |  1 +
>>   include/block/block.h      |  1 +
>>   include/block/block_int.h  |  1 +
>>   block.c                    |  9 ++++++++
>>   block/file-posix.c         | 42 ++++++++++++++++++++++++++++++++--
>>   block/qapi.c               | 11 +++++++++
>>   hw/ide/core.c              | 12 ++++++++++
>>   hw/scsi/scsi-disk.c        | 29 ++++++++++++++---------
>>   9 files changed, 150 insertions(+), 13 deletions(-)
>>
> 
> Hey, looks like this series has fallen through the cracks.  Anton, are
> you going to send an updated version?
> 
> Thanks,
> 
> Paolo
> 

hej,

yes, and v3 was the latest
(http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03688.html)

I will make a few rebase fixups and resend it soon.

/Anton
