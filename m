Received: from eggs.gnu.org ([2001:4830:134:3::10]:33198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXuQk-0001jp-1o
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXuQj-0000Ub-5H
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:51:29 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-7-jsnow@redhat.com>
	<43e3e755-e4d3-5342-2829-e7c309d675e4@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4893f07b-a38b-1f36-ffcb-424df9af8d0e@redhat.com>
Date: Fri, 14 Dec 2018 15:51:19 -0500
MIME-Version: 1.0
In-Reply-To: <43e3e755-e4d3-5342-2829-e7c309d675e4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iotests: allow pretty-print for
 qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/13/18 8:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.12.2018 4:50, John Snow wrote:
>> If iotests have lines exceeding >998 characters long, git doesn't
>> want to send it plaintext to the list. We can solve this by allowing
>> the iotests to use pretty printed QMP output that we can match against
>> instead.
>>
>> As a bonus, it's much nicer for human eyes, too.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   tests/qemu-iotests/iotests.py | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 9595429fea..dbbef4bad3 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -447,12 +447,12 @@ class VM(qtest.QEMUQtestMachine):
>>               result.append(filter_qmp_event(ev))
>>           return result
>>   
>> -    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
>> +    def qmp_log(self, cmd, indent=None, filters=[filter_testfiles], **kwargs):
>>           logmsg = '{"execute": "%s", "arguments": %s}' % \
>>               (cmd, json.dumps(kwargs, sort_keys=True))
>>           log(logmsg, filters)
> 
> why not to prettify cmd json too? Just make fullobj = {"execute": cmd, "arguments": kwargs}, and prettify it.
> (hmm, unfortunately, "execute" < "arguments", and they will be rearranged)
> 

It wasn't long enough to irritate me :)
but we're here, so I'll do that too.

> with or without (as the patch don't aim to prettify everything):
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
>>           result = self.qmp(cmd, **kwargs)
>> -        log(json.dumps(result, sort_keys=True), filters)
>> +        log(json.dumps(result, indent=indent, sort_keys=True), filters)
>>           return result
> 
> hmm, doing the same thing as Eric (check specs), I see the following note:
> 
>  > Note: Since the default item separator is ', ', the output might include trailing whitespace when indent is specified.
> 
> And I remember a pain of trailing whitespaces in iotests on, may be, backporting, or something like this some time ago.
> It's of course not about this patch, but I think it is a good idea to avoid trailing whitespaces in test output, at least
> in common helpers. May be best place to fix is iotests.log() function
> 

Oh, good spot. I actually did run into this and wasn't aware of what
caused it! I will change the default separator.

>>   
>>       def run_job(self, job, auto_finalize=True, auto_dismiss=False):
>>
> 
> 
