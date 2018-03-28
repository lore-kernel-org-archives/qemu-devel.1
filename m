Received: from eggs.gnu.org ([2001:4830:134:3::10]:56749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1BOe-0002mU-TM
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1BOb-0006F0-Qf
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:45:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f1BOb-0006EX-Lv
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:45:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA58BF6404
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:45:41 +0000 (UTC)
References: <20180328130723.20831-1-marcandre.lureau@redhat.com>
	<20180328130723.20831-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a74de730-cf65-056c-dfa1-2fcc9361b9a1@redhat.com>
Date: Wed, 28 Mar 2018 08:45:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180328130723.20831-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qobject: introduce QObjectCommon
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

On 03/28/2018 08:07 AM, Marc-Andr=C3=A9 Lureau wrote:
> By moving the common fields to a QObjectCommon, QObject can be a type
> which also has a 'base' QObjectCommon field. This allows to write a
> generic QOBJECT() macro that will work with any QObject type,
> including QObject itself. The container_of() macro ensures that the
> object to cast has a QObjectCommon base field, give me some type
> safety guarantees. However, for it to work properly, all QObject types
> must have 'base' at offset 0 (which is ensured by static checking from
> previous patch)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/include/qapi/qmp/qbool.h
> @@ -17,7 +17,7 @@
>   #include "qapi/qmp/qobject.h"
>  =20
>   struct QBool {
> -    QObject base;
> +    struct QObjectCommon base;

Why no 'typedef struct QObjectCommon QObjectCommon' in scope to make=20
this simpler?

> -/* Get the 'base' part of an object */
> -#define QOBJECT(obj) (&(obj)->base)
> +struct QObject {
> +    struct QObjectCommon base;
> +};
> +
> +#define QOBJECT(x) \
> +   container_of(&(x)->base, QObject, base)

If I understand correctly, this still causes clang complaints when=20
called as QOBJECT(NULL).  As long as we are touching this, should we=20
improve this macro to be friendly to NULL conversion?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
