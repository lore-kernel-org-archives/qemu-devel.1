Received: from eggs.gnu.org ([2001:4830:134:3::10]:34528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHl-0002YB-97
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHh-0003lN-CV
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHh-0003jE-0y
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:33 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJd0of136461
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:31 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g80r1k6v1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:31 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:30 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-10-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-10-armbru@redhat.com>
Date: Sun, 18 Feb 2018 16:31:15 -0600
Message-Id: <151899307518.12376.3557657658351863552@sif>
Subject: Re: [Qemu-devel] [PATCH v2 09/29] qapi-gen: Convert from getopt to
 argparse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:35:47)
> argparse is nicer to use than getopt, and gives us --help almost for
> free.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-gen.py    | 48 ++++++++++++++++++++++++++++++--------------=
----
>  scripts/qapi/common.py | 43 -------------------------------------------
>  2 files changed, 30 insertions(+), 61 deletions(-)
> =

> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 2100ca1145..e5be484e3e 100755
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -4,8 +4,11 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
>  # See the COPYING file in the top-level directory.
> =

> +from __future__ import print_function
> +import argparse
> +import re
>  import sys
> -from qapi.common import parse_command_line, QAPISchema
> +from qapi.common import QAPISchema
>  from qapi.types import gen_types
>  from qapi.visit import gen_visit
>  from qapi.commands import gen_commands
> @@ -15,26 +18,35 @@ from qapi.doc import gen_doc
> =

> =

>  def main(argv):
> -    (input_file, output_dir, prefix, opts) =3D \
> -        parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
> +    parser =3D argparse.ArgumentParser(
> +        description=3D'Generate code from a QAPI schema')
> +    parser.add_argument('-b', '--builtins', action=3D'store_true',
> +                        help=3D"generate code for built-in types")
> +    parser.add_argument('-o', '--output_dir', action=3D'store', default=
=3D'',

Was the change from --output-dir to --output_dir intentional? The former
seems more consistent.
