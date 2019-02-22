Received: from eggs.gnu.org ([209.51.188.92]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxCci-000219-8q
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxCch-0008Qp-EI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:20:24 -0500
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <83a234ca-cf14-76b9-0374-6425dab989bd@redhat.com>
Date: Fri, 22 Feb 2019 10:20:15 -0500
MIME-Version: 1.0
In-Reply-To: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] iotests: handle TypeError for Python3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com, mreitz@redhat.com, den@openvz.org, philmd@redhat.com



On 2/22/19 6:26 AM, Andrey Shinkevich wrote:
> The data type for bytes in Python3 differs from the one in Python2.
> Those cases should be managed separately.
> 
> v1:
> In the first version, the TypeError in Python3 was handled as the
> exception.
> Discussed in the e-mail thread with the Message ID:
> <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/242 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
> index 16c65ed..446fbf8 100755
> --- a/tests/qemu-iotests/242
> +++ b/tests/qemu-iotests/242
> @@ -20,6 +20,7 @@
>  
>  import iotests
>  import json
> +import sys
>  from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
>      file_path, img_info_log, log, filter_qemu_io
>  
> @@ -65,9 +66,12 @@ def toggle_flag(offset):
>      with open(disk, "r+b") as f:
>          f.seek(offset, 0)
>          c = f.read(1)
> -        toggled = chr(ord(c) ^ bitmap_flag_unknown)
> +        toggled = ord(c) ^ bitmap_flag_unknown
>          f.seek(-1, 1)
> -        f.write(toggled)
> +        if sys.version_info.major >= 3:
> +            f.write(bytes([toggled]))
> +        else:
> +            f.write(chr(toggled))
>  

I originally suggested:

sys.version_info.major == 2:
 ...

Because this is already present on other tests, and IIRC Max mentioned
using this as an easy to find flag the moment Python 2 support is to be
dropped.  But, looking for "sys.version_info.major" is just as
effective, so:

Reviewed-by: Cleber Rosa <crosa@redhat.com>

>  
>  qemu_img_create('-f', iotests.imgfmt, disk, '1M')
> 
