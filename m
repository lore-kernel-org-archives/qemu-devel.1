Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cp1Yu-0000ay-3y
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cp1Yr-0005G9-2E
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:45:36 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1cp1Yq-0005Eo-Qu
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:45:32 -0400
Received: by mail-vk0-f42.google.com with SMTP id d188so48654530vka.0
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 16:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20170315092940.1367-1-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-1-stefanha@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 17 Mar 2017 23:45:20 +0000
Message-ID: <CAMRbyyuOxePB5ErcGmkTErSd0FiezgaAjCDGRJWAr4ZGOgcK2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v2 0/8] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

On Wed, Mar 15, 2017 at 11:29 AM Stefan Hajnoczi <stefanha@redhat.com>
wrote:

> RFCv2:
>  * Publishing RFC again to discuss the new user-visible interfaces.  Code
> has
>    changed quite a bit, I have not kept any Reviewed-by tags.
>  * Rename qemu-img sub-command "measure" and API bdrv_measure() [Nir]
>  * Report both "required bytes" and "fully allocated bytes" to handle the
> empty
>    image file and prealloc use cases [Nir and Dan]
>  * Use bdrv_getlength() instead of bdrv_nb_sectors() [Berto]
>  * Rename "err" label "out" in qemu-img-cmds.c [Nir]
>  * Add basic qcow2 support, doesn't support qemu-img convert from existing
> files yet
>
> RFCv1:
>  * Publishing patch series with just raw support, no qcow2 yet.  Please
> review
>    the command-line interface and let me know if you are happy with this
>    approach.
>
> Users and management tools sometimes need to know the size required for a
> new
> disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of
> time.
> Image formats like qcow2 have non-trivial metadata that makes it hard to
> estimate the exact size without knowledge of file format internals.
>
> This patch series introduces a new qemu-img sub-command that calculates the
> required size for both image creation and conversion scenarios.


> The conversion scenario is:
>
>   $ qemu-img measure -f raw -O qcow2 input.img
>   required bytes: 1327680
>   fully allocated bytes: 1074069504


Other commands like qemu-img info are using "size" instead of "bytes", I
guess
we like to keep the term "size" for consistency.

Here an existing image file is taken and the output includes the space
> required
> for data from the input image file.
>
> The creation scenario is:
>
>   $ qemu-img measure -O qcow2 --size 5G
>   required bytes: 327680
>   fully allocated bytes: 1074069504
>

There is a third scenario that you may want to describe
here, extending a block device when it becomes full. In this case
we want to limit the block device to the fully allocated size, including
additional size needed for bitmaps. Currently ovirt is using virtual_size *
1.1
for this limit, which seems to work for images without additional bitmaps.


> Stefan Hajnoczi (8):
>   block: add bdrv_measure() API
>   raw-format: add bdrv_measure() support
>   qcow2: extract preallocation calculation function
>   qcow2: extract image creation option parsing
>   qcow2: add bdrv_measure() support
>   qemu-img: add measure subcommand
>   qemu-iotests: support per-format golden output files
>   iotests: add test 178 for qemu-img measure
>
>  qapi/block-core.json             |  19 +++
>  include/block/block.h            |   4 +
>  include/block/block_int.h        |   2 +
>  block.c                          |  33 +++++
>  block/qcow2.c                    | 296
> ++++++++++++++++++++++++++-------------
>  block/raw-format.c               |  22 +++
>  qemu-img.c                       | 213 ++++++++++++++++++++++++++++
>  qemu-img-cmds.hx                 |   9 ++
>  tests/qemu-iotests/178           |  75 ++++++++++
>  tests/qemu-iotests/178.out.qcow2 |  33 +++++
>  tests/qemu-iotests/178.out.raw   |  33 +++++
>  tests/qemu-iotests/check         |   5 +
>  tests/qemu-iotests/group         |   1 +
>  13 files changed, 651 insertions(+), 94 deletions(-)
>  create mode 100755 tests/qemu-iotests/178
>  create mode 100644 tests/qemu-iotests/178.out.qcow2
>  create mode 100644 tests/qemu-iotests/178.out.raw
>
> --
> 2.9.3
>
>
