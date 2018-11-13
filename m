Received: from eggs.gnu.org ([2001:4830:134:3::10]:47446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=848a82f1d=marcolso@amazon.com>)
	id 1gMiCv-0007yd-9b
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=848a82f1d=marcolso@amazon.com>)
	id 1gMiCs-0006dd-4V
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:34:57 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-2-git-send-email-marcolso@amazon.com>
	<94e0cf20-1a15-e4d0-cc68-cc7247067914@redhat.com>
From: Marc Olson <marcolso@amazon.com>
Message-ID: <5d567a8f-ccde-96b2-1650-4fd9723e1fb9@amazon.com>
Date: Tue, 13 Nov 2018 15:34:46 -0800
MIME-Version: 1.0
In-Reply-To: <94e0cf20-1a15-e4d0-cc68-cc7247067914@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 2/3] blkdebug: Extend rule check for
 additional types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/13/18 3:22 PM, John Snow wrote:
>
> On 11/12/18 2:06 AM, Marc Olson via Qemu-devel wrote:
>> Break out the more common parts of the BlkdebugRule struct, and make
>> rule_check() more explicit about operating only on error injection types
>> so that additional rule types can be added in the future.
>>
>> Signed-off-by: Marc Olson <marcolso@amazon.com>
>> ---
>>   block/blkdebug.c | 59 +++++++++++++++++++++++++++++---------------------------
>>   1 file changed, 31 insertions(+), 28 deletions(-)
>>
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 327049b..7739849 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -73,13 +73,13 @@ typedef struct BlkdebugRule {
>>       BlkdebugEvent event;
>>       int action;
>>       int state;
>> +    int once;
>> +    int64_t offset;
>>       union {
>>           struct {
>>               int error;
>>               int immediately;
>> -            int once;
>> -            int64_t offset;
>> -        } inject;
>> +        } inject_error;
> ...pulling out "once" and "offset" from inject_error (renamed inject) to
> shared properties. Fine, though this looks like it could use more love.
> Not your doing.
>
> This adds new dead fields for set_state and suspend which will now work,
> but hopefully not do anything.


I think set_state was already there?

>
>>           struct {
>>               int new_state;
>>           } set_state;
>> @@ -182,16 +182,16 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
>>           .state  = qemu_opt_get_number(opts, "state", 0),
>>       };
>>   
>> +    rule->once = qemu_opt_get_bool(opts, "once", 0);
>> +    sector = qemu_opt_get_number(opts, "sector", -1);
>> +    rule->offset = sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;
>> +
>>       /* Parse action-specific options */
>>       switch (d->action) {
>>       case ACTION_INJECT_ERROR:
>> -        rule->options.inject.error = qemu_opt_get_number(opts, "errno", EIO);
>> -        rule->options.inject.once  = qemu_opt_get_bool(opts, "once", 0);
>> -        rule->options.inject.immediately =
>> +        rule->options.inject_error.error = qemu_opt_get_number(opts, "errno", EIO);
>> +        rule->options.inject_error.immediately =
>>               qemu_opt_get_bool(opts, "immediately", 0);
>> -        sector = qemu_opt_get_number(opts, "sector", -1);
>> -        rule->options.inject.offset =
>> -            sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;
>>           break;
>>   
>>       case ACTION_SET_STATE:
>> @@ -474,38 +474,41 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
>>   {
>>       BDRVBlkdebugState *s = bs->opaque;
>>       BlkdebugRule *rule = NULL;
>> +    BlkdebugRule *error_rule = NULL;
>>       int error;
>>       bool immediately;
>> +    int ret = 0;
>>   
>>       QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
>> -        uint64_t inject_offset = rule->options.inject.offset;
>> -
>> -        if (inject_offset == -1 ||
>> -            (bytes && inject_offset >= offset &&
>> -             inject_offset < offset + bytes))
>> +        if (rule->offset == -1 ||
>> +            (bytes && rule->offset >= offset &&
>> +             rule->offset < offset + bytes))
>>           {
>> -            break;
>> +            if (rule->action == ACTION_INJECT_ERROR) {
>> +                error_rule = rule;
>> +                break;
>> +            }
>>           }
>>       }
>>   
>> -    if (!rule) {
>> -        return 0;
>> -    }
>> +    if (error_rule) {
>> +        immediately = error_rule->options.inject_error.immediately;
>> +        error = error_rule->options.inject_error.error;
>>   
>> -    immediately = rule->options.inject.immediately;
>> -    error = rule->options.inject.error;
>> +        if (error_rule->once) {
>> +            QSIMPLEQ_REMOVE(&s->active_rules, error_rule, BlkdebugRule, active_next);
>> +            remove_rule(error_rule);
>> +        }
>>   
>> -    if (rule->options.inject.once) {
>> -        QSIMPLEQ_REMOVE(&s->active_rules, rule, BlkdebugRule, active_next);
>> -        remove_rule(rule);
>> -    }
>> +        if (error && !immediately) {
>> +            aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
>> +            qemu_coroutine_yield();
>> +        }
>>   
>> -    if (error && !immediately) {
>> -        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
>> -        qemu_coroutine_yield();
>> +        ret = -error;
>>       }
> Bit messy as a diff, but it seems to check out. As a bonus we now
> actually check the tag of the rules we're iterating through, so that
> seems like an improvement.


Unfortunately git made a bit of a mess out of the diff.

>
> Reviewed-By: John Snow <jsnow@redhat.com>
>
>>   
>> -    return -error;
>> +    return ret;
>>   }
>>   
>>   static int coroutine_fn
>>
