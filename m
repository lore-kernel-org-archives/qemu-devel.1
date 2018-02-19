Received: from eggs.gnu.org ([2001:4830:134:3::10]:34312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHT-0002G4-1k
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHR-0003LJ-QK
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHR-0003Jd-GF
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:17 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJcvAm106769
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:16 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g7wp63rwf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:15 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:15 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-20-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-20-armbru@redhat.com>
Date: Mon, 19 Feb 2018 09:52:52 -0600
Message-Id: <151905557279.12376.11982412186477174825@sif>
Subject: Re: [Qemu-devel] [PATCH v2 19/29] qapi: Make code-generating
 visitors use QAPIGen more
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

Quoting Markus Armbruster (2018-02-11 03:35:57)
> The use of QAPIGen is rather shallow so far: most of the output
> accumulation is not converted.  Take the next step: convert output
> accumulation in the code-generating visitor classes.  Helper functions
> outside these classes are not converted.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/commands.py   | 71 ++++++++++++++++------------------------
>  scripts/qapi/common.py     | 13 ++++++++
>  scripts/qapi/doc.py        | 74 ++++++++++++++++++++--------------------=
--
>  scripts/qapi/events.py     | 55 ++++++++++++-------------------
>  scripts/qapi/introspect.py | 56 +++++++++++++-------------------
>  scripts/qapi/types.py      | 81 +++++++++++++++++++---------------------=
------
>  scripts/qapi/visit.py      | 80 +++++++++++++++++++---------------------=
-----
>  7 files changed, 188 insertions(+), 242 deletions(-)
> =


<snip>

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 29d98ca934..31d2f73e7e 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -2049,3 +2049,16 @@ class QAPIGenDoc(QAPIGen):
>      def _top(self, fname):
>          return (QAPIGen._top(self, fname)
>                  + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
> +
> +
> +class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
> +
> +    def __init__(self, prefix, what, blurb, pydoc):
> +        self._prefix =3D prefix
> +        self._what =3D what
> +        self._genc =3D QAPIGenC(blurb, pydoc)
> +        self._genh =3D QAPIGenH(blurb, pydoc)
> +
> +    def write(self, output_dir):
> +        self._genc.write(output_dir, self._prefix + self._what + '.c')
> +        self._genh.write(output_dir, self._prefix + self._what + '.h')

minor nit: since subclasses of QAPISchemaVisitor and
QAPISchemaMonolithicCVisitor all rely on .write() now, should we declare it
in the abstract QAPISchemaVisitor?

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
