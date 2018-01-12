Received: from eggs.gnu.org ([2001:4830:134:3::10]:46337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZxkv-0001jd-Aj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZxkr-00075p-7o
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:44:17 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-7-vsementsov@virtuozzo.com>
	<a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
Date: Fri, 12 Jan 2018 14:43:52 +0300
MIME-Version: 1.0
In-Reply-To: <a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

09.01.2018 23:49, Eric Blake wrote:
> On 12/07/2017 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/201     | 130 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/201.out |   5 ++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 136 insertions(+)
>>   create mode 100644 tests/qemu-iotests/201
>>   create mode 100644 tests/qemu-iotests/201.out
>>
> pep8 complains:
>
> $ pep8 tests/qemu-iotests/201
> tests/qemu-iotests/201:31:1: E302 expected 2 blank lines, found 1
> tests/qemu-iotests/201:68:17: E128 continuation line under-indented for
> visual indent
> tests/qemu-iotests/201:69:17: E128 continuation line under-indented for
> visual indent
>
> I don't mind cleaning those up (if you don't have to respin because of
> my comments on 5/6).
>
>> +import os
>> +import sys
>> +import iotests
>> +import time
>> +from iotests import qemu_img, qemu_io, filter_qemu_io, QemuIoInteractive
>> +
>> +nbd_port = '10900'
>> +nbd_uri = 'nbd+tcp://localhost:' + nbd_port + '/exp'
> Is this still going to be safe when we improve the testsuite to run
> multiple tests in parallel?  Wouldn't it be safer to dynamically choose
> the port, instead of hard-coding one?
>
>> +disk = os.path.join(iotests.test_dir, 'disk')
>> +
>> +class TestNbdServerRemove(iotests.QMPTestCase):
>> +    def setUp(self):
>> +        qemu_img('create', '-f', iotests.imgfmt, disk, '1M')
>> +
>> +        self.vm = iotests.VM().add_drive(disk)
>> +        self.vm.launch()
>> +
>> +        address = {
>> +            'type': 'inet',
>> +            'data': {
>> +                'host': 'localhost',
>> +                'port': nbd_port
> Again, for a one-shot test, this works; but it doesn't lend itself to
> parallel testing.  Maybe do a loop with incrementing port numbers until
> one succeeds, if we can reliably detect when a port is already in use?
>
>> +    def assertConnectFailed(self, qemu_io_output):
>> +        self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
>> +                         "can't open device nbd+tcp://localhost:10900/exp: " +
> Worth parameterizing or filtering this assertion to match the rest of
> the parameterization of nbd_port?
>
>> +                         "Requested export not available\nserver reported: " +
>> +                         "export 'exp' not present")
>> +
>> +    def do_test_connect_after_remove(self, force=None):
>> +        args = ('-r', '-f', 'raw', '-c', 'read 0 512', nbd_uri)
>> +        self.assertReadOk(qemu_io(*args))
>> +        self.remove_export('exp', force)
>> +        self.assertExportNotFound('exp')
>> +        self.assertConnectFailed(qemu_io(*args))
>> +
>> +    def test_connect_after_remove_default(self):
>> +        self.do_test_connect_after_remove()
>> +
>> +    def test_connect_after_remove_safe(self):
>> +        self.do_test_connect_after_remove(False)
>> +
>> +    def test_connect_after_remove_force(self):
>> +        self.do_test_connect_after_remove(True)
> May need updates if my comments on 3/6 result in us having three states
> rather than just 2 (the difference being whether there is a knob for
> choosing to let existing clients gracefully disconnect with all pending
> I/O completed, and/or failing the nbd-server-remove if a client is still
> connected).
>
>> +++ b/tests/qemu-iotests/201.out
>> @@ -0,0 +1,5 @@
>> +.......
>> +----------------------------------------------------------------------
>> +Ran 7 tests
> I'm not a fan of python tests that are difficult to debug.  Your
> additions to 147 in patch 4/6 are okay (hard to debug, but an
> incremental addition); but is it possible to rewrite this test in a bit
> more verbose manner?  See test 194 and this message for more details:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00234.html

hmm, what do you mean by "difficult to debug"? This is a usual python 
unittest based test.
And there 3 test cases, sharing same setUp. Do not you say that unittest 
becomes
deprecated in qemu? I think, if we have only one testcase, we may use 
194-like approach,
but if we have more, it's better to use unittest.

>
>> +
>> +OK
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 3e688678dd..15df7678b3 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -197,3 +197,4 @@
>>   197 rw auto quick
>>   198 rw auto
>>   200 rw auto
>> +201 rw auto quick
>>


-- 
Best regards,
Vladimir
