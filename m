Received: from eggs.gnu.org ([2001:4830:134:3::10]:39229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSrU1-0006hi-2k
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSrU0-00065k-80
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:42:01 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-5-eblake@redhat.com>
	<20181130222645.GB27120@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b61ca082-b0ec-c305-05f9-dd29a511410b@redhat.com>
Date: Fri, 30 Nov 2018 16:41:47 -0600
MIME-Version: 1.0
In-Reply-To: <20181130222645.GB27120@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/14] qemu-nbd: Simplify --partition
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On 11/30/18 4:26 PM, Richard W.M. Jones wrote:
> On Fri, Nov 30, 2018 at 04:03:33PM -0600, Eric Blake wrote:
>> Our open-coding of strtol handling forgot to handle overflow
>> conditions. What's more, since we insiste on a user-supplied
> 
> "insist"

(Ever wonder if I stick in a typo on purpose, just to see who reviews 
closely?)

> 
>> partition to be non-zero, we can use 0 rather than -1 for our
>> initial value to distinguish when a partition is not being
>> served, for slightly more optimal code.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   qemu-nbd.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>

>> +            if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
>> +                partition < 1 || partition > 8) {
>> +                error_report("Invalid partition %s", optarg);
> 
> Pffft only supporting a mere 8 partitions :-?  I raised the limits in
> nbdkit recently so it can handle an infinite number of partitions :-)

nbdkit also handles GPT partitions. qemu-nbd is still stuck on MBR:

static int find_partition(BlockBackend *blk, int partition,
                           off_t *offset, off_t *size)
{
     struct partition_record mbr[4];
     uint8_t data[MBR_SIZE];

and if I read git blame correctly, the partition code in qemu-nbd is 
mostly untouched since Fabrice committed Anthony's initial 
implementation in 2008.

Also, reading the code, I see that qemu-nbd allows partitions 5-8 
because it reads through the extended partition descriptor in 4 to 
expose the logical partitions within; which nbdkit can't do yet :)

> 
> Anyway, it's a problem with the existing code, so doesn't affect the
> review.

Indeed, and with nbdkit around, I'm wondering if I should deprecate 
'qemu-nbd --partition' and just point people to nbdkit instead 
(provided, of course, that nbdkit learns logical partitions).

Even if you have a qcow2 image with MBR partitions, and where we don't 
want to write a qcow2 plugin in nbdkit, you can still always rewrite:

client -> qemu-nbd --partition=1

into

client -> nbdkit --filter=partition nbd partition=1 -> qemu-nbd

(although I don't know what the performance penalty would be)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
