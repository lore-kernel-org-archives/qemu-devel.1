Received: from eggs.gnu.org ([2001:4830:134:3::10]:44936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNOQe-0004VK-6U
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 15:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNOQd-0004kJ-Bp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 15:39:56 -0500
References: <20181105163744.25139-1-kwolf@redhat.com>
	<20181105163744.25139-30-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05732a1e-9ed2-69da-8e9a-4ac793d8a4b4@redhat.com>
Date: Thu, 15 Nov 2018 14:39:39 -0600
MIME-Version: 1.0
In-Reply-To: <20181105163744.25139-30-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 29/36] qemu-iotests: Test auto-read-only
 with -drive and -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

On 11/5/18 10:37 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/qemu-iotests/232     | 147 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/232.out |  59 +++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 207 insertions(+)
>   create mode 100755 tests/qemu-iotests/232
>   create mode 100644 tests/qemu-iotests/232.out
> 
> diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
> new file mode 100755
> index 0000000000..bc2972d124
> --- /dev/null
> +++ b/tests/qemu-iotests/232
> @@ -0,0 +1,147 @@
> +#!/bin/bash
> +#
> +# Test for auto-read-only

This breaks './check -luks 232':

@@ -3,57 +3,60 @@

  === -drive with read-write image: read-only/auto-read-only 
combinations ===

-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
-NODE_NAME: TEST_DIR/t.IMGFMT (file)
+QEMU_PROG: -drive 
driver=file,file=driver=IMGFMT,key-secret=keysec0,file.filename=TEST_DIR/t.IMGFMT,if=none,read-only=on,auto-read-only=off: 
Could not open 'driver=IMGFMT': No such file or directory
+QEMU_PROG: -drive 
driver=file,file=driver=IMGFMT,key-secret=keysec0,file.filename=TEST_DIR/t.IMGFMT,if=none,read-only=on,auto-read-only=on: 
Could not open 'driver=IMGFMT': No such file or directory

...

I know that for LUKS, you have to use --image-opts, which would require 
some rewrites of the commands you are testing; so maybe the best thing 
is to just blacklist this test from running on LUKS?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
