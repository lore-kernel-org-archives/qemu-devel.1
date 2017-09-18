Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsJy-00066T-DV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsJu-0006SR-FJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:26:30 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:47648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtsJu-0006S6-7y
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:26:26 -0400
Received: by mail-wm0-x230.google.com with SMTP id 13so829192wmq.2
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 02:26:26 -0700 (PDT)
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-4-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170918024402.3265-4-famz@redhat.com>
Date: Mon, 18 Sep 2017 10:26:23 +0100
Message-ID: <87h8w0jr28.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

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


--
Alex Bennée
