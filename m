Received: from eggs.gnu.org ([2001:4830:134:3::10]:34897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyejQ-0007st-Qc
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyejN-0006Mo-OB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:28:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyejN-0006Kw-KL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:28:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3C9A4023BB3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 14:28:41 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5321b7df-215e-e56d-ae6d-2ada8706cdcc@redhat.com>
Date: Wed, 21 Mar 2018 09:28:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180321134005.8822-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
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
> Now that we can safely call QOBJECT() on QObject * and children types,
> we can have a single macro to ref/unref the object.
>=20
> Change the incref/decref prefix name for the more common ref/unref.

I know you did this by sed (for the most part); but it would be worth=20
including the command line you used in the commit message to make it=20
easier to reproduce the same mechanical portion of the patch when rebasin=
g.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/include/qapi/qmp/qobject.h

> @@ -74,13 +74,16 @@ qobject_unknown_type(const void *unused)
>       (const QObject *, x),                       \
>       qobject_unknown_type(x))
>  =20
> -/* High-level interface for qobject_incref() */
> -#define QINCREF(obj)      \
> -    qobject_incref(QOBJECT(obj))
> +/**
> + * qobject_ref(): Increment QObject's reference count
> + */
> +#define qobject_ref(x) qobject_ref_impl(QOBJECT(x))

The meat of the patch; looks fine to me.

> +++ b/scripts/coccinelle/qobject.cocci
> @@ -3,11 +3,11 @@
>   expression Obj, Key, E;
>   @@
>   (
> -- qobject_incref(QOBJECT(E));
> -+ QINCREF(E);
> +- qobject_ref(QOBJECT(E));
> ++ qobject_ref(E);
>   |
> -- qobject_decref(QOBJECT(E));
> -+ QDECREF(E);
> +- qobject_unref(QOBJECT(E));
> ++ qobject_unref(E);

I wonder if these branches should just be removed; they made sense when=20
we had two spellings, but after your mass conversion, the .cocci script=20
is unlikely to ever find regressions on this front.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
