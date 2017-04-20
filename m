Received: from eggs.gnu.org ([2001:4830:134:3::10]:41786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Dhp-0002YV-Rh
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Dho-0001oP-GQ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:09:13 -0400
Date: Thu, 20 Apr 2017 11:09:05 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170420150905.GJ15762@localhost.localdomain>
References: <d59c2f6ad6c1da8b9b3c7f357c94a7122ccfc55a.1492544096.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59c2f6ad6c1da8b9b3c7f357c94a7122ccfc55a.1492544096.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.10] qemu-iotests: _cleanup_qemu
 must be called on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

On Tue, Apr 18, 2017 at 03:42:41PM -0400, Jeff Cody wrote:
> For the tests that use the common.qemu functions for running a QEMU
> process, _cleanup_qemu must be called in the exit function.
> 
> If it is not, if the qemu process aborts, then not all of the droppings
> are cleaned up (e.g. pidfile, fifos).
> 
> This updates those tests that did not have a cleanup in qemu-iotests.
> 
> (I swapped spaces for tabs in test 102 as well)
> 
> Reported-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
> 
> v3 added test 156
> v2 fixed typo in test 094, s/cleanup/_cleanup/ for the trap function. (Eric)
> 
>  tests/qemu-iotests/028 |  1 +
>  tests/qemu-iotests/094 | 11 ++++++++---
>  tests/qemu-iotests/102 |  5 +++--
>  tests/qemu-iotests/109 |  1 +
>  tests/qemu-iotests/117 |  1 +
>  tests/qemu-iotests/130 |  1 +
>  tests/qemu-iotests/140 |  1 +
>  tests/qemu-iotests/141 |  1 +
>  tests/qemu-iotests/143 |  1 +
>  tests/qemu-iotests/156 |  1 +
>  10 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
> index 7783e57..97a8869 100755
> --- a/tests/qemu-iotests/028
> +++ b/tests/qemu-iotests/028
> @@ -32,6 +32,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>      rm -f "${TEST_IMG}.copy"
>      _cleanup_test_img
>  }
> diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
> index 0ba0b0c..9aa01e3 100755
> --- a/tests/qemu-iotests/094
> +++ b/tests/qemu-iotests/094
> @@ -27,7 +27,14 @@ echo "QA output created by $seq"
>  here="$PWD"
>  status=1	# failure is the default!
>  
> -trap "exit \$status" 0 1 2 3 15
> +_cleanup()
> +{
> +    _cleanup_qemu
> +    _cleanup_test_img
> +    rm -f "$TEST_DIR/source.$IMGFMT"
> +}
> +
> +trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  # get standard environment, filters and checks
>  . ./common.rc
> @@ -73,8 +80,6 @@ _send_qemu_cmd $QEMU_HANDLE \
>  
>  wait=1 _cleanup_qemu
>  
> -_cleanup_test_img
> -rm -f "$TEST_DIR/source.$IMGFMT"
>  
>  # success, all done
>  echo '*** done'
> diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
> index 64b4af9..87db1bb 100755
> --- a/tests/qemu-iotests/102
> +++ b/tests/qemu-iotests/102
> @@ -25,11 +25,12 @@ seq=$(basename $0)
>  echo "QA output created by $seq"
>  
>  here=$PWD
> -status=1	# failure is the default!
> +status=1    # failure is the default!
>  
>  _cleanup()
>  {
> -	_cleanup_test_img
> +    _cleanup_qemu
> +    _cleanup_test_img
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
> index 927151a..6161633 100755
> --- a/tests/qemu-iotests/109
> +++ b/tests/qemu-iotests/109
> @@ -29,6 +29,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>      rm -f $TEST_IMG.src
>  	_cleanup_test_img
>  }
> diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
> index e955d52..6c83461 100755
> --- a/tests/qemu-iotests/117
> +++ b/tests/qemu-iotests/117
> @@ -29,6 +29,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>  	_cleanup_test_img
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
> diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
> index ecc8a5b..d4d148b 100755
> --- a/tests/qemu-iotests/130
> +++ b/tests/qemu-iotests/130
> @@ -31,6 +31,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>      _cleanup_test_img
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
> diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
> index 49f9df4..8c80a5a 100755
> --- a/tests/qemu-iotests/140
> +++ b/tests/qemu-iotests/140
> @@ -33,6 +33,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>      _cleanup_test_img
>      rm -f "$TEST_DIR/nbd"
>  }
> diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
> index 27fb1cc..40a3405 100755
> --- a/tests/qemu-iotests/141
> +++ b/tests/qemu-iotests/141
> @@ -29,6 +29,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>      _cleanup_test_img
>      rm -f "$TEST_DIR/{b,m,o}.$IMGFMT"
>  }
> diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
> index ec4ef22..5ff1944 100755
> --- a/tests/qemu-iotests/143
> +++ b/tests/qemu-iotests/143
> @@ -29,6 +29,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>      rm -f "$TEST_DIR/nbd"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
> diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
> index cc95ff1..2c9d23b 100755
> --- a/tests/qemu-iotests/156
> +++ b/tests/qemu-iotests/156
> @@ -37,6 +37,7 @@ status=1	# failure is the default!
>  
>  _cleanup()
>  {
> +    _cleanup_qemu
>      rm -f "$TEST_IMG{,.target}{,.backing,.overlay}"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
> -- 
> 2.9.3
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
