Received: from eggs.gnu.org ([2001:4830:134:3::10]:54298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dbCyr-0005Bi-Oq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dbCyq-0007ms-BF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:39:33 -0400
Date: Fri, 28 Jul 2017 17:39:23 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170728213923.GH5109@localhost.localdomain>
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728131452.15316-8-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 7/7] qemu-iotests/059: Fix leaked
 image files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Fri, Jul 28, 2017 at 03:14:52PM +0200, Kevin Wolf wrote:
> qemu-iotests 059 left a whole lot of image files behind in the scratch
> directory because VMDK creates additional files for extents and cleaning
> them up requires the original image intact (it parses qemu-img info
> output to find all extent files), but the image overwrote it many times
> like it works for all other image formats.
> 
> In addition, _use_sample_img overwrites the TEST_IMG variable, causing
> new images created afterwards to reuse the name of the sample file
> rather than the usual t.IMGFMT.
> 
> This patch adds an intermediate _cleanup_test_img after each subtest
> that created an image file with additional extent files, and also after
> each use of a sample image. _cleanup_test_img is also changed so that it
> resets TEST_IMG after a sample image is cleaned up.
> 
> Note that this test was failing before this commit and continues to do
> so after it. This failure was introduced in commit 9877860 ('block/vmdk:
> Report failures in vmdk_read_cid()') and needs to be dealt with
> separately.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/059       |  9 +++++++++
>  tests/qemu-iotests/059.out   | 22 +++++++++++-----------
>  tests/qemu-iotests/common.rc |  3 +++
>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
> index 6655aaf384..32d6e6791c 100755
> --- a/tests/qemu-iotests/059
> +++ b/tests/qemu-iotests/059
> @@ -30,6 +30,7 @@ status=1	# failure is the default!
>  _cleanup()
>  {
>  	_cleanup_test_img
> +    rm -f "$TEST_IMG.qcow2"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> @@ -72,15 +73,18 @@ echo
>  echo "=== Testing monolithicFlat creation and opening ==="
>  IMGOPTS="subformat=monolithicFlat" _make_test_img 2G
>  _img_info
> +_cleanup_test_img
>  
>  echo
>  echo "=== Testing monolithicFlat with zeroed_grain ==="
>  IMGOPTS="subformat=monolithicFlat,zeroed_grain=on" _make_test_img 2G
> +_cleanup_test_img
>  
>  echo
>  echo "=== Testing big twoGbMaxExtentFlat ==="
>  IMGOPTS="subformat=twoGbMaxExtentFlat" _make_test_img 1000G
>  $QEMU_IMG info $TEST_IMG | _filter_testdir | sed -e 's/cid: [0-9]*/cid: XXXXXXXX/'
> +_cleanup_test_img
>  
>  echo
>  echo "=== Testing malformed VMFS extent description line ==="
> @@ -114,6 +118,7 @@ echo "=== Testing monolithicFlat with internally generated JSON file name ==="
>  IMGOPTS="subformat=monolithicFlat" _make_test_img 64M
>  $QEMU_IO -c "open -o driver=$IMGFMT,file.driver=blkdebug,file.image.filename=$TEST_IMG,file.inject-error.0.event=read_aio" 2>&1 \
>      | _filter_testdir | _filter_imgfmt
> +_cleanup_test_img
>  
>  echo
>  echo "=== Testing version 3 ==="
> @@ -123,6 +128,7 @@ for i in {0..99}; do
>      $QEMU_IO -r -c "read -P $(( i % 10 + 0x30 )) $(( i * 64 * 1024 * 10 + i * 512 )) 512" $TEST_IMG \
>          | _filter_qemu_io
>  done
> +_cleanup_test_img
>  
>  echo
>  echo "=== Testing 4TB monolithicFlat creation and IO ==="
> @@ -130,6 +136,7 @@ IMGOPTS="subformat=monolithicFlat" _make_test_img 4T
>  _img_info
>  $QEMU_IO -c "write -P 0xa 900G 512" "$TEST_IMG" | _filter_qemu_io
>  $QEMU_IO -c "read -v 900G 1024" "$TEST_IMG" | _filter_qemu_io
> +_cleanup_test_img
>  
>  echo
>  echo "=== Testing qemu-img map on extents ==="
> @@ -139,12 +146,14 @@ for fmt in monolithicSparse twoGbMaxExtentSparse; do
>      $QEMU_IO -c "write 2147483136 1k" "$TEST_IMG" | _filter_qemu_io
>      $QEMU_IO -c "write 5G 1k" "$TEST_IMG" | _filter_qemu_io
>      $QEMU_IMG map "$TEST_IMG" | _filter_testdir
> +    _cleanup_test_img
>  done
>  
>  echo
>  echo "=== Testing afl image with a very large capacity ==="
>  _use_sample_img afl9.vmdk.bz2
>  _img_info
> +_cleanup_test_img
>  
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
> index 6154509bc3..f6dce7947c 100644
> --- a/tests/qemu-iotests/059.out
> +++ b/tests/qemu-iotests/059.out
> @@ -2259,8 +2259,8 @@ read 512/512 bytes at offset 64931328
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  
>  === Testing 4TB monolithicFlat creation and IO ===
> -Formatting 'TEST_DIR/iotest-version3.IMGFMT', fmt=IMGFMT size=4398046511104 subformat=monolithicFlat
> -image: TEST_DIR/iotest-version3.IMGFMT
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4398046511104 subformat=monolithicFlat
> +image: TEST_DIR/t.IMGFMT
>  file format: IMGFMT
>  virtual size: 4.0T (4398046511104 bytes)
>  wrote 512/512 bytes at offset 966367641600
> @@ -2333,7 +2333,7 @@ read 1024/1024 bytes at offset 966367641600
>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  
>  === Testing qemu-img map on extents ===
> -Formatting 'TEST_DIR/iotest-version3.IMGFMT', fmt=IMGFMT size=33285996544 subformat=monolithicSparse
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33285996544 subformat=monolithicSparse
>  wrote 1024/1024 bytes at offset 65024
>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote 1024/1024 bytes at offset 2147483136
> @@ -2341,10 +2341,10 @@ wrote 1024/1024 bytes at offset 2147483136
>  wrote 1024/1024 bytes at offset 5368709120
>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Offset          Length          Mapped to       File
> -0               0x20000         0x3f0000        TEST_DIR/iotest-version3.vmdk
> -0x7fff0000      0x20000         0x410000        TEST_DIR/iotest-version3.vmdk
> -0x140000000     0x10000         0x430000        TEST_DIR/iotest-version3.vmdk
> -Formatting 'TEST_DIR/iotest-version3.IMGFMT', fmt=IMGFMT size=33285996544 subformat=twoGbMaxExtentSparse
> +0               0x20000         0x3f0000        TEST_DIR/t.vmdk
> +0x7fff0000      0x20000         0x410000        TEST_DIR/t.vmdk
> +0x140000000     0x10000         0x430000        TEST_DIR/t.vmdk
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33285996544 subformat=twoGbMaxExtentSparse
>  wrote 1024/1024 bytes at offset 65024
>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote 1024/1024 bytes at offset 2147483136
> @@ -2352,10 +2352,10 @@ wrote 1024/1024 bytes at offset 2147483136
>  wrote 1024/1024 bytes at offset 5368709120
>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Offset          Length          Mapped to       File
> -0               0x20000         0x50000         TEST_DIR/iotest-version3-s001.vmdk
> -0x7fff0000      0x10000         0x70000         TEST_DIR/iotest-version3-s001.vmdk
> -0x80000000      0x10000         0x50000         TEST_DIR/iotest-version3-s002.vmdk
> -0x140000000     0x10000         0x50000         TEST_DIR/iotest-version3-s003.vmdk
> +0               0x20000         0x50000         TEST_DIR/t-s001.vmdk
> +0x7fff0000      0x10000         0x70000         TEST_DIR/t-s001.vmdk
> +0x80000000      0x10000         0x50000         TEST_DIR/t-s002.vmdk
> +0x140000000     0x10000         0x50000         TEST_DIR/t-s003.vmdk
>  
>  === Testing afl image with a very large capacity ===
>  qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 2548e58b99..bfbc80e5f6 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -92,6 +92,7 @@ else
>          TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
>      fi
>  fi
> +ORIG_TEST_IMG="$TEST_IMG"
>  
>  _optstr_add()
>  {
> @@ -228,6 +229,8 @@ _cleanup_test_img()
>              if [ -n "$SAMPLE_IMG_FILE" ]
>              then
>                  rm -f "$TEST_DIR/$SAMPLE_IMG_FILE"
> +                SAMPLE_IMG_FILE=
> +                TEST_IMG="$ORIG_TEST_IMG"
>              fi
>              ;;
>  
> -- 
> 2.13.3
> 
> 

You aren't kidding; I did a before and after test while reviewing, and it
left 518 (mostly empty) images behind before!

Reviewed-by: Jeff Cody <jcody@redhat.com>
