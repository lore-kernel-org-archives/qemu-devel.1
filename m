Received: from eggs.gnu.org ([2001:4830:134:3::10]:49029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAgTO-0006gH-MV
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAgTJ-00082m-Hx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAgTJ-00081U-9V
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:41:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0415CC05FFCB
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 17:41:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-11-marcandre.lureau@redhat.com>
Date: Tue, 16 May 2017 19:41:13 +0200
In-Reply-To: <20170509173559.31598-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 May 2017
	20:35:52 +0300")
Message-ID: <87fug466o6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/17] object: add uint property
 setter/getter
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

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qom/object.h | 23 +++++++++++++++++++++++
>  qom/object.c         | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index cd0f412ce9..abaeb8cf4e 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1094,6 +1094,29 @@ int64_t object_property_get_int(Object *obj, const=
 char *name,
>                                  Error **errp);
>=20=20
>  /**
> + * object_property_set_uint:
> + * @value: the value to be written to the property
> + * @name: the name of the property
> + * @errp: returns an error if this function fails
> + *
> + * Writes an unsigned integer value to a property.
> + */
> +void object_property_set_uint(Object *obj, uint64_t value,
> +                              const char *name, Error **errp);
> +
> +/**
> + * object_property_get_uint:
> + * @obj: the object
> + * @name: the name of the property
> + * @errp: returns an error if this function fails
> + *
> + * Returns: the value of the property, converted to an unsigned integer,=
 or 0
> + * an error occurs (including when the property value is not an integer).
> + */
> +uint64_t object_property_get_uint(Object *obj, const char *name,
> +                                  Error **errp);
> +
> +/**
>   * object_property_get_enum:
>   * @obj: the object
>   * @name: the name of the property
> diff --git a/qom/object.c b/qom/object.c
> index c1644dbcb7..a9259e330d 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1221,6 +1221,39 @@ int64_t object_property_get_int(Object *obj, const=
 char *name,
>      return retval;
>  }
>=20=20
> +void object_property_set_uint(Object *obj, uint64_t value,
> +                             const char *name, Error **errp)
> +{
> +    QNum *qn =3D qnum_from_uint(value);

Please call the variable @qnum, to match object_property_set_int() and
object_property_get_uint().

Blank line here.

> +    object_property_set_qobject(obj, QOBJECT(qn), name, errp);
> +    QDECREF(qn);
> +}
> +
> +uint64_t object_property_get_uint(Object *obj, const char *name,
> +                                  Error **errp)
> +{
> +    QObject *ret =3D object_property_get_qobject(obj, name, errp);
> +    Error *err =3D NULL;
> +    QNum *qnum;
> +    uint64_t retval;
> +
> +    if (!ret) {
> +        return 0;
> +    }
> +    qnum =3D qobject_to_qnum(ret);
> +    if (qnum) {
> +        retval =3D qnum_get_uint(qnum, &err);
> +    }
> +
> +    if (!qnum || err) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "uint");
> +        retval =3D 0;
> +    }
> +
> +    qobject_decref(ret);
> +    return retval;
> +}
> +
>  typedef struct EnumProperty {
>      const char * const *strings;
>      int (*get)(Object *, Error **);

With the nits touched up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
