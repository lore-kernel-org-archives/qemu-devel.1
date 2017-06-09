Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKzT-0004jC-54
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKzP-0005Np-2Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:34:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dJKzO-0005NY-OR
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 983651E2F0
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 14:34:13 +0000 (UTC)
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-44-marcandre.lureau@redhat.com>
	<87h8zq1ikt.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <28550e68-281a-a6b6-ca0b-6ebfe46e1dcf@redhat.com>
Date: Fri, 9 Jun 2017 16:34:08 +0200
MIME-Version: 1.0
In-Reply-To: <87h8zq1ikt.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o9aCExhcEoXtg96RMG3Scbb424DJGE8DT"
Subject: Re: [Qemu-devel] [PATCH v3 43/43] qobject: move dump_qobject() from
 block/ to qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o9aCExhcEoXtg96RMG3Scbb424DJGE8DT
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <28550e68-281a-a6b6-ca0b-6ebfe46e1dcf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 43/43] qobject: move dump_qobject() from
 block/ to qobject/
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
 <20170607163635.17635-44-marcandre.lureau@redhat.com>
 <87h8zq1ikt.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8zq1ikt.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-08 19:43, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> The dump functions could be generally useful for any qobject user or f=
or
>> debugging etc.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/qapi/qmp/qdict.h   |  2 ++
>>  include/qapi/qmp/qlist.h   |  2 ++
>>  include/qapi/qmp/qobject.h |  7 ++++
>>  block/qapi.c               | 90 +++----------------------------------=
---------
>>  qobject/qdict.c            | 30 ++++++++++++++++
>>  qobject/qlist.c            | 23 ++++++++++++
>>  qobject/qobject.c          | 19 ++++++++++
>>  tests/check-qjson.c        | 19 ++++++++++
>>  8 files changed, 106 insertions(+), 86 deletions(-)
>>
>> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>> index 8c7c2b762b..1ef3bc8cda 100644
>> --- a/include/qapi/qmp/qdict.h
>> +++ b/include/qapi/qmp/qdict.h
>> @@ -91,4 +91,6 @@ QObject *qdict_crumple(const QDict *src, Error **err=
p);
>> =20
>>  void qdict_join(QDict *dest, QDict *src, bool overwrite);
>> =20
>> +char *qdict_to_string(QDict *dict, int indent);
>> +
>>  #endif /* QDICT_H */
>> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
>> index c4b5fdad9b..c93ac3e15b 100644
>> --- a/include/qapi/qmp/qlist.h
>> +++ b/include/qapi/qmp/qlist.h
>> @@ -60,6 +60,8 @@ size_t qlist_size(const QList *qlist);
>>  QList *qobject_to_qlist(const QObject *obj);
>>  void qlist_destroy_obj(QObject *obj);
>> =20
>> +char *qlist_to_string(QList *list, int indent);
>> +
>>  static inline const QListEntry *qlist_first(const QList *qlist)
>>  {
>>      return QTAILQ_FIRST(&qlist->head);
>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index b8ddbca405..0d6ae5048a 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -101,4 +101,11 @@ static inline QObject *qnull(void)
>>      return &qnull_;
>>  }
>> =20
>> +char *qobject_to_string_indent(QObject *obj, int indent);
>> +
>> +static inline char *qobject_to_string(QObject *obj)
>> +{
>> +    return qobject_to_string_indent(obj, 0);
>> +}
>> +
>>  #endif /* QOBJECT_H */
>> diff --git a/block/qapi.c b/block/qapi.c
>> index 2050df29e4..9b7d42e50a 100644
>> --- a/block/qapi.c
>> +++ b/block/qapi.c
>> @@ -586,101 +586,19 @@ void bdrv_snapshot_dump(fprintf_function func_f=
printf, void *f,
>>      }
>>  }
>> =20
>> -static void dump_qdict(fprintf_function func_fprintf, void *f, int in=
dentation,
>> -                       QDict *dict);
>> -static void dump_qlist(fprintf_function func_fprintf, void *f, int in=
dentation,
>> -                       QList *list);
>> -
>> -static void dump_qobject(fprintf_function func_fprintf, void *f,
>> -                         int comp_indent, QObject *obj)
>> -{
>> -    switch (qobject_type(obj)) {
>> -        case QTYPE_QNUM: {
>> -            QNum *value =3D qobject_to_qnum(obj);
>> -            char *tmp =3D qnum_to_string(value);
>> -            func_fprintf(f, "%s", tmp);
>> -            g_free(tmp);
>> -            break;
>> -        }
>> -        case QTYPE_QSTRING: {
>> -            QString *value =3D qobject_to_qstring(obj);
>> -            func_fprintf(f, "%s", qstring_get_str(value));
>> -            break;
>> -        }
>> -        case QTYPE_QDICT: {
>> -            QDict *value =3D qobject_to_qdict(obj);
>> -            dump_qdict(func_fprintf, f, comp_indent, value);
>> -            break;
>> -        }
>> -        case QTYPE_QLIST: {
>> -            QList *value =3D qobject_to_qlist(obj);
>> -            dump_qlist(func_fprintf, f, comp_indent, value);
>> -            break;
>> -        }
>> -        case QTYPE_QBOOL: {
>> -            QBool *value =3D qobject_to_qbool(obj);
>> -            func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "f=
alse");
>> -            break;
>> -        }
>> -        default:
>> -            abort();
>> -    }
>> -}
>> -
>> -static void dump_qlist(fprintf_function func_fprintf, void *f, int in=
dentation,
>> -                       QList *list)
>> -{
>> -    const QListEntry *entry;
>> -    int i =3D 0;
>> -
>> -    for (entry =3D qlist_first(list); entry; entry =3D qlist_next(ent=
ry), i++) {
>> -        QType type =3D qobject_type(entry->value);
>> -        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QT=
YPE_QLIST);
>> -        func_fprintf(f, "%*s[%i]:%c", indentation * 4, "", i,
>> -                     composite ? '\n' : ' ');
>> -        dump_qobject(func_fprintf, f, indentation + 1, entry->value);=

>> -        if (!composite) {
>> -            func_fprintf(f, "\n");
>> -        }
>> -    }
>> -}
>> -
>> -static void dump_qdict(fprintf_function func_fprintf, void *f, int in=
dentation,
>> -                       QDict *dict)
>> -{
>> -    const QDictEntry *entry;
>> -
>> -    for (entry =3D qdict_first(dict); entry; entry =3D qdict_next(dic=
t, entry)) {
>> -        QType type =3D qobject_type(entry->value);
>> -        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QT=
YPE_QLIST);
>> -        char *key =3D g_malloc(strlen(entry->key) + 1);
>> -        int i;
>> -
>> -        /* replace dashes with spaces in key (variable) names */
>> -        for (i =3D 0; entry->key[i]; i++) {
>> -            key[i] =3D entry->key[i] =3D=3D '-' ? ' ' : entry->key[i]=
;
>> -        }
>> -        key[i] =3D 0;
>> -        func_fprintf(f, "%*s%s:%c", indentation * 4, "", key,
>> -                     composite ? '\n' : ' ');
>> -        dump_qobject(func_fprintf, f, indentation + 1, entry->value);=

>> -        if (!composite) {
>> -            func_fprintf(f, "\n");
>> -        }
>> -        g_free(key);
>> -    }
>> -}
>> -
>>  void bdrv_image_info_specific_dump(fprintf_function func_fprintf, voi=
d *f,
>>                                     ImageInfoSpecific *info_spec)
>>  {
>>      QObject *obj, *data;
>>      Visitor *v =3D qobject_output_visitor_new(&obj);
>> +    char *tmp;
>> =20
>>      visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
>>      visit_complete(v, &obj);
>>      data =3D qdict_get(qobject_to_qdict(obj), "data");
>> -    dump_qobject(func_fprintf, f, 1, data);
>> +    tmp =3D qobject_to_string_indent(data, 1);
>> +    func_fprintf(f, "%s", tmp);
>> +    g_free(tmp);
>>      qobject_decref(obj);
>>      visit_free(v);
>>  }
>=20
> The title claims "move dump_qobject() from block/ to qobject/", but
> that's not what the patch does.  It *replaces* dump_qobject() by
> qobject_to_string().  The former dumps to a callback, the latter to a
> dynamic string buffer.
>=20
> Providing dump functionality in one way doesn't preclude the other way:=

