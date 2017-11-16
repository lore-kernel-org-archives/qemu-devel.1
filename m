Received: from eggs.gnu.org ([2001:4830:134:3::10]:43678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFK1a-0007nC-2X
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFK1V-0000vF-Iq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:16:10 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-6-git-send-email-anton.nefedov@virtuozzo.com>
	<5a1b8baf-e583-2142-902e-976fce9ccc40@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <68f2c092-119a-b816-3fd4-86a8aa725b26@virtuozzo.com>
Date: Thu, 16 Nov 2017 16:15:45 +0300
MIME-Version: 1.0
In-Reply-To: <5a1b8baf-e583-2142-902e-976fce9ccc40@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] iotest 030: add compressed
 block-stream test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com



On 15/11/2017 10:51 PM, Max Reitz wrote:
> On 2017-11-14 11:16, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/030     | 69 +++++++++++++++++++++++++++++++++++++++++++++-
>>   tests/qemu-iotests/030.out |  4 +--
>>   2 files changed, 70 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>> index 1883894..52cbe5d 100755
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
>> @@ -800,5 +800,72 @@ class TestSetSpeed(iotests.QMPTestCase):
>>   
>>           self.cancel_and_wait()
>>   
>> +class TestCompressed(iotests.QMPTestCase):
>> +    supported_fmts = ['qcow2']
>> +    cluster_size = 64 * 1024;
>> +    image_len = 1 * 1024 * 1024;
>> +
>> +    def setUp(self):
>> +        qemu_img('create', backing_img, str(TestCompressed.image_len))
> 
> First, this is missing the '-f raw', if you want to keep it in line with
> the next command.
> 
>> +        qemu_io('-f', 'raw', '-c', 'write -P 1 0 ' + str(TestCompressed.image_len), backing_img)
> 
> But why would you want this to be raw?
> 

Copied this from another test in this file :)
The source image format does not really matter. Will fix though.

>> +        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
>> +
>> +        # write '4' in every 4th cluster
>> +        step=4
> 
> I'd prefer spaces around operators.  (Also in _pattern() and in the call
> to pattern ([1,4,2] should be [1, 4, 2]).)
> 
>> +        for i in range(TestCompressed.image_len / TestCompressed.cluster_size / step + 1):
> 
> As far as I know, range() has an actual step parameter, maybe that would
> be simpler -- and I don't know what the +1 is supposed to mean.
> 
> How about "for ofs in range(0, TestCompressed.image_len,
>                              TestCompressed.cluster_size * step)"?
> Would that work?
> 

It does, thank you.

>> +            qemu_io('-c', 'write -P %d %d %d' %
>> +                    (step, step * i * TestCompressed.cluster_size,> +                     TestCompressed.cluster_size),
>> +                    test_img)
>> +
>> +        self.vm = iotests.VM().add_drive(test_img)
>> +        self.vm.launch()
>> +
>> +    def tearDown(self):
>> +        os.remove(test_img)
>> +        os.remove(backing_img)
>> +
>> +    def _pattern(self, x, divs):
>> +        return divs[-1] if not x%divs[-1] else self._pattern(x, divs[:-1])
> 
> I have no idea what this function does.
> 
> ...OK, having looked into how it's used, I understand better.  A comment
> would certainly be helpful, though.
> 
> Maybe also call it differently.  It doesn't really return a pattern.
> What this function does is it returns the first integer from @divs
> (starting from the end, which is weird) which is a divider of @x.  So
> maybe call it _first_divider(self, x, dividers), that would help already.
> 

Yeah, I really had to comment.

Exactly, it starts from the end as I meant it to accept numbers in the 
order they were written. So 'first_divider' wouldn't be right.
Not that important though, will rename and reorder the input.


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
>> +        # write '2' in every 2nd cluster
>> +        step = 2
>> +        for i in range(TestCompressed.image_len / TestCompressed.cluster_size / step + 1):
>> +            result = self.vm.qmp('human-monitor-command',
>> +                                 command_line=
>> +                                 'qemu-io drive0 \"write -P %d %d %d\"' %
> 
> Just " instead of \" would be enough, I think.
> 
Done.

>> +                                 (step, step * i * TestCompressed.cluster_size,
>> +                                  TestCompressed.cluster_size))
>> +            self.assert_qmp(result, 'return', "")
>> +
>> +        self.wait_until_completed()
>> +        self.assert_no_active_block_jobs()
>> +
>> +        self.vm.shutdown()
>> +
>> +        for i in range(TestCompressed.image_len / TestCompressed.cluster_size):
>> +            outp = qemu_io('-c', 'read -P %d %d %d' %
>> +                           (self._pattern(i, [1,4,2]),
> 
> The 4 is useless, because everything that's divisible by 4 is divisible
> by 2 already.
> 
> Also, I don't quite see what this should achieve exactly.  You first
> write the backing image full of 1s, OK.  Then you write 4s to every
> fourth cluster in the top image.  Then you start streaming, and then you
> write 2s to ever second cluster in the top image, which overwrites all
> of the 4s you wrote.
> 
> Do you maybe not want to write 2 into every second cluster of the
> backing image in setUp() instead of 4 into the top image?  (And then 4th
> into every fourth cluster here in test_compressed().)  Then you would
> need [1, 2, 4] here, which makes much more sense.
> 
> Max
> 

Then the top image would be empty before stream starts.
Not very good as qmp-driven writes may be late and just overwrite
clusters of the image fully copied from backing.

I meant the concurrent write touching both top and backing clusters.
2 and 4 were a bad choice though.

I think setUp() should write every 3 to the top (so we have unallocated 
cluster pairs to cover qcow2 writing several clusters compressed).
And test_compressed() write every 4 with qmp.

>> +                            i * TestCompressed.cluster_size,
>> +                            TestCompressed.cluster_size),
>> +                           test_img)
>> +            self.assertTrue(not 'fail' in outp)
>> +            self.assertTrue('read' in outp and 'at offset' in outp)
>> +
>> +        self.assertTrue(
>> +            "File contains external, encrypted or compressed clusters."
>> +            in qemu_img_pipe('map', test_img))
>> +
>>   if __name__ == '__main__':
>>       iotests.main(supported_fmts=['qcow2', 'qed'])
>> diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
>> index 391c857..42314e9 100644
>> --- a/tests/qemu-iotests/030.out
>> +++ b/tests/qemu-iotests/030.out
>> @@ -1,5 +1,5 @@
>> -.......................
>> +........................
>>   ----------------------------------------------------------------------
>> -Ran 23 tests
>> +Ran 24 tests
>>   
>>   OK
>>
> 
> 
