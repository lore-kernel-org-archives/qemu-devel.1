Received: from eggs.gnu.org ([2001:4830:134:3::10]:44117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFmY-0001Ce-4O
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFmR-000139-Qs
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:03:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-5-kwolf@redhat.com>
Date: Fri, 07 Dec 2018 14:02:48 +0100
In-Reply-To: <20181207115343.6747-5-kwolf@redhat.com> (Kevin Wolf's message of
	"Fri, 7 Dec 2018 12:53:42 +0100")
Message-ID: <871s6txzev.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 4/5] iotests: Add VMDK tests for
 blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/237     | 233 +++++++++++++++++++++++++
>  tests/qemu-iotests/237.out | 347 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 581 insertions(+)
>  create mode 100755 tests/qemu-iotests/237
>  create mode 100644 tests/qemu-iotests/237.out
>
> diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
> new file mode 100755
> index 0000000000..e04a1ac6be
> --- /dev/null
> +++ b/tests/qemu-iotests/237
> @@ -0,0 +1,233 @@
> +#!/usr/bin/env python
> +#
> +# Test vmdk and file image creation
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +#
> +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
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
> +import iotests
> +from iotests import imgfmt
> +
> +iotests.verify_image_format(supported_fmts=['vmdk'])
> +
> +def blockdev_create(vm, options):
> +    result = vm.qmp_log('blockdev-create', job_id='job0', options=options)
> +
> +    if 'return' in result:
> +        assert result['return'] == {}
> +        vm.run_job('job0')
> +    iotests.log("")
> +
> +with iotests.FilePath('t.vmdk') as disk_path, \
> +     iotests.FilePath('t.vmdk.1') as extent1_path, \
> +     iotests.FilePath('t.vmdk.2') as extent2_path, \
> +     iotests.FilePath('t.vmdk.3') as extent3_path, \
> +     iotests.VM() as vm:
> +
> +    #
> +    # Successful image creation (defaults)
> +    #
> +    iotests.log("=== Successful image creation (defaults) ===")
> +    iotests.log("")
> +
> +    size = 5 * 1024 * 1024 * 1024
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': 'file',
> +                          'filename': disk_path,
> +                          'size': 0 })
> +
> +    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
> +               node_name='imgfile')
> +
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': 'imgfile',
> +                          'size': size })
> +    vm.shutdown()
> +
> +    iotests.img_info_log(disk_path)
> +
> +    #
> +    # Successful image creation (inline blockdev-add, explicit defaults)
> +    #
> +    iotests.log("=== Successful image creation (inline blockdev-add, explicit defaults) ===")
> +    iotests.log("")
> +
> +    # Choose a different size to show that we got a new image
> +    size = 64 * 1024 * 1024
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': 'file',
> +                          'filename': disk_path,
> +                          'size': 0 })
> +
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': {
> +                              'driver': 'file',
> +                              'filename': disk_path,
> +                          },
> +                          'size': size,
> +                          'extents': [],
> +                          'subformat': 'monolithicSparse',
> +                          'adapter-type': 'ide',
> +                          'hwversion': '4',
> +                          'zeroed-grain': False })
> +    vm.shutdown()
> +
> +    iotests.img_info_log(disk_path)
> +
> +    #
> +    # Successful image creation (non-default options)
> +    #
> +    iotests.log("=== Successful image creation (with non-default options) ===")
> +    iotests.log("")
> +
> +    # Choose a different size to show that we got a new image
> +    size = 32 * 1024 * 1024
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': 'file',
> +                          'filename': disk_path,
> +                          'size': 0 })
> +
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': {
> +                              'driver': 'file',
> +                              'filename': disk_path,
> +                          },
> +                          'size': size,
> +                          'extents': [],
> +                          'subformat': 'monolithicSparse',
> +                          'adapter-type': 'buslogic',
> +                          'zeroed-grain': True })
> +    vm.shutdown()
> +
> +    iotests.img_info_log(disk_path)
> +
> +    #
> +    # Invalid BlockdevRef
> +    #
> +    iotests.log("=== Invalid BlockdevRef ===")
> +    iotests.log("")
> +
> +    vm.launch()
> +    blockdev_create(vm, { 'driver': imgfmt,
> +                          'file': "this doesn't exist",
> +                          'size': size })
> +    vm.shutdown()
> +
> +    #
> +    # Adapter types
> +    #
> +
> +    iotests.log("=== Adapter types ===")
> +    iotests.log("")
> +
> +    vm.add_blockdev('driver=file,filename=%s,node-name=node0' % (disk_path))
> +
> +    # Valid
> +    iotests.log("== Valid adapter types ==")
> +    iotests.log("")
> +
> +    vm.launch()
> +    for adapter_type in [ 'ide', 'buslogic', 'lsilogic', 'legacyESX' ]:
> +        blockdev_create(vm, { 'driver': imgfmt,
> +                              'file': 'node0',
> +                              'size': size,
> +                              'adapter-type': adapter_type })
> +    vm.shutdown()
> +
> +    # Invalid
> +    iotests.log("== Invalid adapter types ==")
> +    iotests.log("")
> +
> +    vm.launch()
> +    for adapter_type in [ 'foo', 'IDE', 'legacyesx', 1 ]:
> +        blockdev_create(vm, { 'driver': imgfmt,
> +                              'file': 'node0',
> +                              'size': size,
> +                              'adapter-type': adapter_type })
> +    vm.shutdown()
> +
> +    #
> +    # Other subformats
> +    #
> +    iotests.log("=== Other subformats ===")
> +    iotests.log("")
> +
> +    for path in [ extent1_path, extent2_path, extent3_path ]:
> +        msg = iotests.qemu_img_pipe('create', '-f', imgfmt, path, '0')
> +        iotests.log(msg, [iotests.filter_testfiles])
> +

You lost

  +    vm.add_blockdev('driver=file,filename=%s,node-name=node0' % (disk_path))

here since v3.  Intentional?

> +    vm.add_blockdev('driver=file,filename=%s,node-name=ext1' % (extent1_path))
> +    vm.add_blockdev('driver=file,filename=%s,node-name=ext2' % (extent2_path))
> +    vm.add_blockdev('driver=file,filename=%s,node-name=ext3' % (extent3_path))
[...]
