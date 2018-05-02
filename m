Received: from eggs.gnu.org ([2001:4830:134:3::10]:56485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fDsnE-0001As-Tu
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fDsn9-0004Pq-Lj
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:31:40 -0400
Date: Wed, 2 May 2018 10:31:14 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180502143114.GA22414@localhost.localdomain>
References: <20180501220509.14152-1-mreitz@redhat.com>
	<20180501220509.14152-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501220509.14152-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Add test for cancelling a
 mirror job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, May 02, 2018 at 12:05:09AM +0200, Max Reitz wrote:
> We already have an extensive mirror test (041) which does cover
> cancelling a mirror job, especially after it has emitted the READY
> event.  However, it does not check what exact events are emitted after
> block-job-cancel is executed.  More importantly, it does not use
> throttling to ensure that it covers the case of block-job-cancel before
> READY.
> 
> It would be possible to add this case to 041, but considering it is
> already our largest test file, it makes sense to create a new file for
> these cases.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/218     | 138 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/218.out |  30 ++++++++++
>  tests/qemu-iotests/group   |   1 +

Minor conflict in group, but nothing that I can't sort out when applying.

>  3 files changed, 169 insertions(+)
>  create mode 100755 tests/qemu-iotests/218
>  create mode 100644 tests/qemu-iotests/218.out
> 
> diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
> new file mode 100755
> index 0000000000..92c331b6fb
> --- /dev/null
> +++ b/tests/qemu-iotests/218
> @@ -0,0 +1,138 @@
> +#!/usr/bin/env python
> +#
> +# This test covers what happens when a mirror block job is cancelled
> +# in various phases of its existence.
> +#
> +# Note that this test only checks the emitted events (i.e.
> +# BLOCK_JOB_COMPLETED vs. BLOCK_JOB_CANCELLED), it does not compare
> +# whether the target is in sync with the source when the
> +# BLOCK_JOB_COMPLETED event occurs.  This is covered by other tests
> +# (such as 041).
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Creator/Owner: Max Reitz <mreitz@redhat.com>
> +
> +import iotests
> +from iotests import log
> +
> +iotests.verify_platform(['linux'])
> +
> +
> +# Launches the VM, adds two null-co nodes (source and target), and
> +# starts a blockdev-mirror job on them.
> +#
> +# Either both or none of speed and buf_size must be given.
> +
> +def start_mirror(vm, speed=None, buf_size=None):
> +    vm.launch()
> +
> +    ret = vm.qmp('blockdev-add',
> +                     node_name='source',
> +                     driver='null-co',
> +                     size=1048576)
> +    assert ret['return'] == {}
> +
> +    ret = vm.qmp('blockdev-add',
> +                     node_name='target',
> +                     driver='null-co',
> +                     size=1048576)
> +    assert ret['return'] == {}
> +
> +    if speed is not None:
> +        ret = vm.qmp('blockdev-mirror',
> +                         job_id='mirror',
> +                         device='source',
> +                         target='target',
> +                         sync='full',
> +                         speed=speed,
> +                         buf_size=buf_size)
> +    else:
> +        ret = vm.qmp('blockdev-mirror',
> +                         job_id='mirror',
> +                         device='source',
> +                         target='target',
> +                         sync='full')
> +
> +    assert ret['return'] == {}
> +
> +
> +log('')
> +log('=== Cancel mirror job before convergence ===')
> +log('')
> +
> +log('--- force=false ---')
> +log('')
> +
> +with iotests.VM() as vm:
> +    # Low speed so it does not converge
> +    start_mirror(vm, 65536, 65536)
> +
> +    log('Cancelling job')
> +    log(vm.qmp('block-job-cancel', device='mirror', force=False))
> +
> +    log(vm.event_wait('BLOCK_JOB_CANCELLED'),
> +        filters=[iotests.filter_qmp_event])
> +
> +log('')
> +log('--- force=true ---')
> +log('')
> +
> +with iotests.VM() as vm:
> +    # Low speed so it does not converge
> +    start_mirror(vm, 65536, 65536)
> +
> +    log('Cancelling job')
> +    log(vm.qmp('block-job-cancel', device='mirror', force=True))
> +
> +    log(vm.event_wait('BLOCK_JOB_CANCELLED'),
> +        filters=[iotests.filter_qmp_event])
> +
> +
> +log('')
> +log('=== Cancel mirror job after convergence ===')
> +log('')
> +
> +log('--- force=false ---')
> +log('')
> +
> +with iotests.VM() as vm:
> +    start_mirror(vm)
> +
> +    log(vm.event_wait('BLOCK_JOB_READY'),
> +        filters=[iotests.filter_qmp_event])
> +
> +    log('Cancelling job')
> +    log(vm.qmp('block-job-cancel', device='mirror', force=False))
> +
> +    log(vm.event_wait('BLOCK_JOB_COMPLETED'),
> +        filters=[iotests.filter_qmp_event])
> +
> +log('')
> +log('--- force=true ---')
> +log('')
> +
> +with iotests.VM() as vm:
> +    start_mirror(vm)
> +
> +    log(vm.event_wait('BLOCK_JOB_READY'),
> +        filters=[iotests.filter_qmp_event])
> +
> +    log('Cancelling job')
> +    log(vm.qmp('block-job-cancel', device='mirror', force=True))
> +
> +    log(vm.event_wait('BLOCK_JOB_CANCELLED'),
> +        filters=[iotests.filter_qmp_event])
> diff --git a/tests/qemu-iotests/218.out b/tests/qemu-iotests/218.out
> new file mode 100644
> index 0000000000..7dbf78e682
> --- /dev/null
> +++ b/tests/qemu-iotests/218.out
> @@ -0,0 +1,30 @@
> +
> +=== Cancel mirror job before convergence ===
> +
> +--- force=false ---
> +
> +Cancelling job
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 65536, u'len': 1048576, u'offset': 65536}, u'event': u'BLOCK_JOB_CANCELLED'}
> +
> +--- force=true ---
> +
> +Cancelling job
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 65536, u'len': 1048576, u'offset': 65536}, u'event': u'BLOCK_JOB_CANCELLED'}
> +
> +=== Cancel mirror job after convergence ===
> +
> +--- force=false ---
> +
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_READY'}
> +Cancelling job
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_COMPLETED'}
> +
> +--- force=true ---
> +
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_READY'}
> +Cancelling job
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_CANCELLED'}
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 2edc377370..cc8cd8cc8e 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -215,3 +215,4 @@
>  214 rw auto
>  215 rw auto quick
>  216 rw auto quick
> +218 rw auto quick
> -- 
> 2.14.3
> 
