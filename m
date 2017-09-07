Received: from eggs.gnu.org ([2001:4830:134:3::10]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dpo2p-0005k6-5T
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 00:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dpo2j-0001bx-1J
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 00:03:58 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:33504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dpo2h-0001YW-Nd
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 00:03:52 -0400
Date: Thu, 7 Sep 2017 09:33:38 +0530 (IST)
From: Ishani <chugh.ishani@research.iiit.ac.in>
Message-ID: <487942674.1966626.1504757018811.JavaMail.zimbra@research.iiit.ac.in>
In-Reply-To: <5b41f64d-3a13-4314-4f0e-29864c940c2b@redhat.com>
References: <1504120538-9309-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504120538-9309-4-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170831020210.GF17741@lemon.lan>
	<5b41f64d-3a13-4314-4f0e-29864c940c2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] Backup Tool: Test for Incremental
 Backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow <jsnow@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, stefanha <stefanha@redhat.com>

Hello,
I apologize for late reply. I was occupied by exams.
I will send a revision asap. 
Thanks.

----- On Sep 2, 2017, at 4:23 AM, jsnow jsnow@redhat.com wrote:

> On 08/30/2017 10:02 PM, Fam Zheng wrote:
>> On Thu, 08/31 00:45, Ishani Chugh wrote:
>>> This patch is the test for incremental backup implementation in Backup tool.
>>> The test employs two basic subtests:
>>> 1) Backing up an empty guest and comparing it with base image.
>>> 2) Writing a pattern to the guest, creating backup, writing
>>>    a pattern again, creating backup and comparing with base image.
>>>
>>> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
>>> ---
>>>  tests/qemu-iotests/193     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  tests/qemu-iotests/193.out | 34 ++++++++++++++++++
>>>  tests/qemu-iotests/group   |  1 +
>>>  3 files changed, 121 insertions(+)
>>>  create mode 100755 tests/qemu-iotests/193
>>>  create mode 100644 tests/qemu-iotests/193.out
>>>
>>> diff --git a/tests/qemu-iotests/193 b/tests/qemu-iotests/193
>>> new file mode 100755
>>> index 0000000..500e5df
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/193
>>> @@ -0,0 +1,86 @@
>>> +#!/bin/bash
>>> +#
>>> +# Test Incremental backup functionality of qemu-backup tool
>>> +#
>>> +# Copyright (C) 2009 Red Hat, Inc.
>> 
>> Year is off, probably the copyright holder too?
>> 
> 
> Yup, please take credit for your own work, Ishani :)
> 
>>> +#
>>> +# This program is free software; you can redistribute it and/or modify
>>> +# it under the terms of the GNU General Public License as published by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>> +#
>>> +
>>> +# creator
>>> +owner=chugh.ishani@research.iiit.ac.in
>>> +
>>> +seq=`basename $0`
>>> +echo "QA output created by $seq"
>>> +
>>> +here=`pwd`
>>> +status=1	# failure is the default!
>> 
>> s/\t/ /
>> 
> 
> Fam means to remove the tab here and use spaces instead.
> 
>>> +
>>> +
>>> +# get standard environment, filters and checks
>>> +. ./common.rc
>>> +. ./common.filter
>>> +. ./common.qemu
>>> +
>>> +_supported_fmt generic
>>> +_supported_proto generic
>>> +_supported_os Linux
>>> +
>>> +
>>> +CONFIG_FILE=$TEST_DIR/backup-config
>>> +SOCKET=unix:$TEST_DIR/backup_socket
>>> +size=128M
>>> +
>>> +_make_test_img $size
>>> +export QEMU_BACKUP_CONFIG=$CONFIG_FILE
>>> +qemu_comm_method="monitor"
>>> +echo
>>> +_launch_qemu -drive if=virtio,file=$TEST_IMG -qmp $SOCKET,server,nowait
>>> +$PYTHON ../../contrib/backup/qemu-backup.py guest add --guest adad --qmp
>>> $SOCKET
>>> +$PYTHON ../../contrib/backup/qemu-backup.py drive add --id virtio0 --guest adad
>>> --target $TEST_DIR/virtio0
>>> +echo
>>> +echo "== Creating backup =="
>>> +$PYTHON ../../contrib/backup/qemu-backup.py backup --inc --guest adad
>>> +_send_qemu_cmd $QEMU_HANDLE 'quit' ''
>>> +wait=1 _cleanup_qemu
>>> +echo
>>> +echo "== Comparing images =="
>>> +$QEMU_IMG compare $TEST_DIR/virtio0_inc_0 $TEST_IMG
>>> +
>>> +rm $TEST_DIR/virtio0_inc_0
>>> +
>>> +_launch_qemu -drive if=virtio,id=virtio0,file=$TEST_IMG -qmp
>>> $SOCKET,server,nowait
>>> +echo
>>> +echo "== Writing Pattern =="
>>> +_send_qemu_cmd $QEMU_HANDLE 'qemu-io virtio0 "write -P 0x22 0 1M"' "(qemu)" |
>>> _filter_qemu_io
>>> +echo
>>> +
>>> +echo "== Creating backup =="
>>> +$PYTHON ../../contrib/backup/qemu-backup.py backup --inc --guest adad
>>> +
>>> +echo "== Writing Pattern =="
>>> +_send_qemu_cmd $QEMU_HANDLE 'qemu-io virtio0 "write -P 0x22 0 1M"' "(qemu)" |
>>> _filter_qemu_io
>>> +echo
>>> +$PYTHON ../../contrib/backup/qemu-backup.py backup --inc --guest adad
>>> +_send_qemu_cmd $QEMU_HANDLE 'quit' ''
>>> +wait=1 _cleanup_qemu
>>> +echo
>>> +echo "== Comparing images =="
>>> +$QEMU_IMG compare $TEST_DIR/virtio0_inc_1 $TEST_IMG
>>> +rm $TEST_DIR/virtio0_inc_0
>>> +rm $TEST_DIR/virtio0_inc_1
>>> +rm $CONFIG_FILE
>>> +
>>> +echo "*** done"
>>> +status=0
>>> \ No newline at end of file
>>> diff --git a/tests/qemu-iotests/193.out b/tests/qemu-iotests/193.out
>>> new file mode 100644
>>> index 0000000..3a836c2
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/193.out
>>> @@ -0,0 +1,34 @@
>>> +QA output created by 193
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> +
>>> +Successfully Added Guest
>>> +Successfully Added Drive
>>> +
>>> +== Creating backup ==
>>> +QEMU X.Y.Z monitor - type 'help' for more information
>>> +(qemu) Formatting 'TEST_DIR/virtio0_inc_0', fmt=qcow2 size=134217728
>>> cluster_size=65536 lazy_refcounts=off refcount_bits=16
>>> +quit
>>> +
>>> +== Comparing images ==
>>> +Images are identical.
>>> +
>>> +== Writing Pattern ==
>>> +QEMU X.Y.Z monitor - type 'help' for more information
>>> +(qemu) qemu-io virtio0 "write -P 0x22 0 1M"
>>> +
>>> +== Creating backup ==
>>> +Initial Backup does not exist
>>> +== Writing Pattern ==
>>> +wrote 1048576/1048576 bytes at offset 0
>>> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +(qemu) Formatting 'TEST_DIR/virtio0_inc_0', fmt=qcow2 size=134217728
>>> cluster_size=65536 lazy_refcounts=off refcount_bits=16
>>> +
>>> +Formatting
>>> '/home/ishani/Desktop/opw/qemu/tests/qemu-iotests/scratch/virtio0_inc_1',
>>> fmt=qcow2 size=134217728
>>> backing_file=/home/ishani/Desktop/opw/qemu/tests/qemu-iotests/scratch/virtio0_inc_0
>>> backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off
>>> refcount_bits=16
>>> +qemu-io virtio0 "write -P 0x22 0 1M"
>>> +wrote 1048576/1048576 bytes at offset 0
>>> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +(qemu) quit
>>> +
>>> +== Comparing images ==
>>> +Images are identical.
>>> +*** done
>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>> index 33c945b..6b9e034 100644
>>> --- a/tests/qemu-iotests/group
>>> +++ b/tests/qemu-iotests/group
>>> @@ -189,3 +189,4 @@
>>>  191 rw auto
>>>  192 rw auto quick
>>>  194 rw auto migration quick
>>> +193 rw auto
>> 
>> Let's add this line after 192 before 194, and you can add 'quick' btw.
>> 
>> Fam
>> 
>>> --
>>> 2.7.4
>>>
