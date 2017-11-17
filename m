Received: from eggs.gnu.org ([2001:4830:134:3::10]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eFgtm-0008Bl-14
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eFgti-0005yP-Ou
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:41:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eFgti-0005wQ-Ff
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:41:34 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAHDcoJU012203
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 08:41:29 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e9xuhdqqp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 08:41:28 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 17 Nov 2017 08:41:27 -0500
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
	<20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
	<4ab78f2c-7088-81b4-2c5c-13a88bd8e75c@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2017 11:41:21 -0200
MIME-Version: 1.0
In-Reply-To: <4ab78f2c-7088-81b4-2c5c-13a88bd8e75c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <08120201-7700-92d3-cfe2-8ece56dee166@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] tests/qemu-iotests: adding
 savevm/loadvm with postcopy flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 11/17/2017 11:24 AM, Cleber Rosa wrote:
>
> On 11/16/2017 05:35 PM, Daniel Henrique Barboza wrote:
>> This patch implements a test case for the scenario that was failing
>> prior to the patch "migration/ram.c: do not set 'postcopy_running' in
>> POSTCOPY_INCOMING_END".
>>
>> This new test file 198 was derived from the test file 181 authored
>> by Kevin Wolf.
>>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Cleber Rosa <crosa@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>
>> ---
>> I CCed Cleber Rosa because this patch was developed at the same
>> time his patch series "[PATCH 00/10] I/O tests cleanups" hit the
>> mailing list. Most of the cleanups/fixes he made in the series was
>> done in this new test as well.
>>
> Your test looks like a positive review/validation of (some of) the
> changes proposed in the "[PATCH 00/10] I/O tests cleanups" indeed.
>
> Thanks for noticing that and for the CC.

No problem!

And unless I missed something, the only proposed change that wasn't
applied here is the one from " [PATCH 04/10] qemu-iotests: include (source)
filters from common.rc" because it relies on changes in
tests/qemu-iotests/common.rc.


Daniel
> - Cleber.
>
>>   tests/qemu-iotests/198     | 110 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/198.out |  20 +++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 131 insertions(+)
>>   create mode 100755 tests/qemu-iotests/198
>>   create mode 100644 tests/qemu-iotests/198.out
>>
>> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
>> new file mode 100755
>> index 0000000000..786e37fc95
>> --- /dev/null
>> +++ b/tests/qemu-iotests/198
>> @@ -0,0 +1,110 @@
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
>> +#
>> +# Creator/Owner : danielhb@linux.vnet.ibm.com
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
>> +echo === On destination, execute savevm and loadvm ===
>> +echo
>> +
>> +silent=
>> +_send_qemu_cmd $dest 'savevm state1"' "(qemu)"
>> +_send_qemu_cmd $dest 'loadvm state1"' "(qemu)"
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
>> diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
>> new file mode 100644
>> index 0000000000..6c27303857
>> --- /dev/null
>> +++ b/tests/qemu-iotests/198.out
>> @@ -0,0 +1,20 @@
>> +QA output created by 198
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>> +
>> +=== Starting VMs ===
>> +
>> +
>> +=== Set 'migrate_set_capability postcopy-ram on' and migrate ===
>> +
>> +
>> +=== On destination, execute savevm and loadvm ===
>> +
>> +(qemu) savevm state1"
>> +(qemu) loadvm state1"
>> +
>> +=== Shut down and check image ===
>> +
>> +(qemu) quit
>> +(qemu) quit
>> +No errors were found on the image.
>> +*** done
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 24e5ad1b79..84d082bc38 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -194,3 +194,4 @@
>>   194 rw auto migration quick
>>   195 rw auto quick
>>   197 rw auto quick
>> +198 rw auto migration
>>
