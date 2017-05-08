Received: from eggs.gnu.org ([2001:4830:134:3::10]:57267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7kxu-0000Zc-DF
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7kxq-0004JL-L8
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:52:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d7kxq-0004H3-FQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:52:46 -0400
Date: Mon, 8 May 2017 16:52:37 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170508155237.GW18871@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170505032340.26467-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Fri, May 05, 2017 at 11:23:40AM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-block | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 tests/docker/test-block
> 
> diff --git a/tests/docker/test-block b/tests/docker/test-block
> new file mode 100755
> index 0000000..20ef705
> --- /dev/null
> +++ b/tests/docker/test-block
> @@ -0,0 +1,21 @@
> +#!/bin/bash -e
> +#
> +# Run block test cases
> +#
> +# Copyright (c) 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +. common.rc
> +
> +cd "$BUILD_DIR"
> +
> +build_qemu --target-list=x86_64-softmmu
> +cd tests/qemu-iotests
> +./check -raw
> +./check -qcow2

qcow v1  should be passing all tests now too, so pleae include
that.

I also want to have LUKS support included, though that is pending
a couple of patches to fix some current failures

  https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00277.html

If we add more tests though, this single 'test-block' job is going
to get pretty slow.  qcow v1 is massively slower to complete tests
than qcow v2, and luks is quite alot slower too - particularly if
you enable the cryptsetup interoperability test case (it takes about
5 minutes to run now)

Should we have separate jobs to parallelize this across different
I/O backends.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
