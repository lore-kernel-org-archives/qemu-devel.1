Received: from eggs.gnu.org ([2001:4830:134:3::10]:47790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtpoA-0003YH-Jl
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 02:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtpo9-0003jh-54
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 02:45:30 -0400
Date: Mon, 18 Sep 2017 14:45:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918064515.GF15551@lemon.lan>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-19-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-19-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/18] iotests: Add test for active
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, 09/13 20:19, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/151     | 111 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/151.out |   5 ++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 117 insertions(+)
>  create mode 100755 tests/qemu-iotests/151
>  create mode 100644 tests/qemu-iotests/151.out
> 
> diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
> new file mode 100755
> index 0000000000..49a60773f9
> --- /dev/null
> +++ b/tests/qemu-iotests/151
> @@ -0,0 +1,111 @@
> +#!/usr/bin/env python
> +#
> +# Tests for active mirroring
> +#
> +# Copyright (C) 2017 Red Hat, Inc.
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
> +
> +import os
> +import iotests
> +from iotests import qemu_img
> +
> +source_img = os.path.join(iotests.test_dir, 'source.' + iotests.imgfmt)
> +target_img = os.path.join(iotests.test_dir, 'target.' + iotests.imgfmt)
> +
> +class TestActiveMirror(iotests.QMPTestCase):
> +    image_len = 128 * 1024 * 1024 # MB
> +    potential_writes_in_flight = True
> +
> +    def setUp(self):
> +        qemu_img('create', '-f', iotests.imgfmt, source_img, '128M')
> +        qemu_img('create', '-f', iotests.imgfmt, target_img, '128M')
> +
> +        blk_source = {'node-name': 'source',
> +                      'driver': iotests.imgfmt,
> +                      'file': {'driver': 'file',
> +                               'filename': source_img}}
> +
> +        blk_target = {'node-name': 'target',
> +                      'driver': iotests.imgfmt,
> +                      'file': {'driver': 'file',
> +                               'filename': target_img}}
> +
> +        self.vm = iotests.VM()
> +        self.vm.add_blockdev(self.qmp_to_opts(blk_source))
> +        self.vm.add_blockdev(self.qmp_to_opts(blk_target))
> +        self.vm.launch()
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +
> +        if not self.potential_writes_in_flight:
> +            self.assertTrue(iotests.compare_images(source_img, target_img),
> +                            'mirror target does not match source')
> +
> +        os.remove(source_img)
> +        os.remove(target_img)
> +
> +    def doActiveIO(self, sync_source_and_target):
> +        # Fill the source image
> +        self.vm.hmp_qemu_io('source',
> +                            'write -P 1 0 %i' % self.image_len);
> +
> +        # Start some background requests
> +        for offset in range(0, self.image_len, 1024 * 1024):
> +            self.vm.hmp_qemu_io('source', 'write -B -P 2 %i 1M' % offset)
> +
> +        # Start the block job
> +        result = self.vm.qmp('blockdev-mirror',
> +                             job_id='mirror',
> +                             filter_node_name='mirror-node',
> +                             device='source',
> +                             target='target',
> +                             sync='full',
> +                             copy_mode='active-write')
> +        self.assert_qmp(result, 'return', {})
> +
> +        # Start some more requests
> +        for offset in range(0, self.image_len, 1024 * 1024):
> +            self.vm.hmp_qemu_io('mirror-node', 'write -B -P 3 %i 1M' % offset)
> +
> +        # Wait for the READY event
> +        self.wait_ready(drive='mirror')
> +
> +        # Now start some final requests; all of these (which land on
> +        # the source) should be settled using the active mechanism.
> +        # The mirror code itself asserts that the source BDS's dirty
> +        # bitmap will stay clean between READY and COMPLETED.
> +        for offset in range(0, self.image_len, 1024 * 1024):
> +            self.vm.hmp_qemu_io('mirror-node', 'write -B -P 4 %i 1M' % offset)
> +
> +        if sync_source_and_target:
> +            # If source and target should be in sync after the mirror,
> +            # we have to flush before completion

Not sure I understand this requirements, does it apply to libvirt and user too?
I.e. it's a part of the interface ? Why cannot mirror_complete do it
automatically?

Fam

> +            self.vm.hmp_qemu_io('mirror-node', 'flush')
> +            self.potential_writes_in_flight = False
> +
> +        self.complete_and_wait(drive='mirror', wait_ready=False)
> +
> +    def testActiveIO(self):
> +        self.doActiveIO(False)
> +
> +    def testActiveIOFlushed(self):
> +        self.doActiveIO(True)
> +
> +
> +
> +if __name__ == '__main__':
> +    iotests.main(supported_fmts=['qcow2', 'raw'])
> diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
> new file mode 100644
> index 0000000000..fbc63e62f8
> --- /dev/null
> +++ b/tests/qemu-iotests/151.out
> @@ -0,0 +1,5 @@
> +..
> +----------------------------------------------------------------------
> +Ran 2 tests
> +
> +OK
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 94e764865a..c64adbe5bf 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -156,6 +156,7 @@
>  148 rw auto quick
>  149 rw auto sudo
>  150 rw auto quick
> +151 rw auto
>  152 rw auto quick
>  153 rw auto quick
>  154 rw auto backing quick
> -- 
> 2.13.5
> 
