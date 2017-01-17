Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cTV4x-0006aS-Qv
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cTV4t-0004ks-Lt
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:49:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cTV4t-0004kJ-72
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:49:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0HEnAfF004796
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 09:49:36 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2812r1t2tj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 09:49:36 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Tue, 17 Jan 2017 09:49:34 -0500
References: <20170116211201.46601-1-farman@linux.vnet.ibm.com>
	<20170116211201.46601-4-farman@linux.vnet.ibm.com>
	<20170117070401.GD21563@lemon.Home>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Tue, 17 Jan 2017 09:49:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170117070401.GD21563@lemon.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <a92ed3bb-1d9b-681f-6bcf-7c03441a00fd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: get max_transfer limit for char
 (scsi-generic) devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 01/17/2017 02:04 AM, Fam Zheng wrote:
> On Mon, 01/16 22:12, Eric Farman wrote:
>> Commit 6f607174 introduced a routine to get the maximum number
>> of bytes for a single I/O transfer for block devices, however
>> scsi generic devices are character devices, not block.  Add
>> a condition for this, with slightly different logic because
>> the value is already in bytes, and need not be converted from
>> blocks as happens for block devices.
>>
>> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
>> ---
>>  block/file-posix.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 2115155..c0843c2 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -679,6 +679,13 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>>              if (ret > 0 && ret <= BDRV_REQUEST_MAX_SECTORS) {
>>                  bs->bl.max_transfer = pow2floor(ret << BDRV_SECTOR_BITS);
>>              }
>> +        } else if (S_ISCHR(st.st_mode)) {
>> +            /* sg returns transfer length in bytes already */
>> +            int ret = hdev_get_max_transfer_length(bs, s->fd);
>> +            if (ret > 0 &&
>> +                (ret >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS) {
>> +                bs->bl.max_transfer = pow2floor(ret);
>> +            }
>
> Please keep the sectors/bytes quirk in hdev_get_max_transfer_length and always
> return bytes from there.

That's easy enough.  I'll allow a day or two before sending a v2, in 
case there's other considerations for the rats nest I've wandered into.

Thanks!

  - Eric
