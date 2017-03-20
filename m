Received: from eggs.gnu.org ([2001:4830:134:3::10]:56256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq4U9-0004Nn-G8
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq4U5-0005ea-Ha
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:05:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55178
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq4U5-0005eL-BK
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:04:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KKwYiN165726
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 17:04:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb5p4hv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 17:04:56 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 15:04:55 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1490026424-11330-2-git-send-email-armbru@redhat.com>
References: <1490026424-11330-1-git-send-email-armbru@redhat.com>
	<1490026424-11330-2-git-send-email-armbru@redhat.com>
Date: Mon, 20 Mar 2017 16:04:44 -0500
Message-Id: <149004388488.3910.16144904386783855924@loki>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] qapi: Fix string input visitor
 regression for empty lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2017-03-20 11:13:43)
> Visiting a list when input is the empty string should result in an
> empty list, not an error.  Noticed when commit 3d089ce belatedly added
> tests, but simply accepted as weird then.  It's actually a regression:
> broken in commit 74f24cb, v2.7.0.  Fix it, and throw in another test
> case for empty string.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  qapi/string-input-visitor.c       |  4 ++++
>  tests/test-string-input-visitor.c | 11 ++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> =

> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 806b01ae..c089491 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -54,6 +54,10 @@ static int parse_str(StringInputVisitor *siv, const ch=
ar *name, Error **errp)
>          return 0;
>      }
> =

> +    if (!*str) {
> +        return 0;
> +    }
> +
>      do {
>          errno =3D 0;
>          start =3D strtoll(str, &endptr, 0);
> diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-=
visitor.c
> index 6db850b..79313a7 100644
> --- a/tests/test-string-input-visitor.c
> +++ b/tests/test-string-input-visitor.c
> @@ -63,6 +63,11 @@ static void test_visitor_in_int(TestInputVisitorData *=
data,
> =

>      visit_type_int(v, NULL, &res, &err);
>      error_free_or_abort(&err);
> +
> +    v =3D visitor_input_test_init(data, "");
> +
> +    visit_type_int(v, NULL, &res, &err);
> +    error_free_or_abort(&err);
>  }
> =

>  static void check_ilist(Visitor *v, int64_t *expected, size_t n)
> @@ -140,11 +145,11 @@ static void test_visitor_in_intList(TestInputVisito=
rData *data,
>      v =3D visitor_input_test_init(data, "18446744073709551615");
>      check_ulist(v, expect4, ARRAY_SIZE(expect4));
> =

> -    /* Empty list is invalid (weird) */
> +    /* Empty list */
> =

>      v =3D visitor_input_test_init(data, "");
> -    visit_type_int64List(v, NULL, &res, &err);
> -    error_free_or_abort(&err);
> +    visit_type_int64List(v, NULL, &res, &error_abort);
> +    g_assert(!res);
> =

>      /* Not a list */
> =

> -- =

> 2.7.4
>=20
