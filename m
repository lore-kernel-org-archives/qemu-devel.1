Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fBm7O-0001cA-QF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fBm7L-00023f-OV
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:59:46 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fBm7L-00023B-JX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:59:43 -0400
Received: by mail-io0-f195.google.com with SMTP id t23-v6so19334818ioc.10
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 11:59:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180426152805.8469-1-armbru@redhat.com>
References: <20180426152805.8469-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 26 Apr 2018 20:59:40 +0200
Message-ID: <CAMxuvazATn8H7u6NL5_CWvCj47XZco1hQnOUaa8wEYYhiVFTJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qobject: Use qobject_to() instead of type
 cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>

On Thu, Apr 26, 2018 at 5:28 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> The proper way to convert from (abstract) QObject to a (concrete)
> subtype is qobject_to().  Look for offenders that type cast instead:
>
>     $ git-grep '(Q[A-Z][a-z]* \*)'
>     hmp.c:    qmp_device_add((QDict *)qdict, NULL, &err);
>     include/qapi/qmp/qobject.h:        return (QObject *)obj;
>     qobject/qobject.c:static void (*qdestroy[QTYPE__MAX])(QObject *) =3D =
{
>     tests/check-qdict.c:    dst =3D (QDict *)qdict_crumple(src, &error_ab=
ort);
>
> The first two cast away const, the third isn't a type cast.  Fix the
> fourth.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/check-qdict.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index a0e0454684..eba5d3528e 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -657,7 +657,7 @@ static void qdict_crumple_test_empty(void)
>
>      src =3D qdict_new();
>
> -    dst =3D (QDict *)qdict_crumple(src, &error_abort);
> +    dst =3D qobject_to(QDict, qdict_crumple(src, &error_abort));
>
>      g_assert_cmpint(qdict_size(dst), =3D=3D, 0);
>
> --
> 2.13.6
>
