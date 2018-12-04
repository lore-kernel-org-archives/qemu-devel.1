Received: from eggs.gnu.org ([2001:4830:134:3::10]:42375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUCYD-0001RB-Cx
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUCYB-00080Z-M2
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUCYB-0007u4-DT
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:23:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEED8804E5
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 15:23:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-6-marcandre.lureau@redhat.com>
Date: Tue, 04 Dec 2018 16:23:36 +0100
In-Reply-To: <20180706105753.26700-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 12:57:31 +0200")
Message-ID: <877egpwc1z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/27] qapi: include osdep.h in type
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Now that the schema can be configured, it is crucial that all types
> are configured the same. Make sure config-host.h is included, so
> build-sys tracks the dependency and rebuilds the types, by including
> osdep.h first.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/types.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index fd7808103c..91f87d0b8f 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -201,6 +201,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
>  ''',
>                                        types=3Dtypes, visit=3Dvisit))
>          self._genh.preamble_add(mcgen('''
> +#include "qemu/osdep.h"
>  #include "qapi/qapi-builtin-types.h"
>  '''))

No.  Every .c must include qemu/osdep.h first.  No .h may include it.
We clean this up periodically.  scripts/clean-includes can help with
that.  We currently have a few offenders in the tree.
