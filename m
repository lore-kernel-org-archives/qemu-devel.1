Received: from eggs.gnu.org ([2001:4830:134:3::10]:43706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db860-0001WK-Fc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db85w-000062-Dn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1db85w-0008VY-7v
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:26:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-48-f4bug@amsat.org>
Date: Fri, 28 Jul 2017 18:26:27 +0200
In-Reply-To: <20170728053610.15770-48-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri,
	28 Jul 2017 02:36:10 -0300")
Message-ID: <87r2x0le8c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 47/47] script to find outdated entry in
 MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/check_maintainer.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 scripts/check_maintainer.sh
>
> diff --git a/scripts/check_maintainer.sh b/scripts/check_maintainer.sh
> new file mode 100755
> index 0000000000..074a6acf69
> --- /dev/null
> +++ b/scripts/check_maintainer.sh
> @@ -0,0 +1,21 @@
> +#! /bin/bash
> +#
> +# This script checks MAINTAINERS consistency

Consistency?  I think you mean coverage.

> +#
> +# Copyright (C) 2017 Philippe Mathieu-Daud=C3=A9. GPLv2+.
> +#
> +# Usage:
> +# ./scripts/check_maintainer.sh | tee MAINTAINERS.missing
> +
> +echo "Incorrect MAINTAINERS paths:" 1>&2
> +egrep ^F: MAINTAINERS | cut -d\  -f2 | while read p; do
> +    ls -ld $p 1>/dev/null
> +done
> +
> +echo "No maintainers found for:" 1>&2
> +git ls-files|while read f; do
> +    OUT=3D$(./scripts/get_maintainer.pl -f $f 2>&1)
> +    if [[ "$OUT" =3D=3D *"No maintainers found"* ]]; then
> +        echo $f
> +    fi
> +done

Good idea.

But what I really want is checkpatch whining when it happens.  Thomas
posted a patch some time ago.  Would you be willing to revive it?

https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05742.html
Message-Id: <1485436265-12573-5-git-send-email-thuth@redhat.com>

Basically:

* Patch deletes a file

  - still in MAINTAINERS after the patch: warn
  - else: ok

* Patch creates a file

  - not in in MAINTAINERS after the patch: warn
  - else: ok

* Patch moves a file

  - old still in MAINTAINERS after the patch: warn
  - new not in in MAINTAINERS after the patch: warn
  - neither: ok

May have to ignore "uninteresting" files to reduce the noise.  But even
ignoring everything but *.[ch] would be an improvement!
