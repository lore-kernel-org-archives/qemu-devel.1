Received: from eggs.gnu.org ([2001:4830:134:3::10]:35728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZggr-0002dj-Dj
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZggo-0005Tx-8T
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:35:29 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-4-jsnow@redhat.com>
	<0de4bd2b-c78f-f293-4d43-20c8bcd168c6@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <38592dbf-e2e2-1de5-2cc6-62d5541b43dc@redhat.com>
Date: Wed, 19 Dec 2018 13:35:07 -0500
MIME-Version: 1.0
In-Reply-To: <0de4bd2b-c78f-f293-4d43-20c8bcd168c6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/5] iotests: change qmp_log filters to
 expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 6:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 19.12.2018 4:52, John Snow wrote:
>> log() treats filters as if they can always filter its primary argument=
.
>> qmp_log treats filters as if they're always text.
>>
>> Change qmp_log to treat filters as if they're always qmp object filter=
s,
>> then change the logging call to rely on log()'s ability to serialize Q=
MP
>> objects, so we're not duplicating that effort.
>=20
> As I understand, there still no use for qmp-object based filters (even =
after the
> series), do we really need them? I'm afraid it's premature complication=
.
>=20

There are callers of log() that use qmp filters. Those callers can now
migrate over to qmp_log to get both the call and response.

There ARE users of QMP filters.

Look at `git grep 'log(vm'` for callers that are passing rich QMP
objects. The ones that pass filters are usually passing filter_qmp_event.

Now, if we choose, we can move them over to using qmp_log and amend the
logging output to get both the outgoing and returning message.

-- hmm, maybe, if you want, and I am NOT suggesting I will do this
before the holiday break (and therefore not in this series) -- what we
can do is this:

log(txt, filters=3D[]) -- Takes text and text filters only.

log_qmp(obj, tfilters=3D[], qfilters=3D[]) -- Logs a QMP object, takes QM=
P
filters for pre-filtering and tfilters for post-filtering. Contains the
json.dumps call. Simply passes tfilters down to log().

vm.qmp(log=3D1, tfilters=3D[], qfilters=3D[], ...) -- Perform the actual =
QMP
call and response, logging the outgoing and incoming objects via log_qmp.

I can use this patchset as a starting point to do that. It will involve
amending a lot of existing tests and test outputs, so I won't do this
unless there appears to be some support for that API in advance.

> Why not to keep all filters text based? If we need to filter some concr=
ete fields,
> not the whole thing, I doubt that recursion and defining functions insi=
de
> functions is a true way for it. Instead in concrete case, like in you t=
est, it's
> better to select fields that should be in output, and output only them.
>=20
>>
>> Because kwargs have been sorted already, the order is preserved.
>>
>> Edit the only caller who uses filters on qmp_log to use a qmp version,
>> also added in this patch.
>> ---
>>   tests/qemu-iotests/206        |  4 ++--
>>   tests/qemu-iotests/iotests.py | 24 +++++++++++++++++++++---
>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
>> index e92550fa59..5bb738bf23 100755
>> --- a/tests/qemu-iotests/206
>> +++ b/tests/qemu-iotests/206
>> @@ -27,7 +27,7 @@ iotests.verify_image_format(supported_fmts=3D['qcow2=
'])
>>  =20
>>   def blockdev_create(vm, options):
>>       result =3D vm.qmp_log('blockdev-create',
>> -                        filters=3D[iotests.filter_testfiles],
>> +                        filters=3D[iotests.filter_qmp_testfiles],
>>                           job_id=3D'job0', options=3Doptions)
>>  =20
>>       if 'return' in result:
>> @@ -55,7 +55,7 @@ with iotests.FilePath('t.qcow2') as disk_path, \
>>                             'size': 0 })
>>  =20
>>       vm.qmp_log('blockdev-add',
>> -               filters=3D[iotests.filter_testfiles],
>> +               filters=3D[iotests.filter_qmp_testfiles],
>>                  driver=3D'file', filename=3Ddisk_path,
>>                  node_name=3D'imgfile')
>>  =20
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index 55fb60e039..812302538d 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -246,10 +246,29 @@ def filter_qmp_event(event):
>>           event['timestamp']['microseconds'] =3D 'USECS'
>>       return event
>>  =20
>> +def filter_qmp(qmsg, filter_fn):
>> +    '''Given a string filter, filter a QMP object's values.
>> +    filter_fn takes a (key, value) pair.'''
>> +    for key in qmsg:
>> +        if isinstance(qmsg[key], list):
>> +            qmsg[key] =3D [filter_qmp(atom, filter_fn) for atom in qm=
sg[key]]
>> +        elif isinstance(qmsg[key], dict):
>> +            qmsg[key] =3D filter_qmp(qmsg[key], filter_fn)
>> +        else:
>> +            qmsg[key] =3D filter_fn(key, qmsg[key])
>> +    return qmsg
>> +
>>   def filter_testfiles(msg):
>>       prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
>>       return msg.replace(prefix, 'TEST_DIR/PID-')
>>  =20
>> +def filter_qmp_testfiles(qmsg):
>> +    def _filter(key, value):
>> +        if key =3D=3D 'filename' or key =3D=3D 'backing-file':
>> +            return filter_testfiles(value)
>> +        return value
>> +    return filter_qmp(qmsg, _filter)
>> +
>>   def filter_generated_node_ids(msg):
>>       return re.sub("#block[0-9]+", "NODE_NAME", msg)
>>  =20
>> @@ -462,10 +481,9 @@ class VM(qtest.QEMUQtestMachine):
>>       def qmp_log(self, cmd, filters=3D[], **kwargs):
>>           full_cmd =3D OrderedDict({"execute": cmd,
>>                                   "arguments": ordered_kwargs(kwargs)}=
)
>> -        logmsg =3D json.dumps(full_cmd)
>> -        log(logmsg, filters)
>> +        log(full_cmd, filters)
>>           result =3D self.qmp(cmd, **kwargs)
>> -        log(json.dumps(result, sort_keys=3DTrue), filters)
>> +        log(result, filters)
>>           return result
>>  =20
>>       def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFals=
e):
>>
>=20
>=20

--=20
=E2=80=94js
