Received: from eggs.gnu.org ([2001:4830:134:3::10]:38823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnsay-0008CM-T6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnsau-0003Es-3F
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:31:16 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnsat-0003E0-Uc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:31:12 -0400
Received: by mail-qk0-x241.google.com with SMTP id a77so947272qkb.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 13:31:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-4-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e83fff4-2a8d-f16b-51cd-9d99441f443d@amsat.org>
Date: Fri, 1 Sep 2017 17:31:06 -0300
MIME-Version: 1.0
In-Reply-To: <20170831064302.14427-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/12] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 08/31/2017 03:42 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   scripts/archive-source.sh | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>   create mode 100755 scripts/archive-source.sh
> 
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..84e84961d4
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +#
> +# Author: Fam Zheng <famz@redhat.com>
> +#
> +# Create archive of source tree, including submodules
> +#

It seems you missed the license here.

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
> +else
> +    git ls-files > $1.list
> +fi
> +
> +tar -cf $1 -T $1.list
> +rm $1.list
> 
