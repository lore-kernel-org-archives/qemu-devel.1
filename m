Received: from eggs.gnu.org ([2001:4830:134:3::10]:34185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cH5qy-0008EM-BL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 04:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cH5qx-0003FR-Bl
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 04:28:00 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-20-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <76c0f6c7-1477-9dbc-921b-7db1daa7741a@redhat.com>
Date: Wed, 14 Dec 2016 10:27:47 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-20-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/21] iotests: test qcow2 persistent dirty
 bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

On 2016-11-22 at 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/165     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/165.out |  5 +++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 95 insertions(+)
>  create mode 100755 tests/qemu-iotests/165
>  create mode 100644 tests/qemu-iotests/165.out
>
> diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
> new file mode 100755
> index 0000000..0b04b04
> --- /dev/null
> +++ b/tests/qemu-iotests/165
> @@ -0,0 +1,89 @@
> +#!/usr/bin/env python
> +#
> +# Tests for persistent dirty bitmaps.
> +#
> +# Copyright: Vladimir Sementsov-Ogievskiy 2015-2016
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
> +disk = os.path.join(iotests.test_dir, 'disk')
> +disk_size = 0x40000000 # 1G
> +
> +# regions for qemu_io: (start, count) in bytes
> +regions1 = ((0,        0x100000),
> +            (0x200000, 0x100000))
> +
> +regions2 = ((0x10000000, 0x20000),
> +            (0x3fff0000, 0x10000))
> +
> +class TestPersistentDirtyBitmap(iotests.QMPTestCase):
> +
> +    def setUp(self):
> +        qemu_img('create', '-f', iotests.imgfmt, disk, str(disk_size))
> +
> +    def tearDown(self):
> +        os.remove(disk)
> +
> +    def mkVm(self):
> +        return iotests.VM().add_drive(disk)
> +
> +    def getSha256(self):
> +        result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
> +                             node='drive0', name='bitmap0')
> +        return result['return']['sha256']
> +
> +    def checkBitmap(self, sha256):
> +        result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
> +                             node='drive0', name='bitmap0')
> +        self.assert_qmp(result, 'return/sha256', sha256);
> +
> +    def writeRegions(self, regions):
> +        for r in regions:
> +          self.vm.hmp_qemu_io('drive0',

Indentation should be two more spaces. With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +                              'write %d %d' % r)
