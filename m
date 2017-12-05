Received: from eggs.gnu.org ([2001:4830:134:3::10]:54211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMIwr-00045p-DT
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMIwm-000384-VR
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:32:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMIwm-00037P-LV
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:32:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5JSYGO008918
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 14:32:01 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eny1qrjb1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 14:32:01 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 12:32:00 -0700
References: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
	<20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
	<20171205180612.GB2969@work-vm>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 17:31:53 -0200
MIME-Version: 1.0
In-Reply-To: <20171205180612.GB2969@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <3b62cb3c-11d4-6215-1e14-b1abb9ba59d5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] tests/qemu-iotests: adding
 savevm/loadvm with postcopy flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>



On 12/05/2017 04:06 PM, Dr. David Alan Gilbert wrote:
> * Daniel Henrique Barboza (danielhb@linux.vnet.ibm.com) wrote:
>> This patch implements a test case for the scenario that was failing
>> prior to the patch "migration/ram.c: do not set 'postcopy_running' in
>> POSTCOPY_INCOMING_END", commit acab30b85d.
>>
>> This new test file 201 was derived from the test file 181 authored
>> by Kevin Wolf.
> The test is interesting because it enables postcopy but never triggers
> postcopy entry (using migrate_start_postcopy).  Still it's a good path
> to check.
>
> It will fail to enable postcopy on older linux hosts or non-linux hosts
> that don't have userfault though; I'm not sure how your test fails
> with that.
Hmmm I am not sure either. I have tested it with Travis and it passed 
all tests,
including a claimed Mac OS environment. Not sure if that counts.

I'll see if I can get this tested on a Windows env to see how this test 
fails.


Daniel

>
> Dave
>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Cleber Rosa <crosa@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>   tests/qemu-iotests/201     | 116 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/201.out |  23 +++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 140 insertions(+)
>>   create mode 100755 tests/qemu-iotests/201
>>   create mode 100644 tests/qemu-iotests/201.out
>>
>> diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
>> new file mode 100755
>> index 0000000000..9b6e23bbfc
>> --- /dev/null
>> +++ b/tests/qemu-iotests/201
>> @@ -0,0 +1,116 @@
>> +#!/bin/bash
>> +#
>> +# Test savevm and loadvm after live migration with postcopy flag
>> +#
>> +# Copyright (C) 2017, IBM Corporation.
>> +#
>> +# This file is derived from tests/qemu-iotests/181 by Kevin Wolf
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
>> +
>> +seq=`basename $0`
>> +echo "QA output created by $seq"
>> +
>> +status=1	# failure is the default!
>> +
>> +MIG_SOCKET="${TEST_DIR}/migrate"
>> +
>> +# get standard environment, filters and checks
>> +. ./common.rc
>> +. ./common.filter
>> +. ./common.qemu
>> +
>> +_cleanup()
>> +{
>> +    rm -f "${MIG_SOCKET}"
>> +    _cleanup_test_img
>> +    _cleanup_qemu
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_supported_fmt qcow2
>> +_supported_proto generic
>> +_supported_os Linux
>> +
>> +size=64M
>> +_make_test_img $size
>> +
>> +echo
>> +echo === Starting VMs ===
>> +echo
>> +
>> +qemu_comm_method="monitor"
>> +
>> +if [ "$IMGOPTSSYNTAX" = "true" ]; then
>> +    _launch_qemu \
>> +        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk
>> +else
>> +    _launch_qemu \
>> +        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
>> +fi
>> +src=$QEMU_HANDLE
>> +
>> +if [ "$IMGOPTSSYNTAX" = "true" ]; then
>> +    _launch_qemu \
>> +        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk \
>> +        -incoming "unix:${MIG_SOCKET}"
>> +else
>> +    _launch_qemu \
>> +        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
>> +        -incoming "unix:${MIG_SOCKET}"
>> +fi
>> +dest=$QEMU_HANDLE
>> +
>> +echo
>> +echo === Set \'migrate_set_capability postcopy-ram on\' and migrate ===
>> +echo
>> +
>> +silent=yes
>> +_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
>> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
>> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
>> +
>> +QEMU_COMM_TIMEOUT=1 qemu_cmd_repeat=10 silent=yes \
>> +    _send_qemu_cmd $src "info migrate" "completed\|failed"
>> +silent=yes _send_qemu_cmd $src "" "(qemu)"
>> +
>> +echo
>> +echo === Check if migration was successful ===
>> +echo
>> +
>> +QEMU_COMM_TIMEOUT=1 silent=yes \
>> +    _send_qemu_cmd $src "info migrate" "completed"
>> +silent=yes _send_qemu_cmd $src "" "(qemu)"
>> +
>> +echo
>> +echo === On destination, execute savevm and loadvm ===
>> +echo
>> +
>> +silent=
>> +_send_qemu_cmd $dest 'savevm state1' "(qemu)"
>> +_send_qemu_cmd $dest 'loadvm state1' "(qemu)"
>> +
>> +echo
>> +echo === Shut down and check image ===
>> +echo
>> +
>> +_send_qemu_cmd $src 'quit' ""
>> +_send_qemu_cmd $dest 'quit' ""
>> +wait=1 _cleanup_qemu
>> +
>> +_check_test_img
>> +
>> +# success, all done
>> +echo "*** done"
>> +status=0
>> diff --git a/tests/qemu-iotests/201.out b/tests/qemu-iotests/201.out
>> new file mode 100644
>> index 0000000000..9faf06f996
>> --- /dev/null
>> +++ b/tests/qemu-iotests/201.out
>> @@ -0,0 +1,23 @@
>> +QA output created by 201
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>> +
>> +=== Starting VMs ===
>> +
>> +
>> +=== Set 'migrate_set_capability postcopy-ram on' and migrate ===
>> +
>> +
>> +=== Check if migration was successful ===
>> +
>> +
>> +=== On destination, execute savevm and loadvm ===
>> +
>> +(qemu) savevm state1
>> +(qemu) loadvm state1
>> +
>> +=== Shut down and check image ===
>> +
>> +(qemu) quit
>> +(qemu) quit
>> +No errors were found on the image.
>> +*** done
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 3e688678dd..c16bc2c5e2 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -197,3 +197,4 @@
>>   197 rw auto quick
>>   198 rw auto
>>   200 rw auto
>> +201 rw auto migration
>> -- 
>> 2.13.6
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
