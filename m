Received: from eggs.gnu.org ([2001:4830:134:3::10]:33859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTsg-0003rD-7g
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTsd-0005hx-1X
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:26:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXTsc-0005gr-Os
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:25:58 -0500
Date: Fri, 5 Jan 2018 15:25:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105152552.GE28322@stefanha-x1.localdomain>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <20180103214925.16677-4-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/4] libqos: implement sdbus QMP
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 06:49:24PM -0300, Philippe Mathieu-Daud=E9 wrote:
> +static const char *qmp_sdbus_getpath(const char *blkname)
> +{
> +    QDict *response, *minfo;
> +    QList *list;
> +    const QListEntry *le;
> +    QString *qstr;
> +    const char *mname;
> +    QObject *qobj;
> +
> +    response =3D qmp("{ 'execute': 'query-block' }");

This function implicitly uses global_qtest.  If you ever want to do
multi-VM (e.g. migration) tests then this may become a problem because
there's no way to say which QEMU process to talk to.

This can be addressed by adding a QTestState *s argument to these
functions so that global_qtest isn't hardcoded.  Use qtest_qmp()
instead.

> +    g_assert_nonnull(response);
> +    list =3D qdict_get_qlist(response, "return");
> +    g_assert_nonnull(list);
> +
> +    QLIST_FOREACH_ENTRY(list, le) {
> +        QDict *response2;
> +
> +        minfo =3D qobject_to_qdict(qlist_entry_obj(le));
> +        g_assert(minfo);
> +        qobj =3D qdict_get(minfo, "qdev");
> +        if (!qobj) {
> +            continue;
> +        }
> +        qstr =3D qobject_to_qstring(qobj);
> +        g_assert(qstr);
> +        mname =3D qstring_get_str(qstr);
> +
> +        response2 =3D qmp("{ 'execute': 'qom-get',"
> +                        "  'arguments': { 'path': %s,"
> +                        "   'property': \"parent_bus\"}"
> +                        "}", mname);
> +        g_assert(response2);
> +        g_assert(qdict_haskey(response2, "return"));
> +        qobj =3D qdict_get(response2, "return");
> +        qstr =3D qobject_to_qstring(qobj);
> +        g_assert(qstr);
> +        mname =3D qstring_get_str(qstr);
> +
> +        return mname;
> +    }
> +    return NULL;
> +}

response is leaked.  I think something like this is needed:

  char *mname =3D g_strdup(qstring_get_str(qstr));
  QDECREF(response);
  return mname;

The caller must g_free() the return value too and the type must be char
* instead of const char *.

> +
> +static ssize_t qmp_mmc_do_cmd(SDBusAdapter *adapter, enum NCmd cmd, uint=
32_t arg,
> +                              uint8_t **response)
> +{
> +    QMPSDBus *s =3D (QMPSDBus *)adapter;
> +    QDict *response1;
> +    QObject *qobj;
> +
> +    response1 =3D qmp("{ 'execute': 'x-debug-sdbus-command',"
> +                    "  'arguments': { 'qom-path': %s,"
> +                    "                 'command': %u, 'arg': %u}"
> +                    "}",
> +                    s->qom_path, cmd, arg);
> +    g_assert(qdict_haskey(response1, "return"));
> +    qobj =3D qdict_get(response1, "return");
> +    //QDECREF(response);
> +
> +    if (!qobj) {
> +        return -1;
> +    }
> +
> +    {
> +        QString *qstr;
> +        const gchar *mname;
> +        guchar *uc;
> +        gsize out_len;
> +        QDict *response2 =3D qobject_to_qdict(qobj);
> +
> +        if (!qdict_haskey(response2, "base64")) {
> +            return 0;
> +        }
> +        qobj =3D qdict_get(response2, "base64");
> +        qstr =3D qobject_to_qstring(qobj);
> +        if (!qstr) {
> +            puts("!qstr");
> +            return 0;
> +        }
> +        mname =3D qstring_get_str(qstr);
> +
> +        uc =3D g_base64_decode(mname, &out_len);
> +        if (response) {
> +            *response =3D uc;
> +        } else {
> +            g_free(uc);
> +        }
> +        return out_len;
> +
> +    }
> +
> +    return 0;
> +}

Please fix memory leaks here, too.  For example, response1 is leaked.

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT5kAAAoJEJykq7OBq3PIZHgH/RzDTH/29Vpttg22Q7Rzklv/
K6H51gXxfI2AnayC6x5P5f0t5nRNz9Ko8K7XiTWloDa86slG4GPxeziI0ZK8Merz
6QIPjiaH4MMritVQPz8rSxUewThhPdDyRqRMpcNpg+949Xt3hlU/OAy6b3jDJOGJ
EdEkSSd+E/N4xKWwUQD6fVqdEKT/jaB7Sn+QXh41UduMyyAFB5GuFRWwQk3y2mkT
PK+Q+qJpqIgp5cYPc0E+KL0f0RnRJf1Ul91jOOGijiwFvYGyGF4/aWC+EAE2Ep0h
rOAfbKNQFi/+tuZoFQoBZ5pasz1uzsYeUn4qNPz3gcamSqqEoa13LtBIvDXvw1s=
=Gy27
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
