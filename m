Received: from eggs.gnu.org ([2001:4830:134:3::10]:60440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1cNN-0003Iv-Lg
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1cNM-0004Tu-Rl
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:02:01 -0400
Date: Mon, 9 Oct 2017 14:01:53 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171009180153.GI4501@localhost.localdomain>
References: <20171009163456.485-1-mreitz@redhat.com>
	<20171009163456.485-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009163456.485-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] iotests: Pull
 _filter_actual_image_size from 67/87
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Mon, Oct 09, 2017 at 06:34:55PM +0200, Max Reitz wrote:
> Tests 067 and 087 filter the actual image size because it depends on the
> host filesystem (and is not part of the respective test).  Since this is
> generally true, we should have a common filter function for this, so
> let's pull out the sed line from both tests into such a function.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  tests/qemu-iotests/067           | 2 +-
>  tests/qemu-iotests/087           | 2 +-
>  tests/qemu-iotests/common.filter | 6 ++++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
> index ee9595f0da..9d561ef786 100755
> --- a/tests/qemu-iotests/067
> +++ b/tests/qemu-iotests/067
> @@ -56,7 +56,7 @@ _filter_qmp_events()
>  function run_qemu()
>  {
>      do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp | _filter_qemu \
> -                          | sed -e 's/\("actual-size":\s*\)[0-9]\+/\1SIZE/g' \
> +                          | _filter_actual_image_size \
>                            | _filter_generated_node_ids | _filter_qmp_events
>  }
>  
> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> index f8e4903f4f..27ab6c5151 100755
> --- a/tests/qemu-iotests/087
> +++ b/tests/qemu-iotests/087
> @@ -46,7 +46,7 @@ function run_qemu()
>  {
>      do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
>                            | _filter_qemu | _filter_imgfmt \
> -                          | sed -e 's/\("actual-size":\s*\)[0-9]\+/\1SIZE/g'
> +                          | _filter_actual_image_size
>  }
>  
>  size=128M
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 227b37e941..873ca6b104 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -105,6 +105,12 @@ _filter_block_job_len()
>      sed -e 's/, "len": [0-9]\+,/, "len": LEN,/g'
>  }
>  
> +# replace actual image size (depends on the host filesystem)
> +_filter_actual_image_size()
> +{
> +    sed -s 's/\("actual-size":\s*\)[0-9]\+/\1SIZE/g'
> +}
> +
>  # replace driver-specific options in the "Formatting..." line
>  _filter_img_create()
>  {
> -- 
> 2.13.6
> 
> 
