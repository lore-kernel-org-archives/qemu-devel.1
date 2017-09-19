Received: from eggs.gnu.org ([2001:4830:134:3::10]:52058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duK7Y-0003MW-KB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duK7V-0006yB-Rd
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:07:32 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:46716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1duK7V-0006xi-KM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:07:29 -0400
Received: by mail-wm0-x234.google.com with SMTP id i189so359699wmf.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:07:29 -0700 (PDT)
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-4-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170919072719.11815-4-famz@redhat.com>
Date: Tue, 19 Sep 2017 16:07:28 +0100
Message-ID: <877ewuengv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  scripts/archive-source.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..e155d980ee
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,46 @@
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
> +error() {
> +    echo "$@" >&2
> +    exit 1
> +}
> +
> +if test $# -lt 1; then
> +    error "Usage: $0 <output tarball>"
> +fi
> +
> +submodules=$(git submodule foreach --recursive --quiet 'echo $name')
> +
> +if test $? -ne 0; then
> +    error "git submodule command failed"
> +fi
> +
> +if test -n "$submodules"; then
> +    {
> +        git ls-files || error "git ls-files failed"
> +        for sm in $submodules; do
> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> +            if test ${PIPESTATUS[0]} -ne 0 -o $? -ne 0; then
> +                error "git ls-files in submodule $sm failed"
> +            fi
> +        done
> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$1".list
> +else
> +    git ls-files > "$1".list
> +fi
> +
> +if test $? -ne 0; then
> +    error "failed to generate list file"
> +fi
> +
> +tar -cf "$1" -T "$1".list || error "failed to create tar file"
> +rm "$1".list


--
Alex Bennée
