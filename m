Received: from eggs.gnu.org ([2001:4830:134:3::10]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqeXv-0002Yo-N0
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 08:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqeXu-0002ri-MP
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 08:07:35 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqeXu-0002rR-FV
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 08:07:34 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 108so7972271wra.5
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 05:07:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170909054613.19148-11-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
	<20170909054613.19148-11-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Sep 2017 13:07:12 +0100
Message-ID: <CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 September 2017 at 06:45, Fam Zheng <famz@redhat.com> wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Message-Id: <20170905021201.25684-4-famz@redhat.com>
> ---
>  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..1de369532e
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +#
> +# Author: Fam Zheng <famz@redhat.com>
> +#
> +# Create archive of source tree, including submodules
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.

So is this the script that for instance Mike Roth would use
to create the release tarballs? If it isn't, should it be?
Is it intended for end users to create tarballs with, or
is it really just a helper script for the docker stuff?
If the latter, it would be helpful to say so. If the former,
it could really use more usage information/documentation...

> +
> +set -e
> +
> +if test $# -lt 1; then
> +    echo "Usage: $0 <output>"
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
> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > $1.list

Supporting '-e something' in a tar -T listfile seems to
be GNU tar specific. Do we care?

> +else
> +    git ls-files > $1.list
> +fi

This will blow up if we ever have a file in the repo
that starts with a '-'. Do we care?

> +
> +tar -cf $1 -T $1.list
> +rm $1.list

This is missing a lot of quoting for $1, so it will go wrong
if there's a space in that filename argument.

thanks
-- PMM
