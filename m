Received: from eggs.gnu.org ([2001:4830:134:3::10]:51702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVsj-0002tT-BG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVsh-0005pe-Bh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:38:44 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-8-jsnow@redhat.com>
	<2818268a-ed9e-a106-720c-d65c816d2f2c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a04fe821-e0c7-a99c-ded4-fc4354437883@redhat.com>
Date: Thu, 13 Dec 2018 13:38:32 -0500
MIME-Version: 1.0
In-Reply-To: <2818268a-ed9e-a106-720c-d65c816d2f2c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: add iotest 236 for testing
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/13/18 8:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.12.2018 4:50, John Snow wrote:
>> New interface, new smoke test.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   tests/qemu-iotests/236     | 123 +++++++++++++++++
>>   tests/qemu-iotests/236.out | 265 +++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 389 insertions(+)
>>   create mode 100755 tests/qemu-iotests/236
>>   create mode 100644 tests/qemu-iotests/236.out
>>
>> diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
>> new file mode 100755
>> index 0000000000..3d162e967b
>> --- /dev/null
>> +++ b/tests/qemu-iotests/236
>> @@ -0,0 +1,123 @@
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
>> +import sys
>> +import os
>> +import iotests
>> +from iotests import log
>> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
>> +from qemu import QEMUMachine
> 
> unused, with previous line and, therefore, os and sys modules)
> 

Forgive the copy and paste. I'll trim it down.

>> +
>> +iotests.verify_image_format(supported_fmts=['qcow2'])
>> +
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
>> +with iotests.FilePath('img') as img_path, \
>> +     iotests.VM() as vm:
>> +
>> +    log('--- Preparing image & VM ---\n')
>> +    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, img_path, '64M')
> 
> hm, actually null device is enough here.
> 

Sure.

>> +    vm.add_drive(img_path)
>> +    vm.launch()
>> +
>> +    log('--- Adding preliminary bitmaps A & B ---\n')
>> +    vm.qmp_log("block-dirty-bitmap-add", node="drive0", name="bitmapA")
>> +    vm.qmp_log("block-dirty-bitmap-add", node="drive0", name="bitmapB")
>> +
>> +    # Dirties 4 clusters. count=262144 > +    log('')
>> +    log('--- Emulating writes ---\n')
>> +    for p in patterns:
>> +        cmd = "write -P%s %s %s" % p
>> +        log(cmd)
>> +        log(vm.hmp_qemu_io("drive0", cmd))
>> +
>> +    vm.qmp_log("query-block", indent=2,
>> +               filters=[iotests.filter_generated_node_ids,
>> +                        iotests.filter_testfiles])
> 
> I'm against. query-block prints a lot of unrelated things, which may change from
> version to version (for example, Andrey is now adding bitmap information to qcow2
> format-specific info), then, backported test may fail for previous versions (or just
> different config) because of something absolutely unrelated to bitmaps.
> 

You have a point. I'm only interested in the bitmap info structures, here.

> I think, it should be shortened to result[0]['device'], result[0]['dirty-bitmaps']
> 

OK, let me look at printing something like

{
  "device0": bitmapInfo0,
  "device1": bitmapInfo1,
  ...
}

to the log.

> And, I think, any way it would be good to create a separate helper for printing
> current state of bitmaps (which may output their sha256 too)
> 

Yeah, I was working on a command to do just this but I ran into troubles
with caching the bitmap info for computing it and wound up shelving the
series and I got sidetracked on other issues...

>> +
>> +    log('')
>> +    log('--- Disabling B & Adding C ---\n')
> 
> why not just
> log('\n--- Disabling B & Adding C ---\n')
> 

Just preference, there's no reason.

I have a habit of avoiding pre-pending control characters to string
lines, but don't have an aversion to appending them.

I can change it if it sticks out as too unusual.

> [...]
> 
> Otherwise, the test looks fine for me
> 
> 

Thanks for looking!
