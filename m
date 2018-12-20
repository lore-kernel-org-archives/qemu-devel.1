Received: from eggs.gnu.org ([2001:4830:134:3::10]:53387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga6mW-000664-8L
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 17:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga6mV-0007j9-8l
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 17:27:04 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-10-jsnow@redhat.com>
	<06e3594c-b4f9-9c3a-2a44-fadf36cf4b89@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1448f5f6-c521-956f-e646-3b93efeb6945@redhat.com>
Date: Thu, 20 Dec 2018 17:26:42 -0500
MIME-Version: 1.0
In-Reply-To: <06e3594c-b4f9-9c3a-2a44-fadf36cf4b89@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/11] iotests: change qmp_log filters
 to expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/20/18 6:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> 20.12.2018 5:29, John Snow wrote:
>> As laid out in the previous commit's message:
>>
>> ```
>> Several places in iotests deal with serializing objects into JSON
>> strings, but to add pretty-printing it seems desireable to localize
>> all of those cases.
>>
>> log() seems like a good candidate for that centralized behavior.
>> log() can already serialize json objects, but when it does so,
>> it assumes filters=[] operates on QMP objects, not strings.
>>
>> qmp_log currently operates by dumping outgoing and incoming QMP
>> objects into strings and filtering them assuming that filters=[]
>> are string filters.
>> ```
>>
>> Therefore:
>>
>> Change qmp_log to treat filters as if they're always qmp object filters,
>> then change the logging call to rely on log()'s ability to serialize QMP
>> objects, so we're not duplicating that effort.
>>
>> Add a qmp version of filter_testfiles and adjust the only caller using
>> it for qmp_log to use the qmp version.
>>
>> Signed-off-by: John Snow  <jsnow@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   tests/qemu-iotests/206        |  4 ++--
>>   tests/qemu-iotests/iotests.py | 24 +++++++++++++++++++++---
>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
>> index e92550fa59..5bb738bf23 100755
>> --- a/tests/qemu-iotests/206
>> +++ b/tests/qemu-iotests/206
>> @@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=['qcow2'])
>>   
>>   def blockdev_create(vm, options):
>>       result = vm.qmp_log('blockdev-create',
>> -                        filters=[iotests.filter_testfiles],
>> +                        filters=[iotests.filter_qmp_testfiles],
>>                           job_id='job0', options=options)
>>   
>>       if 'return' in result:
>> @@ -55,7 +55,7 @@ with iotests.FilePath('t.qcow2') as disk_path, \
>>                             'size': 0 })
>>   
>>       vm.qmp_log('blockdev-add',
>> -               filters=[iotests.filter_testfiles],
>> +               filters=[iotests.filter_qmp_testfiles],
>>                  driver='file', filename=disk_path,
>>                  node_name='imgfile')
>>   
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 57fe20db45..dcd0c6f71d 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -246,10 +246,29 @@ def filter_qmp_event(event):
>>           event['timestamp']['microseconds'] = 'USECS'
>>       return event
>>   
>> +def filter_qmp(qmsg, filter_fn):
>> +    '''Given a string filter, filter a QMP object's values.
>> +    filter_fn takes a (key, value) pair.'''
> 
> hm, I decided to look into PEP8, which in turn refers to PEP257,
> which asks:
>   - For consistency, always use """triple double quotes""" around docstring
>   - Unless the entire docstring fits on a line, place the closing quotes on a line by themselves
> 
> Unfortunately, iotests.py prefers to be in opposition.. And consistency within the file is more
> important. May be we'll fix it one day..
> 
> 
>> +    for key in qmsg:
> 
> and here again we can benefit (or all right-value qmsg[key]) of using qmsg.items()
> 
>> +        if isinstance(qmsg[key], list):
>> +            qmsg[key] = [filter_qmp(atom, filter_fn) for atom in qmsg[key]]
> 
> hmm, stop. filter_qmp() assumes that its argument is dict. but atom may not be dict.
> 

Oh, good catch. Will fix.

> so, to fit into the concept of fn(key, value) filtering function, we should do something like
> this:
> 
> for i in len(qmsg[key]):
>    if isinstance(qmsg[key], dict):
>      qmsg[key][i] = filter_qmp(qmsg[key][i], filter_fn)
> 
> qmsg[key] = filter_fn(key, qmsg[key])
> 
> ---
> or, we may want to apply filter_fn only to lists of non-dicts, and filter only list of dicts,
> assuming that we don't have mixed lists.
> 
> 
>> +        elif isinstance(qmsg[key], dict):
>> +            qmsg[key] = filter_qmp(qmsg[key], filter_fn)
>> +        else:
>> +            qmsg[key] = filter_fn(key, qmsg[key]) > +    return qmsg
>> +
>>   def filter_testfiles(msg):
>>       prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
>>       return msg.replace(prefix, 'TEST_DIR/PID-')
>>   
>> +def filter_qmp_testfiles(qmsg):
>> +    def _filter(key, value):
>> +        if key == 'filename' or key == 'backing-file':
>> +            return filter_testfiles(value)
>> +        return value
>> +    return filter_qmp(qmsg, _filter)
>> +
>>   def filter_generated_node_ids(msg):
>>       return re.sub("#block[0-9]+", "NODE_NAME", msg)
>>   
>> @@ -465,10 +484,9 @@ class VM(qtest.QEMUQtestMachine):
>>               ("execute", cmd),
>>               ("arguments", ordered_kwargs(kwargs))
>>           ))
>> -        logmsg = json.dumps(full_cmd)
>> -        log(logmsg, filters)
>> +        log(full_cmd, filters)
>>           result = self.qmp(cmd, **kwargs)
>> -        log(json.dumps(result, sort_keys=True), filters)
>> +        log(result, filters)
>>           return result
>>   
>>       def run_job(self, job, auto_finalize=True, auto_dismiss=False):
>>
> 
> 
