Received: from eggs.gnu.org ([2001:4830:134:3::10]:40965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKFLS-0005wy-GI
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKFLR-0005jv-C4
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:17:02 -0500
Date: Thu, 30 Nov 2017 11:16:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130031646.GK16237@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123020832.8165-7-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/17] iotests: Drop format-specific in
 _filter_img_info
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
> _filter_img_info should remove format-specific information, too.  We
> already have such a filter in _img_info, and it is very useful for
> query-block-named-block-nodes (etc.), too.
> 
> However, in 198 we need that information (but we still want the rest of
> the filter), so make that filtering optional.  Note that "the rest of
> the filter" includes filtering of the test directory, so we can drop the
> _filter_testdir from 198 at the same time.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/198           |  6 ++++--
>  tests/qemu-iotests/common.filter | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
> index 34ef666381..a84a058396 100755
> --- a/tests/qemu-iotests/198
> +++ b/tests/qemu-iotests/198
> @@ -91,11 +91,13 @@ $QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0x9 0 $size" --image-op
>  
>  echo
>  echo "== checking image base =="
> -$QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info | _filter_testdir | sed -e "/^disk size:/ D"
> +$QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-specific \
> +    | sed -e "/^disk size:/ D"
>  
>  echo
>  echo "== checking image layer =="
> -$QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info | _filter_testdir | sed -e "/^disk size:/ D"
> +$QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-specific \
> +    | sed -e "/^disk size:/ D"
>  
>  
>  # success, all done
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index d9237799e9..0c0e53fae7 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -139,6 +139,15 @@ _filter_img_create()
>  
>  _filter_img_info()
>  {
> +    if [[ "$1" == "--format-specific" ]]; then
> +        local format_specific=1
> +        shift
> +    else
> +        local format_specific=0
> +    fi
> +
> +    discard=0
> +    regex_json_spec_start='^ *"format-specific": \{'
>      sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
> @@ -159,7 +168,25 @@ _filter_img_info()
>          -e "/block_state_zero: \\(on\\|off\\)/d" \
>          -e "/log_size: [0-9]\\+/d" \
>          -e "s/iters: [0-9]\\+/iters: 1024/" \
> -        -e "s/uuid: [-a-f0-9]\\+/uuid: 00000000-0000-0000-0000-000000000000/"
> +        -e "s/uuid: [-a-f0-9]\\+/uuid: 00000000-0000-0000-0000-000000000000/" | \
> +    while IFS='' read -r line; do
> +        if [[ $format_specific == 1 ]]; then
> +            discard=0
> +        elif [[ $line == "Format specific information:" ]]; then
> +            discard=1
> +        elif [[ $line =~ $regex_json_spec_start ]]; then
> +            discard=2
> +            regex_json_spec_end="^${line%%[^ ]*}\\},? *$"
> +        fi
> +        if [[ $discard == 0 ]]; then
> +            echo "$line"
> +        elif [[ $discard == 1 && ! $line ]]; then

s/\$line/"\$line"/ ?

> +            echo
> +            discard=0
> +        elif [[ $discard == 2 && $line =~ $regex_json_spec_end ]]; then

Ditto.

> +            discard=0
> +        fi
> +    done
>  }
>  
>  # filter out offsets and file names from qemu-img map; good for both
> -- 
> 2.13.6
> 
