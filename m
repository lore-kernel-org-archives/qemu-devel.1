Received: from eggs.gnu.org ([209.51.188.92]:57093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gyMzP-0003X8-Ts
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gyMzP-0004Qi-5d
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:36:39 -0500
Date: Mon, 25 Feb 2019 17:26:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190225202630.GA4925@habkost.net>
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, crosa@redhat.com, mreitz@redhat.com, kwolf@redhat.com, philmd@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On Fri, Feb 22, 2019 at 02:26:13PM +0300, Andrey Shinkevich wrote:
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

Pretending we are dealing with text strings and using str/ord is
a python2-specific quirk.  I think it would be nice to get rid of
it.

Python 2 has bytearray(), which behaves more similarly to the
bytes type from Python 3.  If we use it, we can make the code
more python3-like:

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 16c65edcd7..7794fd4a70 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -64,10 +64,12 @@ def write_to_disk(offset, size):
 def toggle_flag(offset):
     with open(disk, "r+b") as f:
         f.seek(offset, 0)
-        c = f.read(1)
-        toggled = chr(ord(c) ^ bitmap_flag_unknown)
+        # The casts to bytearray() below are only necessary
+        # for Python 2 compatibility
+        c = bytearray(f.read(1))[0]
+        toggled = c ^ bitmap_flag_unknown
         f.seek(-1, 1)
-        f.write(toggled)
+        f.write(bytearray([toggled]))
 
 
 qemu_img_create('-f', iotests.imgfmt, disk, '1M')

-- 
Eduardo
