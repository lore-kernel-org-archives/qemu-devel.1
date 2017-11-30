Received: from eggs.gnu.org ([2001:4830:134:3::10]:56492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEpp-0000wE-96
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEpo-0008M5-8r
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:44:21 -0500
Date: Thu, 30 Nov 2017 10:44:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130024409.GF16237@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-11-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123020832.8165-11-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/17] iotests: Fix 020 for vmdk
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

On Thu, 11/23 03:08, Max Reitz wrote:
> vmdk cannot work with anything but vmdk backing files, so make the
> backing file be the same format as the overlay.
> 
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/020     | 9 ++++++---
>  tests/qemu-iotests/020.out | 6 ++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
> index d22ab81414..eac5080f83 100755
> --- a/tests/qemu-iotests/020
> +++ b/tests/qemu-iotests/020
> @@ -111,10 +111,12 @@ echo
>  echo 'Testing failing commit'
>  echo
>  
> +TEST_IMG="$TEST_IMG.base" _make_test_img 1M
> +
>  # Create an image with a null backing file to which committing will fail (with
>  # ENOSPC so we can distinguish the result from some generic EIO which may be
>  # generated anywhere in the block layer)
> -_make_test_img -b "json:{'driver': 'raw',
> +_make_test_img -b "json:{'driver': '$IMGFMT',
>                           'file': {
>                               'driver': 'blkdebug',
>                               'inject-error': [{
> @@ -123,14 +125,15 @@ _make_test_img -b "json:{'driver': 'raw',
>                                   'once': true
>                               }],
>                               'image': {
> -                                 'driver': 'null-co'
> +                                 'driver': 'file',
> +                                 'filename': '$TEST_IMG.base'
>                               }}}"
>  
>  # Just write anything so committing will not be a no-op
>  $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
>  
>  $QEMU_IMG commit "$TEST_IMG"
> -_cleanup_test_img
> +_cleanup
>  
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
> index 165b70aa49..4b722b2dd0 100644
> --- a/tests/qemu-iotests/020.out
> +++ b/tests/qemu-iotests/020.out
> @@ -1078,7 +1078,8 @@ No errors were found on the image.
>  
>  Testing failing commit
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=json:{'driver': 'raw',,
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driver': 'IMGFMT',,
>                           'file': {
>                               'driver': 'blkdebug',,
>                               'inject-error': [{
> @@ -1087,7 +1088,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=json:{'d
>                                   'once': true
>                               }],,
>                               'image': {
> -                                 'driver': 'null-co'
> +                                 'driver': 'file',,
> +                                 'filename': 'TEST_DIR/t.IMGFMT.base'
>                               }}}
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.13.6
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
