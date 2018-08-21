Received: from eggs.gnu.org ([2001:4830:134:3::10]:42271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fs9KX-0005OC-8Z
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fs9KV-0004rj-SO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:16:29 -0400
Date: Tue, 21 Aug 2018 12:16:13 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180821161613.GB170019@localhost.localdomain>
References: <cover.1534444235.git.jcody@redhat.com>
	<fa938f6c5e7aa523a6ddcf578f052f02d97a3720.1534444235.git.jcody@redhat.com>
	<c6a54a8c-86fe-14ec-9966-4c02706ebb40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a54a8c-86fe-14ec-9966-4c02706ebb40@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block: iotest to catch abort on
 forced blockjob cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org

On Mon, Aug 20, 2018 at 05:26:23PM -0400, John Snow wrote:
> 
> 
> On 08/16/2018 02:46 PM, Jeff Cody wrote:
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  tests/qemu-iotests/229     | 95 ++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/229.out | 23 +++++++++
> >  tests/qemu-iotests/group   |  1 +
> >  3 files changed, 119 insertions(+)
> >  create mode 100755 tests/qemu-iotests/229
> >  create mode 100644 tests/qemu-iotests/229.out
> > 
> > diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
> > new file mode 100755
> > index 0000000000..2af04c8028
> > --- /dev/null
> > +++ b/tests/qemu-iotests/229
> > @@ -0,0 +1,95 @@
> > +#!/bin/bash
> > +#
> > +# Test for force canceling a running blockjob that is paused in
> > +# an error state.
> > +#
> > +# Copyright (C) 2018 Red Hat, Inc.
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > +#
> > +
> > +# creator
> > +owner=jcody@redhat.com
> > +
> > +seq="$(basename $0)"
> > +echo "QA output created by $seq"
> > +
> > +here="$PWD"
> > +status=1	# failure is the default!
> > +
> > +_cleanup()
> > +{
> > +    _cleanup_qemu
> > +    _cleanup_test_img
> > +    rm -f "$TEST_IMG" "$DEST_IMG"
> > +}
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +# get standard environment, filters and checks
> > +. ./common.rc
> > +. ./common.filter
> > +. ./common.qemu
> > +
> > +# Needs backing file and backing format support
> > +_supported_fmt qcow2 qed
> > +_supported_proto file
> > +_supported_os Linux
> > +
> > +
> > +DEST_IMG="$TEST_DIR/d.$IMGFMT"
> > +TEST_IMG="$TEST_DIR/b.$IMGFMT"
> > +
> > +_make_test_img 2M
> > +
> > +# destination for mirror will be too small, causing error
> > +TEST_IMG=$DEST_IMG _make_test_img 1M
> > +
> > +$QEMU_IO -c 'write 0 2M' "$TEST_IMG" | _filter_qemu_io
> > +
> > +_launch_qemu -drive id=testdisk,file="$TEST_IMG",format="$IMGFMT"
> > +
> > +_send_qemu_cmd $QEMU_HANDLE \
> > +    "{'execute': 'qmp_capabilities'}" \
> > +    'return'
> > +
> > +echo
> > +echo '=== Starting drive-mirror, causing error & stop  ==='
> > +echo
> > +
> > +_send_qemu_cmd $QEMU_HANDLE \
> > +    "{'execute': 'drive-mirror',
> > +                 'arguments': {'device': 'testdisk',
> > +                               'mode':   'absolute-paths',
> > +                               'format': 'qcow2',
> > +                               'target': '$DEST_IMG',
> > +                               'sync':   'full',
> > +                               'mode':   'existing',
> > +                               'on-source-error': 'stop',
> > +                               'on-target-error': 'stop' }}"    \
> > +     "BLOCK_JOB_ERROR"
> > +
> > +echo
> > +echo '=== Force cancel job paused in error state  ==='
> > +echo
> > +
> > +success_or_failure="y" _send_qemu_cmd $QEMU_HANDLE \
> > +    "{'execute': 'block-job-cancel',
> > +                 'arguments': { 'device': 'testdisk',
> > +                                'force': true}}" \
> > +     "BLOCK_JOB_CANCELLED" "Assertion"
> > +
> > +# success, all done
> > +echo "*** done"
> > +rm -f $seq.full
> > +status=0
> > diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
> > new file mode 100644
> > index 0000000000..d5dea5cdd2
> > --- /dev/null
> > +++ b/tests/qemu-iotests/229.out
> > @@ -0,0 +1,23 @@
> > +QA output created by 229
> > +Formatting 'TEST_DIR/b.IMGFMT', fmt=IMGFMT size=2097152
> > +Formatting 'TEST_DIR/d.IMGFMT', fmt=IMGFMT size=1048576
> > +wrote 2097152/2097152 bytes at offset 0
> > +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +{"return": {}}
> > +
> > +=== Starting drive-mirror, causing error & stop  ===
> > +
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "testdisk"}}
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
> > +{"return": {}}
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "write", "action": "stop"}}
> > +
> > +=== Force cancel job paused in error state  ===
> > +
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "testdisk"}}
> 
> Is this a race? I imagine the job pauses itself as a result of the error
> it just signaled, so the pause event generally occurs before we start
> attempting to force cancel, and then:
> 
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
> > +{"return": {}}
> 
> These two lines are actually the first that should belong to this
> heading, and then:
> 
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "write", "action": "stop"}}
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk"}}
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 2097152, "offset": 1048576, "speed": 0, "type": "mirror"}}
> 
> These three follow directly after the force cancellation.
> 
> Am I misinterpreting the output?

Not misinterpreting it per se, but it isn't a race condition.  It is a
side effect of the common.qemu process stdout buffer - that output was still
in the pipeline, and was printed while we waited for the
"BLOCK_JOB_CANCELLED".

If I had structured the test 229 to wait for "JOB_STATUS_CHANGE.*paused"
instead of "BLOCK_JOB_ERROR" when doing the mirror, then you wouldn't see
that oddity, because it would have been consumed.

Would you like me to spin a v3 with that change in the iotests?  Actually,
I'll go ahead and do that whether you want me to or not :)

> 
> > +*** done
> > diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> > index b973dc842d..743790745b 100644
> > --- a/tests/qemu-iotests/group
> > +++ b/tests/qemu-iotests/group
> > @@ -225,3 +225,4 @@
> >  225 rw auto quick
> >  226 auto quick
> >  227 auto quick
> > +229 auto quick
> > 
> 