> given callback, one could define a callback that builds up a string
> buffer, and given buffer, one could (and you actually do) pass the
> buffer to a callback.  That's less efficient, though.
>=20
> Trading efficiency for ease-of-use should be okay here, but I'm cc'ing
> Max and Kevin to double-check.

Given that this function is called only by HMP's "info block -v" and
qemu-img, I don't think efficiency is too important. In the former case,
it's your own fault for using HMP, in the latter you'll have only a
single image anyway.

So I'm OK with this change.

Max

>=20
> Two ways forward:
>=20
> 1. Get Max / Kevin's blessing, change the commit message to match the
> code.
>=20
> 2. Change the code to match the commit message.


--o9aCExhcEoXtg96RMG3Scbb424DJGE8DT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOrHgEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQHWU
CAC5qS8pPMIFX6cYnnoVNb8djGYwtE5jvgpOLr8NGSBCpp6er4wqed+V8Ip51pJE
1v6HD36AK02Mp7a1y/GxSrj0kQfgwDJklF4FoUH2aD2J/i6oGdMUFyG0zjNFbCIn
0wfucpNwvJqVpPKQvjXbxsEwYCULsDckTtM0LPY4xr2kNl6cKUye2T55fz8RfGB/
9pV+DVRRglru4tEbe3d4afXpIBC7iD79tkYEK+fhMRmKMlEK8hlycNd0wtKQBOWf
vzPO6y+ukn2wU6hjXJ0Glw6WLlMQRn6k92KnV1zxspysGBl1Xn+W7/YXkyXTL/Qi
YXjTgznzGRFhrpule4Tfsv/8
=/QCr
-----END PGP SIGNATURE-----

--o9aCExhcEoXtg96RMG3Scbb424DJGE8DT--
