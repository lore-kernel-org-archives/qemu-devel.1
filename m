Received: from eggs.gnu.org ([2001:4830:134:3::10]:35515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVxFa-0005SC-2c
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVxFZ-0003PI-7C
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:18:50 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:1674 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVxFY-0003Mk-Rq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:18:49 -0500
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
	<20170124075949.GD27126@lemon.Home>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <22f99aae-0968-286f-186c-0eaefadbe649@virtuozzo.com>
Date: Tue, 24 Jan 2017 12:18:36 +0300
MIME-Version: 1.0
In-Reply-To: <20170124075949.GD27126@lemon.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/21] backup: skip unallocated clusters
 for full mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com, jcody@redhat.com

24.01.2017 10:59, Fam Zheng wrote:
> On Fri, 12/23 17:28, Vladimir Sementsov-Ogievskiy wrote:
>> diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
>> index 1d3fd04..388b7b2 100755
>> --- a/tests/qemu-iotests/055
>> +++ b/tests/qemu-iotests/055
>> @@ -30,6 +30,7 @@ target_img = os.path.join(iotests.test_dir, 'target.img')
>>   blockdev_target_img = os.path.join(iotests.test_dir, 'blockdev-target.img')
>>   
>>   image_len = 64 * 1024 * 1024 # MB
>> +pause_write = '3M'
>>   
>>   def setUpModule():
>>       qemu_img('create', '-f', iotests.imgfmt, test_img, str(image_len))
>> @@ -39,6 +40,7 @@ def setUpModule():
>>       qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xd5 1M 32k', test_img)
>>       qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 32M 124k', test_img)
>>       qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x33 67043328 64k', test_img)
>> +    qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 40M ' + pause_write, test_img)
> What does this iotest change do?

Without this backup block-job finishes before the next query to it from 
test and test fails. This is a wide problem I suffer of on the way of 
backup improvement and it should have better solution then adjusting 
amount of data being copied...

>
> Fam
>
>>   
>>   def tearDownModule():
>>       os.remove(test_img)
>> -- 
>> 1.8.3.1
>>


-- 
Best regards,
Vladimir
