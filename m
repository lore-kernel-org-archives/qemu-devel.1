Received: from eggs.gnu.org ([2001:4830:134:3::10]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBNLC-0001Ac-Rm
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBNL7-0006zM-RP
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBNL7-0006xc-I7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:27:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87BC880486
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:27:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-17-marcandre.lureau@redhat.com>
Date: Thu, 18 May 2017 17:27:35 +0200
In-Reply-To: <20170509173559.31598-17-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 May 2017
	20:35:58 +0300")
Message-ID: <87zieanq1k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/17] RFC: qdict: add uint
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

> Similar to int support, add uint support.
>
> Note this is RFC because this is currently unused in qemu, I haven't
> found a good user for it yet (kaslr qemu-ga code did use it though).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Do we think future use is reasonably likely?  If yes, let's stop
worrying and take the patch.

> ---
>  include/qapi/qmp/qdict.h |  5 +++++
>  qobject/qdict.c          | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/check-qdict.c      | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
>
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index 363e431106..8c7c2b762b 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -56,6 +56,8 @@ void qdict_destroy_obj(QObject *obj);
>  /* Helpers for int, bool, and string */
>  #define qdict_put_int(qdict, key, value) \
>          qdict_put(qdict, key, qnum_from_int(value))
> +#define qdict_put_uint(qdict, key, value)        \
> +        qdict_put(qdict, key, qnum_from_uint(value))
>  #define qdict_put_bool(qdict, key, value) \
>          qdict_put(qdict, key, qbool_from_bool(value))
>  #define qdict_put_str(qdict, key, value) \
> @@ -64,12 +66,15 @@ void qdict_destroy_obj(QObject *obj);
>  /* High level helpers */
>  double qdict_get_double(const QDict *qdict, const char *key);
>  int64_t qdict_get_int(const QDict *qdict, const char *key);
> +uint64_t qdict_get_uint(const QDict *qdict, const char *key);
>  bool qdict_get_bool(const QDict *qdict, const char *key);
>  QList *qdict_get_qlist(const QDict *qdict, const char *key);
>  QDict *qdict_get_qdict(const QDict *qdict, const char *key);
>  const char *qdict_get_str(const QDict *qdict, const char *key);
>  int64_t qdict_get_try_int(const QDict *qdict, const char *key,
>                            int64_t def_value);
> +uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
> +                            uint64_t def_value);
>  bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_va=
lue);
>  const char *qdict_get_try_str(const QDict *qdict, const char *key);
>=20=20
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index ad5bab9572..34478fbdd4 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -202,6 +202,19 @@ int64_t qdict_get_int(const QDict *qdict, const char=
 *key)
>  }
>=20=20
>  /**
> + * qdict_get_uint(): Get an unsigned integer mapped by 'key'
> + *
> + * This function assumes that 'key' exists and it stores a
> + * QNum int object.
> + *
> + * Return unsigned integer mapped by 'key'.
> + */
> +uint64_t qdict_get_uint(const QDict *qdict, const char *key)
> +{
> +    return qnum_get_uint(qobject_to_qnum(qdict_get(qdict, key)), &error_=
abort);
> +}
> +
> +/**
>   * qdict_get_bool(): Get a bool mapped by 'key'
>   *
>   * This function assumes that 'key' exists and it stores a
> @@ -270,6 +283,31 @@ int64_t qdict_get_try_int(const QDict *qdict, const =
char *key,
>  }
>=20=20
>  /**
> + * qdict_get_try_uint(): Try to get usigned integer mapped by 'key'
> + *
> + * Return unsigned integer mapped by 'key', if it is not present in
> + * the dictionary or if the stored object is not of QNum type
> + * 'def_value' will be returned.
> + */
> +uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
> +                            uint64_t def_value)
> +{
> +    Error *err =3D NULL;
> +    QNum *qnum =3D qobject_to_qnum(qdict_get(qdict, key));
> +    uint64_t val =3D def_value;
> +
> +    if (qnum) {
> +        val =3D qnum_get_uint(qnum, &err);
> +    }
> +    if (err) {
> +        error_free(err);
> +        val =3D def_value;
> +    }
> +
> +    return val;
> +}
> +
> +/**
>   * qdict_get_try_bool(): Try to get a bool mapped by 'key'
>   *
>   * Return bool mapped by 'key', if it is not present in the
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index bcd06a7d6b..7f9ea67862 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -105,6 +105,21 @@ static void qdict_get_int_test(void)
>      QDECREF(tests_dict);
>  }
>=20=20
> +static void qdict_get_uint_test(void)
> +{
> +    uint64_t ret;
> +    const uint64_t value =3D UINT64_MAX;
> +    const char *key =3D "uint";
> +    QDict *tests_dict =3D qdict_new();
> +
> +    qdict_put_uint(tests_dict, key, value);
> +
> +    ret =3D qdict_get_uint(tests_dict, key);
> +    g_assert(ret =3D=3D value);
> +
> +    QDECREF(tests_dict);
> +}
> +
>  static void qdict_get_try_int_test(void)
>  {
>      int ret;
> @@ -120,6 +135,21 @@ static void qdict_get_try_int_test(void)
>      QDECREF(tests_dict);
>  }
>=20=20
> +static void qdict_get_try_uint_test(void)
> +{
> +    uint64_t ret;
> +    const uint64_t value =3D UINT64_MAX;
> +    const char *key =3D "uint";
> +    QDict *tests_dict =3D qdict_new();
> +
> +    qdict_put_uint(tests_dict, key, value);
> +
> +    ret =3D qdict_get_try_uint(tests_dict, key, 0);
> +    g_assert(ret =3D=3D value);
> +
> +    QDECREF(tests_dict);
> +}
> +

Just as spotty as its signed buddy.  Both should at least also test
cases "key is not in dict" and "key maps to a value that isn't QNum".

>  static void qdict_get_str_test(void)
>  {
>      const char *p;
> @@ -852,7 +882,9 @@ int main(int argc, char **argv)
>      /* Continue, but now with fixtures */
>      g_test_add_func("/public/get", qdict_get_test);
>      g_test_add_func("/public/get_int", qdict_get_int_test);
> +    g_test_add_func("/public/get_uint", qdict_get_uint_test);
>      g_test_add_func("/public/get_try_int", qdict_get_try_int_test);
> +    g_test_add_func("/public/get_try_uint", qdict_get_try_uint_test);
>      g_test_add_func("/public/get_str", qdict_get_str_test);
>      g_test_add_func("/public/get_try_str", qdict_get_try_str_test);
>      g_test_add_func("/public/defaults", qdict_defaults_test);
