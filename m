Received: from eggs.gnu.org ([2001:4830:134:3::10]:43031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cju7q-00062x-S2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cju7l-0007j8-T1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:48:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cju7l-0007iy-N1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:48:25 -0500
References: <20170303135150.12145-1-stefanha@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <10926cf4-d9ae-3094-8905-368dc97f7041@redhat.com>
Date: Fri, 3 Mar 2017 15:48:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170303135150.12145-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>



On 03/03/2017 08:51 AM, Stefan Hajnoczi wrote:
> RFCv1:
>  * Publishing patch series with just raw support, no qcow2 yet.  Please review
>    the command-line interface and let me know if you are happy with this
>    approach.
> 
> Users and management tools sometimes need to know the size required for a new
> disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of time.
> Image formats like qcow2 have non-trivial metadata that makes it hard to
> estimate the exact size without knowledge of file format internals.
> 
> This patch series introduces a new qemu-img subcommand that calculates the
> required size for both image creation and conversion scenarios.
> 
> The conversion scenario is:
> 
>   $ qemu-img max-size -f raw -O qcow2 input.img
>   107374184448
> 
> Here an existing image file is taken and the output includes the space required
> for data from the input image file.
> 
> The creation scenario is:
> 
>   $ qemu-img max-size -O qcow2 --size 5G
>   196688
> 

It looks sane to me, implementation looks clean enough.
Thanks!

> Stefan Hajnoczi (4):
>   block: add bdrv_max_size() API
>   raw-format: add bdrv_max_size() support
>   qemu-img: add max-size subcommand
>   iotests: add test 178 for qemu-img max-size
> 
>  include/block/block.h      |   2 +
>  include/block/block_int.h  |   2 +
>  block.c                    |  37 +++++++++
>  block/raw-format.c         |  16 ++++
>  qemu-img.c                 | 196 +++++++++++++++++++++++++++++++++++++++++++++
>  qemu-img-cmds.hx           |   6 ++
>  tests/qemu-iotests/178     |  75 +++++++++++++++++
>  tests/qemu-iotests/178.out |  25 ++++++
>  tests/qemu-iotests/group   |   1 +
>  9 files changed, 360 insertions(+)
>  create mode 100755 tests/qemu-iotests/178
>  create mode 100644 tests/qemu-iotests/178.out
> 
