Received: from eggs.gnu.org ([2001:4830:134:3::10]:49576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLsPA-00049F-MG
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLsP7-0000RV-Vu
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:11:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eLsP7-0000Qu-N1
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:11:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4F9nEW034176
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 10:11:30 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2en6h80dj4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 10:11:29 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 08:01:13 -0700
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
	<20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
	<6892975f-87d7-a348-ce21-739fdff4b25e@redhat.com>
	<86ab3a7c-bb8c-5dc6-8f26-995bcf07ef0a@linux.vnet.ibm.com>
	<cfa46ea3-ab0e-d794-cebe-5a6e9fa9a626@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 13:01:07 -0200
MIME-Version: 1.0
In-Reply-To: <cfa46ea3-ab0e-d794-cebe-5a6e9fa9a626@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <e1da55ab-1975-78aa-ae4d-b2ebd9455fbb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>



On 12/04/2017 12:50 PM, Max Reitz wrote:
> On 2017-12-03 21:13, Daniel Henrique Barboza wrote:
>> Hi Max,
>>
>> On 12/01/2017 06:13 PM, Max Reitz wrote:
>>> On 2017-11-16 23:35, Daniel Henrique Barboza wrote:
>>>> This patch implements a test case for the scenario that was failing
>>>> prior to the patch "migration/ram.c: do not set 'postcopy_running' i=
n
>>>> POSTCOPY_INCOMING_END".
>>>>
>>>> This new test file 198 was derived from the test file 181 authored
>>>> by Kevin Wolf.
>>>>
>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>> CC: Max Reitz <mreitz@redhat.com>
>>>> CC: Cleber Rosa <crosa@redhat.com>
>>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>>>
>>>> ---
>>>> I CCed Cleber Rosa because this patch was developed at the same
>>>> time his patch series "[PATCH 00/10] I/O tests cleanups" hit the
>>>> mailing list. Most of the cleanups/fixes he made in the series was
>>>> done in this new test as well.
>>>>
>>>>   tests/qemu-iotests/198     | 110 +++++++++++++++++++++++++++++++++=
++++++++++++
>>>>   tests/qemu-iotests/198.out |  20 +++++++++
>>>>   tests/qemu-iotests/group   |   1 +
>>>>   3 files changed, 131 insertions(+)
>>>>   create mode 100755 tests/qemu-iotests/198
>>>>   create mode 100644 tests/qemu-iotests/198.out
>>> Looks good overall, just two nitpicks below.
>>>
>>>> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
>>>> new file mode 100755
>>>> index 0000000000..786e37fc95
>>>> --- /dev/null
>>>> +++ b/tests/qemu-iotests/198
>>>> @@ -0,0 +1,110 @@
>>>> +#!/bin/bash
>>>> +#
>>>> +# Test savevm and loadvm after live migration with postcopy flag
>>>> +#
>>>> +# Copyright (C) 2017, IBM Corporation.
>>>> +#
>>>> +# This file is derived from tests/qemu-iotests/181 by Kevin Wolf
>>>> +#
>>>> +# This program is free software; you can redistribute it and/or mod=
ify
>>>> +# it under the terms of the GNU General Public License as published=
 by
>>>> +# the Free Software Foundation; either version 2 of the License, or
>>>> +# (at your option) any later version.
>>>> +#
>>>> +# This program is distributed in the hope that it will be useful,
>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +# GNU General Public License for more details.
>>>> +#
>>>> +# You should have received a copy of the GNU General Public License
>>>> +# along with this program.  If not, see <http://www.gnu.org/license=
s/>.
>>>> +#
>>>> +# Creator/Owner : danielhb@linux.vnet.ibm.com
>>>> +
>>>> +seq=3D`basename $0`
>>>> +echo "QA output created by $seq"
>>>> +
>>>> +status=3D1	# failure is the default!
>>>> +
>>>> +MIG_SOCKET=3D"${TEST_DIR}/migrate"
>>>> +
>>>> +# get standard environment, filters and checks
>>>> +. ./common.rc
>>>> +. ./common.filter
>>>> +. ./common.qemu
>>>> +
>>>> +_cleanup()
>>>> +{
>>>> +    rm -f "${MIG_SOCKET}"
>>>> +    _cleanup_test_img
>>>> +    _cleanup_qemu
>>>> +}
>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> +
>>>> +_supported_fmt qcow2
>>>> +_supported_proto generic
>>>> +_supported_os Linux
>>>> +
>>>> +size=3D64M
>>>> +_make_test_img $size
>>>> +
>>>> +echo
>>>> +echo =3D=3D=3D Starting VMs =3D=3D=3D
>>>> +echo
>>>> +
>>>> +qemu_comm_method=3D"monitor"
>>>> +
>>>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>>> +    _launch_qemu \
>>>> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
>>>> +else
>>>> +    _launch_qemu \
>>>> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$=
IMGFMT,id=3Ddisk
>>>> +fi
>>>> +src=3D$QEMU_HANDLE
>>>> +
>>>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>>> +    _launch_qemu \
>>>> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
>>>> +        -incoming "unix:${MIG_SOCKET}"
>>>> +else
>>>> +    _launch_qemu \
>>>> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$=
IMGFMT,id=3Ddisk \
>>>> +        -incoming "unix:${MIG_SOCKET}"
>>>> +fi
>>>> +dest=3D$QEMU_HANDLE
>>>> +
>>>> +echo
>>>> +echo =3D=3D=3D Set \'migrate_set_capability postcopy-ram on\' and m=
igrate =3D=3D=3D
>>>> +echo
>>>> +
>>>> +silent=3Dyes
>>>> +_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qem=
u)"
>>>> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu=
)"
>>>> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
>>>> +
>>>> +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
>>>> +    _send_qemu_cmd $src "info migrate" "completed\|failed"
>>>> +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>>> Would it make sense to query the migration status non-silently here,
>>> too, so that the test output would verify that it has actually succee=
ded?
>>>
>>> (I suppose the savevm/loadvm coming up next would fail if the migrati=
on
>>> failed, but maybe if it's easy enough...)
>> Not exactly non-silently, but we can do something like this:
>>
>>
>> echo
>> echo =3D=3D=3D Check if migration was successful =3D=3D=3D
>> echo
>>
>> QEMU_COMM_TIMEOUT=3D1 silent=3Dyes \
>>  =C2=A0=C2=A0=C2=A0 _send_qemu_cmd $src "info migrate" "completed"
>> silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>>
>>
>> If migration failed, the test will fail with timeout error waiting for
>> "completed"
>> prior to savevm. What do you think?
> Sounds good.  Shouldn't you keep the qemu_cmd_repeat=3D10, though?

I don't think it's needed. The command prior to it was:

+QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
+    _send_qemu_cmd $src "info migrate" "completed\|failed"
+silent=3Dyes _send_qemu_cmd $src "" "(qemu)"


So it's guaranteed that the next 'info migrate' will contain the string
"completed" or "failed".


Daniel


>
> Max
>
