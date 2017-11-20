Received: from eggs.gnu.org ([2001:4830:134:3::10]:57380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGoB8-00066x-0y
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGoB4-0006sM-Rn
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:40:10 -0500
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510851298-59922-5-git-send-email-anton.nefedov@virtuozzo.com>
	<20171120143814.GF4516@stefanha-x1.localdomain>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <80dabc5d-ed04-8c45-b807-be56ab181127@virtuozzo.com>
Date: Mon, 20 Nov 2017 18:39:48 +0300
MIME-Version: 1.0
In-Reply-To: <20171120143814.GF4516@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] iotests: 030: add compressed
 block-stream test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com



On 20/11/2017 5:38 PM, Stefan Hajnoczi wrote:
> On Thu, Nov 16, 2017 at 07:54:58PM +0300, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/030     | 66 +++++++++++++++++++++++++++++++++++++++++++++-
>>   tests/qemu-iotests/030.out |  4 +--
>>   2 files changed, 67 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>> index 457984b..831d6f3 100755
>> --- a/tests/qemu-iotests/030
>> +++ b/tests/qemu-iotests/030
>> @@ -21,7 +21,7 @@
>>   import time
>>   import os
>>   import iotests
>> -from iotests import qemu_img, qemu_io
>> +from iotests import qemu_img, qemu_img_pipe, qemu_io
>>   
>>   backing_img = os.path.join(iotests.test_dir, 'backing.img')
>>   mid_img = os.path.join(iotests.test_dir, 'mid.img')
>> @@ -804,5 +804,69 @@ class TestSetSpeed(iotests.QMPTestCase):
>>   
>>           self.cancel_and_wait(resume=True)
>>   
>> +class TestCompressed(iotests.QMPTestCase):
>> +    supported_fmts = ['qcow2']
>> +    cluster_size = 64 * 1024;
>> +    image_len = 1 * 1024 * 1024;
> 
> Please drop the unnecessary semicolons
> 
>> +
>> +    def setUp(self):
>> +        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d' % TestCompressed.cluster_size, backing_img, str(TestCompressed.image_len))
>> +        qemu_io('-c', 'write -P 1 0 ' + str(TestCompressed.image_len), backing_img)
>> +        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s,cluster_size=%d' % (backing_img, TestCompressed.cluster_size), test_img)
>> +
>> +        # write '3' in every 3rd cluster
>> +        step = 3
>> +        for off in range(0, TestCompressed.image_len, TestCompressed.cluster_size * step):
>> +            qemu_io('-c', 'write -P %d %d %d' %
>> +                    (step, off, TestCompressed.cluster_size), test_img)
>> +
>> +        self.vm = iotests.VM().add_drive(test_img)
>> +        self.vm.launch()
>> +
>> +    def tearDown(self):
>> +        os.remove(test_img)
>> +        os.remove(backing_img)
>> +
>> +    def _first_divider(self, x, divs):
> 
> "Divisor" or "factor":
> https://en.wikipedia.org/wiki/Divisor
> 
>> +        return divs[0] if not x%divs[0] else self._first_divider(x, divs[1:])
> 
> An alternative that I find easier to read than conditional expressions:
> 
>    for divisor in divs:
>        if x % divisor == 0:
>            return divisor
>    raise ValueError('No suitable divisor found')
> 
>> +
>> +    def test_compressed(self):
>> +        self.assert_no_active_block_jobs()
>> +
>> +        result = self.vm.qmp('block-stream', device='drive0', compress=True)
>> +        if iotests.imgfmt not in TestCompressed.supported_fmts:
>> +            self.assert_qmp(
>> +                result, 'error/desc',
>> +                'Compression is not supported for this drive drive0')
>> +            return
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # write '4' in every 4th cluster
>> +        step = 4
>> +        for off in range(0, TestCompressed.image_len, TestCompressed.cluster_size * step):
>> +            result = self.vm.qmp('human-monitor-command',
>> +                                 command_line=
>> +                                 'qemu-io drive0 "write -P %d %d %d"' %
>> +                                 (step, off, TestCompressed.cluster_size))
>> +            self.assert_qmp(result, 'return', "")
>> +
>> +        self.wait_until_completed()
>> +        self.assert_no_active_block_jobs()
>> +
>> +        self.vm.shutdown()
> 
> It is safe to call self.vm.shutdown() multiple times.  Please call it
> from tearDown() too so the QEMU process is cleaned up on failure.
> 

Thank you, done to all remarks.
