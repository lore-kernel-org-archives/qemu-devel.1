Received: from eggs.gnu.org ([2001:4830:134:3::10]:45957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771160022=marcolso@amazon.com>)
	id 1fuT6S-0007Dl-GM
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771160022=marcolso@amazon.com>)
	id 1fuSyh-0008Km-GP
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:39:36 -0400
References: <1535087186-9643-1-git-send-email-marcolso@amazon.com>
	<837facae-ff38-e995-ca2e-9c16efb7c209@redhat.com>
From: Marc Olson <marcolso@amazon.com>
Message-ID: <0956d551-b21a-7e01-f541-b96ef3be03d8@amazon.com>
Date: Mon, 27 Aug 2018 18:34:49 -0700
MIME-Version: 1.0
In-Reply-To: <837facae-ff38-e995-ca2e-9c16efb7c209@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] blkdebug: Add support for latency rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


On 08/24/2018 09:11 AM, Eric Blake wrote:
> On 08/24/2018 12:06 AM, Marc Olson via Qemu-devel wrote:
>> Allow rules to be created to inject latency into I/O operations.
>>
>> Signed-off-by: Marc Olson <marcolso@amazon.com>
>> ---
>>   block/blkdebug.c        | 101 
>> ++++++++++++++++++++++++++++++++++++++----------
>>   docs/devel/blkdebug.txt |  30 ++++++++++----
>>   2 files changed, 103 insertions(+), 28 deletions(-)
>
> The commit message could usefully summarize some of the doc additions 
> (so you can learn more about it without having to read the patch 
> itself) - but the doc additions are appreciated.
I can be more verbose in the commit.
>
> Missing: you should enhance an existing (or add a new) iotests usage 
> of blkdebug to specify a latency operation. One possible test would be 
> forcing a read to take longer than a write - then issue an aio read, a 
> write immediately after, and verify that the write completes first and 
> then the read (whether the read sees the old or the new data just 
> written would then depend on whether the delay is acted on before or 
> after blkdebug forwards the read on to the real block layer).
>
I'll add at least a simple test to the repo.

>>
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index e216699..762e438 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -65,6 +65,7 @@ typedef struct BlkdebugSuspendedReq {
>>     enum {
>>       ACTION_INJECT_ERROR,
>> +    ACTION_DELAY,
>>       ACTION_SET_STATE,
>>       ACTION_SUSPEND,
>>   };
>
> Does any of this need to be accessible via QMP?  (If QMP can't already 
> fine-tune what blkdebug can do, I'm not proposing that you have to 
> make it do so - but if QMP can specify error injections, it should 
> also be able to specify delays).  Even if it doesn't need to be in 
> QMP, should we specify this enum and related types in our qapi/*.json 
> files?
It does appear that blkdebug is in the qapi/*.json files. I've added the 
appropriate types, but I'm less familiar with the QMP incantations, and 
seem to have misconfigured my tests as they result in an uninitialized 
mutex when trying to do aio*. Using the existing tests as a guide, 
there's no global BlockBackend created, and so hmp_qemu_io() creates a 
local backend that is cleaned up before the aio completes. Removing the 
blk_unref() clears it up, but of course leaks memory. I don't see an API 
that creates the appropriate QMP BlockBackend for file backed devices.

>
>> @@ -123,6 +127,33 @@ static QemuOptsList inject_error_opts = {
>>       },
>>   };
>>   +static QemuOptsList delay_opts = {
>
> One reason for suggesting that this be done with QAPI types is that 
> QemuOpts is already proving to be painfully hard to extend, where in 
> general we are trying to move towards using QAPI types rather than yet 
> more QemuOpts munging.
>
>> @@ -182,16 +214,21 @@ static int add_rule(void *opaque, QemuOpts 
>> *opts, Error **errp)
>>           .state  = qemu_opt_get_number(opts, "state", 0),
>>       };
>>   +    rule->once  = qemu_opt_get_bool(opts, "once", 0);
>> +    sector = qemu_opt_get_number(opts, "sector", -1);
>> +    rule->offset = sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;
>
> I really wish we could spend time moving blkdebug to be byte-based 
> instead of sector-based.
I'm not certain I see the benefit of moving to byte based. Storage 
devices are sector based. The biggest pain point with blkdebug is not 
that it's sector based, but that offsets are based on the backing file, 
and not as viewed by the guest. In order to properly use blkdebug with 
qcow2, for example, you have to do some gymnastics.
>
>> +++ b/docs/devel/blkdebug.txt
>> @@ -24,7 +24,7 @@ This way, all error paths can be tested to make 
>> sure they are correct.
>>   Rules
>>   -----
>>   The blkdebug block driver takes a list of "rules" that tell the 
>> error injection
>> -engine when to fail an I/O request.
>> +engine when to fail (inject-error) or add latency to (delay) an I/O 
>> request.
>>     Each I/O request is evaluated against the rules.  If a rule 
>> matches the request
>>   then its "action" is executed.
>> @@ -33,17 +33,25 @@ Rules can be placed in a configuration file; the 
>> configuration file
>>   follows the same .ini-like format used by QEMU's -readconfig 
>> option, and
>>   each section of the file represents a rule.
>>   -The following configuration file defines a single rule:
>> +The following configuration file defines multiple rules:
>>       $ cat blkdebug.conf
>>     [inject-error]
>>     event = "read_aio"
>>     errno = "28"
>>   -This rule fails all aio read requests with ENOSPC (28).  Note that 
>> the errno
>> -value depends on the host.  On Linux, see
>> +  [delay]
>> +  event = "read_aio"
>> +  sector = "2048"
>> +  latency = "500000"
>> +
>> +The error rule fails all aio read requests with ENOSPC (28). Note 
>> that the
>> +errno value depends on the host.  On Linux, see
>>   /usr/include/asm-generic/errno-base.h for errno values.
>>   +The delay rule adds 500 ms of latency to a read I/O request 
>> containing sector
>> +2048.
>
> So in this example, you get a failure no matter what, but that one 
> sector takes even longer to fail?
No, in the case of injection that overlaps, it takes the first rule. 
This is similar to the existing behavior--if two errors match, you don't 
know which you're getting. I like the suggestion, and I've reworked it a 
bit to delay first and then take any errors, but still take the first of 
each. I could see a follow on that looks for the most specific rule in 
either case (or the greatest delay in the latency case).

>
> Overall, I like the idea.
>
