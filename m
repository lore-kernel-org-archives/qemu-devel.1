Received: from eggs.gnu.org ([2001:4830:134:3::10]:49843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXrr8-0002oZ-En
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXrr3-0000ly-GA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:06:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gXrr3-0000lj-8J
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:06:29 -0500
References: <20181214094828.18343-1-pbonzini@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6e191a36-7283-ed82-5f1f-3a8f4f818d62@redhat.com>
Date: Fri, 14 Dec 2018 16:06:25 -0200
MIME-Version: 1.0
In-Reply-To: <20181214094828.18343-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add script to convert
 multiline comments into 4-line format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com



On 12/14/2018 07:48 AM, Paolo Bonzini wrote:
> Since we're adding checkpatch rules to enforce 4-line multiline comment
> format, i.e. with lone /* and */, this script can be run on existing
> code so that the comment style does not become inconsistent within a
> file.
>
> The alternative to awk-in-a-shell-script could be Perl, which also
> supports -i directly, but a2p seems to have bitrotten and I didn't quit=
e
> feel like writing this twice...
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>          v1->v2: fix handling of multiline doc comments without lone /*=
*
> ---
>   scripts/fix-multiline-comments.sh | 62 ++++++++++++++++++++++++++++++=
+
>   1 file changed, 62 insertions(+)
>   create mode 100755 scripts/fix-multiline-comments.sh
>
> diff --git a/scripts/fix-multiline-comments.sh b/scripts/fix-multiline-=
comments.sh
> new file mode 100755
> index 0000000000..93f9b10669
> --- /dev/null
> +++ b/scripts/fix-multiline-comments.sh
> @@ -0,0 +1,62 @@
> +#! /bin/sh
> +#
> +# Fix multiline comments to match CODING_STYLE
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +#
> +# Author: Paolo Bonzini
> +#
> +# Usage: scripts/fix-multiline-comments.sh [-i] FILE...
> +#
> +# -i edits the file in place (requires gawk 4.1.0).
> +#
> +# Set the AWK environment variable to choose the awk interpreter to us=
e
> +# (default 'awk')
> +
> +if test "$1" =3D -i; then
> +  # gawk extension
> +  inplace=3D"-i inplace"
> +  shift
> +fi
> +${AWK-awk} $inplace 'BEGIN { indent =3D -1 }
> +{
> +    line =3D $0
> +    # apply a star to the indent on lines after the first
> +    if (indent !=3D -1) {
> +        if (line =3D=3D "") {
> +            line =3D sp " *"
> +        } else if (substr(line, 1, indent + 2) =3D=3D sp "  ") {
> +            line =3D sp " *" substr(line, indent + 3)
> +        }
> +    }

IIUC above block handles the lines between lead and trail. So it would=20
fix (but it doesn't) this:

# cat foo
/*
 =C2=A0comment 1
 =C2=A0comment 2
 =C2=A0*/

# scripts/fix-multiline-comments.sh foo
/*
 =C2=A0comment 1
 =C2=A0comment 2
 =C2=A0*/

- Wainer

> +
> +    is_lead =3D (line ~ /^[ \t]*\/\*/)
> +    is_trail =3D (line ~ /\*\//)
> +    if (is_lead && !is_trail) {
> +        # grab the indent at the start of a comment, but not for
> +        # single-line comments
> +        match(line, /^[ \t]*\/\*/)
> +        indent =3D RLENGTH - 2
> +        sp =3D substr(line, 1, indent)
> +    }
> +
> +    # the regular expression filters out lone /*, /**, or */
> +    if (indent !=3D -1 && !(line ~ /^[ \t]*(\/\*+|\*\/)[ \t]*$/)) {
> +        if (is_lead) {
> +            # split the leading /* or /** on a separate line
> +            match(line, /^[ \t]*\/\*+/)
> +            lead =3D substr(line, 1, RLENGTH)
> +            match(line, /^[ \t]*\/\*+[ \t]*/)
> +            line =3D lead "\n" sp " *" substr(line, RLENGTH)
> +        }
> +        if (is_trail) {
> +            # split the trailing */ on a separate line
> +            match(line, /[ \t]*\*\//)
> +            line =3D substr(line, 1, RSTART - 1) "\n" sp " */"
> +        }
> +    }
> +    if (is_trail) {
> +        indent =3D -1
> +    }
> +    print line
> +}' "$@"
