Received: from eggs.gnu.org ([209.51.188.92]:34863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=939e5f57f=marcolso@amazon.com>)
	id 1gtfUf-0005if-9i
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=939e5f57f=marcolso@amazon.com>)
	id 1gtfUd-0004be-Cs
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:21:29 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-3-git-send-email-marcolso@amazon.com>
	<72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
From: Marc Olson <marcolso@amazon.com>
Message-ID: <13cbaa71-82ac-e142-945f-4ece8e3093f6@amazon.com>
Date: Tue, 12 Feb 2019 13:21:18 -0800
MIME-Version: 1.0
In-Reply-To: <72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 3/3] blkdebug: Add latency injection
 rule type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 1/11/19 7:00 AM, Max Reitz wrote:
> On 12.11.18 08:06, Marc Olson wrote:
>> Add a new rule type for blkdebug that instead of returning an error, can
>> inject latency to an IO.
>>
>> Signed-off-by: Marc Olson <marcolso@amazon.com>
>> ---
>>   block/blkdebug.c           | 79 +++++++++++++++++++++++++++++++++++++++++++---
>>   docs/devel/blkdebug.txt    | 35 ++++++++++++++------
>>   qapi/block-core.json       | 31 ++++++++++++++++++
>>   tests/qemu-iotests/071     | 63 ++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/071.out | 31 ++++++++++++++++++
>>   5 files changed, 226 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 7739849..6b1f2d6 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
> [...]
>
>> @@ -194,6 +227,11 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
>>               qemu_opt_get_bool(opts, "immediately", 0);
>>           break;
>>   
>> +    case ACTION_INJECT_DELAY:
>> +        rule->options.delay.latency =
>> +            qemu_opt_get_number(opts, "latency", 100) * SCALE_US;
> Why the default of 100?  I think it would be best if this option were
> mandatory.
Ok.
>
>> +        break;
>> +
>>       case ACTION_SET_STATE:
>>           rule->options.set_state.new_state =
>>               qemu_opt_get_number(opts, "new_state", 0);
> [...]
>
>> @@ -484,20 +538,36 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
>>               (bytes && rule->offset >= offset &&
>>                rule->offset < offset + bytes))
>>           {
>> -            if (rule->action == ACTION_INJECT_ERROR) {
>> +            if (!error_rule && rule->action == ACTION_INJECT_ERROR) {
>>                   error_rule = rule;
>> +            } else if (!delay_rule && rule->action == ACTION_INJECT_DELAY) {
>> +                delay_rule = rule;
>> +            }
>> +
> How about handling "once" here?
>
> (by adding:
>
> else {
>      continue;
> }
>
> if (rule->once) {
>      remove_active_rule(s, rule);
> }
>
> and making the QSIMPLEQ_FOREACH a QSIMPLEQ_FOREACH_SAFE.
>
> (Or maybe in that case we want to inline remove_active_rule().))
>
> It isn't like the state here is too bad, but if we can't handle "once"
> in a common code path, I'm torn whether it has a place in the
> BlkdebugRule root.  (Doing that makes parsing a bit easier, but OTOH we
> just shouldn't parse it for set-state at all, so I'd keep it in the
> "unionized structs" if it isn't handled in a common code path.)
Yes, this makes sense.
>
>> +            if (error_rule && delay_rule) {
>>                   break;
>>               }
>>           }
>>       }
>>   
>> +    if (delay_rule) {
>> +        latency = delay_rule->options.delay.latency;
>> +
>> +        if (delay_rule->once) {
>> +            remove_active_rule(s, delay_rule);
>> +        }
>> +
>> +        if (latency != 0) {
>> +            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, latency);
>> +        }
>> +    }
>> +
>>       if (error_rule) {
>>           immediately = error_rule->options.inject_error.immediately;
>>           error = error_rule->options.inject_error.error;
>>   
>>           if (error_rule->once) {
>> -            QSIMPLEQ_REMOVE(&s->active_rules, error_rule, BlkdebugRule, active_next);
>> -            remove_rule(error_rule);
>> +            remove_active_rule(s, error_rule);
>>           }
>>   
>>           if (error && !immediately) {
> [...]
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index d4fe710..72f7861 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3057,6 +3057,34 @@
>>               '*immediately': 'bool' } }
>>   
>>   ##
>> +# @BlkdebugDelayOptions:
>> +#
>> +# Describes a single latency injection for blkdebug.
>> +#
>> +# @event:       trigger event
>> +#
>> +# @state:       the state identifier blkdebug needs to be in to
>> +#               actually trigger the event; defaults to "any"
>> +#
>> +# @latency:     The delay to add to an I/O, in microseconds.
>> +#
>> +# @sector:      specifies the sector index which has to be affected
>> +#               in order to actually trigger the event; defaults to "any
>> +#               sector"
>> +#
>> +# @once:        disables further events after this one has been
>> +#               triggered; defaults to false
>> +#
>> +# Since: 3.1
> Well, 4.0 now, sorry...
Baking version numbers into code is downright silly. Every single 
version of this patch has made a comment along the lines of, "oops, it 
didn't get reviewed in time for the next version bump, so you have to 
resubmit." With a fast moving project, this is nonsense. If you're 
looking at the code, you should have access to the git history as well 
to determine the version.
>
>> +##
>> +{ 'struct': 'BlkdebugDelayOptions',
>> +  'data': { 'event': 'BlkdebugEvent',
>> +            '*state': 'int',
>> +            '*latency': 'int',
> I'd make this option mandatory.
>
>> +            '*sector': 'int',
>> +            '*once': 'bool' } }
>> +
>> +##
>>   # @BlkdebugSetStateOptions:
>>   #
>>   # Describes a single state-change event for blkdebug.
>> @@ -3115,6 +3143,8 @@
>>   #
>>   # @inject-error:    array of error injection descriptions
>>   #
>> +# @inject-delay:    array of delay injection descriptions
> This needs a "(Since 4.0)".
>
>> +#
>>   # @set-state:       array of state-change descriptions
>>   #
>>   # Since: 2.9
> [...]
>
>> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
>> index 48b4955..976f747 100755
>> --- a/tests/qemu-iotests/071
>> +++ b/tests/qemu-iotests/071
>> @@ -100,6 +100,69 @@ $QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.inject-error.event
>>            -c 'read -P 42 0x38000 512'
>>   
>>   echo
>> +echo "=== Testing blkdebug latency through filename ==="
>> +echo
>> +
>> +$QEMU_IO -c "open -o file.driver=blkdebug,file.inject-delay.event=write_aio,file.inject-delay.latency=10000 $TEST_IMG" \
>> +         -c 'aio_write -P 42 0x28000 512' \
>> +         -c 'aio_read -P 42 0x38000 512' \
>> +         | _filter_qemu_io
>> +
>> +echo
>> +echo "=== Testing blkdebug latency through file blockref ==="
>> +echo
>> +
>> +$QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.inject-delay.event=write_aio,file.inject-delay.latency=10000,file.image.filename=$TEST_IMG" \
>> +         -c 'aio_write -P 42 0x28000 512' \
>> +         -c 'aio_read -P 42 0x38000 512' \
>> +         | _filter_qemu_io
>> +
>> +# Using QMP is synchronous by default, so even though we would
>> +# expect reordering due to using the aio_* commands, they are
>> +# not. The purpose of this test is to verify that the driver
>> +# can be setup via QMP, and IO can complete. See the qemu-io
>> +# test above to prove delay functionality
> But it doesn't prove that because the output is filtered.  To prove it,
> you'd probably need to use null-co as the protocol (so there is as
> little noise as possible) and then parse the qemu-io output to show that
> the time is always above 10 ms.
>
> I leave it to you whether you'd like to go through that pain.
There's not a great way to prove it without doing a lot of parsing 
changes in testing. I'll consider an update to this patch, but I think 
this series has carried on long enough.
>
> [...]
>
>> diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
>> index 1d5e28d..1952990 100644
>> --- a/tests/qemu-iotests/071.out
>> +++ b/tests/qemu-iotests/071.out
>> @@ -36,6 +36,37 @@ read failed: Input/output error
>>   
>>   read failed: Input/output error
>>   
>> +=== Testing blkdebug latency through filename ===
>> +
>> +read 512/512 bytes at offset 229376
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset 163840
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +
>> +=== Testing blkdebug latency through file blockref ===
>> +
>> +read 512/512 bytes at offset 229376
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset 163840
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> (As you can see, the output is filtered.)
>
> Max
>
