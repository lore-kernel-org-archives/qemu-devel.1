Received: from eggs.gnu.org ([2001:4830:134:3::10]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZ0VL-0008Sv-B1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 16:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZ0VJ-0004Wh-Vc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 16:32:47 -0500
References: <20181214231512.5295-1-jsnow@redhat.com>
	<20181214231512.5295-8-jsnow@redhat.com>
	<3832143d-136d-d282-e487-376f1f38ad44@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f7fa56ed-c000-fad8-bce5-5b57c1a812a0@redhat.com>
Date: Mon, 17 Dec 2018 16:32:35 -0500
MIME-Version: 1.0
In-Reply-To: <3832143d-136d-d282-e487-376f1f38ad44@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>



On 12/17/18 10:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.12.2018 2:15, John Snow wrote:
>> New interface, new smoke test.
>> ---
>>   tests/qemu-iotests/236     | 124 +++++++++++++++++++++++
>>   tests/qemu-iotests/236.out | 200 +++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 325 insertions(+)
>>   create mode 100755 tests/qemu-iotests/236
>>   create mode 100644 tests/qemu-iotests/236.out
>>
>> diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
>> new file mode 100755
>> index 0000000000..edf16c4ab1
>> --- /dev/null
>> +++ b/tests/qemu-iotests/236
>> @@ -0,0 +1,124 @@
>> +#!/usr/bin/env python
>> +#
>> +# Test bitmap merges.
>> +#
>> +# Copyright (c) 2018 John Snow for Red Hat, Inc.
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +# owner=jsnow@redhat.com
>> +
>> +import json
>> +import iotests
>> +from iotests import log
>> +
>> +iotests.verify_image_format(supported_fmts=['qcow2'])
>> +
> 
> we hardcode patterns, so it's better to hardcode size here too:
> 
> size = 64 * 1024 * 1024

If you insist.

> 
>> +patterns = [("0x5d", "0",         "64k"),
>> +            ("0xd5", "1M",        "64k"),
>> +            ("0xdc", "32M",       "64k"),
>> +            ("0xcd", "0x3ff0000", "64k")]  # 64M - 64K
>> +
>> +overwrite = [("0xab", "0",         "64k"), # Full overwrite
>> +             ("0xad", "0x00f8000", "64k"), # Partial-left (1M-32K)
>> +             ("0x1d", "0x2008000", "64k"), # Partial-right (32M+32K)
>> +             ("0xea", "0x3fe0000", "64k")] # Adjacent-left (64M - 128K)
>> +
>> +def query_bitmaps(vm):
>> +    res = vm.qmp("query-block")
>> +    return {device['device']: device['dirty-bitmaps'] for
>> +            device in res['return']}
>> +
>> +with iotests.FilePath('img') as img_path, \
>> +     iotests.VM() as vm:
>> +
>> +    log('--- Preparing image & VM ---\n')
>> +    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, img_path, '64M')
> 
> no needs for qemu_img_pipe, as you don't use its output, qemu_img() is enough and qemu_img_create() is better,
> and the best I think is just:
> 

More cargo cult copy and paste.

> vm.add_drive_raw('id=drive0,driver=null-co,size=' + str(size))
> 
> as qcow2 (and real disk in general) is actually unrelated to the test.
> 

I think I'll leave the image creation in just so that if you run the
test under different formats it'll actually do something vaguely
different, just in case.

Actually, it did highlight how weird VPC is again and I changed the rest
as a result to accommodate image formats that round their disk sizes.

> 
>> +    vm.add_drive(img_path)
>> +    vm.launch()
>> +
>> +    log('--- Adding preliminary bitmaps A & B ---\n')
>> +    vm.qmp_log("block-dirty-bitmap-add", node="drive0", name="bitmapA")
>> +    vm.qmp_log("block-dirty-bitmap-add", node="drive0", name="bitmapB")
>> +
>> +    # Dirties 4 clusters. count=262144
>> +    log('')
>> +    log('--- Emulating writes ---\n')
>> +    for p in patterns:
>> +        cmd = "write -P%s %s %s" % p
>> +        log(cmd)
>> +        log(vm.hmp_qemu_io("drive0", cmd))
>> +
>> +    log(json.dumps(query_bitmaps(vm), indent=2, separators=(',', ': ')))
> 
> log can do json.dumps, so it's strange to do it here, and I don't like ',' separator, as I described

Because it tries to filter the rich object before it converts, as you've
noticed. I think I'll take a page from your book and try to fix log() to
be better.

As for not liking the ',' separator, it should be identical to your
approach because it only removes the space when pretty printing is
enabled. Can you show me what this approach does that you find to be
ugly and how it's different from your regex approach?

--js
