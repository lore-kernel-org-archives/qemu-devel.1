Received: from eggs.gnu.org ([2001:4830:134:3::10]:39357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5Kx-0002V1-Ig
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5Kw-0008Ry-OO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:56:07 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:47035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ds5Kw-0008Qo-I4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:56:06 -0400
Received: by mail-wm0-x232.google.com with SMTP id i189so3580561wmf.1
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 03:56:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170913030119.3957-4-famz@redhat.com>
References: <20170913030119.3957-1-famz@redhat.com>
	<20170913030119.3957-4-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Sep 2017 11:55:44 +0100
Message-ID: <CAFEAcA_BfVKDOs3R6hv+-VY5MUcfi97g0RuLwNL2-Zxb+0yK6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On 13 September 2017 at 04:01, Fam Zheng <famz@redhat.com> wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/archive-source.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..8b373e3090
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +#
> +# Author: Fam Zheng <famz@redhat.com>
> +#
> +# Archive source tree, including submodules. This is created for test code to
> +# export the source files, in order to be built in a different enviornment,

"environment"

> +# such as in a docker instance or VM.
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +
> +set -e
> +
> +if test $# -lt 1; then
> +    echo "Usage: $0 <output tarball>"
> +    exit 1
> +fi
> +
> +submodules=$(git submodule foreach --recursive --quiet 'echo $name')
> +
> +if test -n "$submodules"; then
> +    {
> +        git ls-files
> +        for sm in $submodules; do
> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> +        done
> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$1".list
> +else
> +    git ls-files > "$1".list
> +fi
> +
> +tar -cf "$1" -T "$1".list
> +rm "$1".list
> --
> 2.13.5
>

thanks
-- PMM
