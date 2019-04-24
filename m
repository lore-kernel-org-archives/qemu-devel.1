Received: from eggs.gnu.org ([209.51.188.92]:42900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJFSh-0005ZR-7x
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJFSf-0007lV-Oj
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:49:11 -0400
Date: Wed, 24 Apr 2019 11:48:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424104855.GE31388@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424103747.10173-6-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

On Wed, Apr 24, 2019 at 12:37:46PM +0200, Thomas Huth wrote:
> People often forget to run the iotests before submitting patches or
> pull requests - this is likely due to the fact that we do not run the
> tests during our mandatory "make check" tests yet. Now that we've got
> a new "ci" group of iotests that should be fine to run in every environ-
> ment, it should be OK to enable the iotests during "make check" again.
> Thus we now run the "ci" tests by default from the qemu-iotests-quick.sh
> script, and only use the former "quick" group (that contains some tests
> that are failing in some environments) when the user decided to run
> "make check SPEED=thorough" or something similar.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include      |  2 +-
>  tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)

> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
> index 0e554bb972..416b3fc48b 100755
> --- a/tests/qemu-iotests-quick.sh
> +++ b/tests/qemu-iotests-quick.sh

s/-quick//  perhaps, since it no longer only runs the "quick" tests.

> @@ -1,8 +1,23 @@
>  #!/bin/sh
>  
> +# Honor the SPEED environment variable, just like we do it for the qtests.
> +# The default is to run all tests that still work fine in a CI environments,
> +# but if the user set SPEED=slow or SPEED=thorough, we also run all other
> +# tests that are still marked as "quick"
> +if [ "$SPEED" = "slow" -o "$SPEED" = "thorough" ]; then
> +    group=quick

When user asks for "slow" tests we run the "quick" tests, which
presumably implies...

> +else
> +    group=ci

..."ci" is quicker than the "quick"  tests !

Confused ? We certainly try to ensure that you will be :-)

> +fi
> +
> +if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +    echo "No qemu-system binary available. Skipped qemu-iotests."
> +    exit 0
> +fi
> +
>  cd tests/qemu-iotests
>  
>  ret=0
> -TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g quick || ret=1
> +TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g "$group" || ret=1


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
