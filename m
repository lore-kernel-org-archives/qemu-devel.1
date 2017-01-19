Received: from eggs.gnu.org ([2001:4830:134:3::10]:36470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8hr-00044G-PF
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8hq-00019i-Kt
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:31 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:35588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cU8hq-00019M-FT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:30 -0500
Received: by mail-yw0-x243.google.com with SMTP id 17so3278027ywk.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 01:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-4-eblake@redhat.com>
In-Reply-To: <20170118161653.19296-4-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Jan 2017 09:08:19 +0000
Message-ID: <CAJ+F1CJad2iG3n0T6dTJs74XadoWF3tUyyt9dxD+AvMLeXn-5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qlist: Add convenience helpers for
 wrapped appends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

Hi

On Wed, Jan 18, 2017 at 8:34 PM Eric Blake <eblake@redhat.com> wrote:

> Similar to the qdict additions of the previous patch, although
> this time there are not as many clients.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>

Not very useful, but why not:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  include/qapi/qmp/qlist.h |  8 ++++++++
>  tests/check-qdict.c      | 10 +++++-----
>  tests/check-qlist.c      |  2 +-
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
> index a84117e..659325a 100644
> --- a/include/qapi/qmp/qlist.h
> +++ b/include/qapi/qmp/qlist.h
> @@ -29,6 +29,14 @@ typedef struct QList {
>  #define qlist_append(qlist, obj) \
>          qlist_append_obj(qlist, QOBJECT(obj))
>
> +/* Helpers for int, bool, and const char*. */
> +#define qlist_append_int(qlist, value) \
> +        qlist_append(qlist, qint_from_int(value))
> +#define qlist_append_bool(qlist, value) \
> +        qlist_append(qlist, qbool_from_bool(value))
> +#define qlist_append_str(qlist, value) \
> +        qlist_append(qlist, qstring_from_str(value))
> +
>  #define QLIST_FOREACH_ENTRY(qlist, var)             \
>          for ((var) =3D ((qlist)->head.tqh_first);     \
>              (var);                                  \
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index d00b411..6d4f8a7 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -297,11 +297,11 @@ static void qdict_flatten_test(void)
>      qdict_put_int(dict1, "a", 0);
>      qdict_put_int(dict1, "b", 1);
>
> -    qlist_append_obj(list1, QOBJECT(qint_from_int(23)));
> -    qlist_append_obj(list1, QOBJECT(qint_from_int(66)));
> -    qlist_append_obj(list1, QOBJECT(dict1));
> -    qlist_append_obj(list2, QOBJECT(qint_from_int(42)));
> -    qlist_append_obj(list2, QOBJECT(list1));
> +    qlist_append_int(list1, 23);
> +    qlist_append_int(list1, 66);
> +    qlist_append(list1, dict1);
> +    qlist_append_int(list2, 42);
> +    qlist_append(list2, list1);
>
>      qdict_put_int(dict2, "c", 2);
>      qdict_put_int(dict2, "d", 3);
> diff --git a/tests/check-qlist.c b/tests/check-qlist.c
> index e16da5e..38463f1 100644
> --- a/tests/check-qlist.c
> +++ b/tests/check-qlist.c
> @@ -74,7 +74,7 @@ static void qlist_destroy_test(void)
>      qlist =3D qlist_new();
>
>      for (i =3D 0; i < 42; i++)
> -        qlist_append(qlist, qint_from_int(i));
> +        qlist_append_int(qlist, i);
>
>      QDECREF(qlist);
>  }
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
