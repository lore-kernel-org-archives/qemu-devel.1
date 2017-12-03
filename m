Received: from eggs.gnu.org ([2001:4830:134:3::10]:59638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLadh-0001nb-DH
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 15:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLade-0000Hd-3x
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 15:13:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eLadd-0000H7-Qw
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 15:13:22 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB3KBg18094998
	for <qemu-devel@nongnu.org>; Sun, 3 Dec 2017 15:13:18 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2emgjqddwq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 15:13:17 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Sun, 3 Dec 2017 13:13:16 -0700
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
	<20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
	<6892975f-87d7-a348-ce21-739fdff4b25e@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Sun, 3 Dec 2017 18:13:10 -0200
MIME-Version: 1.0
In-Reply-To: <6892975f-87d7-a348-ce21-739fdff4b25e@redhat.com>
Content-Language: en-US
Message-Id: <86ab3a7c-bb8c-5dc6-8f26-995bcf07ef0a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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

Hi Max,

On 12/01/2017 06:13 PM, Max Reitz wrote:
> On 2017-11-16 23:35, Daniel Henrique Barboza wrote:
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
>>   tests/qemu-iotests/198     | 110 +++++++++++++++++++++++++++++++++++=
++++++++++
>>   tests/qemu-iotests/198.out |  20 +++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 131 insertions(+)
>>   create mode 100755 tests/qemu-iotests/198
>>   create mode 100644 tests/qemu-iotests/198.out
> Looks good overall, just two nitpicks below.
>
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
>> +# This program is free software; you can redistribute it and/or modif=
y
>> +# it under the terms of the GNU General Public License as published b=
y
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>> +#
>> +# Creator/Owner : danielhb@linux.vnet.ibm.com
>> +
>> +seq=3D`basename $0`
>> +echo "QA output created by $seq"
>> +
>> +status=3D1	# failure is the default!
>> +
>> +MIG_SOCKET=3D"${TEST_DIR}/migrate"
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
>> +size=3D64M
>> +_make_test_img $size
>> +
>> +echo
>> +echo =3D=3D=3D Starting VMs =3D=3D=3D
>> +echo
>> +
>> +qemu_comm_method=3D"monitor"
>> +
>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>> +    _launch_qemu \
>> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
>> +else
>> +    _launch_qemu \
>> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IM=
GFMT,id=3Ddisk
>> +fi
>> +src=3D$QEMU_HANDLE
>> +
>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>> +    _launch_qemu \
>> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
>> +        -incoming "unix:${MIG_SOCKET}"
>> +else
>> +    _launch_qemu \
>> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IM=
GFMT,id=3Ddisk \
>> +        -incoming "unix:${MIG_SOCKET}"
>> +fi
>> +dest=3D$QEMU_HANDLE
>> +
>> +echo
>> +echo =3D=3D=3D Set \'migrate_set_capability postcopy-ram on\' and mig=
rate =3D=3D=3D
>> +echo
>> +
>> +silent=3Dyes
>> +_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)=
"
>> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
>> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
>> +
>> +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
>> +    _send_qemu_cmd $src "info migrate" "completed\|failed"
>> +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
> Would it make sense to query the migration status non-silently here,
> too, so that the test output would verify that it has actually succeede=
d?
>
> (I suppose the savevm/loadvm coming up next would fail if the migration
> failed, but maybe if it's easy enough...)

Not exactly non-silently, but we can do something like this:


echo
echo =3D=3D=3D Check if migration was successful =3D=3D=3D
echo

QEMU_COMM_TIMEOUT=3D1 silent=3Dyes \
 =C2=A0=C2=A0=C2=A0 _send_qemu_cmd $src "info migrate" "completed"
silent=3Dyes _send_qemu_cmd $src "" "(qemu)"


If migration failed, the test will fail with timeout error waiting for=20
"completed"
prior to savevm. What do you think?


>
>> +
>> +echo
>> +echo =3D=3D=3D On destination, execute savevm and loadvm =3D=3D=3D
>> +echo
>> +
>> +silent=3D
>> +_send_qemu_cmd $dest 'savevm state1"' "(qemu)"
>> +_send_qemu_cmd $dest 'loadvm state1"' "(qemu)"
> Any specific reason why the snapshot name has a trailing double quote?

No reason, just an ugly that slipped by. I'll remove it in the next versi=
on.



Thanks,


Daniel


>
> Max
>
>> +
>> +echo
>> +echo =3D=3D=3D Shut down and check image =3D=3D=3D
>> +echo
>> +
>> +_send_qemu_cmd $src 'quit' ""
>> +_send_qemu_cmd $dest 'quit' ""
>> +wait=3D1 _cleanup_qemu
>> +
>> +_check_test_img
>> +
>> +# success, all done
>> +echo "*** done"
>> +status=3D0
>> diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
>> new file mode 100644
>> index 0000000000..6c27303857
>> --- /dev/null
>> +++ b/tests/qemu-iotests/198.out
>> @@ -0,0 +1,20 @@
>> +QA output created by 198
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> +
>> +=3D=3D=3D Starting VMs =3D=3D=3D
>> +
>> +
>> +=3D=3D=3D Set 'migrate_set_capability postcopy-ram on' and migrate =3D=
=3D=3D
>> +
>> +
>> +=3D=3D=3D On destination, execute savevm and loadvm =3D=3D=3D
>> +
>> +(qemu) savevm state1"
>> +(qemu) loadvm state1"
>> +
>> +=3D=3D=3D Shut down and check image =3D=3D=3D
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
>
