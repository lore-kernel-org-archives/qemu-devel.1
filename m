Received: from eggs.gnu.org ([2001:4830:134:3::10]:37892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1a8h-0005F8-Pn
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1a8e-00033T-Hn
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:10:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f1a8e-000331-Cr
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:10:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 868207CBBA
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 16:10:52 +0000 (UTC)
References: <20180329154833.566-1-marcandre.lureau@redhat.com>
	<20180329154833.566-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49475649-b8d8-e09a-8e95-7ce36c7396f2@redhat.com>
Date: Thu, 29 Mar 2018 11:10:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180329154833.566-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qobject: modify qobject_ref() to
 assert on NULL and return obj
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

On 03/29/2018 10:48 AM, Marc-Andr=C3=A9 Lureau wrote:
> Following a discussion on the mailing list: while it may be convenient
> to accept NULL value in qobject_unref() (for similar reasons as free()
> accepts NULL), it is a probably a bad idea to accept NULL argument in
> qobject_ref().
>=20
> Furthermore, it is convenient and more clear to call qobject_ref() at
> the time when the reference is associated with a variable, or
> argument. For this reason, make qobject_ref() return the same pointer
> as given.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> @@ -101,13 +101,18 @@ static inline void qobject_unref(QObject *obj)
>  =20
>   /**
>    * qobject_ref(): Increment QObject's reference count
> + * @obj: a #QObject or children type instance (must not be NULL)

s/children/child/

> + *
> + * Returns: the same @obj. The type of @obj will be propagated to the
> + * return type.
>    */
>   #define qobject_ref(obj)                        \
> -    qobject_ref(QOBJECT(obj))
> +    (typeof(obj)) qobject_ref(QOBJECT(obj))

You're missing outer ().  There are cases where '(cast) (expr)' and=20
'((cast)(expr))' can behave differently when combined with surrounding=20
syntax; for example, -> has higher precedence than cast.  Consider:

qobject_ref(my_qdict)->size;

As you wrote it, you would attempt to dereference the 'size' member of=20
void* (compile error), prior to casting that result to QDict*; with the=20
parenthesis, you get the intended dereference of the size member of the=20
QDict pointer.

> +++ b/block.c
> @@ -5134,8 +5134,8 @@ static bool append_open_options(QDict *d, BlockDr=
iverState *bs)
>               continue;
>           }
>  =20
> -        qobject_ref(qdict_entry_value(entry));
> -        qdict_put_obj(d, qdict_entry_key(entry), qdict_entry_value(ent=
ry));
> +        qdict_put_obj(d, qdict_entry_key(entry),
> +                      qobject_ref(qdict_entry_value(entry)));

However, I like this simplification that your patch enables.  How did=20
you find candidate spots? Manually, or via Coccinelle?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
