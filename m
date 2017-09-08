Received: from eggs.gnu.org ([2001:4830:134:3::10]:57489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqKUP-0002Fh-EK
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqKUK-00021u-GX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:42:37 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:43840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqKUK-00020U-8N
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:42:32 -0400
Received: by mail-wm0-x230.google.com with SMTP id f145so6576162wme.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 07:42:32 -0700 (PDT)
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-4-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170905021201.25684-4-famz@redhat.com>
Date: Fri, 08 Sep 2017 15:42:29 +0100
Message-ID: <87vaktgskq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 03/12] scripts: Add archive-source.sh
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
> ---
>  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..3cae7f34d3
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +#
> +# Author: Fam Zheng <famz@redhat.com>
> +#
> +# Create archive of source tree, including submodules
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +
> +set -e
> +
> +if test $# -lt 1; then
> +    echo "Usage: $0 <output>"

Maybe <output tarball> to make it clear what it creates?

> +    exit 1
> +fi
> +
> +submodules=$(git submodule foreach --recursive --quiet 'echo $name')
> +
> +if test -n "$submodules"; then
> +    {
> +        git ls-files

Couldn't we do the main git ls-files first and then append the data for
any submodules?

> +        for sm in $submodules; do
> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> +        done
> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > $1.list
> +else
> +    git ls-files > $1.list
> +fi
> +
> +tar -cf $1 -T $1.list
> +rm $1.list


--
Alex Bennée
