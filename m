Received: from eggs.gnu.org ([2001:4830:134:3::10]:40829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLJwJ-0000Bl-SN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 22:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLJwJ-0001t3-2j
	for qemu-devel@nongnu.org; Tue, 22 May 2018 22:55:47 -0400
Date: Wed, 23 May 2018 10:55:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180523025537.GK28114@lemon.usersys.redhat.com>
References: <20180518142605.19846-1-kwolf@redhat.com>
	<20180518142605.19846-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518142605.19846-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-iotests: Filter NFS paths
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

On Fri, 05/18 16:26, Kevin Wolf wrote:
> NFS paths were only partially filtered in _filter_img_create, _img_info
> and _filter_img_info, resulting in "nfs://127.0.0.1TEST_DIR/t.IMGFMT".
> This adds another replacement to the sed calls that matches the test
> directory not as a host path, but as an NFS URL (the prefix as used for
> $TEST_IMG).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.filter | 6 ++++--
>  tests/qemu-iotests/common.rc     | 8 +++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index c5f4bcf578..f08ee55046 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -119,7 +119,8 @@ _filter_actual_image_size()
>  # replace driver-specific options in the "Formatting..." line
>  _filter_img_create()
>  {
> -    sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
> +    sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
> +        -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
>          -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
> @@ -154,7 +155,8 @@ _filter_img_info()
>  
>      discard=0
>      regex_json_spec_start='^ *"format-specific": \{'
> -    sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
> +    sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
> +        -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
>          -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index cb5fa14e7f..d236bb9f15 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -148,6 +148,7 @@ else
>          TEST_IMG="ssh://127.0.0.1$TEST_IMG_FILE"
>      elif [ "$IMGPROTO" = "nfs" ]; then
>          TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
> +        REMOTE_TEST_DIR="nfs://127.0.0.1$TEST_DIR"
>          TEST_IMG="nfs://127.0.0.1$TEST_IMG_FILE"
>      elif [ "$IMGPROTO" = "vxhs" ]; then
>          TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
> @@ -173,6 +174,10 @@ if [ ! -d "$TEST_DIR" ]; then
>      exit 1
>  fi
>  
> +if [ -z "$REMOTE_TEST_DIR" ]; then
> +        REMOTE_TEST_DIR="$TEST_DIR"

This has one extra level of indentation.

Reviewed-by: Fam Zheng <famz@redhat.com>

> +fi
> +
>  if [ ! -d "$SAMPLE_IMG_DIR" ]; then
>      echo "common.config: Error: \$SAMPLE_IMG_DIR ($SAMPLE_IMG_DIR) is not a directory"
>      exit 1
> @@ -333,7 +338,8 @@ _img_info()
>      discard=0
>      regex_json_spec_start='^ *"format-specific": \{'
>      $QEMU_IMG info $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" 2>&1 | \
> -        sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
> +        sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
> +            -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>              -e "s#$TEST_DIR#TEST_DIR#g" \
>              -e "s#$IMGFMT#IMGFMT#g" \
>              -e "/^disk size:/ D" \
> -- 
> 2.13.6
> 
> 
