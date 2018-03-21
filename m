Received: from eggs.gnu.org ([2001:4830:134:3::10]:56377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeJS-0007p7-U9
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeJM-0006Em-WE
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:01:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyeJM-0006EV-SN
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:01:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BF96A2025
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 14:01:50 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <989e4d84-15a9-8867-4616-31fc6c6151fa@redhat.com>
Date: Wed, 21 Mar 2018 09:01:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180321134005.8822-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qobject: assume base of a qobject is
 at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

On 03/21/2018 08:40 AM, Marc-Andr=C3=A9 Lureau wrote:
> Simplify casting to QObject by not requiring the definition of the
> type and assuming base QObject is at offset 0. Add a static check for
> this.
>=20
> Use the QEMU_GENERIC macro for keeping type safety check and error
> when given an unknown type.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qapi/qmp/qobject.h | 36 ++++++++++++++++++++++++++++++++++--
>   qobject/qobject.c          |  9 +++++++++
>   2 files changed, 43 insertions(+), 2 deletions(-)

> +++ b/qobject/qobject.c
> @@ -16,6 +16,15 @@
>   #include "qapi/qmp/qlist.h"
>   #include "qapi/qmp/qstring.h"
>  =20
> +QEMU_BUILD_BUG_MSG(
> +    offsetof(QNull, base) !=3D 0 ||
> +    offsetof(QNum, base) !=3D 0 ||
> +    offsetof(QString, base) !=3D 0 ||
> +    offsetof(QDict, base) !=3D 0 ||
> +    offsetof(QList, base) !=3D 0 ||
> +    offsetof(QBool, base) !=3D 0,
> +    "base qobject must be at offset 0");

Interesting.  If we do this, we should also simplify qobject_to() from=20
its current:

#define qobject_to(type, obj) ({ \
     QObject *_tmp =3D qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)=
); \
     _tmp ? container_of(_tmp, type, base) : (type *)NULL; })

to the simpler:

#define qobject_to(type, obj) \
     ((type *)qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)))


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
