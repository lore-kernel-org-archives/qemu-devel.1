Received: from eggs.gnu.org ([2001:4830:134:3::10]:39904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyOZ-0006LV-O6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyOY-0007xV-Rc
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:50:51 -0500
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-21-eblake@redhat.com>
	<20180214131215.GD4766@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <54c1036c-4d51-51cb-7cae-1e4bfac3bacc@redhat.com>
Date: Wed, 14 Feb 2018 08:50:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180214131215.GD4766@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 20/21] vvfat: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/14/2018 07:12 AM, Kevin Wolf wrote:
> Am 13.02.2018 um 21:27 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Update the vvfat driver accordingly.  Note that we
>> can rely on the block driver having already clamped limits to our
>> block size, and simplify accordingly.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>

>>   {
>> -    *n = bs->total_sectors - sector_num;
>> -    if (*n > nb_sectors) {
>> -        *n = nb_sectors;
>> -    } else if (*n < 0) {
>> -        return 0;
>> -    }
>> +    *n = bytes;
>>       return BDRV_BLOCK_DATA;
>>   }
> 
> Preexisting, but this is inconsistent with other protocol drivers as far
> as OFFSET_VALID is concerned (as I hinted in another mail, I like it
> better this way, but it's still inconsistent).
> 
> Do we actually need any callback here or could the solution be to simply
> remove it like with nvme?

Does that mean io.c's defaults for protocol drivers is wrong?  It 
defaults to setting OFFSET_VALID and *map on all protocol drivers 
without a callback (at least nvme, nbd); I didn't delete this callback 
because I noticed the difference in return value, and couldn't justify 
whether it was intentional.  Also, vvfat is weird - it is somewhat of a 
format driver, rather than just a protocol; even though it sets 
.protocol_name.  It may be possible for vvfat to actually set 
OFFSET_VALID to particular offsets within the host file that correspond 
to what the guest would read, where it is not a simple 1:1 mapping, 
precisely because it is imposing format on the host file.  However, 
vvfat is one of those things that I try to avoid as much as possible, 
because it is just so weird.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
