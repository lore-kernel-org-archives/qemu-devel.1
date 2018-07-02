Received: from eggs.gnu.org ([2001:4830:134:3::10]:35940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZyPe-0008SX-Oc
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZyPc-00039e-Bz
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:58:38 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-4-vsementsov@virtuozzo.com>
	<fadc548f-0cde-769a-8523-80fa0a28ac81@redhat.com>
	<73a74a66-1a16-5cb5-1851-3598c908700b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9e15200a-4b25-d9d3-54ae-397dce8afdd9@virtuozzo.com>
Date: Mon, 2 Jul 2018 15:58:22 +0300
MIME-Version: 1.0
In-Reply-To: <73a74a66-1a16-5cb5-1851-3598c908700b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Image fleecing test
 case 222
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org

30.06.2018 00:04, John Snow wrote:
>
> On 06/29/2018 01:58 PM, Eric Blake wrote:
>> On 06/29/2018 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> From: Fam Zheng <famz@redhat.com>
>>>
>>> This tests the workflow of creating a lightweight point-in-time snapshot
>>> with blockdev-backup command, and exporting it with built-in NBD server.
>>>
>>> It's tested that any post-snapshot writing to the original device
>>> doesn't change data seen in NBD target.
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> [vsementsov: add -f iotests.imgfmt to qemu_io, fix target_img to be
>>> always qcow2, add -r to qemu_io for nbd, add fleecing-filter layer,
>>> wrap long lines]
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> For my own records: Fam's most recent post was:
>> https://lists.gnu.org/archive/html/qemu-devel/2014-05/msg03895.html
>> [Qemu-devel] [PATCH v20 15/15] qemu-iotests: Image fleecing test case 089
>>
>> Wow - has it really been FOUR YEARS since we first proposed this?
>>
> Yup...
>
>> I'm trying to figure out why that original post was abandoned; it looks
>> like:
>> https://lists.gnu.org/archive/html/qemu-devel/2014-05/msg04333.html
>>
>> split that v20 series into stuff that was ready (which made it in back
>> then), and stuff that was still undergoing comments (which then stalled
>> and got lost in the shuffle until now).
>>
>> My next question: how does this compare to John's recent patch?  And how
>> much of Fam's original work did John borrow (that self.patterns array
>> looks pretty common, now that I'm looking at multiple mails - although
>> John's version lacks any commit message body):
>> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08594.html
>>
> Mine was indeed inspired by Fam's version, but I opted to rewrite it
> instead of continue with the python unit tests approach. This is why I
> lost the commit message, existing copyright text, etc.
>
> I can re-add him as author credit to my version, or at least mention in
> the commit message that it was based on a proposed test that he wrote.
>
> I'm sorry if that was a faux pas.
>
>> And given the iterative improvements that have gone into John's version
>> (such as checking that the fleece image reads overwritten zeroes just as
>> correctly as overwritten data), we definitely need to merge the two
>> approaches into one patch.
>>
> And before we do that, getting to the bottom of patch 2/3 in this series
> is in order.
>
>>> +++ b/tests/qemu-iotests/222
>>> @@ -0,0 +1,112 @@
>>> +#!/usr/bin/env python
>>> +#
>>> +# Tests for image fleecing (point in time snapshot export to NBD)
>>> +#
>>> +# Copyright (C) 2014 Red Hat, Inc.
>>> +#
>> Interesting copyright line; it matches Fam's original post (and the fact
>> that you kept him as author); whereas John's version had the humorous:
>>
>> +# Copyright (C) 2018 Red Hat, Inc.
>> +# John helped, too.
>>
>>> +# Based on 055.
>> Is this information still useful? John dropped it.
>>
> My version started with a blank test which was based on an unmerged
> test, so it didn't have anything useful to reference as a "source." If
> we keep the python unit test style here, keeping this line is fine.
>
>>> +
>>> +test_img = os.path.join(iotests.test_dir, 'test.img')
>>> +target_img = os.path.join(iotests.test_dir, 'target.img')
>>> +nbd_sock = os.path.join(iotests.test_dir, 'nbd.sock')
>>> +
>>> +class TestImageFleecing(iotests.QMPTestCase):
>>> +    image_len = 64 * 1024 * 1024 # MB
>>> +
>>> +    def setUp(self):
>>> +        # Write data to the image so we can compare later
>>> +        qemu_img('create', '-f', iotests.imgfmt, test_img,
>>> +                 str(TestImageFleecing.image_len))
>> Difference in style between nested methods of a class, vs. directly
>> using 'with iotests.FilePath(..., iotests.VM() as vm:'
>>
> Because this version will use the cleanup infrastructure as part of the
> unit tests, unlike the python scripting approach which needs to manage
> its own cleanup.
>
>>> +        self.patterns = [
>>> +                ("0x5d", "0", "64k"),
>>> +                ("0xd5", "1M", "64k"),
>>> +                ("0xdc", "32M", "64k"),
>>> +                ("0xdc", "67043328", "64k")]
>> John spelled it:
>>   ("0xcd", "0x3ff0000", "64k"]  # 64M - 64K
>>
>> The 0xdc vs. 0xcd doesn't matter all that much, but having distinct
>> patterns in distinct ranges is kind of nice if we have to later inspect
>> a file.
>>
> I felt like the hex aided clarity to show which cluster we were
> targeting. I'm not very good at reading raw byte values.
>
>>> +
>>> +        for p in self.patterns:
>>> +            qemu_io('-f', iotests.imgfmt, '-c', 'write -P%s %s %s' % p,
>>> +                    test_img)
>>> +
>>> +        qemu_img('create', '-f', 'qcow2', target_img,
>>> +                 str(TestImageFleecing.image_len))
>>> +
>>> +        self.vm = iotests.VM().add_drive(test_img)
>>> +        self.vm.launch()
>>> +
>>> +        self.overwrite_patterns = [
>>> +                ("0xa0", "0", "64k"),
>>> +                ("0x0a", "1M", "64k"),
>>> +                ("0x55", "32M", "64k"),
>>> +                ("0x56", "67043328", "64k")]
>>> +
>>> +        self.nbd_uri = "nbd+unix:///drive1?socket=%s" % nbd_sock
>>> +
>>> +    def tearDown(self):
>>> +        self.vm.shutdown()
>>> +        os.remove(test_img)
>>> +        os.remove(target_img)
>> I'm not seeing anything that stops the NBD server; John's version added
>> that at my insistence.
>>
>>> +
>>> +    def verify_patterns(self):
>>> +        for p in self.patterns:
>>> +            self.assertEqual(
>>> +                    -1,
>>> +                    qemu_io(self.nbd_uri, '-r', '-c', 'read -P%s %s
>>> %s' % p)
>>> +                        .find("verification failed"),
>>> +                    "Failed to verify pattern: %s %s %s" % p)
>>> +
>>> +    def test_image_fleecing(self):
>>> +        result = self.vm.qmp("blockdev-add", **{
>>> +            "driver": "fleecing-filter",
>>> +            "node-name": "drive1",
>>> +            "file": {
>>> +                "driver": "qcow2",
>>> +                "file": {
>>> +                    "driver": "file",
>>> +                    "filename": target_img,
>>> +                    },
>>> +                "backing": "drive0",
>>> +            }
>>> +            })
>>> +        self.assert_qmp(result, 'return', {})
>>> +
>>> +        result = self.vm.qmp(
>>> +                "nbd-server-start",
>>> +                **{"addr": { "type": "unix", "data": { "path":
>>> nbd_sock } } })
>>> +        self.assert_qmp(result, 'return', {})
>>> +        result = self.vm.qmp("blockdev-backup", device="drive0",
>>> +                             target="drive1", sync="none")
>>> +        self.assert_qmp(result, 'return', {})
>>> +        result = self.vm.qmp("nbd-server-add", device="drive1")
>>> +        self.assert_qmp(result, 'return', {})
>>> +
>>> +        self.verify_patterns()
>>> +
>>> +        for p in self.overwrite_patterns:
>>> +            self.vm.hmp_qemu_io("drive0", "write -P%s %s %s" % p)
>>> +
>>> +        self.verify_patterns()
>>> +
>>> +        self.cancel_and_wait(resume=True)
>>> +        self.assert_no_active_block_jobs()
>>> +
>>> +if __name__ == '__main__':
>>> +    iotests.main(supported_fmts=['raw', 'qcow2'])
>>> diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
>>> new file mode 100644
>>> index 0000000000..ae1213e6f8
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/222.out
>>> @@ -0,0 +1,5 @@
>>> +.
>>> +----------------------------------------------------------------------
>>> +Ran 1 tests
>>> +
>> I also much prefer the output style that resulted in John's version.
>>
> Yes, I think the "python script" style is superior because you can get
> debug printfs from a test build of QEMU into the diff output instead of
> having to edit the iotests infrastructure to stop deleting the logs so
> you can read them.

infrastructure for python unittest based tests definitely should be 
improved..

>
>>> +OK
>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>> index eea75819d2..8019a9f721 100644
>>> --- a/tests/qemu-iotests/group
>>> +++ b/tests/qemu-iotests/group
>>> @@ -220,3 +220,4 @@
>>>    218 rw auto quick
>>>    219 rw auto
>>>    221 rw auto quick
>>> +222 rw auto quick
>>>
> I would prefer to use "my" version as a base, but we can modify it to
> use the fleecing filter if that winds up being requisite. Your patch 1/3
> is better, though.

Ok, no objections

-- 
Best regards,
Vladimir
