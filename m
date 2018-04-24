Received: from eggs.gnu.org ([2001:4830:134:3::10]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB19d-0007oI-JG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB19c-0005Yf-4M
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:50:57 -0400
Date: Tue, 24 Apr 2018 18:50:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424165037.GE4080@localhost.localdomain>
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-10-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421132929.21610-10-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 9/9] iotests: Add test for COR across
 nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 21.04.2018 um 15:29 hat Max Reitz geschrieben:
> COR across nodes (that is, you have some filter node between the
> actually COR target and the node that performs the COR) cannot reliably
> work together with the permission system when there is no explicit COR
> node that can request the WRITE_UNCHANGED permission for its child.
> This is because COR (currently) sneaks its requests by the usual
> permission checks, so it can work without a WRITE* permission; but if
> there is a filter node in between, that will re-issue the request, which
> then passes through the usual check -- and if nobody has requested a
> WRITE_UNCHANGED permission, that check will fail.
> 
> There is no real direct fix apart from hoping that there is someone who
> has requested that permission; in case of just the qemu-io HMP command
> (and no guest device), however, that is not the case.  The real real fix
> is to implement the copy-on-read flag through an implicitly added COR
> node.  Such a node can request the necessary permissions as shown in
> this test.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/216     | 117 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/216.out |  28 +++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 146 insertions(+)
>  create mode 100755 tests/qemu-iotests/216
>  create mode 100644 tests/qemu-iotests/216.out
> 
> diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
> new file mode 100755
> index 0000000000..b362cf93a8
> --- /dev/null
> +++ b/tests/qemu-iotests/216
> @@ -0,0 +1,117 @@
> +#!/usr/bin/env python
> +#
> +# Copy-on-read tests using a COR filter node
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
> +#
> +# Non-shared storage migration test using NBD server and drive-mirror
> +
> +import iotests
> +from iotests import log, qemu_img_pipe, qemu_io, filter_qemu_io
> +
> +# Need backing file support
> +iotests.verify_image_format(supported_fmts=['qcow2', 'qcow', 'qed', 'vmdk'])
> +iotests.verify_platform(['linux'])
> +
> +log('')
> +log('=== Copy-on-read across nodes ===')
> +log('')
> +
> +# The old copy-on-read mechanism without a filter node cannot request
> +# WRITE_UNCHANGED permissions for its child.  Therefore it just tries
> +# to sneak its write by the usual permission system and holds its
> +# fingers crossed.  However, that sneaking does not work so well when
> +# there is a filter node in the way: That will receive the write
> +# request and re-issue a new one to its child, which this time is a
> +# proper write request that will make the permission system cough --
> +# unless there is someone at the top (like a guest device) that has
> +# requested write permissions.
> +#
> +# A COR filter node, however, can request the proper permissions for
> +# its child and therefore is not hit by this issue.
> +
> +with iotests.FilePath('base.img') as base_img_path, \
> +     iotests.FilePath('top.img') as top_img_path, \
> +     iotests.VM() as vm:
> +
> +    log('--- Setting up images ---')
> +    log('')
> +
> +    qemu_img_pipe('create', '-f', iotests.imgfmt, base_img_path, '64M')
> +
> +    log(filter_qemu_io(qemu_io(base_img_path, '-c', 'write -P 1 0M 1M')))
> +
> +    qemu_img_pipe('create', '-f', iotests.imgfmt, '-b', base_img_path,
> +                  top_img_path)
> +
> +    log(filter_qemu_io(qemu_io(top_img_path,  '-c', 'write -P 2 1M 1M')))
> +
> +    log('')
> +    log('--- Doing COR ---')
> +    log('')
> +
> +    # Compare with e.g. the following:
> +    #   vm.add_drive_raw('if=none,node-name=node0,copy-on-read=on,driver=raw,' \
> +    #                    'file.driver=%s,file.file.filename=%s' %
> +    #                       (iotests.imgfmt, top_img_path))
> +    # (Remove the blockdev-add instead.)
> +    # ((Not tested here because it hits an assertion in the permission
> +    #   system.))

That's... kind of unfortunate.

This probably means that we can't continue with converting stuff like
throttling to filter nodes internally before this is fixed (i.e. copy on
read must be converted first). Let's hope it's the only one and we don't
end up with mutual dependencies...

Kevin
