Received: from eggs.gnu.org ([2001:4830:134:3::10]:54870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLtR-0007KR-Kw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLtQ-00044i-If
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:45:29 -0400
Date: Mon, 12 Mar 2018 11:45:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312114522.GL3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172713.26318-7-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] qemu-iotests: Test luks QMP image
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 06:27:13PM +0100, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/208       | 211 +++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/208.out   | 136 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/common.rc |   2 +-
>  tests/qemu-iotests/group     |   1 +
>  4 files changed, 349 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/208
>  create mode 100644 tests/qemu-iotests/208.out
> 
> diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
> new file mode 100755
> index 0000000000..ab4650d0ae
> --- /dev/null
> +++ b/tests/qemu-iotests/208


> +
> +run_qemu -object secret,id=keysec0,data="foo" <<EOF
> +{ "execute": "qmp_capabilities" }
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "file",
> +      "filename": "$TEST_IMG_FILE",
> +      "size": 0
> +  }
> +}
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": {
> +          "driver": "file",
> +          "filename": "$TEST_IMG_FILE"
> +      },
> +      "size": $size,
> +      "qcrypto": {
> +          "key-secret": "keysec0",
> +          "cipher-alg": "twofish-128",
> +          "cipher-mode": "ctr",
> +          "ivgen-alg": "plain64",
> +          "ivgen-hash-alg": "md5",
> +          "hash-alg": "sha1",
> +          "iter-time": 10

I'd recommend using  'iter-time': 10, in every single x-blockdev-create
command in this file, otherwise this test will be unneccessarily slow to
execute as each x-blockdev-create will burn 2 seconds of time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
