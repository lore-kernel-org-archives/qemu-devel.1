Received: from eggs.gnu.org ([2001:4830:134:3::10]:45533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMBh5-0005dT-Hn
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMBh1-0005Uv-Iv
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:47:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45826
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMBh1-0005UY-CM
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:47:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5Bi9xT094316
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 06:47:16 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ensv8kdvp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 06:47:16 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 06:47:15 -0500
References: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
	<20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
	<8435b741-1bfc-fbe8-baa8-00bc98e60e0f@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 09:47:09 -0200
MIME-Version: 1.0
In-Reply-To: <8435b741-1bfc-fbe8-baa8-00bc98e60e0f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0a28bdcd-907f-fc9f-8b35-65a15d8bfae9@linux.vnet.ibm.com>
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>



On 12/04/2017 08:23 PM, Max Reitz wrote:
> On 2017-12-04 16:17, Daniel Henrique Barboza wrote:
>> This patch implements a test case for the scenario that was failing
>> prior to the patch "migration/ram.c: do not set 'postcopy_running' in
>> POSTCOPY_INCOMING_END", commit acab30b85d.
>>
>> This new test file 201 was derived from the test file 181 authored
>> by Kevin Wolf.
>>
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
> Sorry, I had to unqueue the patch again, because I only just saw there's
> something like
>
>> # Internal snapshots are (currently) impossible with refcount_bits=1
>> _unsupported_imgopts 'refcount_bits=1[^0-9]'
> missing here (taken from 080).
>
> (Without that, the test fails with
>   $ ./check -T -qcow2 -o refcount_bits=1 201
> )
>
> I could have added it myself, but that seemed a bit too much of a change
> to me...

No problem, I'll resend with that extra instruction.

I have a question though: is there a way to run a qemu-iotest with all the
parameters combinations (image type, image protocol ...) that the test must
support?


Thanks,


Daniel


>
> Max
>
>> +
>> +size=64M
>> +_make_test_img $size
